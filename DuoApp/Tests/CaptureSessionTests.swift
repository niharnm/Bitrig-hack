import XCTest

@testable import DuoApp

final class CaptureSessionTests: XCTestCase {
  private struct ProcessingError: Error {}

  func testPhotoOutcomeRequiresDataAndNoError() {
    XCTAssertEqual(PhotoCaptureOutcome(fileData: Data([0xFF, 0xD8]), error: nil), .captured)
    XCTAssertEqual(
      PhotoCaptureOutcome(fileData: Data([0xFF, 0xD8]), error: ProcessingError()), .failed)
    XCTAssertEqual(PhotoCaptureOutcome(fileData: Data(), error: nil), .failed)
    XCTAssertEqual(PhotoCaptureOutcome(fileData: nil, error: nil), .failed)
  }

  /// TC-C02: before start (hasCamera still true), shutter is a no-op — not a crash or failure banner.
  @MainActor
  func testShutterWithoutLiveSessionLeavesStateUnchanged() async {
    let capture = CaptureSessionController()
    XCTAssertEqual(capture.phase, .idle)
    XCTAssertTrue(capture.hasCamera)
    await capture.capturePhoto()
    XCTAssertEqual(capture.phase, .idle)
    XCTAssertFalse(capture.isLive)
    XCTAssertEqual(capture.capturedPhotoCount, 0)
    XCTAssertFalse(capture.lastPhotoFailed)
  }
  @MainActor
  func testPermissionRefreshRecoversAfterSettingsGrant() async {
    var permission = PermissionSubstate.denied
    let capture = CaptureSessionController(permissionProvider: { permission })
    XCTAssertEqual(capture.permission, .denied)
    permission = .authorized
    capture.refreshPermission()
    XCTAssertEqual(capture.permission, .authorized)
    XCTAssertEqual(capture.phase, .idle)
  }

  @MainActor
  func testPermissionRefreshReflectsSettingsRevocation() async {
    var permission = PermissionSubstate.authorized
    let capture = CaptureSessionController(permissionProvider: { permission })
    permission = .denied
    capture.refreshPermission()
    XCTAssertEqual(capture.permission, .denied)
    XCTAssertEqual(capture.phase, .idle)
    XCTAssertFalse(capture.isLive)
  }


  /// B.noDevices Peak-End: idle + !hasCamera still gets a flash beat and success count.
  @MainActor
  func testShutterWithoutCameraStillFlashes() async {
    let capture = CaptureSessionController()
    // Mirror post-start noCamera: idle with discovery empty.
    // hasCamera is private(set); start() on sim typically yields this. Force via reflection-free path:
    // capturePhoto only flashes when !hasCamera — simulate by running start then checking.
    // If a camera exists in the test host, skip the no-device assertion.
    await capture.start()
    guard !capture.hasCamera else {
      // Device/simulator with a camera: live shutter path is covered by photo pipeline, not this case.
      return
    }
    XCTAssertEqual(capture.phase, .idle)
    await capture.capturePhoto()
    XCTAssertEqual(capture.phase, .idle)
    XCTAssertEqual(capture.capturedPhotoCount, 1)
    XCTAssertFalse(capture.lastPhotoFailed)
  }
}
