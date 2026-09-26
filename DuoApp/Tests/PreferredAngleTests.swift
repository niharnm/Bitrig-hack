import XCTest
@testable import DuoApp

final class PreferredAngleTests: XCTestCase {
  private let target = PreferredAngle(height: 0.6, orbit: -0.6, distance: 0)

  func testMatchIsHundredOnlyAtTheSavedAngle() {
    XCTAssertEqual(AngleGuide.matchPercent(current: target, target: target), 100)
    XCTAssertTrue(AngleGuide.moves(current: target, target: target).isEmpty)
    var off = target
    off.height -= 0.25
    XCTAssertLessThan(AngleGuide.matchPercent(current: off, target: target), 100)
    XCTAssertEqual(AngleGuide.moves(current: off, target: target), [.raise])
  }

  func testNewStrangerNeedsEveryMoveAndFollowingArrowsReachesPerfect() {
    var current = AngleGuide.startingPoint(for: target)
    XCTAssertEqual(Set(AngleGuide.moves(current: current, target: target)).count, 3)
    let start = AngleGuide.matchPercent(current: current, target: target)
    XCTAssertLessThan(start, 50)
    var taps = 0
    while let move = AngleGuide.moves(current: current, target: target).first, taps < 20 {
      current = AngleGuide.nudged(current, by: move)
      taps += 1
    }
    XCTAssertEqual(taps, 9, "Three taps per axis")
    XCTAssertEqual(AngleGuide.matchPercent(current: current, target: target), 100)
  }

  func testArrowDirections() {
    let low = PreferredAngle(height: -0.5, orbit: 0.5, distance: 0.5)
    let moves = Set(AngleGuide.moves(current: low, target: .eyeLevel))
    XCTAssertEqual(moves, [.raise, .moveLeft, .stepCloser])
  }

  func testStartingPointStaysInRange() {
    for value in stride(from: -1.0, through: 1.0, by: 0.1) {
      let start = AngleGuide.startingPoint(for: PreferredAngle(height: value, orbit: value, distance: value))
      XCTAssertEqual(start, start.clamped(), "value \(value)")
    }
  }

  func testPhotoPatternFramingFromFaceSize() {
    let closeUp = FavoritePhotoPattern.preferredAngle(from: [FaceSample(yaw: 0, pitch: 0, faceHeight: 0.4)])
    let fullBody = FavoritePhotoPattern.preferredAngle(from: [FaceSample(yaw: 0, pitch: 0, faceHeight: 0.05)])
    let waistUp = FavoritePhotoPattern.preferredAngle(from: [FaceSample(yaw: nil, pitch: nil, faceHeight: 0.15)])
    XCTAssertLessThan(closeUp?.distance ?? 0, -0.9)
    XCTAssertGreaterThan(fullBody?.distance ?? 0, 0.9)
    XCTAssertEqual(waistUp?.distance ?? 1, 0, accuracy: 0.001)
    XCTAssertNil(FavoritePhotoPattern.preferredAngle(from: []))
  }

  func testSetupOptionsPickNearest() {
    XCTAssertEqual(AngleAxis.height.nearestOption(to: 0.5).title, "Above")
    XCTAssertEqual(AngleAxis.side.nearestOption(to: -0.4).title, "Right side")
    XCTAssertEqual(AngleAxis.framing.nearestOption(to: 0.05).title, "Waist up")
  }
}
