import XCTest

@testable import DuoApp

final class FrostStandbyTests: XCTestCase {
  @MainActor
  func testUnconfirmedEntitlementCannotSelectPaidCover() async {
    for status in [EntitlementStatus.unknown, .loading, .inactive, .error] {
      let view = OuterDecoyStageView(
        threatLevel: .locked,
        entitlementState: EntitlementState(status: status, entitlementID: "pro"),
        preferredPack: .cVaultCover
      )
      XCTAssertEqual(view.visiblePack, .aLockLookalike, "Status: \(status)")
    }
  }

  @MainActor
  func testActiveEntitlementChangesDefaultOuterCover() async {
    let view = OuterDecoyStageView(
      threatLevel: .locked,
      entitlementState: EntitlementState(status: .active, entitlementID: "pro")
    )
    XCTAssertEqual(view.visiblePack, .cVaultCover)
  }

  @MainActor
  func testPaidEntitlementPreservesExplicitFreeCoverSelection() async {
    for selection in [DecoyPack.aLockLookalike, .bBusyCover] {
      let view = OuterDecoyStageView(
        threatLevel: .locked,
        entitlementState: EntitlementState(status: .active, entitlementID: "pro"),
        preferredPack: selection
      )
      XCTAssertEqual(view.visiblePack, selection)
    }
  }

  func testFrostStrengthIncreasesWithThreat() {
    let radii = [ThreatLevel.clear, .cautious, .threatened, .locked].map(\.frostBlurRadius)
    XCTAssertEqual(radii.first, 0)
    for (current, next) in zip(radii, radii.dropFirst()) {
      XCTAssertLessThan(current, next)
    }
  }
}
