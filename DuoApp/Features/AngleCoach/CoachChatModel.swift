import Foundation
import FoundationModels

struct CoachMessage: Identifiable, Equatable {
  enum Role: Equatable {
    case owner
    case coach
  }

  let id = UUID()
  var role: Role
  var text: String
}

/// Lets the on-device model change the coach's own settings when the owner asks in chat.
struct UpdateCoachSettingsTool: Tool {
  let name = "updateCoachSettings"
  let description =
    "Changes the coach's name, voice, countdown phrase, countdown length, match strictness, automatic shooting, or remembers an owner preference. Pass only the fields the owner asked to change."

  @Generable
  struct Arguments {
    @Guide(description: "New name for the coach")
    var name: String?
    @Guide(description: "Voice: hype, calm, playful, or direct")
    var vibe: String?
    @Guide(description: "Short word shown when the photo is taken, such as Smile! or Cheese!")
    var countdownPhrase: String?
    @Guide(description: "Countdown length in seconds, from 1 to 10")
    var countdownSeconds: Int?
    @Guide(description: "How exactly the angle must match: relaxed, balanced, or strict")
    var strictness: String?
    @Guide(description: "True to take the photo automatically when the angle matches")
    var autoShoot: Bool?
    @Guide(description: "A preference to remember, such as: my left side is my good side")
    var rememberNote: String?
  }

  let apply: @Sendable (CoachSettingsChange) async -> [String]

  func call(arguments: Arguments) async throws -> String {
    let change = CoachSettingsChange(
      name: arguments.name,
      vibe: arguments.vibe.flatMap { CoachVibe(rawValue: $0.lowercased()) },
      countdownPhrase: arguments.countdownPhrase,
      countdownSeconds: arguments.countdownSeconds,
      tolerance: arguments.strictness.flatMap { AngleTolerance(rawValue: $0.lowercased()) },
      autoShoot: arguments.autoShoot,
      rememberNote: arguments.rememberNote)
    let updates = await apply(change)
    return updates.isEmpty ? "Nothing changed." : "Updated: " + updates.joined(separator: "; ")
  }
}

/// The coach you talk to. Uses Apple's on-device model when available and the basic coach otherwise.
@MainActor
@Observable
final class CoachChatModel {
  enum Engine: Equatable {
    case onDevice
    /// Localization key explaining why the on-device model is not in use.
    case basic(reasonKey: String)
  }

  private(set) var messages: [CoachMessage] = []
  private(set) var isResponding = false
  private(set) var engine: Engine
  /// Settings lines changed by the most recent reply, shown under it as confirmation.
  private(set) var lastUpdates: [String] = []

  @ObservationIgnored private let personaStore: CoachPersonaStore
  @ObservationIgnored private let angleStore: BestAngleStore
  @ObservationIgnored private var session: LanguageModelSession?
  /// The instructions a session was built with; a new persona or angle starts a fresh session.
  @ObservationIgnored private var sessionInstructions: String?

  init(personaStore: CoachPersonaStore = .shared, angleStore: BestAngleStore = .shared) {
    self.personaStore = personaStore
    self.angleStore = angleStore
    engine = Self.currentEngine()
    messages = [greeting]
  }

  static func currentEngine() -> Engine {
    switch SystemLanguageModel.default.availability {
    case .available:
      return .onDevice
    case .unavailable(.appleIntelligenceNotEnabled):
      return .basic(reasonKey: "coach.engine.aiOff")
    case .unavailable(.modelNotReady):
      return .basic(reasonKey: "coach.engine.notReady")
    case .unavailable:
      return .basic(reasonKey: "coach.engine.unsupported")
    }
  }

  private var greeting: CoachMessage {
    let key = angleStore.profile == nil ? "coach.greeting.noAngle" : "coach.greeting"
    return CoachMessage(role: .coach, text: String(format: String(localized: String.LocalizationValue(key)), personaStore.persona.name))
  }

  func send(_ raw: String) async {
    let text = raw.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !text.isEmpty, !isResponding else { return }
    messages.append(CoachMessage(role: .owner, text: text))
    lastUpdates = []
    isResponding = true
    defer { isResponding = false }

    engine = Self.currentEngine()
    if engine == .onDevice {
      do {
        try await respondOnDevice(to: text)
        return
      } catch {
        // Guardrail, context, or asset errors fall back to the basic coach instead of leaving the owner hanging.
        session = nil
      }
    }
    let angleSummary = angleStore.profile?.summary ?? []
    let reply = BasicCoach.reply(to: text, persona: personaStore.persona, angleSummary: angleSummary)
    var replyText = reply.text
    if let change = reply.change {
      lastUpdates = personaStore.apply(change)
      if lastUpdates.isEmpty {
        replyText = String(localized: "coach.basic.unchanged")
      }
    }
    messages.append(CoachMessage(role: .coach, text: replyText))
  }

  /// Starts over with a greeting that uses the current name.
  func resetConversation() {
    session = nil
    sessionInstructions = nil
    lastUpdates = []
    messages = [greeting]
  }

  private func respondOnDevice(to text: String) async throws {
    let session = currentSession()
    let index = messages.count
    messages.append(CoachMessage(role: .coach, text: ""))
    do {
      for try await snapshot in session.streamResponse(to: text) {
        messages[index].text = snapshot.content
      }
    } catch {
      messages.remove(at: index)
      throw error
    }
  }

  private func currentSession() -> LanguageModelSession {
    let instructions = CoachPrompt.instructions(
      persona: personaStore.persona, angleSummary: angleStore.profile?.summary ?? [])
    if let session, sessionInstructions == instructions {
      return session
    }
    let store = personaStore
    let tool = UpdateCoachSettingsTool { [weak self] change in
      await MainActor.run {
        let updates = store.apply(change)
        self?.lastUpdates += updates
        return updates
      }
    }
    let session = LanguageModelSession(tools: [tool], instructions: instructions)
    self.session = session
    // Record the instructions after tool edits too, so the next turn rebuilds with the new persona.
    sessionInstructions = instructions
    return session
  }
}
