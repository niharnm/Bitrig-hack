import Foundation
import ImageIO
import UIKit
import Vision

/// Where a face sits in an upright frame and how the head is turned. Positions are 0...1 from the top-left.
/// Both the saved photo and live frames are measured "as others see you", never mirrored.
struct FaceMeasurement: Codable, Equatable, Sendable {
  var centerX: Double
  var centerY: Double
  /// Face box height as a fraction of the frame height. Stands in for camera distance.
  var height: Double
  /// Degrees. Positive turns the nose toward the frame's right, which is the subject's left.
  var yaw: Double
  /// Degrees. Positive tilts the head counterclockwise in the frame, toward the subject's right shoulder.
  var roll: Double
  /// Degrees. Positive nods the head down, which is how a face looks from a camera held above it.
  var pitch: Double
}

extension FaceMeasurement {
  init(observation: VNFaceObservation) {
    let box = observation.boundingBox
    let degrees = { (value: NSNumber?) in (value?.doubleValue ?? 0) * 180 / .pi }
    self.init(
      centerX: box.midX,
      centerY: 1 - box.midY,
      height: box.height,
      yaw: degrees(observation.yaw),
      roll: degrees(observation.roll),
      pitch: degrees(observation.pitch))
  }
}

/// How close the live frame must be before the coach calls it a match.
enum AngleTolerance: String, Codable, CaseIterable, Identifiable, Sendable {
  case relaxed
  case balanced
  case strict

  var id: String { rawValue }

  var titleKey: String { "coach.tolerance.\(rawValue)" }

  /// Normalized distance the face center may drift from the saved spot.
  var position: Double {
    switch self {
    case .relaxed: 0.10
    case .balanced: 0.07
    case .strict: 0.045
    }
  }

  /// Relative face size error, so 0.16 allows 16% larger or smaller.
  var size: Double {
    switch self {
    case .relaxed: 0.25
    case .balanced: 0.16
    case .strict: 0.10
    }
  }

  var yaw: Double {
    switch self {
    case .relaxed: 14
    case .balanced: 9
    case .strict: 6
    }
  }

  var roll: Double {
    switch self {
    case .relaxed: 10
    case .balanced: 7
    case .strict: 4
    }
  }

  var pitch: Double {
    switch self {
    case .relaxed: 12
    case .balanced: 8
    case .strict: 5
    }
  }
}

/// One instruction for the person holding the phone. They control where the camera is.
enum PhotographerCue: String, Equatable, Sendable {
  case findFace
  case stepCloser
  case stepBack
  case aimLeft
  case aimRight
  case aimUp
  case aimDown
  case raisePhone
  case lowerPhone
  case hold

  var key: String { "angle.photographer.\(rawValue)" }

  var symbolName: String {
    switch self {
    case .findFace: "viewfinder"
    case .stepCloser: "arrow.up.forward"
    case .stepBack: "arrow.down.backward"
    case .aimLeft: "arrow.left"
    case .aimRight: "arrow.right"
    case .aimUp: "arrow.up"
    case .aimDown: "arrow.down"
    case .raisePhone: "arrow.up.to.line"
    case .lowerPhone: "arrow.down.to.line"
    case .hold: "checkmark.circle.fill"
    }
  }
}

/// One instruction for the subject on the outer display. They control their head.
enum SubjectCue: String, Equatable, Sendable {
  case lookAtCamera
  case turnLeft
  case turnRight
  case tiltLeft
  case tiltRight
  case hold

  var key: String { "angle.subject.\(rawValue)" }
}

struct AngleGuidance: Equatable, Sendable {
  var photographer: PhotographerCue
  var subject: SubjectCue
  /// 0...1. Rises as the live frame approaches the saved angle, so people can play warmer/colder.
  var score: Double
  var isMatched: Bool

  static let noFace = AngleGuidance(
    photographer: .findFace, subject: .lookAtCamera, score: 0, isMatched: false)
  static let matched = AngleGuidance(photographer: .hold, subject: .hold, score: 1, isMatched: true)
}

/// Turns the gap between a live face and the saved one into one cue per person.
/// The photographer fixes distance, framing, then height. The subject fixes turn, then tilt.
enum AngleMatcher {
  static func guidance(
    live: FaceMeasurement?, target: FaceMeasurement, tolerance: AngleTolerance
  ) -> AngleGuidance {
    guard let live, target.height > 0 else { return .noFace }

    let sizeError = live.height / target.height - 1
    let dx = live.centerX - target.centerX
    let dy = live.centerY - target.centerY
    let dYaw = target.yaw - live.yaw
    let dRoll = target.roll - live.roll
    let dPitch = target.pitch - live.pitch

    let errors: [(value: Double, limit: Double, weight: Double)] = [
      (sizeError, tolerance.size, 1.2),
      (dx, tolerance.position, 1),
      (dy, tolerance.position, 1),
      (dPitch, tolerance.pitch, 0.8),
      (dYaw, tolerance.yaw, 1.2),
      (dRoll, tolerance.roll, 0.8),
    ]
    let isMatched = errors.allSatisfy { abs($0.value) <= $0.limit }
    // Inside tolerance scores at least 2/3; three times the tolerance scores zero.
    let totalWeight = errors.reduce(0) { $0 + $1.weight }
    let score =
      errors.reduce(0) { sum, error in
        sum + error.weight * max(0, 1 - abs(error.value) / error.limit / 3)
      } / totalWeight

    let photographer: PhotographerCue
    if sizeError < -tolerance.size {
      photographer = .stepCloser
    } else if sizeError > tolerance.size {
      photographer = .stepBack
    } else if abs(dx) > tolerance.position {
      // Panning toward the side the face drifted to brings it back.
      photographer = dx > 0 ? .aimRight : .aimLeft
    } else if abs(dy) > tolerance.position {
      photographer = dy > 0 ? .aimDown : .aimUp
    } else if abs(dPitch) > tolerance.pitch {
      photographer = dPitch > 0 ? .raisePhone : .lowerPhone
    } else {
      photographer = .hold
    }

    let subject: SubjectCue
    if abs(dYaw) > tolerance.yaw {
      subject = dYaw > 0 ? .turnLeft : .turnRight
    } else if abs(dRoll) > tolerance.roll {
      subject = dRoll > 0 ? .tiltRight : .tiltLeft
    } else {
      subject = .hold
    }

    return AngleGuidance(
      photographer: photographer, subject: subject, score: isMatched ? max(score, 0.9) : score,
      isMatched: isMatched)
  }
}

enum FaceAnalyzer {
  /// Largest face in an upright image, or nil when Vision finds none.
  static func measure(cgImage: CGImage) throws -> FaceMeasurement? {
    let request = VNDetectFaceRectanglesRequest()
    try VNImageRequestHandler(cgImage: cgImage, orientation: .up).perform([request])
    return largest(request.results)
  }

  /// Live frames arrive already rotated upright by the video connection.
  static func measure(pixelBuffer: CVPixelBuffer) -> FaceMeasurement? {
    let request = VNDetectFaceRectanglesRequest()
    do {
      try VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up).perform([request])
    } catch {
      return nil
    }
    return largest(request.results)
  }

  private static func largest(_ faces: [VNFaceObservation]?) -> FaceMeasurement? {
    faces?
      .max { $0.boundingBox.width * $0.boundingBox.height < $1.boundingBox.width * $1.boundingBox.height }
      .map(FaceMeasurement.init(observation:))
  }
}

struct BestAngleProfile: Codable, Equatable, Sendable {
  var measurement: FaceMeasurement
  var createdAt: Date

  /// Plain-language keys describing the saved angle, for the studio card and the coach's instructions.
  var summaryKeys: [String] {
    let face = measurement
    var keys: [String] = []
    switch face.height {
    case 0.35...: keys.append("angle.summary.closeUp")
    case 0.18..<0.35: keys.append("angle.summary.portrait")
    case 0.08..<0.18: keys.append("angle.summary.halfBody")
    default: keys.append("angle.summary.fullBody")
    }
    if face.centerX < 0.4 {
      keys.append("angle.summary.leftOfCenter")
    } else if face.centerX > 0.6 {
      keys.append("angle.summary.rightOfCenter")
    } else if face.centerY < 0.4 {
      keys.append("angle.summary.upperThird")
    } else {
      keys.append("angle.summary.centered")
    }
    if face.yaw > 6 {
      keys.append("angle.summary.turnedLeft")
    } else if face.yaw < -6 {
      keys.append("angle.summary.turnedRight")
    } else {
      keys.append("angle.summary.facingCamera")
    }
    if face.pitch > 6 {
      keys.append("angle.summary.cameraAbove")
    } else if face.pitch < -6 {
      keys.append("angle.summary.cameraBelow")
    } else {
      keys.append("angle.summary.eyeLevel")
    }
    if abs(face.roll) > 6 {
      keys.append("angle.summary.headTilt")
    }
    return keys
  }

  var summary: [String] {
    summaryKeys.map { String(localized: String.LocalizationValue($0)) }
  }
}

enum BestAngleError: LocalizedError, Equatable {
  case unreadableImage
  case noFace

  var errorDescription: String? {
    switch self {
    case .unreadableImage: String(localized: "coach.bestAngle.error.unreadable")
    case .noFace: String(localized: "coach.bestAngle.error.noFace")
    }
  }
}

/// The owner's saved best angle. Stays on this device in Application Support; nothing is uploaded.
@MainActor
@Observable
final class BestAngleStore {
  static let shared = BestAngleStore()

  private(set) var profile: BestAngleProfile?
  private(set) var referenceImage: UIImage?
  private(set) var isAnalyzing = false
  @ObservationIgnored private let directory: URL?

  private var profileURL: URL? { directory?.appendingPathComponent("profile.json") }
  private var imageURL: URL? { directory?.appendingPathComponent("reference.jpg") }

  /// Pass nil to keep everything in memory, as tests do.
  init(directory: URL? = BestAngleStore.defaultDirectory) {
    self.directory = directory
    if let profileURL, let data = try? Data(contentsOf: profileURL) {
      profile = try? JSONDecoder().decode(BestAngleProfile.self, from: data)
    }
    if profile != nil, let imageURL {
      referenceImage = UIImage(contentsOfFile: imageURL.path)
    }
  }

  nonisolated static var defaultDirectory: URL? {
    FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?
      .appendingPathComponent("BestAngle", isDirectory: true)
  }

  /// Scans a photo for the owner's face and saves it as the angle to match.
  @discardableResult
  func setReference(imageData: Data) async throws -> BestAngleProfile {
    isAnalyzing = true
    defer { isAnalyzing = false }
    let analysis = try await Task.detached(priority: .userInitiated) {
      try Self.analyze(imageData)
    }.value
    let profile = BestAngleProfile(measurement: analysis.measurement, createdAt: .now)
    if let directory, let profileURL, let imageURL {
      try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
      try analysis.jpeg.write(to: imageURL, options: [.atomic, .completeFileProtection])
      try JSONEncoder().encode(profile).write(to: profileURL, options: [.atomic, .completeFileProtection])
    }
    self.profile = profile
    referenceImage = UIImage(data: analysis.jpeg)
    return profile
  }

  func clear() {
    profile = nil
    referenceImage = nil
    if let directory {
      try? FileManager.default.removeItem(at: directory)
    }
  }

  private struct Analysis: Sendable {
    var measurement: FaceMeasurement
    var jpeg: Data
  }

  /// Draws the photo upright at a modest size, so Vision and the saved copy agree on orientation.
  nonisolated private static func analyze(_ data: Data) throws -> Analysis {
    guard let image = UIImage(data: data), image.size.width > 0, image.size.height > 0 else {
      throw BestAngleError.unreadableImage
    }
    let longest: CGFloat = 1280
    let scale = min(1, longest / max(image.size.width, image.size.height))
    let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
    let format = UIGraphicsImageRendererFormat()
    format.scale = 1
    let upright = UIGraphicsImageRenderer(size: size, format: format).image { _ in
      image.draw(in: CGRect(origin: .zero, size: size))
    }
    guard let cgImage = upright.cgImage, let jpeg = upright.jpegData(compressionQuality: 0.85) else {
      throw BestAngleError.unreadableImage
    }
    guard let measurement = try FaceAnalyzer.measure(cgImage: cgImage) else {
      throw BestAngleError.noFace
    }
    return Analysis(measurement: measurement, jpeg: jpeg)
  }
}
