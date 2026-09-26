import SwiftUI

/// Inner capture shell (SCR-OL-B). Hosts the outer coach and keeps the shutter working without it.
struct InnerCaptureView: View {
  @State private var capture = CaptureSessionController()
  @State private var coach = CoachModel()
  @State private var selectedStock: FilmStock = .natural
  @State private var showPaywall = false
  @State private var isSubjectEnabled = true
  @State private var isSubjectAvailable = false
  @State private var isSettingsPresented = false
  @Environment(\.entitlementState) private var entitlementState
  @Environment(\.presentPaywall) private var presentPaywall
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  private var isPro: Bool { entitlementState.isPro || coach.isProSimulated }
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
      if !isSubjectAvailable, !isStarting {
        subjectPreview
          .frame(maxHeight: .infinity)
      }
      VStack(spacing: FilmToolTokens.Space.s4) {
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
        FilmStockSelectorView(
          selectedStock: $selectedStock,
          isPro: isPro,
          showPaywall: $showPaywall
        )
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
    .sheet(isPresented: $showPaywall) {
      PaywallHostView(isPresented: $showPaywall)
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
          entitlementState.isPro ? "capture.proActive" : "capture.simulatedProActive"
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
    }
    .presentationDetents([.medium])
  }
}
