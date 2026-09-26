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
  func testUnknownPoseCannotOpenPaywall() async {
    var presentations = 0
    let presenter = PaywallPresenter(
      currentPose: { .unknown }, allowsClosedPose: true,
      {
        presentations += 1
      })
    XCTAssertFalse(presenter.isAvailable)
    presenter()
    XCTAssertEqual(presentations, 0)
  }

  @MainActor
  func testOuterLensClosedPoseCanOpenPaywall() async {
    var presentations = 0
    let presenter = PaywallPresenter(
      currentPose: { .closed }, allowsClosedPose: true,
      {
        presentations += 1
      })
    XCTAssertTrue(presenter.isAvailable)
    presenter()
    XCTAssertEqual(presentations, 1)
  }

  @MainActor
  func testFrostClosedPoseCannotOpenPaywall() async {
    var presentations = 0
    let presenter = PaywallPresenter(
      currentPose: { .closed }, allowsClosedPose: false,
      {
        presentations += 1
      })
    XCTAssertFalse(presenter.isAvailable)
    presenter()
    XCTAssertEqual(presentations, 0)
  }

  @MainActor
  func testInnerPosesCanRequestPaywall() async {
    var presentations = 0
    for pose in [PoseMode.flat, .open, .tabletop, .book] {
      let presenter = PaywallPresenter(
        currentPose: { pose }, allowsClosedPose: false,
        {
          presentations += 1
        })
      XCTAssertTrue(presenter.isAvailable)
      presenter()
    }
    XCTAssertEqual(presentations, 4)
  }

  @MainActor
  func testRetainedPresenterReadsCurrentPoseBeforeOpening() async {
    var pose = PoseMode.open
    var presentations = 0
    let presenter = PaywallPresenter(
      currentPose: { pose }, allowsClosedPose: false,
      {
        presentations += 1
      })

    presenter()
    XCTAssertEqual(presentations, 1)

    pose = .closed
    XCTAssertFalse(presenter.isAvailable)
    presenter()
    XCTAssertEqual(presentations, 1)
  }

  func testSubscriptionAccessUnlocksOnlyPro() {
    XCTAssertTrue(SubscriptionAccess.isUnlocked(activeEntitlementIDs: ["pro"]))
    XCTAssertFalse(SubscriptionAccess.isUnlocked(activeEntitlementIDs: ["photon_pro"]))
    XCTAssertFalse(SubscriptionAccess.isUnlocked(activeEntitlementIDs: []))
    XCTAssertEqual(
      SubscriptionAccess.displayedEntitlementID(activeEntitlementIDs: ["photon_pro"]),
      RCIdentifiers.entitlementId
    )
  }

  func testOfferingPackagesSoftFallbackPrefersWiredPackages() {
    let available = ["lifetime", "$rc_monthly"]
    XCTAssertEqual(
      OfferingPackages.resolvePurchasePackageId(requested: "yearly", availableIdentifiers: available),
      "lifetime"
    )
    XCTAssertEqual(
      OfferingPackages.resolvePurchasePackageId(requested: "lifetime", availableIdentifiers: available),
      "lifetime"
    )
  }

  func testOfferingPackagesSoftFallbackToRcMonthly() {
    let available = ["$rc_monthly"]
    XCTAssertEqual(
      OfferingPackages.resolvePurchasePackageId(requested: "yearly", availableIdentifiers: available),
      RCIdentifiers.packageId
    )
    XCTAssertEqual(
      OfferingPackages.resolvePurchasePackageId(requested: "missing", availableIdentifiers: []),
      RCIdentifiers.packageId
    )
  }

  func testMatchingWiredPackagesFiltersOffering() {
    XCTAssertEqual(
      OfferingPackages.matchingWiredPackages(availableIdentifiers: ["yearly", "weekly", "lifetime"]),
      ["lifetime", "yearly"]
    )
  }
}
