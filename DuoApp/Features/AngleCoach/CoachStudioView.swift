import PhotosUI
import SwiftUI

/// Inner-display sheet: save your best angle, talk to your coach, and customize it.
struct CoachStudioView: View {
  /// JPEG of the most recent shot, offered as the best angle.
  let lastPhotoData: Data?
  @State private var chat = CoachChatModel()
  @State private var draft = ""
  @State private var pickerItem: PhotosPickerItem?
  @State private var angleError: String?
  @FocusState private var isInputFocused: Bool
  @Environment(\.dismiss) private var dismiss
  private let angleStore = BestAngleStore.shared
  private let personaStore = CoachPersonaStore.shared

  private static let suggestionKeys = [
    "coach.suggestion.goodSide",
    "coach.suggestion.cheese",
    "coach.suggestion.calm",
    "coach.suggestion.seconds",
  ]

  var body: some View {
    NavigationStack {
      ScrollViewReader { proxy in
        ScrollView {
          VStack(alignment: .leading, spacing: FilmToolTokens.Space.s4) {
            engineStatus
            bestAngleCard
            conversation
            Color.clear.frame(height: 1).id(Self.bottomID)
          }
          .padding(FilmToolTokens.Space.s4)
        }
        .scrollDismissesKeyboard(.interactively)
        .onChange(of: chat.messages.last?.text) {
          withAnimation { proxy.scrollTo(Self.bottomID, anchor: .bottom) }
        }
      }
      .safeAreaInset(edge: .bottom) { inputBar }
      .background(FilmToolTokens.Palette.canvas.ignoresSafeArea())
      .navigationTitle(personaStore.persona.name)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          NavigationLink {
            CoachCustomizeView(store: personaStore)
          } label: {
            Label("coach.customize.title", systemImage: "slider.horizontal.3")
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button(role: .close) {
            dismiss()
          }
        }
      }
    }
    .onChange(of: pickerItem) { _, item in
      guard let item else { return }
      Task {
        let data = try? await item.loadTransferable(type: Data.self)
        pickerItem = nil
        await saveBestAngle(data)
      }
    }
    .presentationDetents([.large])
    .preferredColorScheme(.dark)
  }

  private static let bottomID = "coach.bottom"

  private var engineStatus: some View {
    Group {
      switch chat.engine {
      case .onDevice:
        Label("coach.engine.onDevice", systemImage: "sparkles")
      case .basic(let reasonKey):
        Label(LocalizedStringKey(reasonKey), systemImage: "text.bubble")
      }
    }
    .font(.footnote.weight(.medium))
    .foregroundStyle(FilmToolTokens.Palette.inkMuted)
  }

  // MARK: Best angle

  private var bestAngleCard: some View {
    VStack(alignment: .leading, spacing: FilmToolTokens.Space.s3) {
      Text("coach.bestAngle.title")
        .font(.headline)
        .foregroundStyle(FilmToolTokens.Palette.ink)
      if let image = angleStore.referenceImage, let profile = angleStore.profile {
        HStack(alignment: .top, spacing: FilmToolTokens.Space.s3) {
          Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 84, height: 112)
            .clipShape(RoundedRectangle(cornerRadius: FilmToolTokens.Radius.control, style: .continuous))
            .accessibilityLabel("coach.bestAngle.photo")
          VStack(alignment: .leading, spacing: FilmToolTokens.Space.s1) {
            ForEach(profile.summaryKeys, id: \.self) { key in
              Label(LocalizedStringKey(key), systemImage: "checkmark")
                .labelStyle(SummaryLabelStyle())
            }
          }
        }
        Text("coach.bestAngle.howItWorks")
          .font(.footnote)
          .foregroundStyle(FilmToolTokens.Palette.inkMuted)
      } else {
        Text("coach.bestAngle.empty")
          .font(.subheadline)
          .foregroundStyle(FilmToolTokens.Palette.inkMuted)
      }
      HStack(spacing: FilmToolTokens.Space.s2) {
        // The picker label builds off the main actor, so decide its title here.
        let pickerTitle: LocalizedStringKey =
          angleStore.profile == nil ? "coach.bestAngle.choose" : "coach.bestAngle.replace"
        PhotosPicker(selection: $pickerItem, matching: .images) {
          Label(pickerTitle, systemImage: "photo.on.rectangle")
        }
        .buttonStyle(.glassProminent)
        .tint(FilmToolTokens.Palette.accent)
        if lastPhotoData != nil {
          Button("coach.bestAngle.useLast", systemImage: "camera") {
            Task { await saveBestAngle(lastPhotoData) }
          }
          .buttonStyle(.glass)
        }
        Spacer(minLength: 0)
        if angleStore.profile != nil {
          Button("coach.bestAngle.remove", systemImage: "trash", role: .destructive) {
            angleStore.clear()
          }
          .labelStyle(.iconOnly)
          .buttonStyle(.glass)
        }
      }
      .disabled(angleStore.isAnalyzing)
      if angleStore.isAnalyzing {
        ProgressView("coach.bestAngle.scanning")
          .tint(FilmToolTokens.Palette.ink)
      }
      if let angleError {
        Text(angleError)
          .font(.footnote.weight(.medium))
          .foregroundStyle(FilmToolTokens.Palette.danger)
      }
    }
    .padding(FilmToolTokens.Space.s4)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      FilmToolTokens.Palette.panel,
      in: RoundedRectangle(cornerRadius: FilmToolTokens.Radius.tip, style: .continuous))
  }

  private func saveBestAngle(_ data: Data?) async {
    angleError = nil
    guard let data else {
      angleError = BestAngleError.unreadableImage.errorDescription
      return
    }
    do {
      try await angleStore.setReference(imageData: data)
    } catch {
      angleError = error.localizedDescription
    }
  }

  // MARK: Conversation

  private var conversation: some View {
    VStack(alignment: .leading, spacing: FilmToolTokens.Space.s3) {
      ForEach(chat.messages) { message in
        MessageBubble(message: message, isTyping: chat.isResponding && message.text.isEmpty)
      }
      if !chat.lastUpdates.isEmpty {
        VStack(alignment: .leading, spacing: FilmToolTokens.Space.s1) {
          ForEach(chat.lastUpdates, id: \.self) { update in
            Label(update, systemImage: "checkmark.circle.fill")
              .font(.footnote.weight(.medium))
              .foregroundStyle(FilmToolTokens.Palette.success)
          }
        }
      }
      if chat.messages.count <= 1 {
        suggestions
      }
    }
  }

  private var suggestions: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: FilmToolTokens.Space.s2) {
        ForEach(Self.suggestionKeys, id: \.self) { key in
          Button(LocalizedStringKey(key)) {
            send(String(localized: String.LocalizationValue(key)))
          }
          .font(.footnote.weight(.medium))
          .buttonStyle(.glass)
        }
      }
    }
    .disabled(chat.isResponding)
  }

  private var inputBar: some View {
    HStack(alignment: .bottom, spacing: FilmToolTokens.Space.s2) {
      TextField("coach.input.placeholder", text: $draft, axis: .vertical)
        .lineLimit(1...4)
        .focused($isInputFocused)
        .submitLabel(.send)
        .onSubmit { send(draft) }
        .padding(.horizontal, FilmToolTokens.Space.s4)
        .padding(.vertical, FilmToolTokens.Space.s3)
        .glassEffect(in: RoundedRectangle(cornerRadius: 22, style: .continuous))
      Button("coach.input.send", systemImage: "arrow.up") {
        send(draft)
      }
      .labelStyle(.iconOnly)
      .font(.body.weight(.bold))
      .frame(width: FilmToolTokens.Control.minHit, height: FilmToolTokens.Control.minHit)
      .buttonStyle(.glassProminent)
      .buttonBorderShape(.circle)
      .tint(FilmToolTokens.Palette.accent)
      .disabled(chat.isResponding || draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    .padding(.horizontal, FilmToolTokens.Space.s4)
    .padding(.vertical, FilmToolTokens.Space.s2)
  }

  private func send(_ text: String) {
    let message = text
    draft = ""
    Task { await chat.send(message) }
  }
}

private struct SummaryLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: .firstTextBaseline, spacing: FilmToolTokens.Space.s2) {
      configuration.icon
        .font(.caption.weight(.bold))
        .foregroundStyle(FilmToolTokens.Palette.accent)
      configuration.title
        .font(.subheadline)
        .foregroundStyle(FilmToolTokens.Palette.ink)
    }
  }
}

private struct MessageBubble: View {
  let message: CoachMessage
  let isTyping: Bool

  private var isOwner: Bool { message.role == .owner }

  var body: some View {
    HStack {
      if isOwner { Spacer(minLength: 48) }
      Group {
        if isTyping {
          ProgressView()
            .tint(FilmToolTokens.Palette.inkMuted)
            .accessibilityLabel("coach.typing")
        } else {
          Text(message.text)
            .textSelection(.enabled)
        }
      }
      .font(.body)
      .foregroundStyle(isOwner ? FilmToolTokens.Palette.canvas : FilmToolTokens.Palette.ink)
      .padding(.horizontal, FilmToolTokens.Space.s4)
      .padding(.vertical, FilmToolTokens.Space.s3)
      .background(
        isOwner ? FilmToolTokens.Palette.accent : FilmToolTokens.Palette.panelRaised,
        in: RoundedRectangle(cornerRadius: 18, style: .continuous))
      if !isOwner { Spacer(minLength: 48) }
    }
  }
}

/// Every coach setting in one form. The chat can change the same settings by asking.
struct CoachCustomizeView: View {
  @Bindable var store: CoachPersonaStore

  var body: some View {
    Form {
      Section("coach.customize.identity") {
        TextField("coach.customize.name", text: $store.persona.name)
          .textInputAutocapitalization(.words)
        Picker("coach.customize.vibe", selection: $store.persona.vibe) {
          ForEach(CoachVibe.allCases) { vibe in
            Text(LocalizedStringKey(vibe.titleKey)).tag(vibe)
          }
        }
      }
      Section {
        TextField("coach.customize.phrase", text: $store.persona.countdownPhrase)
        Stepper(value: $store.persona.countdownSeconds, in: CoachPersona.secondsRange) {
          LabeledContent("coach.customize.seconds") {
            Text(store.persona.countdownSeconds, format: .number)
          }
        }
      } header: {
        Text("coach.customize.countdown")
      } footer: {
        Text("coach.customize.countdownFooter")
      }
      Section {
        Picker("coach.customize.tolerance", selection: $store.persona.tolerance) {
          ForEach(AngleTolerance.allCases) { tolerance in
            Text(LocalizedStringKey(tolerance.titleKey)).tag(tolerance)
          }
        }
        Toggle("coach.customize.autoShoot", isOn: $store.persona.autoShoot)
      } header: {
        Text("coach.customize.matching")
      } footer: {
        Text("coach.customize.matchingFooter")
      }
      Section("coach.customize.notes") {
        TextField("coach.customize.notesPlaceholder", text: $store.persona.notes, axis: .vertical)
          .lineLimit(3...6)
      }
    }
    .navigationTitle("coach.customize.title")
    .navigationBarTitleDisplayMode(.inline)
    .onDisappear { store.fillBlankText() }
  }
}
