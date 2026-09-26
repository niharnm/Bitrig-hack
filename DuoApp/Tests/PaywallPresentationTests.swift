import XCTest

@testable import DuoApp

final class PaywallPresentationTests: XCTestCase {
  @MainActor
  func testClosedAndUnknownPosesCannotOpenPaywall() async {
    var presentations = 0
    for pose in [PoseMode.closed, .unknown] {
      let presenter = PaywallPresenter(pose: pose) { presentations += 1 }
      XCTAssertFalse(presenter.isAvailable)
      presenter()
    }
    XCTAssertEqual(presentations, 0)
  }

  @MainActor
  func testInnerPosesCanRequestPaywall() async {
    var presentations = 0
    for pose in [PoseMode.flat, .open, .tabletop, .book] {
      let presenter = PaywallPresenter(pose: pose) { presentations += 1 }
      XCTAssertTrue(presenter.isAvailable)
      presenter()
    }
    XCTAssertEqual(presentations, 4)
  }
}
