import SwiftUI

/// Reserved-region facts for one view. Panes lay out around these frames; hinge angle never feeds layout.
struct RegionHints: Equatable, Sendable {
  var hasActiveDivision = false
  /// Orientation of the fold line: horizontal when seated like a laptop, vertical when held like a book.
  var creaseOrientation: Axis?
  /// Region frames already include the system margins. Do not add them again.
  var activeDivisionFrames: [CGRect] = []
  var inactiveDivisionFrames: [CGRect] = []
  var occlusionFrames: [CGRect] = []

  static let empty = RegionHints()
}

enum ArrangementRegions {
  /// Query on every layout pass. Regions can arrive after the first layout, and the outer display reports none.
  static func snapshot(_ proxy: GeometryProxy) -> RegionHints {
    guard #available(iOS 27.1, *) else { return .empty }
    // The default active-only filter is unconfirmed (§05 UNKNOWN), so fetch inactive regions and filter here.
    let divisions = proxy.reservedRegions(kind: .division, options: .includeInactive)
    let active = divisions.filter(\.isActive)
    let crease = (active.first ?? divisions.first)?.frame
    return RegionHints(
      hasActiveDivision: !active.isEmpty,
      creaseOrientation: crease.map { $0.width > $0.height ? .horizontal : .vertical },
      activeDivisionFrames: active.map(\.frame),
      inactiveDivisionFrames: divisions.filter { !$0.isActive }.map(\.frame),
      occlusionFrames: proxy.reservedRegions(kind: .occlusion, options: .includeInactive)
        .filter(\.isActive)
        .map(\.frame)
    )
  }
}

extension View {
  /// Sends this view's reserved regions to the pose router whenever its geometry changes.
  func publishRegions(to router: PoseRouter) -> some View {
    background {
      GeometryReader { proxy in
        Color.clear.onChange(of: ArrangementRegions.snapshot(proxy), initial: true) { _, hints in
          router.update(regions: hints)
        }
      }
    }
  }
}
