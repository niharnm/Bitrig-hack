import AVFoundation
import CoreImage
import SwiftUI

/// One analyzed camera frame: the largest face, and a small upright copy for the outer mirror.
struct LiveFrame: @unchecked Sendable {
  var face: FaceMeasurement?
  /// Immutable once created, so it is safe to hand from the frame queue to the main actor.
  var image: CGImage?
}

/// Reads live video on its own queue, about ten times a second, so the photo path never waits on Vision.
final class LiveFrameAnalyzer: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, @unchecked Sendable {
  static let interval: TimeInterval = 0.1
  static let mirrorWidth: CGFloat = 360

  let output = AVCaptureVideoDataOutput()
  private let queue = DispatchQueue(label: "outerlens.frames")
  private let context = CIContext(options: [.cacheIntermediates: false])
  private let lock = NSLock()
  private var sink: (@Sendable (LiveFrame) -> Void)?
  /// Touched only on `queue`.
  private var lastProcessed: TimeInterval = 0

  override init() {
    super.init()
    output.alwaysDiscardsLateVideoFrames = true
    output.setSampleBufferDelegate(self, queue: queue)
  }

  func setSink(_ sink: @escaping @Sendable (LiveFrame) -> Void) {
    lock.withLock { self.sink = sink }
  }

  /// Upright and unmirrored, so live frames measure the same way as the saved photo.
  func configureConnection() {
    guard let connection = output.connection(with: .video) else { return }
    if connection.isVideoRotationAngleSupported(90) {
      connection.videoRotationAngle = 90
    }
    if connection.isVideoMirroringSupported {
      connection.automaticallyAdjustsVideoMirroring = false
      connection.isVideoMirrored = false
    }
  }

  func captureOutput(
    _ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection
  ) {
    let now = ProcessInfo.processInfo.systemUptime
    guard now - lastProcessed >= Self.interval,
      let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
    else { return }
    lastProcessed = now
    let frame = LiveFrame(face: FaceAnalyzer.measure(pixelBuffer: pixelBuffer), image: preview(of: pixelBuffer))
    let sink = lock.withLock { self.sink }
    sink?(frame)
  }

  private func preview(of pixelBuffer: CVPixelBuffer) -> CGImage? {
    let image = CIImage(cvPixelBuffer: pixelBuffer)
    guard image.extent.width > 0 else { return nil }
    let scale = Self.mirrorWidth / image.extent.width
    let scaled = image.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
    return context.createCGImage(scaled, from: scaled.extent)
  }
}

/// Live best-angle state shared by both displays: the mirror frame, the smoothed face, and the current cues.
@MainActor
@Observable
final class AngleCoachState {
  /// How long a match must hold before the coach starts the countdown on its own.
  static let holdDuration: TimeInterval = 0.8
  /// A face that vanishes for longer than this stops steering the cues.
  static let faceTimeout: TimeInterval = 0.6
  static let smoothing = 0.45

  private(set) var mirrorFrame: CGImage?
  private(set) var guidance: AngleGuidance?
  private(set) var liveFace: FaceMeasurement?
  @ObservationIgnored private var lastFaceAt: Date?
  @ObservationIgnored private var matchedSince: Date?
  /// Cleared after an automatic shot; set again once the subject leaves the angle, so holding still takes one photo.
  @ObservationIgnored private var isArmed = true

  var frameSize: CGSize? {
    mirrorFrame.map { CGSize(width: $0.width, height: $0.height) }
  }

  /// Returns true when the saved angle has held long enough to shoot.
  @discardableResult
  func ingest(
    _ frame: LiveFrame, target: FaceMeasurement?, tolerance: AngleTolerance, now: Date = .now
  ) -> Bool {
    if let image = frame.image {
      mirrorFrame = image
    }
    if let face = frame.face {
      liveFace = liveFace.map { Self.blend($0, face) } ?? face
      lastFaceAt = now
    } else if let lastFaceAt, now.timeIntervalSince(lastFaceAt) > Self.faceTimeout {
      liveFace = nil
    }

    guard let target else {
      guidance = nil
      matchedSince = nil
      return false
    }
    let next = AngleMatcher.guidance(live: liveFace, target: target, tolerance: tolerance)
    guidance = next
    guard next.isMatched else {
      matchedSince = nil
      isArmed = true
      return false
    }
    let since = matchedSince ?? now
    matchedSince = since
    guard isArmed, now.timeIntervalSince(since) >= Self.holdDuration else { return false }
    isArmed = false
    return true
  }

  /// Rehearsal without a camera: show the matched cues so the room sees the hand-off moment.
  func simulateMatch() {
    guidance = .matched
  }

  func reset() {
    mirrorFrame = nil
    guidance = nil
    liveFace = nil
    lastFaceAt = nil
    matchedSince = nil
    isArmed = true
  }

  private static func blend(_ old: FaceMeasurement, _ new: FaceMeasurement) -> FaceMeasurement {
    let k = smoothing
    func mix(_ a: Double, _ b: Double) -> Double { a + (b - a) * k }
    return FaceMeasurement(
      centerX: mix(old.centerX, new.centerX),
      centerY: mix(old.centerY, new.centerY),
      height: mix(old.height, new.height),
      yaw: mix(old.yaw, new.yaw),
      roll: mix(old.roll, new.roll),
      pitch: mix(old.pitch, new.pitch))
  }
}

/// Where an aspect-filled image lands inside a container, matching `resizeAspectFill`.
enum AspectFill {
  static func rect(for image: CGSize, in container: CGSize) -> CGRect {
    guard image.width > 0, image.height > 0 else { return CGRect(origin: .zero, size: container) }
    let scale = max(container.width / image.width, container.height / image.height)
    let size = CGSize(width: image.width * scale, height: image.height * scale)
    return CGRect(
      x: (container.width - size.width) / 2, y: (container.height - size.height) / 2,
      width: size.width, height: size.height)
  }

  /// Screen rect for a saved face, optionally mirrored for the subject's view of themselves.
  static func faceRect(
    for face: FaceMeasurement, image: CGSize, in container: CGSize, mirrored: Bool
  ) -> CGRect {
    let frame = rect(for: image, in: container)
    let x = mirrored ? 1 - face.centerX : face.centerX
    let height = face.height * frame.height
    // Vision's face box is roughly square in the frame; draw it as a portrait oval around the head.
    let width = height * 0.8
    return CGRect(
      x: frame.minX + x * frame.width - width / 2,
      y: frame.minY + face.centerY * frame.height - height * 0.6,
      width: width, height: height * 1.2)
  }
}
