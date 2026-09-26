import XCTest
import SwiftUI
import AVFoundation

@testable import DuoApp

final class CaptureFilmStockTests: XCTestCase {
  func testFilmStockAllCasesAndIDs() {
    let expectedCases: [FilmStock] = [.natural, .leicaMono, .warmAmber, .portraSoft]
    XCTAssertEqual(FilmStock.allCases, expectedCases)
    XCTAssertEqual(FilmStock.natural.id, "natural")
    XCTAssertEqual(FilmStock.leicaMono.id, "leicaMono")
    XCTAssertEqual(FilmStock.warmAmber.id, "warmAmber")
    XCTAssertEqual(FilmStock.portraSoft.id, "portraSoft")
  }

  func testFilmStockRequiresProGating() {
    XCTAssertFalse(FilmStock.natural.requiresPro, "Natural stock must be free")
    XCTAssertTrue(FilmStock.leicaMono.requiresPro, "Mono stock requires Pro")
    XCTAssertTrue(FilmStock.warmAmber.requiresPro, "Warm Amber stock requires Pro")
    XCTAssertTrue(FilmStock.portraSoft.requiresPro, "Portra Soft stock requires Pro")
  }

  func testFilmStockLocalizationKeys() {
    XCTAssertEqual(FilmStock.natural.displayNameKey, "filmStock.natural.name")
    XCTAssertEqual(FilmStock.natural.descriptionKey, "filmStock.natural.description")
    XCTAssertEqual(FilmStock.leicaMono.displayNameKey, "filmStock.leicaMono.name")
    XCTAssertEqual(FilmStock.leicaMono.descriptionKey, "filmStock.leicaMono.description")
    XCTAssertEqual(FilmStock.warmAmber.displayNameKey, "filmStock.warmAmber.name")
    XCTAssertEqual(FilmStock.warmAmber.descriptionKey, "filmStock.warmAmber.description")
    XCTAssertEqual(FilmStock.portraSoft.displayNameKey, "filmStock.portraSoft.name")
    XCTAssertEqual(FilmStock.portraSoft.descriptionKey, "filmStock.portraSoft.description")
  }

  func testTipPackGating() {
    let expectedCases: [TipPack] = [.free, .kidsPro, .portraitPro]
    XCTAssertEqual(TipPack.allCases, expectedCases)
    XCTAssertFalse(TipPack.free.requiresPro, "Free tip pack must be free")
    XCTAssertTrue(TipPack.kidsPro.requiresPro, "Kids pack requires Pro")
    XCTAssertTrue(TipPack.portraitPro.requiresPro, "Portrait pack requires Pro")
  }

  func testFilmGradePresetValues() {
    let natural = FilmToolTokens.FilmGrade.natural
    XCTAssertEqual(natural.contrast, 1.0, accuracy: 0.001)
    XCTAssertEqual(natural.saturation, 1.0, accuracy: 0.001)
    XCTAssertEqual(natural.amberTintOpacity, 0.0, accuracy: 0.001)

    let leicaMono = FilmToolTokens.FilmGrade.leicaMono
    XCTAssertEqual(leicaMono.contrast, 1.28, accuracy: 0.001)
    XCTAssertEqual(leicaMono.saturation, 0.0, accuracy: 0.001)
    XCTAssertEqual(leicaMono.amberTintOpacity, 0.0, accuracy: 0.001)

    let warmAmber = FilmToolTokens.FilmGrade.warmAmber
    XCTAssertEqual(warmAmber.contrast, 1.08, accuracy: 0.001)
    XCTAssertEqual(warmAmber.saturation, 1.15, accuracy: 0.001)
    XCTAssertEqual(warmAmber.amberTintOpacity, 0.24, accuracy: 0.001)

    let portraSoft = FilmToolTokens.FilmGrade.portraSoft
    XCTAssertEqual(portraSoft.contrast, 0.94, accuracy: 0.001)
    XCTAssertEqual(portraSoft.saturation, 0.90, accuracy: 0.001)
    XCTAssertEqual(portraSoft.amberTintOpacity, 0.08, accuracy: 0.001)

    XCTAssertEqual(FilmStock.natural.grade, natural)
    XCTAssertEqual(FilmStock.leicaMono.grade, leicaMono)
    XCTAssertEqual(FilmStock.warmAmber.grade, warmAmber)
    XCTAssertEqual(FilmStock.portraSoft.grade, portraSoft)
  }

  func testKidMagnetMotionTokens() {
    XCTAssertEqual(FilmToolTokens.KidMagnet.pulseDuration, 0.85, accuracy: 0.001)
    XCTAssertEqual(FilmToolTokens.KidMagnet.bounceOffset, 8.0, accuracy: 0.001)
    XCTAssertEqual(FilmToolTokens.KidMagnet.minScale, 0.96, accuracy: 0.001)
    XCTAssertEqual(FilmToolTokens.KidMagnet.maxScale, 1.16, accuracy: 0.001)
  }

  @MainActor
  func testCaptureSessionControllerSimulatorLifecycle() async {
    let controller = CaptureSessionController()
    XCTAssertEqual(controller.phase, .idle)

    await controller.start()

    // On simulator with no camera hardware:
    guard !controller.hasCamera else {
      // Device/host with a camera: skip no-device assertions.
      return
    }
    XCTAssertEqual(controller.phase, .idle, "No-camera start stays idle (§11.2.4 B.noDevices)")

    // Peak-End: shutter still flashes without a live session camera.
    await controller.capturePhoto()
    XCTAssertEqual(controller.phase, .idle)
    XCTAssertEqual(controller.capturedPhotoCount, 1)
    XCTAssertFalse(controller.lastPhotoFailed)

    controller.stop()
    XCTAssertEqual(controller.phase, .idle)
  }
}