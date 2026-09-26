import XCTest

@testable import DuoApp

final class PaywallPresentationTests: XCTestCase {
  @MainActor
  func testUnknownPoseCannotOpenPaywall() async {
    var presentations = 0
    let presenter = PaywallPresenter(currentPose: { .unknown }, allowsClosedPose: true) {
      presentations += 1
    }
    XCTAssertFalse(presenter.isAvailable)
    presenter()
    XCTAssertEqual(presentations, 0)
  }

  @MainActor
  func testOuterLensClosedPoseCanOpenPaywall() async {
    var presentations = 0
    let presenter = PaywallPresenter(currentPose: { .closed }, allowsClosedPose: true) {
      presentations += 1
    }
    XCTAssertTrue(presenter.isAvailable)
    presenter()
    XCTAssertEqual(presentations, 1)
  }

  @MainActor
  func testFrostClosedPoseCannotOpenPaywall() async {
    var presentations = 0
    let presenter = PaywallPresenter(currentPose: { .closed }, allowsClosedPose: false) {
      presentations += 1
    }
    XCTAssertFalse(presenter.isAvailable)
    presenter()
    XCTAssertEqual(presentations, 0)
  }

  @MainActor
  func testInnerPosesCanRequestPaywall() async {
    var presentations = 0
    for pose in [PoseMode.flat, .open, .tabletop, .book] {
      let presenter = PaywallPresenter(currentPose: { pose }, allowsClosedPose: false) {
        presentations += 1
      }
      XCTAssertTrue(presenter.isAvailable)
      presenter()
    }
    XCTAssertEqual(presentations, 4)
  }

  @MainActor
  func testRetainedPresenterReadsCurrentPoseBeforeOpening() async {
    var pose = PoseMode.open
    var presentations = 0
    let presenter = PaywallPresenter(currentPose: { pose }, allowsClosedPose: false) {
      presentations += 1
    }

    presenter()
    XCTAssertEqual(presentations, 1)

    pose = .closed
    XCTAssertFalse(presenter.isAvailable)
    presenter()
    XCTAssertEqual(presentations, 1)
  }
}
