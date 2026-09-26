import XCTest

@testable import DuoApp

final class PaywallPresentationTests: XCTestCase {
  func testWiredPackageIdentifiersAndProAccess() {
    XCTAssertEqual(
      RCIdentifiers.subscriptionPackageIds,
      ["lifetime", "yearly", "monthly"]
    )
    XCTAssertEqual(RCIdentifiers.entitlementId, "pro")
    XCTAssertEqual(
      OfferingPackages.matchingWiredPackages(availableIdentifiers: ["yearly", "other", "monthly"]),
      ["yearly", "monthly"]
    )
    XCTAssertTrue(SubscriptionAccess.isUnlocked(activeEntitlementIDs: ["pro"]))
    XCTAssertFalse(SubscriptionAccess.isUnlocked(activeEntitlementIDs: ["lifetime"]))
    XCTAssertEqual(
      SubscriptionAccess.displayedEntitlementID(activeEntitlementIDs: ["pro"]),
      "pro"
    )
  }

  @MainActor
  func testClosedAndUnknownPosesCannotOpenPaywall() async {
    var presentations = 0
    for pose in [PoseMode.closed, .unknown] {
      let presenter = PaywallPresenter(currentPose: { pose }, { presentations += 1 })
      XCTAssertFalse(presenter.isAvailable)
      presenter()
    }
    XCTAssertEqual(presentations, 0)
  }

  @MainActor
  func testInnerPosesCanRequestPaywall() async {
    var presentations = 0
    for pose in [PoseMode.flat, .open, .tabletop, .book] {
      let presenter = PaywallPresenter(currentPose: { pose }, { presentations += 1 })
      XCTAssertTrue(presenter.isAvailable)
      presenter()
    }
    XCTAssertEqual(presentations, 4)
  }

  @MainActor
  func testRetainedPresenterReadsCurrentPoseBeforeOpening() async {
    var pose = PoseMode.open
    var presentations = 0
    let presenter = PaywallPresenter(currentPose: { pose }, { presentations += 1 })

    presenter()
    XCTAssertEqual(presentations, 1)

    pose = .closed
    XCTAssertFalse(presenter.isAvailable)
    presenter()
    XCTAssertEqual(presentations, 1)
  }
}
