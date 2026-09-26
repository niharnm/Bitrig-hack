//
//  CoachOverlayTests.swift
//  DuoAppTests
//
//  Comprehensive validation of CoachOverlay, KidMagnetView, GuideOvalView dashed stroke,
//  tip pack gating, countdown sequencing, and reduce motion accessibility.
//

import SwiftUI
import XCTest
@testable import DuoApp

@MainActor
final class CoachOverlayTests: XCTestCase {

  // MARK: - TipPack Contract & Gating

  func testTipPackEnumCasesAndRequiresProGating() {
    let allPacks = TipPack.allCases
    XCTAssertEqual(allPacks.count, 3)
    XCTAssertTrue(allPacks.contains(.free))
    XCTAssertTrue(allPacks.contains(.kidsPro))
    XCTAssertTrue(allPacks.contains(.portraitPro))

    XCTAssertFalse(TipPack.free.requiresPro, "Free pack must not require Pro")
    XCTAssertTrue(TipPack.kidsPro.requiresPro, "Kids pack must require Pro")
    XCTAssertTrue(TipPack.portraitPro.requiresPro, "Portrait pack must require Pro")

    XCTAssertEqual(TipPack.free.id, "free")
    XCTAssertEqual(TipPack.kidsPro.id, "kidsPro")
    XCTAssertEqual(TipPack.portraitPro.id, "portraitPro")

    XCTAssertEqual(TipPack.free.displayNameKey, "capture.tipPack.free")
    XCTAssertEqual(TipPack.kidsPro.displayNameKey, "capture.tipPack.kids")
    XCTAssertEqual(TipPack.portraitPro.displayNameKey, "capture.tipPack.portrait")
  }

  // MARK: - Tip Cycling & Pack Gating

  func testFreeTierOnlyShowsFreeTips() {
    let model = CoachModel()
    model.activePack = .free

    // Under free tier (isPro: false), cycling must produce free tips
    XCTAssertEqual(model.tipKey(isPro: false), "tip.free.1")
    model.advanceTip()
    XCTAssertEqual(model.tipKey(isPro: false), "tip.free.2")
    model.advanceTip()
    XCTAssertEqual(model.tipKey(isPro: false), "tip.free.3")
    model.advanceTip()
    XCTAssertEqual(model.tipKey(isPro: false), "tip.free.1")

    // Even if activePack is set to kidsPro or portraitPro, isPro: false must strictly return free tips
    model.activePack = .kidsPro
    XCTAssertEqual(model.tipKey(isPro: false), "tip.free.1")
    model.activePack = .portraitPro
    XCTAssertEqual(model.tipKey(isPro: false), "tip.free.1")
  }

  func testProTierKidsPackCycling() {
    let model = CoachModel()
    model.activePack = .kidsPro

    // Under Pro tier (isPro: true) with kidsPro pack, tips cycle through kids tips
    XCTAssertEqual(model.tipKey(isPro: true), "tip.kids.1")
    model.advanceTip()
    XCTAssertEqual(model.tipKey(isPro: true), "tip.kids.2")
    model.advanceTip()
    XCTAssertEqual(model.tipKey(isPro: true), "tip.kids.3")
    model.advanceTip()
    XCTAssertEqual(model.tipKey(isPro: true), "tip.kids.1")
  }

  func testProTierPortraitPackCycling() {
    let model = CoachModel()
    model.activePack = .portraitPro

    // Under Pro tier (isPro: true) with portraitPro pack, tips cycle through portrait tips
    XCTAssertEqual(model.tipKey(isPro: true), "tip.portrait.1")
    model.advanceTip()
    XCTAssertEqual(model.tipKey(isPro: true), "tip.portrait.2")
    model.advanceTip()
    XCTAssertEqual(model.tipKey(isPro: true), "tip.portrait.3")
    model.advanceTip()
    XCTAssertEqual(model.tipKey(isPro: true), "tip.portrait.1")
  }

  // MARK: - Countdown Progression

  func testCountdownProgression() {
    let model = CoachModel()
    XCTAssertNil(model.countdown, "Initial countdown must be nil")

    model.setCountdown(3)
    XCTAssertEqual(model.countdown, 3)

    model.setCountdown(2)
    XCTAssertEqual(model.countdown, 2)

    model.setCountdown(1)
    XCTAssertEqual(model.countdown, 1)

    model.setCountdown(nil)
    XCTAssertNil(model.countdown)
  }

  // MARK: - Guide Oval Token & Dashed Stroke

  func testGuideOvalDashedStrokeStyle() {
    XCTAssertEqual(GuideOvalView.accent, FilmToolTokens.Palette.accent)
    XCTAssertEqual(GuideOvalView.strokeStyle.lineWidth, 3)
    XCTAssertEqual(GuideOvalView.strokeStyle.dash, [8, 6])
    XCTAssertEqual(GuideOvalView.strokeStyle.lineCap, .round)
  }

  // MARK: - Kid Magnet Tokens & Motion

  func testKidMagnetTokensAndConstants() {
    XCTAssertEqual(FilmToolTokens.KidMagnet.pulseDuration, 0.85, accuracy: 0.001)
    XCTAssertEqual(FilmToolTokens.KidMagnet.bounceOffset, 8.0, accuracy: 0.001)
    XCTAssertEqual(FilmToolTokens.KidMagnet.minScale, 0.96, accuracy: 0.001)
    XCTAssertEqual(FilmToolTokens.KidMagnet.maxScale, 1.16, accuracy: 0.001)
  }

  func testKidMagnetReduceMotionDisablesAnimations() {
    // When reduce motion is enabled:
    XCTAssertNil(
      FilmToolMotion.kidMagnetPulseAnimation(reduceMotion: true),
      "Pulse animation must be nil when reduceMotion is enabled"
    )
    XCTAssertEqual(
      FilmToolMotion.kidMagnetBounceOffset(reduceMotion: true, phase: true),
      0,
      "Bounce offset must be 0 when reduceMotion is enabled"
    )
    XCTAssertEqual(
      FilmToolMotion.kidMagnetBounceOffset(reduceMotion: true, phase: false),
      0,
      "Bounce offset must be 0 when reduceMotion is enabled"
    )
    XCTAssertEqual(
      FilmToolMotion.kidMagnetScale(reduceMotion: true, phase: true),
      1.0,
      "Scale must be 1.0 when reduceMotion is enabled"
    )
    XCTAssertEqual(
      FilmToolMotion.kidMagnetScale(reduceMotion: true, phase: false),
      1.0,
      "Scale must be 1.0 when reduceMotion is enabled"
    )

    // When reduce motion is disabled:
    XCTAssertNotNil(
      FilmToolMotion.kidMagnetPulseAnimation(reduceMotion: false),
      "Pulse animation must be present when reduceMotion is false"
    )
    XCTAssertNotEqual(
      FilmToolMotion.kidMagnetBounceOffset(reduceMotion: false, phase: true),
      0,
      "Bounce offset must be non-zero during active phase when reduceMotion is false"
    )
    XCTAssertEqual(
      FilmToolMotion.kidMagnetBounceOffset(reduceMotion: false, phase: false),
      0,
      "Bounce offset must be 0 during resting phase"
    )
    XCTAssertEqual(
      FilmToolMotion.kidMagnetScale(reduceMotion: false, phase: true),
      FilmToolTokens.KidMagnet.maxScale,
      "Scale must be maxScale during pulse"
    )
    XCTAssertEqual(
      FilmToolMotion.kidMagnetScale(reduceMotion: false, phase: false),
      FilmToolTokens.KidMagnet.minScale,
      "Scale must be minScale during rest"
    )
  }

  // MARK: - View Instantiation Smoke Tests

  func testCoachViewsInstantiateWithoutCrashing() {
    let model = CoachModel()
    let coachView = SubjectCoachView(model: model)
    XCTAssertNotNil(coachView)

    let kidMagnet = KidMagnetView()
    XCTAssertNotNil(kidMagnet)

    let guideOval = GuideOvalView()
    XCTAssertNotNil(guideOval)

    let countdownView = CountdownView(value: 3)
    XCTAssertNotNil(countdownView)
  }

}
