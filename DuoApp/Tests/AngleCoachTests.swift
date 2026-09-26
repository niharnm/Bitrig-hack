//
//  AngleCoachTests.swift
//  DuoAppTests
//
//  Best-angle matching cues, auto-shoot hold, countdown phrase, persona customization, and the basic coach.
//

import UIKit
import XCTest
@testable import DuoApp

@MainActor
final class AngleCoachTests: XCTestCase {
  private let target = FaceMeasurement(centerX: 0.5, centerY: 0.4, height: 0.25, yaw: 10, roll: 0, pitch: 5)

  private func live(_ change: (inout FaceMeasurement) -> Void) -> FaceMeasurement {
    var face = target
    change(&face)
    return face
  }

  private func makePersonaStore() -> CoachPersonaStore {
    let suite = "AngleCoachTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suite)!
    addTeardownBlock { defaults.removePersistentDomain(forName: suite) }
    return CoachPersonaStore(defaults: defaults)
  }

  // MARK: - Matcher

  func testExactMatchHoldsForBothPeople() {
    let guidance = AngleMatcher.guidance(live: target, target: target, tolerance: .balanced)
    XCTAssertTrue(guidance.isMatched)
    XCTAssertEqual(guidance.photographer, .hold)
    XCTAssertEqual(guidance.subject, .hold)
    XCTAssertEqual(guidance.score, 1, accuracy: 0.001)
  }

  func testSmallFaceAsksPhotographerToStepCloser() {
    let guidance = AngleMatcher.guidance(live: live { $0.height = 0.15 }, target: target, tolerance: .balanced)
    XCTAssertEqual(guidance.photographer, .stepCloser)
    XCTAssertFalse(guidance.isMatched)
  }

  func testLargeFaceAsksPhotographerToStepBack() {
    let guidance = AngleMatcher.guidance(live: live { $0.height = 0.4 }, target: target, tolerance: .balanced)
    XCTAssertEqual(guidance.photographer, .stepBack)
  }

  func testDistanceIsFixedBeforeFraming() {
    let face = live {
      $0.height = 0.1
      $0.centerX = 0.9
    }
    XCTAssertEqual(AngleMatcher.guidance(live: face, target: target, tolerance: .balanced).photographer, .stepCloser)
  }

  func testFaceDriftedRightAimsRightAndDriftedLeftAimsLeft() {
    XCTAssertEqual(
      AngleMatcher.guidance(live: live { $0.centerX = 0.7 }, target: target, tolerance: .balanced).photographer,
      .aimRight)
    XCTAssertEqual(
      AngleMatcher.guidance(live: live { $0.centerX = 0.3 }, target: target, tolerance: .balanced).photographer,
      .aimLeft)
  }

  func testFaceTooLowAimsDownAndTooHighAimsUp() {
    XCTAssertEqual(
      AngleMatcher.guidance(live: live { $0.centerY = 0.6 }, target: target, tolerance: .balanced).photographer,
      .aimDown)
    XCTAssertEqual(
      AngleMatcher.guidance(live: live { $0.centerY = 0.2 }, target: target, tolerance: .balanced).photographer,
      .aimUp)
  }

  func testSavedAngleFromAboveAsksToRaisePhone() {
    XCTAssertEqual(
      AngleMatcher.guidance(live: live { $0.pitch = -10 }, target: target, tolerance: .balanced).photographer,
      .raisePhone)
    XCTAssertEqual(
      AngleMatcher.guidance(live: live { $0.pitch = 20 }, target: target, tolerance: .balanced).photographer,
      .lowerPhone)
  }

  func testYawGapTurnsSubjectTowardTheirLeftOrRight() {
    // Target yaw is +10: nose toward the frame's right, the subject's left.
    XCTAssertEqual(
      AngleMatcher.guidance(live: live { $0.yaw = -10 }, target: target, tolerance: .balanced).subject, .turnLeft)
    XCTAssertEqual(
      AngleMatcher.guidance(live: live { $0.yaw = 30 }, target: target, tolerance: .balanced).subject, .turnRight)
  }

  func testRollGapTiltsTowardTheRightShoulder() {
    XCTAssertEqual(
      AngleMatcher.guidance(live: live { $0.roll = -12 }, target: target, tolerance: .balanced).subject, .tiltRight)
    XCTAssertEqual(
      AngleMatcher.guidance(live: live { $0.roll = 12 }, target: target, tolerance: .balanced).subject, .tiltLeft)
  }

  func testNoFaceAsksToFindThem() {
    XCTAssertEqual(AngleMatcher.guidance(live: nil, target: target, tolerance: .balanced), .noFace)
  }

  func testStrictToleranceRejectsWhatRelaxedAccepts() {
    let face = live { $0.yaw = 2 }
    XCTAssertTrue(AngleMatcher.guidance(live: face, target: target, tolerance: .relaxed).isMatched)
    XCTAssertFalse(AngleMatcher.guidance(live: face, target: target, tolerance: .strict).isMatched)
  }

  func testScoreFallsAsTheAngleDrifts() {
    let near = AngleMatcher.guidance(live: live { $0.yaw = 0 }, target: target, tolerance: .balanced)
    let far = AngleMatcher.guidance(live: live { $0.yaw = -30 }, target: target, tolerance: .balanced)
    XCTAssertGreaterThan(near.score, far.score)
    XCTAssertGreaterThanOrEqual(far.score, 0)
  }

  // MARK: - Live state

  func testAutoShootNeedsAHeldMatchAndFiresOnce() {
    let state = AngleCoachState()
    let start = Date(timeIntervalSinceReferenceDate: 1000)
    let frame = LiveFrame(face: target, image: nil)
    XCTAssertFalse(state.ingest(frame, target: target, tolerance: .balanced, now: start))
    XCTAssertFalse(state.ingest(frame, target: target, tolerance: .balanced, now: start.addingTimeInterval(0.5)))
    XCTAssertTrue(state.ingest(frame, target: target, tolerance: .balanced, now: start.addingTimeInterval(0.9)))
    // Holding still does not keep shooting.
    XCTAssertFalse(state.ingest(frame, target: target, tolerance: .balanced, now: start.addingTimeInterval(2)))
    XCTAssertEqual(state.guidance?.isMatched, true)
  }

  func testLeavingTheAngleRearmsAutoShoot() {
    let state = AngleCoachState()
    let start = Date(timeIntervalSinceReferenceDate: 1000)
    let matched = LiveFrame(face: target, image: nil)
    let away = LiveFrame(face: live { $0.height = 0.05 }, image: nil)
    state.ingest(matched, target: target, tolerance: .balanced, now: start)
    XCTAssertTrue(state.ingest(matched, target: target, tolerance: .balanced, now: start.addingTimeInterval(1)))
    for step in 0..<6 {
      state.ingest(away, target: target, tolerance: .balanced, now: start.addingTimeInterval(1.1 + Double(step) * 0.1))
    }
    XCTAssertEqual(state.guidance?.isMatched, false)
    var fired = false
    for step in 0..<30 {
      fired = fired
        || state.ingest(matched, target: target, tolerance: .balanced, now: start.addingTimeInterval(2 + Double(step) * 0.1))
    }
    XCTAssertTrue(fired)
  }

  func testNoSavedAngleMeansNoCues() {
    let state = AngleCoachState()
    XCTAssertFalse(state.ingest(LiveFrame(face: target, image: nil), target: nil, tolerance: .balanced))
    XCTAssertNil(state.guidance)
  }

  func testMirroredTargetFlipsHorizontally() {
    let face = FaceMeasurement(centerX: 0.25, centerY: 0.5, height: 0.2, yaw: 0, roll: 0, pitch: 0)
    let image = CGSize(width: 300, height: 400)
    let container = CGSize(width: 300, height: 400)
    let plain = AspectFill.faceRect(for: face, image: image, in: container, mirrored: false)
    let mirrored = AspectFill.faceRect(for: face, image: image, in: container, mirrored: true)
    XCTAssertEqual(plain.midX, 75, accuracy: 0.01)
    XCTAssertEqual(mirrored.midX, 225, accuracy: 0.01)
  }

  func testAspectFillCropsTheLongSide() {
    let rect = AspectFill.rect(for: CGSize(width: 300, height: 400), in: CGSize(width: 400, height: 400))
    XCTAssertEqual(rect.width, 400, accuracy: 0.01)
    XCTAssertEqual(rect.height, 533.33, accuracy: 0.01)
    XCTAssertEqual(rect.minY, -66.67, accuracy: 0.01)
  }

  // MARK: - Countdown

  func testCountdownShowsThePhraseWhileThePhotoIsTaken() async {
    let personas = makePersonaStore()
    personas.persona.countdownSeconds = 1
    personas.persona.countdownPhrase = "Cheese!"
    let model = CoachModel(personaStore: personas, angleStore: BestAngleStore(directory: nil))
    var cueDuringCapture: String?
    var countdownDuringCapture: Int?
    await model.runCountdown(cueHold: .zero) {
      cueDuringCapture = model.countdownCue
      countdownDuringCapture = model.countdown
    }
    XCTAssertEqual(cueDuringCapture, "Cheese!")
    XCTAssertNil(countdownDuringCapture)
    XCTAssertNil(model.countdownCue)
    XCTAssertFalse(model.isCountingDown)
  }

  // MARK: - Persona

  func testPersonaStoreAppliesChangesAndClamps() {
    let store = makePersonaStore()
    let updates = store.apply(
      CoachSettingsChange(
        name: "  Nova ", vibe: .calm, countdownPhrase: "Cheese!", countdownSeconds: 30, tolerance: .strict,
        autoShoot: false, rememberNote: "Left side is my good side"))
    XCTAssertEqual(store.persona.name, "Nova")
    XCTAssertEqual(store.persona.vibe, .calm)
    XCTAssertEqual(store.persona.countdownPhrase, "Cheese!")
    XCTAssertEqual(store.persona.countdownSeconds, 10)
    XCTAssertEqual(store.persona.tolerance, .strict)
    XCTAssertFalse(store.persona.autoShoot)
    XCTAssertEqual(store.persona.notes, "Left side is my good side")
    XCTAssertEqual(updates.count, 7)
    XCTAssertTrue(store.apply(CoachSettingsChange(name: "Nova")).isEmpty, "Unchanged settings report nothing")
  }

  func testPersonaPersistsAcrossLaunches() {
    let suite = "AngleCoachTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suite)!
    defer { defaults.removePersistentDomain(forName: suite) }
    CoachPersonaStore(defaults: defaults).apply(CoachSettingsChange(name: "Remy", countdownSeconds: 5))
    let reloaded = CoachPersonaStore(defaults: defaults)
    XCTAssertEqual(reloaded.persona.name, "Remy")
    XCTAssertEqual(reloaded.persona.countdownSeconds, 5)
  }

  func testBlankNameAndPhraseFallBackToDefaults() {
    let store = makePersonaStore()
    store.persona.name = "  "
    store.persona.countdownPhrase = ""
    store.fillBlankText()
    XCTAssertEqual(store.persona.name, CoachPersona().name)
    XCTAssertEqual(store.persona.countdownPhrase, CoachPersona().countdownPhrase)
  }

  // MARK: - Basic coach

  func testBasicCoachUnderstandsCustomization() {
    XCTAssertEqual(BasicCoach.parseChange("Call yourself nova").name, "Nova")
    XCTAssertEqual(BasicCoach.parseChange("Say cheese instead").countdownPhrase, "Cheese!")
    XCTAssertEqual(BasicCoach.parseChange("Use a 5 second countdown").countdownSeconds, 5)
    XCTAssertEqual(BasicCoach.parseChange("Be more calm").vibe, .calm)
    XCTAssertEqual(BasicCoach.parseChange("Be less strict about matching").tolerance, .relaxed)
    XCTAssertEqual(BasicCoach.parseChange("Don't auto shoot").autoShoot, false)
    XCTAssertEqual(BasicCoach.parseChange("Remember that my left side is better").rememberNote, "my left side is better")
  }

  func testBasicCoachLeavesQuestionsAlone() {
    XCTAssertTrue(BasicCoach.parseChange("How do I stay calm in photos?").isEmpty)
    XCTAssertTrue(BasicCoach.parseChange("What's my best angle?").isEmpty)
    let reply = BasicCoach.reply(
      to: "What's my best angle?", persona: CoachPersona(), angleSummary: ["Close-up", "Facing the camera"])
    XCTAssertNil(reply.change)
    XCTAssertTrue(reply.text.contains("Close-up"))
  }

  func testPromptCarriesPersonaAngleAndNotes() {
    var persona = CoachPersona()
    persona.name = "Nova"
    persona.countdownPhrase = "Cheese!"
    persona.notes = "No double chin"
    let prompt = CoachPrompt.instructions(persona: persona, angleSummary: ["Close-up", "Camera slightly above you"])
    XCTAssertTrue(prompt.contains("You are Nova"))
    XCTAssertTrue(prompt.contains("\"Cheese!\""))
    XCTAssertTrue(prompt.contains("No double chin"))
    XCTAssertTrue(prompt.contains("Camera slightly above you"))
    XCTAssertTrue(prompt.contains("updateCoachSettings"))
  }

  // MARK: - Best angle

  func testSummaryDescribesTheSavedAngle() {
    let profile = BestAngleProfile(
      measurement: FaceMeasurement(centerX: 0.5, centerY: 0.3, height: 0.4, yaw: 12, roll: 0, pitch: 9),
      createdAt: .now)
    XCTAssertEqual(
      profile.summaryKeys,
      ["angle.summary.closeUp", "angle.summary.upperThird", "angle.summary.turnedLeft", "angle.summary.cameraAbove"])
  }

  func testPhotoWithoutAFaceIsRejected() async throws {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 240, height: 320))
    let blank = renderer.image { context in
      UIColor.darkGray.setFill()
      context.fill(CGRect(x: 0, y: 0, width: 240, height: 320))
    }
    let cgImage = try XCTUnwrap(blank.cgImage)
    XCTAssertNil(try FaceAnalyzer.measure(cgImage: cgImage))

    let store = BestAngleStore(directory: nil)
    do {
      try await store.setReference(imageData: try XCTUnwrap(blank.pngData()))
      XCTFail("A photo without a face must not become the best angle")
    } catch {
      XCTAssertEqual(error as? BestAngleError, .noFace)
    }
    XCTAssertNil(store.profile)
    XCTAssertFalse(store.isAnalyzing)
  }
}
