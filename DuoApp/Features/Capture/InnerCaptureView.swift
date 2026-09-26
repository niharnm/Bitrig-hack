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
  @State private var isSubjectPreviewPresented = false
  @State private var subscriptionMessage: String?
  @Environment(\.entitlementState) private var entitlementState
  @Environment(\.presentPaywall) private var presentPaywall
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  private var isPro: Bool { entitlementState.isPro || coach.isProSimulated }
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

  private var captureShell: some View {
    ZStack {
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
      controlScrim
      shutterFlash
      if isStarting {
        startingOverlay
      }
      if let countdown = coach.countdown {
        // Mirrors the outer countdown so the photographer sees progress after pressing the shutter.
        CountdownView(value: countdown)
          .allowsHitTesting(false)
      }
      VStack(spacing: 0) {
        topBar
        statusStack
        Spacer(minLength: 0)
        bottomControls
      }
    }
    .toolbarVisibility(.hidden, for: .navigationBar)
    .sheet(isPresented: $isSettingsPresented) {
      settingsSheet
    }
    .sheet(isPresented: $isSubjectPreviewPresented) {
      SubjectCoachView(model: coach)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
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

  /// Settings on the leading edge, Pro on the trailing edge. Nothing else competes with the preview.
  private var topBar: some View {
    HStack {
      Button("capture.settings.title", systemImage: "gearshape") {
        isSettingsPresented = true
      }
      .labelStyle(.iconOnly)
      .buttonStyle(.glass)
      .buttonBorderShape(.circle)
      Spacer()
      proControl
    }
    .tint(.white)
    .padding(.horizontal, FilmToolTokens.Space.s4)
    .padding(.top, FilmToolTokens.Space.s2)
  }

  /// Only real problems surface here, as one quiet pill.
  @ViewBuilder
  private var statusStack: some View {
    VStack(spacing: FilmToolTokens.Space.s3) {
      if let banner {
        Text(banner)
          .font(.footnote.weight(.medium))
          .foregroundStyle(FilmToolTokens.Palette.ink)
          .padding(.horizontal, FilmToolTokens.Space.s3)
          .padding(.vertical, FilmToolTokens.Space.s2)
          .glassEffect(in: Capsule())
      }
      if isSessionFailed {
        Button("error.retry") {
          Task { await capture.start() }
        }
        .buttonStyle(.glassProminent)
        .tint(FilmToolTokens.Palette.accent)
      }
    }
    .padding(.top, FilmToolTokens.Space.s3)
  }

  /// Film stock strip above a symmetric shutter row, like the system Camera app.
  private var bottomControls: some View {
    VStack(spacing: FilmToolTokens.Space.s5) {
      // Locked stocks open the paywall only through presentPaywall, which is inner-display only.
      FilmStockSelectorView(selectedStock: $selectedStock, isPro: isPro)
      HStack {
        leadingSlot
          .frame(maxWidth: .infinity)
        shutterButton
        flipButton
          .frame(maxWidth: .infinity)
      }
    }
    .padding(.horizontal, FilmToolTokens.Space.s5)
    .padding(.bottom, FilmToolTokens.Space.s4)
  }

  /// Darkens the bottom of the preview so the controls stay legible over bright scenes.
  private var controlScrim: some View {
    LinearGradient(
      colors: [.clear, .black.opacity(0.55)],
      startPoint: .center,
      endPoint: .bottom
    )
    .ignoresSafeArea()
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

  /// One status line at most, and only when the photographer can act on it.
  private var banner: LocalizedStringKey? {
    if isStarting { return nil }
    if case .failed = capture.phase {
      return "error.sessionFailed"
    }
    if capture.lastPhotoFailed {
      return "capture.banner.photoFailed"
    }
    return nil
  }

  @ViewBuilder
  private var flipButton: some View {
    if capture.isLive {
      Button("capture.flip", systemImage: "camera.rotate") {
        Task { await capture.flipCamera() }
      }
      .labelStyle(.iconOnly)
      .font(FilmToolTokens.Control.iconFont)
      .frame(width: FilmToolTokens.Control.minHit, height: FilmToolTokens.Control.minHit)
      .buttonStyle(.glass)
      .buttonBorderShape(.circle)
      .controlSize(.large)
      .tint(.white)
      .disabled(capture.phase == .shutterFlash)
    } else {
      Color.clear.frame(width: FilmToolTokens.Control.minHit, height: FilmToolTokens.Control.minHit)
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

  /// Where the Camera app puts the last photo: the subject screen toggle, or a thumbnail of what the subject sees.
  @ViewBuilder
  private var leadingSlot: some View {
    if isSubjectAvailable {
      // Shown only while the system can present the accessory; enabled is the user's choice.
      Toggle("capture.subjectToggle", systemImage: "person.crop.rectangle", isOn: $isSubjectEnabled)
        .toggleStyle(.button)
        .labelStyle(.iconOnly)
        .font(FilmToolTokens.Control.iconFont)
        .frame(width: FilmToolTokens.Control.minHit, height: FilmToolTokens.Control.minHit)
        .buttonStyle(.glass)
        .buttonBorderShape(.circle)
        .controlSize(.large)
        // On reads as amber, like the Camera app's active toggles, so the white glyph stays visible.
        .tint(FilmToolTokens.Palette.accent)
    } else if !isStarting {
      subjectThumbnail
    }
  }

  /// Without the accessory, a tap shows the photographer what the subject would see.
  private var subjectThumbnail: some View {
    Button {
      isSubjectPreviewPresented = true
    } label: {
      SubjectCoachView(model: coach)
        .frame(width: 466, height: 678)
        .scaleEffect(48.0 / 466)
        .frame(width: 48, height: 70)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay(
          RoundedRectangle(cornerRadius: 8, style: .continuous)
            .stroke(.white.opacity(0.6), lineWidth: 1.5))
        .contentShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
    .buttonStyle(FilmToolSideButtonStyle())
    .accessibilityLabel("capture.subjectPreview")
  }

  @ViewBuilder
  private var proControl: some View {
    if isPro {
      Label(
        LocalizedStringKey(
          entitlementState.isPro ? "capture.proActive" : "capture.simulatedProActive"
        ), systemImage: "checkmark.seal.fill"
      )
      .font(.footnote.weight(.semibold))
      .foregroundStyle(GuideOvalView.accent)
      .padding(.horizontal, FilmToolTokens.Space.s3)
      .padding(.vertical, FilmToolTokens.Space.s2)
      .glassEffect(in: Capsule())
    } else {
      Button("capture.proCTA", systemImage: "sparkles") {
        presentPaywall()
      }
      .font(.footnote.weight(.semibold))
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
          .stroke(.white, lineWidth: 4)
        Circle()
          .fill(.white)
          .padding(7)
      }
      .frame(
        width: FilmToolTokens.Control.shutterSize,
        height: FilmToolTokens.Control.shutterSize)
      .contentShape(Circle())
    }
    .buttonStyle(FilmToolShutterButtonStyle())
    .disabled(
      isStarting || isSessionFailed || capture.phase == .shutterFlash || coach.countdown != nil)
    // Peak-End: haptic on shutterFlash entry, same-frame as the flash (causality).
    .sensoryFeedback(.impact(weight: .light), trigger: capture.phase == .shutterFlash) { _, isFlashing in
      // Fire on entry only; the trigger also changes when the flash ends.
      isFlashing
    }
    .accessibilityLabel("capture.shutter")
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
