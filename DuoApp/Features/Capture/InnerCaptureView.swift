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
  @State private var isCoachStudioPresented = false
  @State private var subscriptionMessage: String?
  @Environment(\.entitlementState) private var entitlementState
  @Environment(\.presentPaywall) private var presentPaywall
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  private var isPro: Bool { entitlementState.isPro || coach.isProSimulated }
  private var isPurchasesConfigured: Bool {
    #if canImport(RevenueCat)
      Purchases.isConfigured
    #else
      false
    #endif
  }
  private var isStarting: Bool { capture.phase == .starting }
  private var persona: CoachPersona { coach.personaStore.persona }
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
        if let target = coach.angleStore.profile?.measurement, let frameSize = coach.angle.frameSize {
          // Where the owner's face sits in their saved photo, so the photographer can frame to it.
          PhotographerTargetView(
            frameSize: frameSize, target: target, isMatched: coach.angle.guidance?.isMatched == true)
            .ignoresSafeArea()
        }
      }
      trailingScrim
      shutterFlash
      if isStarting {
        startingOverlay
      }
      if let countdown = coach.countdown {
        // Mirrors the outer countdown so the photographer sees progress after pressing the shutter.
        CountdownView(value: countdown)
          .allowsHitTesting(false)
      } else if let cue = coach.countdownCue {
        CountdownCueView(text: cue)
          .allowsHitTesting(false)
      }
      VStack(spacing: 0) {
        topBar
        statusStack
        Spacer(minLength: 0)
        if !isStarting {
          subjectCard
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, FilmToolTokens.Space.s4)
            .padding(.bottom, FilmToolTokens.Space.s4)
        }
      }
      controlColumn
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, FilmToolTokens.Space.s5)
    }
    .toolbarVisibility(.hidden, for: .navigationBar)
    .sheet(isPresented: $isSettingsPresented) {
      settingsSheet
    }
    .sheet(isPresented: $isCoachStudioPresented) {
      CoachStudioView(lastPhotoData: capture.lastPhotoData)
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
    .onAppear {
      let coach = coach
      let capture = capture
      capture.onLiveFrame = { frame in
        let persona = coach.personaStore.persona
        let shouldShoot = coach.angle.ingest(
          frame, target: coach.angleStore.profile?.measurement, tolerance: persona.tolerance)
        // The saved angle held: count down and shoot without anyone touching the phone.
        if shouldShoot, persona.autoShoot, capture.phase == .live {
          Task { await coach.runCountdown { await capture.capturePhoto() } }
        }
      }
    }
    .onDisappear {
      capture.onLiveFrame = nil
      capture.stop()
      coach.angle.reset()
    }
    .modifier(
      CameraCaptureAccessoryHost(
        isEnabled: $isSubjectEnabled,
        isAvailable: $isSubjectAvailable,
        model: coach))
  }

  /// Settings and the wordmark lead, Pro trails, and one readout of what the shot will be sits between them.
  private var topBar: some View {
    HStack(spacing: FilmToolTokens.Space.s3) {
      Button("capture.settings.title", systemImage: "gearshape") {
        isSettingsPresented = true
      }
      .labelStyle(.iconOnly)
      .buttonStyle(.glass)
      .buttonBorderShape(.circle)
      // The owner's coach: best angle, chat, and customization.
      Button(persona.name, systemImage: "wand.and.stars") {
        isCoachStudioPresented = true
      }
      .font(.footnote.weight(.semibold))
      .buttonStyle(.glass)
      // The closed outer display is too narrow for the wordmark and the readout together.
      if horizontalSizeClass == .regular {
        Text("capture.brand")
          .font(FilmToolTokens.Brand.font)
          .foregroundStyle(FilmToolTokens.Palette.ink.opacity(0.82))
          .shadow(color: .black.opacity(0.4), radius: 3)
      }
      Spacer()
      proControl
    }
    .overlay { captureReadout }
    .tint(.white)
    .padding(.horizontal, FilmToolTokens.Space.s4)
    .padding(.top, FilmToolTokens.Space.s2)
  }

  /// Stock, frame and timer in one monospaced capsule, like a camera's top plate.
  private var captureReadout: some View {
    HStack(spacing: FilmToolTokens.Space.s2) {
      Text(LocalizedStringKey(selectedStock.displayNameKey))
        .textCase(.uppercase)
      Text(verbatim: "·").foregroundStyle(FilmToolTokens.Palette.inkFaint)
      // The photo session preset captures 4:3. Dropped on the narrow outer display so the capsule clears Pro.
      if horizontalSizeClass == .regular {
        Text(verbatim: "4:3")
        Text(verbatim: "·").foregroundStyle(FilmToolTokens.Palette.inkFaint)
      }
      // The shutter runs CoachModel's countdown, at the owner's chosen length, before every photo.
      HStack(spacing: 3) {
        Image(systemName: "timer")
        Text(verbatim: "\(persona.countdownSeconds)S")
      }
    }
    .font(.system(size: 12, weight: .semibold, design: .monospaced))
    .kerning(1)
    .foregroundStyle(FilmToolTokens.Palette.ink)
    .padding(.horizontal, FilmToolTokens.Space.s4)
    .frame(height: 32)
    .glassEffect(in: Capsule())
    .contentTransition(.opacity)
    .animation(.snappy, value: selectedStock)
    .accessibilityElement(children: .combine)
  }

  /// Only real problems surface here, as one quiet pill, plus the photographer's best-angle cue.
  @ViewBuilder
  private var statusStack: some View {
    VStack(spacing: FilmToolTokens.Space.s3) {
      if let guidance = coach.angle.guidance, !coach.isCountingDown {
        PhotographerCuePill(guidance: guidance)
          .animation(FilmToolMotion.m1Animation(reduceMotion: reduceMotion), value: guidance.photographer)
      }
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

  /// Subject screen, shutter and flip stacked on the trailing edge: under the thumb and clear of the fold.
  /// The film stock dial wraps the shutter's leading side.
  private var controlColumn: some View {
    VStack(spacing: 28) {
      subjectToggle
      shutterButton
        .overlay {
          // Locked stocks open the paywall only through presentPaywall, which is inner-display only.
          FilmStockSelectorView(selectedStock: $selectedStock, isPro: isPro)
            .offset(x: FilmStockSelectorView.overlayOffset)
        }
      flipButton
    }
  }

  /// Darkens the trailing edge so the dial and shutter stay legible over bright scenes, without a hard rail.
  private var trailingScrim: some View {
    LinearGradient(
      stops: [
        .init(color: .clear, location: 0.45),
        .init(color: .black.opacity(0.6), location: 1),
      ],
      startPoint: .leading,
      endPoint: .trailing
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

  private var isSubjectLive: Bool { isSubjectAvailable && isSubjectEnabled }

  /// Shown only while the system can present the accessory; enabled is the user's choice.
  /// Glass with a live dot rather than an amber fill, so amber keeps meaning Pro.
  @ViewBuilder
  private var subjectToggle: some View {
    if isSubjectAvailable {
      Button("capture.subjectToggle", systemImage: "person.crop.rectangle") {
        isSubjectEnabled.toggle()
      }
      .labelStyle(.iconOnly)
      .font(FilmToolTokens.Control.iconFont)
      .frame(width: FilmToolTokens.Control.minHit, height: FilmToolTokens.Control.minHit)
      .buttonStyle(.glass)
      .buttonBorderShape(.circle)
      .controlSize(.large)
      .tint(.white)
      .overlay(alignment: .topTrailing) {
        if isSubjectEnabled {
          liveDot.offset(x: -2, y: 2)
        }
      }
      .accessibilityAddTraits(isSubjectEnabled ? .isSelected : [])
    } else {
      Color.clear.frame(width: FilmToolTokens.Control.minHit, height: FilmToolTokens.Control.minHit)
    }
  }

  private var liveDot: some View {
    Circle()
      .fill(FilmToolTokens.Palette.success)
      .frame(width: 7, height: 7)
      .background(Circle().fill(FilmToolTokens.Palette.success.opacity(0.2)).padding(-3))
      .accessibilityHidden(true)
  }

  /// What the outer display is saying right now. A tap shows the photographer the subject's view.
  private var subjectCard: some View {
    let tips = coach.currentTips(isPro: isPro)
    let pack: TipPack = isPro ? coach.activePack : .free
    return Button {
      isSubjectPreviewPresented = true
    } label: {
      HStack(spacing: FilmToolTokens.Space.s3) {
        SubjectCoachView(model: coach)
          .frame(width: 466, height: 678)
          .scaleEffect(48.0 / 466)
          .frame(width: 48, height: 70)
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
              .stroke(.white.opacity(0.35), lineWidth: 1))
          .allowsHitTesting(false)
        VStack(alignment: .leading, spacing: 5) {
          HStack(spacing: 6) {
            Text("capture.subjectToggle")
              .textCase(.uppercase)
              .font(.system(size: 10.5, weight: .semibold, design: .monospaced))
              .kerning(1.4)
              .foregroundStyle(FilmToolTokens.Palette.inkMuted)
            if isSubjectLive {
              liveDot
            }
          }
          Text(LocalizedStringKey(coach.tipKey(isPro: isPro)))
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(FilmToolTokens.Palette.ink)
            .lineLimit(1)
          (Text(LocalizedStringKey(pack.displayNameKey))
            + Text(verbatim: " · \(coach.tipIndex % tips.count + 1)/\(tips.count)"))
            .font(.caption)
            .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        }
        .frame(maxWidth: 260, alignment: .leading)
      }
      .padding(.leading, FilmToolTokens.Space.s2)
      .padding(.trailing, FilmToolTokens.Space.s4)
      .padding(.vertical, FilmToolTokens.Space.s2)
      .glassEffect(in: RoundedRectangle(cornerRadius: 18, style: .continuous))
      .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
    .buttonStyle(FilmToolSideButtonStyle())
    .accessibilityElement(children: .combine)
    .accessibilityHint(Text("capture.subjectPreview"))
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
        await coach.runCountdown { await capture.capturePhoto() }
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
      isStarting || isSessionFailed || capture.phase == .shutterFlash || coach.isCountingDown)
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
        Button("capture.settings.simulateAngleMatch") {
          // Rehearsal without a camera: the matched cues, then the owner's countdown and phrase.
          isSettingsPresented = false
          coach.angle.simulateMatch()
          Task {
            await coach.runCountdown { await capture.capturePhoto() }
            coach.angle.reset()
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
