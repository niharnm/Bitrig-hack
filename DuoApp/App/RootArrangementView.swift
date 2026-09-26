import SwiftUI

#if canImport(RevenueCat)
  import RevenueCat
#endif

// Root host (bible §08.2B, §08.3). Layout follows PoseRouter and reserved regions; hinge input only drives effects.
// Features inject through the named slots below instead of rewriting this file.
struct RootArrangementView: View {
  @StateObject private var entitlements = EntitlementsModel.shared
  @State private var pose = PoseRouter()
  @State private var isPaywallPresented = false
  @State private var threatLevel: ThreatLevel = .clear
  @State private var isProtectEnabled = true
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  private let cutover = CutoverFlag.current

  var body: some View {
    // Outer Lens: closed still hosts InnerCaptureView (CCA is the outer), so the Pro sheet may open.
    // Frost closed shows the outer decoy only — keep paywall blocked there.
    let paywallPresenter = PaywallPresenter(
      currentPose: { pose.mode },
      allowsClosedPose: !cutover.isFrost,
      {
        isPaywallPresented = true
      })

    NavigationStack {
      Group {
        if cutover.isFrost {
          frostShell
        } else {
          outerLensShell
        }
      }
      .publishRegions(to: pose)
      .navigationTitle(cutover.isFrost ? "FrostDuo" : "Insider")
      .navigationBarTitleDisplayMode(.inline)
      .sheet(
        isPresented: Binding(
          get: { isPaywallPresented && paywallPresenter.isAvailable },
          set: { isPaywallPresented = $0 }
        )
      ) {
        paywallSlot
      }
    }
    .modifier(HingeEffectsModifier(router: pose))
    .onChange(of: horizontalSizeClass, initial: true) { _, sizeClass in
      pose.update(horizontalSizeClass: sizeClass)
    }
    .environment(pose)
    .environment(\.cutoverFlag, cutover)
    .environment(\.entitlementState, entitlements.state)
    .environment(\.presentPaywall, paywallPresenter)
    .onChange(of: paywallPresenter.isAvailable) { _, available in
      if !available {
        isPaywallPresented = false
      }
    }
  }

  // MARK: Outer Lens

  // Single column until GATE-CCA is green (D-SHELL-02). The outer coach is CameraCaptureAccessory, not a pane.
  private var outerLensShell: some View {
    outerLensPrimarySlot
  }

  /// SCR-OL-B. InnerCaptureView attaches CameraCaptureAccessoryHost itself.
  private var outerLensPrimarySlot: some View {
    InnerCaptureView()
  }

  // MARK: FrostDuo cutover

  @ViewBuilder
  private var frostShell: some View {
    if pose.mode == .closed {
      frostOuterDecoySlot
    } else if #available(iOS 27.1, *) {
      ArrangementView {
        frostPrimarySlot
          .splitArrangementLayoutRatio(0.6)
      } secondary: {
        frostSecondarySlot
      }
      .arrangementViewStyle(.split.axes([.horizontal, .vertical]))
    } else {
      VStack(spacing: 0) {
        frostPrimarySlot
        frostSecondarySlot
      }
    }
  }

  /// SCR-FD-A. LANE-FROST supplies SensitiveSurfaceView.
  private var frostPrimarySlot: some View {
    SensitiveSurfaceView(
      threatLevel: threatLevel,
      title: "Private Notes",
      secret: "Passcode: 9812",
      bodyText: "Confidential strategy notes. Screen blurs as external threats are detected."
    )
  }

  /// SCR-FD-B. LANE-FROST supplies FrostControlsView with Simulate Threat.
  private var frostSecondarySlot: some View {
    FrostControlsView(
      protectEnabled: $isProtectEnabled,
      threatLevel: $threatLevel,
      entitlementState: EntitlementsModel.shared.state,
      onUnlockCoverVault: { isPaywallPresented = true }
    )
  }

  /// SCR-FD-C. Shown when the scene moves to the closed outer display. No second window is opened on the outer.
  private var frostOuterDecoySlot: some View {
    OuterDecoyStageView(
      threatLevel: threatLevel,
      entitlementState: EntitlementsModel.shared.state
    )
  }

  // MARK: Paywall

  /// SCR-OL-D / SCR-FD-D. Presented as a sheet from the inner display only.
  @ViewBuilder
  private var paywallSlot: some View {
    #if canImport(RevenueCat)
      if Purchases.isConfigured {
        PaywallHostView(isPresented: $isPaywallPresented)
      } else {
        unavailablePaywall
      }
    #else
      unavailablePaywall
    #endif
  }

  private var unavailablePaywall: some View {
    VStack(spacing: FilmToolTokens.Space.s5) {
      Text("Purchases unavailable")
      Button("Close") {
        isPaywallPresented = false
      }
    }
    .padding(FilmToolTokens.Space.s5)
  }
}

/// Opens the inner paywall slot. Features call it; only the root presents.
struct PaywallPresenter: Sendable {
  private let currentPose: @MainActor @Sendable () -> PoseMode
  /// When true, folded/closed Outer Lens can still present the inner Pro sheet (demo climax pose).
  private let allowsClosedPose: Bool
  private let open: @MainActor @Sendable () -> Void

  init(
    currentPose: @escaping @MainActor @Sendable () -> PoseMode = { .unknown },
    allowsClosedPose: Bool = true,
    _ open: @escaping @MainActor @Sendable () -> Void
  ) {
    self.currentPose = currentPose
    self.allowsClosedPose = allowsClosedPose
    self.open = open
  }

  @MainActor var isAvailable: Bool {
    let pose = currentPose()
    if pose == .unknown { return false }
    if pose == .closed { return allowsClosedPose }
    return true
  }

  @MainActor func callAsFunction() {
    guard isAvailable else { return }
    open()
  }
}

extension EnvironmentValues {
  @Entry var presentPaywall = PaywallPresenter {}
  @Entry var entitlementState = EntitlementState(status: .unknown, entitlementID: "")
}

/// Stand-in until a lane lands its view. Shows the current pose so fold changes are visible on the simulator.
private struct SlotPlaceholder: View {
  enum Fill {
    case canvas
    case raised
  }

  let title: String
  let pose: PoseMode
  var fill: Fill = .canvas

  var body: some View {
    VStack(spacing: 8) {
      Text(title)
        .font(.title.weight(.medium))
        .foregroundStyle(.white)
        .accessibilityAddTraits(.isHeader)
      Text(String(describing: pose))
        .font(.footnote.monospaced())
        .foregroundStyle(.white.opacity(0.6))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background {
      switch fill {
      case .canvas: FilmToolTokens.Palette.canvas.ignoresSafeArea()
      case .raised: FilmToolTokens.Palette.panel.ignoresSafeArea()
      }
    }
  }
}

#Preview {
  RootArrangementView()
}
