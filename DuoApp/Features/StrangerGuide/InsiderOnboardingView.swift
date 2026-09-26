import Observation
import PhotosUI
import SwiftUI

#if canImport(RevenueCat)
  import RevenueCat
#endif

/// The owner's account on this phone: name, preferred angle, and whether Pro is unlocked.
/// Stored in UserDefaults only. Launch with `-resetDemo YES` to start from account creation.
@MainActor
@Observable
final class InsiderAccount {
  private(set) var name: String?
  private(set) var preferred: PreferredAngle?
  private(set) var proUnlocked: Bool
  private(set) var aiSummary: String?

  private let defaults: UserDefaults

  private enum Key {
    static let name = "insider.account.name"
    static let userID = "insider.account.userID"
    static let preferred = "insider.account.preferred"
    static let proUnlocked = "insider.account.proUnlocked"
    static let aiSummary = "insider.account.aiSummary"
    static let all = [name, userID, preferred, proUnlocked, aiSummary]
  }

  init(defaults: UserDefaults = .standard) {
    self.defaults = defaults
    if defaults.bool(forKey: "resetDemo") {
      Key.all.forEach(defaults.removeObject(forKey:))
    }
    name = defaults.string(forKey: Key.name)
    proUnlocked = defaults.bool(forKey: Key.proUnlocked)
    aiSummary = defaults.string(forKey: Key.aiSummary)
    preferred = defaults.data(forKey: Key.preferred)
      .flatMap { try? JSONDecoder().decode(PreferredAngle.self, from: $0) }
  }

  var hasAccount: Bool { name != nil }

  func createAccount(name: String) {
    let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return }
    let userID = "insider-\(UUID().uuidString.lowercased())"
    defaults.set(trimmed, forKey: Key.name)
    defaults.set(userID, forKey: Key.userID)
    self.name = trimmed
    // Each account is its own RevenueCat customer, so a new account starts on the free tier.
    #if canImport(RevenueCat)
      if Purchases.isConfigured {
        Task { _ = try? await Purchases.shared.logIn(userID) }
      }
    #endif
  }

  func save(preferred angle: PreferredAngle, aiSummary summary: String?) {
    let clamped = angle.clamped()
    defaults.set(try? JSONEncoder().encode(clamped), forKey: Key.preferred)
    defaults.set(summary, forKey: Key.aiSummary)
    preferred = clamped
    aiSummary = summary
  }

  func unlockPro() {
    defaults.set(true, forKey: Key.proUnlocked)
    proUnlocked = true
  }

  func signOut() {
    Key.all.forEach(defaults.removeObject(forKey:))
    name = nil
    preferred = nil
    proUnlocked = false
    aiSummary = nil
    #if canImport(RevenueCat)
      if Purchases.isConfigured {
        Task { _ = try? await Purchases.shared.logOut() }
      }
    #endif
  }
}

/// Launch flow: create an account, set your angles, then hand the phone to someone.
struct InsiderRootView: View {
  @State private var account = InsiderAccount()
  @State private var isEditingAngles = false

  var body: some View {
    Group {
      if !account.hasAccount {
        AccountCreateView { account.createAccount(name: $0) }
      } else if let target = account.preferred {
        StrangerShootView(
          target: target,
          ownerName: account.name ?? "",
          isPro: account.proUnlocked,
          onEditAngles: { isEditingAngles = true },
          onSignOut: { account.signOut() }
        )
      } else {
        AngleSetupView(account: account, onDone: nil)
      }
    }
    .background(FilmToolTokens.Palette.canvas.ignoresSafeArea())
    .fullScreenCover(isPresented: $isEditingAngles) {
      AngleSetupView(account: account, onDone: { isEditingAngles = false })
    }
  }
}

// MARK: - Account

struct AccountCreateView: View {
  let onCreate: (String) -> Void
  @State private var name = ""
  @FocusState private var nameFocused: Bool

  private var canCreate: Bool {
    !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }

  var body: some View {
    VStack(alignment: .leading, spacing: FilmToolTokens.Space.s5) {
      Spacer(minLength: 0)
      Text(FilmToolTokens.Brand.name)
        .font(.system(size: 40, weight: .bold, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.ink)
      Text("Your best angle, even when a stranger takes the photo.")
        .font(.system(size: 20, weight: .medium, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        .fixedSize(horizontal: false, vertical: true)

      TextField("", text: $name, prompt: Text("Your name").foregroundStyle(FilmToolTokens.Palette.inkFaint))
        .font(.system(size: 20, weight: .medium, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.ink)
        .textContentType(.name)
        .submitLabel(.done)
        .focused($nameFocused)
        .onSubmit { if canCreate { onCreate(name) } }
        .padding(FilmToolTokens.Space.s4)
        .background(
          FilmToolTokens.Palette.panel,
          in: RoundedRectangle(cornerRadius: FilmToolTokens.Radius.control, style: .continuous))

      Button {
        onCreate(name)
      } label: {
        PrimaryButtonLabel(title: "Create account")
      }
      .disabled(!canCreate)
      .opacity(canCreate ? 1 : 0.4)

      Text("Your account and angles stay on this phone.")
        .font(.system(size: 13, weight: .regular, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.inkFaint)
      Spacer(minLength: 0)
    }
    .padding(FilmToolTokens.Space.s5)
    .frame(maxWidth: 520)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(FilmToolTokens.Palette.canvas.ignoresSafeArea())
    .onAppear { nameFocused = true }
  }
}

// MARK: - Angle setup

struct AngleSetupView: View {
  let account: InsiderAccount
  /// Set when editing from the shoot screen; nil during first setup.
  let onDone: (() -> Void)?

  @State private var draft: PreferredAngle
  @State private var aiSummary: String?
  @State private var aiApplied = false
  @State private var isAnalyzing = false
  @State private var pickedPhotos: [PhotosPickerItem] = []
  @State private var isProSheetPresented = false

  init(account: InsiderAccount, onDone: (() -> Void)?) {
    self.account = account
    self.onDone = onDone
    _draft = State(initialValue: account.preferred ?? .eyeLevel)
    _aiSummary = State(initialValue: account.aiSummary)
  }

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: FilmToolTokens.Space.s5) {
        header

        StageFrame {
          StickSubjectStage(view: draft)
        }
        .frame(height: 220)

        ForEach(AngleAxis.allCases) { axis in
          AngleAxisRow(
            axis: axis,
            value: Binding(
              get: { axis.value(in: draft) },
              set: { newValue in
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                  axis.set(newValue, in: &draft)
                }
                aiApplied = false
              }))
        }

        aiCard

        Button {
          account.save(preferred: draft, aiSummary: aiApplied ? aiSummary : nil)
          onDone?()
        } label: {
          PrimaryButtonLabel(title: onDone == nil ? "Save my angles" : "Save changes")
        }
      }
      .padding(FilmToolTokens.Space.s5)
      .frame(maxWidth: 560)
      .frame(maxWidth: .infinity)
    }
    .background(FilmToolTokens.Palette.canvas.ignoresSafeArea())
    .sheet(isPresented: $isProSheetPresented) {
      AngleProSheet(onUnlocked: { account.unlockPro() })
    }
    .onChange(of: pickedPhotos) { _, items in
      guard !items.isEmpty else { return }
      Task { await analyze(items) }
    }
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: FilmToolTokens.Space.s2) {
      HStack {
        Text(onDone == nil ? "Hi \(account.name ?? "there")" : "Your angles")
          .font(.system(size: 15, weight: .semibold, design: .rounded))
          .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        Spacer()
        if let onDone {
          Button("Cancel", action: onDone)
            .font(.system(size: 15, weight: .semibold, design: .rounded))
            .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        }
      }
      Text("How do you like your photos?")
        .font(.system(size: 28, weight: .bold, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.ink)
      Text("Pick the angle you look best from. Whoever takes your photo gets guided to it.")
        .font(.system(size: 15, weight: .regular, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
    }
  }

  private var aiCard: some View {
    VStack(alignment: .leading, spacing: FilmToolTokens.Space.s3) {
      HStack(spacing: FilmToolTokens.Space.s2) {
        Image(systemName: "sparkles")
          .foregroundStyle(FilmToolTokens.Palette.accent)
        Text("Let AI find your best angles")
          .font(.system(size: 17, weight: .semibold, design: .rounded))
          .foregroundStyle(FilmToolTokens.Palette.ink)
        Spacer()
        ProBadge()
      }
      Text(
        "Pick your favorite photos of yourself. Insider analyzes them automatically, on this phone, and builds the pattern of your best angles."
      )
      .font(.system(size: 14, weight: .regular, design: .rounded))
      .foregroundStyle(FilmToolTokens.Palette.inkMuted)

      if isAnalyzing {
        HStack(spacing: FilmToolTokens.Space.s2) {
          ProgressView().tint(FilmToolTokens.Palette.accent)
          Text("Analyzing \(pickedPhotos.count) photos…")
            .font(.system(size: 15, weight: .medium, design: .rounded))
            .foregroundStyle(FilmToolTokens.Palette.ink)
        }
      } else if account.proUnlocked {
        PhotosPicker(selection: $pickedPhotos, maxSelectionCount: 20, matching: .images) {
          SecondaryButtonLabel(title: "Choose favorite photos", symbol: "photo.on.rectangle")
        }
      } else {
        Button {
          isProSheetPresented = true
        } label: {
          SecondaryButtonLabel(title: "Unlock with Pro", symbol: "lock.fill")
        }
      }

      if let aiSummary {
        Text(aiSummary)
          .font(.system(size: 14, weight: .medium, design: .rounded))
          .foregroundStyle(aiApplied ? FilmToolTokens.Palette.accent : FilmToolTokens.Palette.inkMuted)
      }
    }
    .padding(FilmToolTokens.Space.s4)
    .background(
      FilmToolTokens.Palette.panel,
      in: RoundedRectangle(cornerRadius: FilmToolTokens.Radius.tip, style: .continuous))
  }

  private func analyze(_ items: [PhotosPickerItem]) async {
    isAnalyzing = true
    defer {
      isAnalyzing = false
      pickedPhotos = []
    }
    var photos: [Data] = []
    for item in items {
      if let data = try? await item.loadTransferable(type: Data.self) {
        photos.append(data)
      }
    }
    let samples = await FavoritePhotoAnalyzer.samples(from: photos)
    guard let learned = FavoritePhotoPattern.preferredAngle(from: samples) else {
      aiSummary =
        "No faces found in those \(items.count) photos. Pick photos where your face is clear, or set your angles by hand."
      aiApplied = false
      return
    }
    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
      draft = learned
    }
    aiSummary = "AI found your face in \(samples.count) of \(items.count) photos and set your angles."
    aiApplied = true
  }
}

private struct AngleAxisRow: View {
  let axis: AngleAxis
  @Binding var value: Double

  var body: some View {
    let selected = axis.nearestOption(to: value)
    VStack(alignment: .leading, spacing: FilmToolTokens.Space.s2) {
      Text(axis.title)
        .font(.system(size: 13, weight: .semibold, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
      HStack(spacing: FilmToolTokens.Space.s2) {
        ForEach(axis.options) { option in
          Button {
            value = option.value
          } label: {
            ChoiceChip(title: option.title, isSelected: option == selected)
          }
          .buttonStyle(FilmToolSideButtonStyle())
        }
      }
    }
  }
}

// MARK: - Pro

/// Pro unlocks the AI analysis. Buys through the RevenueCat Test Store; a labeled demo fallback appears if that fails.
struct AngleProSheet: View {
  let onUnlocked: () -> Void
  @Environment(\.dismiss) private var dismiss
  @State private var isPurchasing = false
  @State private var failure: String?

  var body: some View {
    VStack(alignment: .leading, spacing: FilmToolTokens.Space.s4) {
      HStack {
        Text("\(FilmToolTokens.Brand.name) Pro")
          .font(.system(size: 28, weight: .bold, design: .rounded))
          .foregroundStyle(FilmToolTokens.Palette.ink)
        Spacer()
        Button("Close") { dismiss() }
          .font(.system(size: 15, weight: .semibold, design: .rounded))
          .foregroundStyle(FilmToolTokens.Palette.inkMuted)
      }
      Text("AI analyzes your photos automatically and learns your best angles.")
        .font(.system(size: 17, weight: .medium, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.ink)
      Text("Free: set your angles by hand. Pro: AI builds them from your favorite photos.")
        .font(.system(size: 15, weight: .regular, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)

      Button {
        Task { await purchase() }
      } label: {
        PrimaryButtonLabel(title: isPurchasing ? "Purchasing…" : "Unlock Pro")
      }
      .disabled(isPurchasing)

      if let failure {
        Text(failure)
          .font(.system(size: 14, weight: .medium, design: .rounded))
          .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        Button {
          unlock()
        } label: {
          SecondaryButtonLabel(title: "Simulate purchase (demo)", symbol: "checkmark.seal")
        }
      }

      Text("RevenueCat Test Store purchase. No real charge.")
        .font(.system(size: 13, weight: .regular, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.inkFaint)
    }
    .padding(FilmToolTokens.Space.s5)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .background(FilmToolTokens.Palette.panel.ignoresSafeArea())
    .presentationDetents([.medium, .large])
    .preferredColorScheme(.dark)
  }

  private func unlock() {
    onUnlocked()
    dismiss()
  }

  private func purchase() async {
    isPurchasing = true
    failure = nil
    defer { isPurchasing = false }
    #if canImport(RevenueCat)
      do {
        let snapshot = try await OfferingsRepository.purchase(packageIdentifier: RCIdentifiers.packageId)
        if snapshot.isUnlocked {
          unlock()
        } else {
          failure = "The purchase finished but Pro is not active yet."
        }
      } catch SubscriptionError.cancelled {
        failure = "Purchase cancelled."
      } catch {
        failure = "Test Store purchase failed: \(error.localizedDescription)"
      }
    #else
      failure = "Purchases are not available in this build."
    #endif
  }
}

// MARK: - Shared pieces

struct PrimaryButtonLabel: View {
  let title: String

  var body: some View {
    Text(title)
      .font(.system(size: 17, weight: .semibold, design: .rounded))
      .foregroundStyle(FilmToolTokens.Palette.canvas)
      .frame(maxWidth: .infinity, minHeight: 52)
      .background(
        FilmToolTokens.Palette.accent,
        in: RoundedRectangle(cornerRadius: FilmToolTokens.Radius.control, style: .continuous))
  }
}

struct SecondaryButtonLabel: View {
  let title: String
  let symbol: String

  var body: some View {
    Label(title, systemImage: symbol)
      .font(.system(size: 16, weight: .semibold, design: .rounded))
      .foregroundStyle(FilmToolTokens.Palette.accent)
      .frame(maxWidth: .infinity, minHeight: FilmToolTokens.Control.minHit)
      .background(
        FilmToolTokens.Palette.panelRaised,
        in: RoundedRectangle(cornerRadius: FilmToolTokens.Radius.control, style: .continuous))
  }
}

struct ChoiceChip: View {
  let title: String
  let isSelected: Bool

  var body: some View {
    Text(title)
      .font(.system(size: 15, weight: .semibold, design: .rounded))
      .lineLimit(1)
      .minimumScaleFactor(0.75)
      .foregroundStyle(isSelected ? FilmToolTokens.Palette.accent : FilmToolTokens.Palette.ink)
      .frame(maxWidth: .infinity, minHeight: FilmToolTokens.Control.minHit)
      .background(
        FilmToolTokens.Palette.panel,
        in: RoundedRectangle(cornerRadius: FilmToolTokens.Radius.control, style: .continuous)
      )
      .overlay {
        RoundedRectangle(cornerRadius: FilmToolTokens.Radius.control, style: .continuous)
          .stroke(isSelected ? FilmToolTokens.Palette.accent : .clear, lineWidth: 1.5)
      }
      .contentShape(Rectangle())
  }
}

struct ProBadge: View {
  var body: some View {
    Text("PRO")
      .font(.system(size: 11, weight: .bold, design: .rounded))
      .tracking(1)
      .foregroundStyle(FilmToolTokens.Palette.canvas)
      .padding(.horizontal, FilmToolTokens.Space.s2)
      .padding(.vertical, 3)
      .background(FilmToolTokens.Palette.accent, in: Capsule())
  }
}
