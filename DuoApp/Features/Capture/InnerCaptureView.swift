import SwiftUI
#if canImport(RevenueCat)
  import RevenueCat
#endif
#if canImport(RevenueCatUI)
  import RevenueCatUI
#endif

/// Inner capture shell (SCR-OL-B). Hosts the outer coach and keeps the shutter working without it.
struct InnerCaptureView: View {
  @State private var capture = CaptureSessionController()
  @State private var coach = CoachModel()
  @State private var selectedStock: FilmStock = .natural
  @State private var isSubjectEnabled = true
  @State private var isSubjectAvailable = false
  @State private var isSettingsPresented = false
  @State private var subscriptionMessage: String?
  @ObservedObject private var entitlements = EntitlementsModel.shared
  @Environment(\.presentPaywall) private var presentPaywall
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.scenePhase) private var scenePhase

  private var isPro: Bool { entitlements.state.isPro || coach.isProSimulated }
  private var isPurchasesConfigured: Bool {
    #if canImport(RevenueCat)
      Purchases.isConfigured
    #else
      false
    #endif
  }
  private var isStarting: Bool { capture.phase == .starting }
  private var isSessionFailed: Bool {
    if case .failed = capture.phase { return true }
    return false
  }

  var body: some View {
    Group {
      switch capture.permission {
      case .notDetermined, .requesting:
        PermissionPrimerView(isRequesting: capture.permission == .requesting) {
          Task { await capture.requestAccess() }
        }
      case .denied, .restricted:
        CaptureDeniedView(isRestricted: capture.permission == .restricted)
      case .authorized:
        captureShell
      }
    }
    .onChange(of: scenePhase, initial: true) { _, phase in
      if phase == .active {
        capture.refreshPermission()
      }
    }
  }

  private var captureShell: some View {
    ZStack(alignment: .bottom) {
      FilmToolTokens.Palette.canvas.ignoresSafeArea()
      if capture.isLive {
        CapturePreviewView(session: capture.session)
          .contrast(selectedStock.grade.contrast)
          .saturation(selectedStock.grade.saturation)
          .overlay {
            if selectedStock.grade.amberTintOpacity > 0 {
              selectedStock.grade.tintColor
                .opacity(selectedStock.grade.amberTintOpacity)
                .blendMode(.color)
                .allowsHitTesting(false)
            }
          }
          .ignoresSafeArea()
      }
      shutterFlash
      brandWhisper
      if isStarting {
        startingOverlay
      }
      VStack(spacing: FilmToolTokens.Space.s4) {
        // Stacked above the controls so the film stock row never covers the tip plate.
        if !isSubjectAvailable, !isStarting {
          subjectPreview
        }
        if let banner {
          Text(banner)
            .font(.footnote.weight(.medium))
            .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        }
        if isSessionFailed {
          Button("error.retry") {
            Task { await capture.start() }
          }
          .buttonStyle(.glassProminent)
          .tint(FilmToolTokens.Palette.accent)
        }
        // Locked stocks open the paywall only through presentPaywall, which is inner-display only.
        FilmStockSelectorView(selectedStock: $selectedStock, isPro: isPro)
        shutterButton
          .frame(maxWidth: .infinity)
          .overlay(alignment: .leading) {
            HStack(spacing: FilmToolTokens.Space.s3) {
              flipButton
              subjectToggle
            }
          }
          .overlay(alignment: .trailing) {
            proControl
          }
      }
      .padding(.horizontal, FilmToolTokens.Space.s5)
      .padding(.bottom, FilmToolTokens.Space.s5)
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("capture.settings.title", systemImage: "gearshape") {
          isSettingsPresented = true
        }
      }
    }
    .sheet(isPresented: $isSettingsPresented) {
      settingsSheet
    }
    .onChange(of: isPro) { _, newIsPro in
      if !newIsPro && selectedStock.requiresPro {
        selectedStock = .natural
      }
    }
    .task {
      await capture.start()
    }
    .task {
      await coach.runTipCycle()
    }
    .onDisappear {
      capture.stop()
    }
    .modifier(
      CameraCaptureAccessoryHost(
        isEnabled: $isSubjectEnabled,
        isAvailable: $isSubjectAvailable,
        model: coach))
  }

  /// Quiet on-canvas wordmark — brand test without nav reliance (§11.0.4).
  private var brandWhisper: some View {
    VStack {
      Text("capture.brand")
        .font(FilmToolTokens.Brand.font)
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        .padding(.top, FilmToolTokens.Space.s3)
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .allowsHitTesting(false)
    .accessibilityHidden(true)
  }

  /// B.starting: Activation Energy — never leave first launch as blank charcoal.
  private var startingOverlay: some View {
    VStack(spacing: FilmToolTokens.Space.s3) {
      ProgressView()
        .tint(FilmToolTokens.Palette.ink)
      Text("capture.starting")
        .font(.subheadline.weight(.medium))
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .allowsHitTesting(false)
    .accessibilityElement(children: .combine)
  }

  /// One status line at most. Missing camera wins because it explains the black preview.
  private var banner: LocalizedStringKey? {
    if isStarting { return nil }
    if case .failed = capture.phase {
      return "error.sessionFailed"
    }
    if !capture.hasCamera {
      return "capture.banner.noDevices"
    }
    if capture.lastPhotoFailed {
      return "capture.banner.photoFailed"
    }
    return isSubjectAvailable ? nil : "capture.banner.accessoryUnavailable"
  }

  @ViewBuilder
  private var flipButton: some View {
    if capture.isLive {
      Button("capture.flip", systemImage: "camera.rotate") {
        Task { await capture.flipCamera() }
      }
      .labelStyle(.iconOnly)
      .buttonStyle(.glass)
      .tint(.white)
      .disabled(capture.phase == .shutterFlash)
    }
  }

  /// B.capturing: an opacity-only flash over the preview, so it also holds under Reduce Motion.
  private var shutterFlash: some View {
    Color.white
      .opacity(capture.phase == .shutterFlash ? 0.35 : 0)
      .ignoresSafeArea()
      .allowsHitTesting(false)
      .animation(FilmToolMotion.p1Animation(reduceMotion: reduceMotion), value: capture.phase)
      .accessibilityHidden(true)
  }

  /// While the system is not presenting the accessory, show the photographer what the subject would see.
  private var subjectPreview: some View {
    SubjectCoachView(model: coach)
      .frame(width: 466, height: 678)
      .scaleEffect(0.42)
      .frame(width: 196, height: 285)
      .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
      .overlay(
        RoundedRectangle(cornerRadius: 18, style: .continuous)
          .stroke(.white.opacity(0.2), lineWidth: 1))
      .accessibilityHidden(true)
  }

  @ViewBuilder
  private var subjectToggle: some View {
    // Shown only while the system can present the accessory; enabled is the user's choice.
    if isSubjectAvailable {
      Toggle("capture.subjectToggle", systemImage: "person.crop.rectangle", isOn: $isSubjectEnabled)
        .toggleStyle(.button)
        .labelStyle(.iconOnly)
        .tint(.white)
    }
  }

  @ViewBuilder
  private var proControl: some View {
    if isPro {
      Label(
        LocalizedStringKey(
          entitlements.state.isPro ? "capture.proActive" : "capture.simulatedProActive"
        ), systemImage: "checkmark.seal.fill"
      )
      .font(.subheadline.weight(.semibold))
      .foregroundStyle(GuideOvalView.accent)
    } else {
      Button("capture.proCTA") {
        presentPaywall()
      }
      .buttonStyle(.glass)
      .tint(GuideOvalView.accent)
      .disabled(!presentPaywall.isAvailable)
    }
  }

  private var shutterButton: some View {
    Button {
      // The shutter advances the tip (§11.3.6), runs the T3 countdown on the outer coach, then takes the photo.
      coach.advanceTip()
      Task {
        await coach.startCountdown()
        await capture.capturePhoto()
      }
    } label: {
      ZStack {
        Circle()
          .stroke(.white, lineWidth: 3)
        Circle()
          .fill(.white)
          .padding(6)
      }
      .frame(
        width: FilmToolTokens.Control.shutterSize,
        height: FilmToolTokens.Control.shutterSize)
    }
    .buttonStyle(FilmToolShutterButtonStyle())
    .disabled(
      isStarting || isSessionFailed || capture.phase == .shutterFlash || coach.countdown != nil)
    // Peak-End: haptic on shutterFlash entry, same-frame as the flash (causality).
    .sensoryFeedback(.impact(weight: .light), trigger: capture.phase == .shutterFlash) { _, isFlashing in
      // Fire on entry only; the trigger also changes when the flash ends.
      isFlashing
    }
    .accessibilityLabel("Shutter")
  }

  private var settingsSheet: some View {
    NavigationStack {
      List {
        if isPurchasesConfigured {
          Section {
            NavigationLink("capture.settings.manageSubscription") {
              subscriptionManagement
            }
            Button("capture.settings.restore") {
              Task { await restorePurchases() }
            }
            Button("capture.settings.lifetime") {
              Task { await purchase(RCIdentifiers.lifetimePackageId) }
            }
            Button("capture.settings.yearly") {
              Task { await purchase(RCIdentifiers.yearlyPackageId) }
            }
            Button("capture.settings.monthly") {
              Task { await purchase(RCIdentifiers.monthlyPackageId) }
            }
          }
        } else {
          Section {
            Text("capture.settings.purchasesUnavailable")
              .foregroundStyle(.secondary)
          }
        }
        Button("capture.settings.simulateTip") {
          coach.advanceTip()
        }
        Button {
          // Close first so the M3 bloom plays in view.
          isSettingsPresented = false
          coach.isProSimulated.toggle()
        } label: {
          LabeledContent("capture.settings.simulatePro") {
            if coach.isProSimulated {
              Image(systemName: "checkmark")
            }
          }
        }
        Button("capture.settings.simulateCountdown") {
          isSettingsPresented = false
          Task { await coach.startCountdown() }
        }
      }
      .navigationTitle("capture.settings.title")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button(role: .close) {
            isSettingsPresented = false
          }
        }
      }
      .alert(
        "capture.settings.purchases",
        isPresented: Binding(
          get: { subscriptionMessage != nil },
          set: { if !$0 { subscriptionMessage = nil } }
        )
      ) {
        Button("capture.close", role: .cancel) {
          subscriptionMessage = nil
        }
      } message: {
        Text(subscriptionMessage ?? "")
      }
    }
    .presentationDetents([.medium, .large])
  }

  @ViewBuilder
  private var subscriptionManagement: some View {
    #if canImport(RevenueCatUI)
      if isPurchasesConfigured {
        CustomerCenterView(
          navigationOptions: CustomerCenterNavigationOptions(
            usesNavigationStack: true,
            usesExistingNavigation: true,
            shouldShowCloseButton: false
          )
        )
        .onCustomerCenterRestoreFailed { error in
          subscriptionMessage = error.localizedDescription
        }
        .onCustomerCenterRestoreCompleted { customerInfo in
          EntitlementsModel.shared.apply(customerInfo: customerInfo)
          let activeIDs = customerInfo.entitlements.active.keys
          if SubscriptionAccess.isUnlocked(activeEntitlementIDs: activeIDs) {
            subscriptionMessage = String(localized: "capture.settings.restoreUnlocked")
          }
        }
      } else {
        ContentUnavailableView(
          "capture.settings.purchasesUnavailable",
          systemImage: "person.crop.circle.badge.exclamationmark")
      }
    #else
      ContentUnavailableView(
        "capture.settings.customerCenterUnavailable",
        systemImage: "person.crop.circle.badge.exclamationmark")
    #endif
  }

  private func purchase(_ packageIdentifier: String) async {
    do {
      let snapshot = try await OfferingsRepository.purchase(packageIdentifier: packageIdentifier)
      if snapshot.isUnlocked {
        isSettingsPresented = false
      }
    } catch SubscriptionError.cancelled {
      return
    } catch {
      subscriptionMessage = error.localizedDescription
    }
  }

  private func restorePurchases() async {
    do {
      let snapshot = try await OfferingsRepository.restorePurchases()
      subscriptionMessage =
        snapshot.isUnlocked
        ? String(localized: "capture.settings.restoreUnlocked")
        : String(localized: "capture.settings.restoreEmpty")
    } catch {
      subscriptionMessage = error.localizedDescription
    }
  }
}
