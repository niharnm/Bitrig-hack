import CoreImage
import Foundation
import Vision

/// Where the camera should sit relative to you, in the photographer's frame. Each axis runs -1...1.
/// height: below (-1) to above (+1) your eye level. orbit: photographer's left (-1) to right (+1).
/// distance: close-up (-1) to full body (+1).
struct PreferredAngle: Codable, Equatable, Sendable {
  var height: Double
  var orbit: Double
  var distance: Double

  static let eyeLevel = PreferredAngle(height: 0, orbit: 0, distance: 0)

  func clamped() -> PreferredAngle {
    PreferredAngle(
      height: height.clampedToUnit, orbit: orbit.clampedToUnit, distance: distance.clampedToUnit)
  }
}

extension Double {
  fileprivate var clampedToUnit: Double { Swift.min(1, Swift.max(-1, self)) }
}

// MARK: - Setup choices

struct AngleOption: Identifiable, Equatable, Sendable {
  let title: String
  let value: Double
  var id: String { title }
}

/// The three things you pick during setup. The AI result lands on the same axes.
enum AngleAxis: CaseIterable, Identifiable, Sendable {
  case height
  case side
  case framing

  var id: Self { self }

  var title: String {
    switch self {
    case .height: "Camera height"
    case .side: "Your good side"
    case .framing: "Framing"
    }
  }

  /// Side is named from your point of view; showing your right side puts the camera on the photographer's left.
  var options: [AngleOption] {
    switch self {
    case .height:
      [.init(title: "Below", value: -0.6), .init(title: "Eye level", value: 0), .init(title: "Above", value: 0.6)]
    case .side:
      [.init(title: "Left side", value: 0.6), .init(title: "Straight on", value: 0), .init(title: "Right side", value: -0.6)]
    case .framing:
      [.init(title: "Close-up", value: -0.7), .init(title: "Waist up", value: 0), .init(title: "Full body", value: 0.7)]
    }
  }

  func value(in angle: PreferredAngle) -> Double {
    switch self {
    case .height: angle.height
    case .side: angle.orbit
    case .framing: angle.distance
    }
  }

  func set(_ value: Double, in angle: inout PreferredAngle) {
    switch self {
    case .height: angle.height = value
    case .side: angle.orbit = value
    case .framing: angle.distance = value
    }
  }

  func nearestOption(to value: Double) -> AngleOption {
    options.min { abs($0.value - value) < abs($1.value - value) } ?? options[1]
  }
}

// MARK: - Live guidance

/// One instruction for the person holding the phone.
enum PhoneMove: CaseIterable, Equatable, Sendable {
  case raise
  case lower
  case moveLeft
  case moveRight
  case stepCloser
  case stepBack

  var instruction: String {
    switch self {
    case .raise: "Raise the phone"
    case .lower: "Lower the phone"
    case .moveLeft: "Move left"
    case .moveRight: "Move right"
    case .stepCloser: "Step closer"
    case .stepBack: "Step back"
    }
  }

  var shortLabel: String {
    switch self {
    case .raise: "Raise"
    case .lower: "Lower"
    case .moveLeft: "Left"
    case .moveRight: "Right"
    case .stepCloser: "Closer"
    case .stepBack: "Back"
    }
  }

  var symbol: String {
    switch self {
    case .raise: "arrow.up"
    case .lower: "arrow.down"
    case .moveLeft: "arrow.left"
    case .moveRight: "arrow.right"
    case .stepCloser: "arrow.up.left.and.arrow.down.right"
    case .stepBack: "arrow.down.right.and.arrow.up.left"
    }
  }
}

enum AngleGuide {
  /// Closer than this on an axis counts as matched.
  static let tolerance = 0.13
  /// How far one tap on an arrow moves the simulated phone.
  static let step = 0.25
  /// A new stranger starts this far off on every axis: three taps each.
  static let startOffset = 0.75

  /// 0...100. Reaches 100 only when every axis is inside tolerance.
  static func matchPercent(current: PreferredAngle, target: PreferredAngle) -> Int {
    let misses = gaps(current: current, target: target).map { Swift.max(0, abs($0) - tolerance) }
    let score = 1 - misses.reduce(0, +) / 3
    return Int((Swift.max(0, score) * 100).rounded(.down))
  }

  static func isPerfect(current: PreferredAngle, target: PreferredAngle) -> Bool {
    matchPercent(current: current, target: target) == 100
  }

  /// Every move still needed, biggest gap first.
  static func moves(current: PreferredAngle, target: PreferredAngle) -> [PhoneMove] {
    let gap = gaps(current: current, target: target)
    let candidates: [(PhoneMove, Double)] = [
      (gap[2] > 0 ? .stepBack : .stepCloser, abs(gap[2])),
      (gap[1] > 0 ? .moveRight : .moveLeft, abs(gap[1])),
      (gap[0] > 0 ? .raise : .lower, abs(gap[0])),
    ]
    return candidates
      .filter { $0.1 > tolerance }
      .enumerated()
      .sorted { $0.element.1 != $1.element.1 ? $0.element.1 > $1.element.1 : $0.offset < $1.offset }
      .map(\.element.0)
  }

  static func nudged(_ angle: PreferredAngle, by move: PhoneMove) -> PreferredAngle {
    var next = angle
    switch move {
    case .raise: next.height += step
    case .lower: next.height -= step
    case .moveRight: next.orbit += step
    case .moveLeft: next.orbit -= step
    case .stepBack: next.distance += step
    case .stepCloser: next.distance -= step
    }
    return next.clamped()
  }

  /// Where a stranger's first framing lands: off on every axis, and a whole number of taps from the target.
  static func startingPoint(for target: PreferredAngle) -> PreferredAngle {
    func offset(_ value: Double) -> Double {
      value - startOffset >= -1 ? value - startOffset : value + startOffset
    }
    return PreferredAngle(
      height: offset(target.height), orbit: offset(target.orbit), distance: offset(target.distance))
  }

  /// target minus current, per axis: height, orbit, distance.
  private static func gaps(current: PreferredAngle, target: PreferredAngle) -> [Double] {
    [
      target.height - current.height,
      target.orbit - current.orbit,
      target.distance - current.distance,
    ]
  }
}

// MARK: - Learning from favorite photos (Pro)

/// The largest face in one photo: head turn and tilt in radians, and face height as a share of the frame.
struct FaceSample: Equatable, Sendable {
  var yaw: Double?
  var pitch: Double?
  var faceHeight: Double
}

/// Averages the faces in your favorite photos into one preferred angle.
enum FavoritePhotoPattern {
  /// About 35 degrees of head turn maps to a full orbit.
  static let fullTurn = 0.61
  /// About 25 degrees of head tilt maps to the top or bottom of the height axis.
  static let fullTilt = 0.44
  /// A face this tall (share of the frame) reads as waist up.
  static let waistUpFaceHeight = 0.15

  static func preferredAngle(from samples: [FaceSample]) -> PreferredAngle? {
    guard !samples.isEmpty else { return nil }
    let yaws = samples.compactMap(\.yaw)
    let pitches = samples.compactMap(\.pitch)
    let meanYaw = yaws.isEmpty ? 0 : yaws.reduce(0, +) / Double(yaws.count)
    let meanPitch = pitches.isEmpty ? 0 : pitches.reduce(0, +) / Double(pitches.count)
    let meanFace = samples.map(\.faceHeight).reduce(0, +) / Double(samples.count)
    return PreferredAngle(
      // A turned head in your favorites means the camera was off to that side.
      height: -meanPitch / fullTilt,
      orbit: meanYaw / fullTurn,
      // Bigger faces mean closer framing: 2.5x the waist-up size is a close-up.
      distance: log(waistUpFaceHeight / Swift.max(meanFace, 0.01)) / log(2.5)
    ).clamped()
  }
}

/// On-device face detection with Apple's Vision framework. Photos never leave the phone.
enum FavoritePhotoAnalyzer {
  static func samples(from photos: [Data]) async -> [FaceSample] {
    await Task.detached(priority: .userInitiated) {
      photos.compactMap { sample(from: $0) }
    }.value
  }

  static func sample(from data: Data) -> FaceSample? {
    guard let image = CIImage(data: data, options: [.applyOrientationProperty: true]) else {
      return nil
    }
    let request = VNDetectFaceRectanglesRequest()
    request.revision = VNDetectFaceRectanglesRequestRevision3
    let handler = VNImageRequestHandler(ciImage: image, options: [:])
    do {
      try handler.perform([request])
    } catch {
      return nil
    }
    guard
      let face = request.results?.max(by: { $0.boundingBox.height < $1.boundingBox.height })
    else { return nil }
    return FaceSample(
      yaw: face.yaw?.doubleValue,
      pitch: face.pitch?.doubleValue,
      faceHeight: Double(face.boundingBox.height))
  }
}
