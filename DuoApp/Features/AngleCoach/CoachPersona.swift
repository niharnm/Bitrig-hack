import Foundation

/// How the coach talks. Shapes chat replies; the outer cues stay short either way.
enum CoachVibe: String, Codable, CaseIterable, Identifiable, Sendable {
  case hype
  case calm
  case playful
  case direct

  var id: String { rawValue }

  var titleKey: String { "coach.vibe.\(rawValue)" }

  /// Voice description for the model's instructions.
  var voice: String {
    switch self {
    case .hype: "an upbeat hype friend who is genuinely excited about the shot"
    case .calm: "a calm, reassuring portrait photographer"
    case .playful: "a playful friend who keeps it light and a little silly"
    case .direct: "a direct, efficient pro who gives crisp instructions"
    }
  }
}

/// Everything the owner can change about their coach. Persisted as JSON in UserDefaults.
struct CoachPersona: Codable, Equatable, Sendable {
  static let secondsRange = 1...10
  static let maxNameLength = 20
  static let maxPhraseLength = 20

  var name = "Lens"
  var vibe = CoachVibe.hype
  /// Shown big on both displays at the moment the photo is taken.
  var countdownPhrase = "Smile!"
  var countdownSeconds = 3
  var tolerance = AngleTolerance.balanced
  /// Start the countdown by itself once the saved angle holds.
  var autoShoot = true
  /// Free-form preferences, such as "left side is my good side".
  var notes = ""
}

/// A requested settings change, from the chat model's tool or the basic coach.
struct CoachSettingsChange: Equatable, Sendable {
  var name: String?
  var vibe: CoachVibe?
  var countdownPhrase: String?
  var countdownSeconds: Int?
  var tolerance: AngleTolerance?
  var autoShoot: Bool?
  var rememberNote: String?

  var isEmpty: Bool { self == CoachSettingsChange() }
}

@MainActor
@Observable
final class CoachPersonaStore {
  static let shared = CoachPersonaStore()
  static let storageKey = "coach.persona"

  var persona: CoachPersona {
    didSet { save() }
  }
  @ObservationIgnored private let defaults: UserDefaults

  init(defaults: UserDefaults = .standard) {
    self.defaults = defaults
    persona =
      defaults.data(forKey: Self.storageKey)
      .flatMap { try? JSONDecoder().decode(CoachPersona.self, from: $0) } ?? CoachPersona()
  }

  /// Applies a change and returns one plain-language line per setting that actually changed.
  @discardableResult
  func apply(_ change: CoachSettingsChange) -> [String] {
    var next = persona
    var updates: [String] = []
    if let name = Self.clean(change.name, limit: CoachPersona.maxNameLength), name != next.name {
      next.name = name
      updates.append(String(format: String(localized: "coach.update.name"), name))
    }
    if let vibe = change.vibe, vibe != next.vibe {
      next.vibe = vibe
      updates.append(
        String(format: String(localized: "coach.update.vibe"), String(localized: String.LocalizationValue(vibe.titleKey))))
    }
    if let phrase = Self.clean(change.countdownPhrase, limit: CoachPersona.maxPhraseLength),
      phrase != next.countdownPhrase
    {
      next.countdownPhrase = phrase
      updates.append(String(format: String(localized: "coach.update.phrase"), phrase))
    }
    if let seconds = change.countdownSeconds {
      let clamped = min(max(seconds, CoachPersona.secondsRange.lowerBound), CoachPersona.secondsRange.upperBound)
      if clamped != next.countdownSeconds {
        next.countdownSeconds = clamped
        updates.append(String(format: String(localized: "coach.update.seconds"), clamped))
      }
    }
    if let tolerance = change.tolerance, tolerance != next.tolerance {
      next.tolerance = tolerance
      updates.append(
        String(
          format: String(localized: "coach.update.tolerance"),
          String(localized: String.LocalizationValue(tolerance.titleKey))))
    }
    if let autoShoot = change.autoShoot, autoShoot != next.autoShoot {
      next.autoShoot = autoShoot
      updates.append(String(localized: autoShoot ? "coach.update.autoOn" : "coach.update.autoOff"))
    }
    if let note = Self.clean(change.rememberNote, limit: 200) {
      next.notes = next.notes.isEmpty ? note : next.notes + "\n" + note
      updates.append(String(format: String(localized: "coach.update.note"), note))
    }
    if next != persona {
      persona = next
    }
    return updates
  }

  /// The form can leave a field empty mid-edit; empty name or phrase falls back to the defaults.
  func fillBlankText() {
    let defaults = CoachPersona()
    if persona.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      persona.name = defaults.name
    }
    if persona.countdownPhrase.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      persona.countdownPhrase = defaults.countdownPhrase
    }
  }

  private func save() {
    if let data = try? JSONEncoder().encode(persona) {
      defaults.set(data, forKey: Self.storageKey)
    }
  }

  private static func clean(_ value: String?, limit: Int) -> String? {
    guard let trimmed = value?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmed.isEmpty else {
      return nil
    }
    return String(trimmed.prefix(limit))
  }
}

/// Instructions for the on-device model. Kept separate so tests can read exactly what the model is told.
enum CoachPrompt {
  static func instructions(persona: CoachPersona, angleSummary: [String]) -> String {
    let angle =
      angleSummary.isEmpty
      ? "The owner has not saved a best-angle photo yet. Encourage them to add one in the Best angle card."
      : "The owner's saved best angle: \(angleSummary.joined(separator: "; "))."
    let notes =
      persona.notes.isEmpty ? "" : "\nThe owner told you: \(persona.notes.replacingOccurrences(of: "\n", with: "; "))."
    return """
      You are \(persona.name), the photo coach inside \(FilmToolTokens.Brand.name), a camera app for iPhone Duo. \
      The owner hands their phone to someone else to take their photo. The photographer looks at the inner display; \
      the owner stands in front of the camera and sees themselves on the outer display. \
      Your job is to get the owner's photo the way they like it.
      Speak as \(persona.vibe.voice).
      Keep replies under 60 words. Anything the subject should do goes in a command of at most 8 words.
      \(angle)\(notes)
      When the photo is taken, both displays count down from \(persona.countdownSeconds) and show "\(persona.countdownPhrase)".
      If the owner asks to change your name, voice, countdown phrase, countdown length, match strictness, \
      automatic shooting, or asks you to remember a preference, call updateCoachSettings with only those fields.
      Never claim you can see the camera; the app does the live angle matching.
      """
  }
}

/// A small rule-based coach for when Apple Intelligence is unavailable, so the chat still works and still customizes.
enum BasicCoach {
  struct Reply: Equatable {
    var text: String
    var change: CoachSettingsChange?
  }

  static func reply(to message: String, persona: CoachPersona, angleSummary: [String]) -> Reply {
    let change = parseChange(message)
    if !change.isEmpty {
      return Reply(text: String(localized: "coach.basic.updated"), change: change)
    }
    let lower = message.lowercased()
    if lower.contains("side") || lower.contains("angle") || lower.contains("look") {
      guard !angleSummary.isEmpty else {
        return Reply(text: String(localized: "coach.basic.noAngle"))
      }
      return Reply(
        text: String(format: String(localized: "coach.basic.angle"), angleSummary.joined(separator: ", ")))
    }
    if lower.contains("pose") || lower.contains("how") || lower.contains("tip") {
      return Reply(text: String(localized: String.LocalizationValue("coach.basic.tip.\(persona.vibe.rawValue)")))
    }
    return Reply(text: String(format: String(localized: "coach.basic.help"), persona.name))
  }

  static func parseChange(_ message: String) -> CoachSettingsChange {
    let lower = message.lowercased()
    var change = CoachSettingsChange()

    if let name = firstCapture(#"(?:call (?:you|yourself)|your name is|rename (?:you|yourself) to|name you)\s+([A-Za-z][A-Za-z'\-]{0,19})"#, in: message) {
      change.name = name.prefix(1).uppercased() + name.dropFirst()
    }
    if let phrase = firstCapture(#"(?:^|\s)say\s+["“]?([A-Za-z][A-Za-z' ]{0,18}?)["”]?\s*(?:instead|at the end|when|$|[.!?,])"#, in: message) {
      let trimmed = phrase.trimmingCharacters(in: .whitespaces)
      change.countdownPhrase = trimmed.prefix(1).uppercased() + trimmed.dropFirst() + "!"
    }
    if let seconds = firstCapture(#"(\d{1,2})\s*-?\s*(?:second|sec)"#, in: lower).flatMap(Int.init) {
      change.countdownSeconds = seconds
    }
    // Only a request about the coach's voice changes it, so "how do I stay calm?" stays a question.
    let asksForVoice = ["be ", "more ", "sound", "vibe", "tone", "style", "switch", "act "].contains {
      lower.contains($0)
    }
    if asksForVoice {
      if lower.contains("hype") {
        change.vibe = .hype
      } else if lower.contains("calm") {
        change.vibe = .calm
      } else if lower.contains("playful") || lower.contains("funny") || lower.contains("silly") {
        change.vibe = .playful
      } else if lower.contains("direct") || lower.contains("blunt") {
        change.vibe = .direct
      }
    }
    if lower.contains("strict") && !lower.contains("less strict") || lower.contains("picky") {
      change.tolerance = .strict
    } else if lower.contains("less strict") || lower.contains("relaxed") || lower.contains("looser") {
      change.tolerance = .relaxed
    }
    if lower.contains("auto") {
      let off = ["don't", "dont", "do not", "stop", "off", "no auto", "disable", "manual"]
      change.autoShoot = !off.contains { lower.contains($0) }
    }
    if let note = firstCapture(#"(?:remember|note) (?:that )?(.+)"#, in: message) {
      change.rememberNote = note.trimmingCharacters(in: CharacterSet(charactersIn: " .!"))
    }
    return change
  }

  private static func firstCapture(_ pattern: String, in text: String) -> String? {
    guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]),
      let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
      match.numberOfRanges > 1, let range = Range(match.range(at: 1), in: text)
    else { return nil }
    return String(text[range])
  }
}
