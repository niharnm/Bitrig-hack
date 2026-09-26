import XCTest

@testable import DuoApp

final class CaptureSessionTests: XCTestCase {
  private struct ProcessingError: Error {}

  func testPhotoOutcomeRequiresDataAndNoError() {
    XCTAssertEqual(PhotoCaptureOutcome(fileData: Data([0xFF, 0xD8]), error: nil), .captured)
    XCTAssertEqual(PhotoCaptureOutcome(fileData: Data([0xFF, 0xD8]), error: ProcessingError()), .failed)
    XCTAssertEqual(PhotoCaptureOutcome(fileData: Data(), error: nil), .failed)
    XCTAssertEqual(PhotoCaptureOutcome(fileData: nil, error: nil), .failed)
  }

  /// TC-C02: without a live session the shutter is a no-op, not a crash or a failure banner.
  @MainActor
  func testShutterWithoutLiveSessionLeavesStateUnchanged() async {
    let capture = CaptureSessionController()
    XCTAssertEqual(capture.phase, .idle)
    await capture.capturePhoto()
    XCTAssertEqual(capture.phase, .idle)
    XCTAssertFalse(capture.isLive)
    XCTAssertEqual(capture.capturedPhotoCount, 0)
    XCTAssertFalse(capture.lastPhotoFailed)
  }
}
