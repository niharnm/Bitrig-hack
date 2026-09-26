import Observation
import SwiftUI

/// Hinge posture reported by the system. Effects input only; never a layout signal.
enum HingeStatusKind: Equatable, Sendable {
  case unavailable
  case closed
  case partiallyOpen
  case fullyOpen
}

/// Publishes the design pose from size class, reserved regions, and hinge status (bible §08.10).
/// Layout reads `mode`. Only visual effects may read `effectAngle`.
@MainActor
@Observable
final class PoseRouter {
  private(set) var mode: PoseMode = .unknown
  private(set) var hingeStatus: HingeStatusKind = .unavailable
  /// Hinge angle while partially open, for effects such as haptics. Nil in every other state so no effect sticks.
  private(set) var effectAngle: Angle?
  private(set) var regions: RegionHints = .empty
  private var horizontalSizeClass: UserInterfaceSizeClass?

  func update(horizontalSizeClass: UserInterfaceSizeClass?) {
    self.horizontalSizeClass = horizontalSizeClass
    reclassify()
  }

  func update(regions: RegionHints) {
    self.regions = regions
    reclassify()
  }

  func update(hingeStatus: HingeStatusKind, angle: Angle?) {
    self.hingeStatus = hingeStatus
    effectAngle = hingeStatus == .partiallyOpen ? angle : nil
    reclassify()
  }

  private func reclassify() {
    // Keep the last stable pose when the inputs say nothing, such as during size-class churn.
    if let next = Self.classify(
      horizontalSizeClass: horizontalSizeClass, regions: regions, hingeStatus: hingeStatus)
    {
      mode = next
    }
  }

  /// Apple ships no pose enum; this maps system signals to the app vocabulary in §07 `PoseMode`.
  nonisolated static func classify(
    horizontalSizeClass: UserInterfaceSizeClass?,
    regions: RegionHints,
    hingeStatus: HingeStatusKind
  ) -> PoseMode? {
    if regions.hasActiveDivision {
      return regions.creaseOrientation == .horizontal ? .tabletop : .book
    }
    switch hingeStatus {
    case .closed:
      return .closed
    case .fullyOpen:
      return .flat
    case .partiallyOpen, .unavailable:
      break
    }
    switch horizontalSizeClass {
    case .regular:
      return .open
    case .compact:
      return .closed
    default:
      return nil
    }
  }
}

@available(iOS 27.1, *)
extension PoseRouter {
  func update(hinge: DeviceHinge?) {
    guard let hinge else {
      // Nil means no hinge in this context: a regular iPhone or a view leaving the hierarchy.
      update(hingeStatus: .unavailable, angle: nil)
      return
    }
    let status: HingeStatusKind =
      switch hinge.status {
      case .closed: .closed
      case .partiallyOpen: .partiallyOpen
      case .fullyOpen: .fullyOpen
      default: .unavailable
      }
    update(hingeStatus: status, angle: hinge.angle)
  }
}

/// Feeds hinge changes to the router. Attach once at the root. Effects only (TC-S03).
struct HingeEffectsModifier: ViewModifier {
  let router: PoseRouter

  func body(content: Content) -> some View {
    if #available(iOS 27.1, *) {
      content.onHingeChange { _, context in
        router.update(hinge: context.hinge)
      }
    } else {
      content
    }
  }
}
