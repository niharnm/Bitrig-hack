import SwiftUI
import XCTest

@testable import DuoApp

final class MotionAccessibilityTests: XCTestCase {
  func testReducedMotionRemovesTipTranslationAndCountdownAnimation() {
    XCTAssertEqual(FilmToolMotion.m1Rise(reduceMotion: true), 0)
    XCTAssertNil(FilmToolMotion.m1Animation(reduceMotion: true))
    XCTAssertNil(FilmToolMotion.m2Animation(reduceMotion: true))
  }

  func testReducedMotionKeepsAllPressControlsStationary() {
    XCTAssertEqual(FilmToolMotion.p1Scale(reduceMotion: true), 1)
    XCTAssertEqual(FilmToolMotion.p2Scale(reduceMotion: true), 1)
    XCTAssertNil(FilmToolMotion.p1Animation(reduceMotion: true))
    XCTAssertNil(FilmToolMotion.p2Animation(reduceMotion: true))
    XCTAssertNil(FilmToolMotion.p3Animation(reduceMotion: true))
  }

  func testUnlockAnimationChangesWhenReduceMotionIsEnabled() {
    XCTAssertNotEqual(
      FilmToolMotion.m3Animation(reduceMotion: true),
      FilmToolMotion.m3Animation(reduceMotion: false)
    )
  }

  func testReducedMotionMakesFrostAndDecoyUpdatesInstant() {
    XCTAssertNil(FilmToolMotion.frostAnimation(reduceMotion: true))
    XCTAssertNil(FilmToolMotion.decoyAnimation(reduceMotion: true))
  }

  func testStandardMotionContractsRemainAvailable() {
    XCTAssertNotEqual(FilmToolMotion.m1Rise(reduceMotion: false), 0)
    XCTAssertNotNil(FilmToolMotion.m1Animation(reduceMotion: false))
    XCTAssertNotNil(FilmToolMotion.m2Animation(reduceMotion: false))
    XCTAssertGreaterThan(FilmToolMotion.p1Scale(reduceMotion: false), 0)
    XCTAssertLessThan(FilmToolMotion.p1Scale(reduceMotion: false), 1)
    XCTAssertGreaterThan(FilmToolMotion.p2Scale(reduceMotion: false), 0)
    XCTAssertLessThan(FilmToolMotion.p2Scale(reduceMotion: false), 1)
  }
}
