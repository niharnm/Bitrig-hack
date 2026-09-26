import AVFoundation
import SwiftUI

/// Photo-only capture for SCR-OL-B. The session runs on a private queue and stays on the inner display.
@MainActor
@Observable
final class CaptureSessionController {
  private(set) var permission = CaptureSessionController.currentPermission()
  private(set) var phase: CaptureSessionPhase = .idle
  /// False when discovery finds no camera, as in the simulator. Tips still work (§11.2.4 B.noDevices).
  private(set) var hasCamera = true
  /// Successful captures this session. Drives the shutter haptic.
  private(set) var capturedPhotoCount = 0
  /// True when the most recent shutter produced no photo. Cleared by the next shutter.
  private(set) var lastPhotoFailed = false
  /// The most recent photo, kept in memory only so the owner can save it as their best angle.
  @ObservationIgnored private(set) var lastPhotoData: Data?
  /// Receives analyzed frames for the best-angle coach and the outer mirror.
  @ObservationIgnored var onLiveFrame: (@MainActor (LiveFrame) -> Void)?
  @ObservationIgnored private let pipeline = CapturePipeline()

  init() {
    pipeline.frames.setSink { [weak self] frame in
      Task { @MainActor in
        self?.onLiveFrame?(frame)
      }
    }
  }

  var session: AVCaptureSession { pipeline.session }
  /// `shutterFlash` belongs to the live family (§07): the preview stays up while a photo is taken.
  var isLive: Bool { phase == .live || phase == .shutterFlash }

  static func currentPermission() -> PermissionSubstate {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized: .authorized
    case .denied: .denied
    case .restricted: .restricted
    default: .notDetermined
    }
  }

  func requestAccess() async {
    permission = .requesting
    _ = await AVCaptureDevice.requestAccess(for: .video)
    permission = Self.currentPermission()
  }

  func start() async {
    guard permission == .authorized else { return }
    switch phase {
    case .idle, .failed: break
    default: return
    }
    phase = .starting
    let result = await pipeline.start(position: .back)
    hasCamera = result != .noCamera
    switch result {
    case .running: phase = .live
    case .noCamera: phase = .idle
    case .failed: phase = .failed(.configuration)
    }
  }

  func stop() {
    pipeline.stop()
    phase = .idle
  }

  func flipCamera() async {
    guard phase == .live else { return }
    _ = await pipeline.flip()
  }

  /// C8: live → shutterFlash → live. No-camera idle still flashes for Peak-End tip theater.
  /// The flash lasts at least 200ms (§11.2.4 B.capturing).
  func capturePhoto() async {
    let canFlash = phase == .live || (phase == .idle && !hasCamera)
    guard canFlash else { return }
    let resume: CaptureSessionPhase = phase == .live ? .live : .idle
    phase = .shutterFlash
    lastPhotoFailed = false
    async let minimumFlash: Void? = try? Task.sleep(for: .milliseconds(200))
    let outcome: PhotoCaptureOutcome
    var photoData: Data?
    if resume == .live {
      (outcome, photoData) = await pipeline.capturePhoto()
    } else {
      // Simulator / noDevices: visible flash + tip advance without AV capture.
      outcome = .captured
    }
    _ = await minimumFlash
    switch outcome {
    case .captured:
      capturedPhotoCount += 1
      if let photoData {
        lastPhotoData = photoData
      }
    case .failed: lastPhotoFailed = true
    }
    // `stop()` may have run while the photo was processing.
    if phase == .shutterFlash {
      phase = resume
    }
  }
}

/// Photo-only slice: the photo is not saved, so no photo library permission is requested (§11.1.4).
enum PhotoCaptureOutcome: Equatable, Sendable {
  case captured
  case failed

  init(fileData: Data?, error: Error?) {
    self = error == nil && fileData?.isEmpty == false ? .captured : .failed
  }
}

/// Owns the AVFoundation objects. They are not Sendable, so every touch happens on `queue`.
private final class CapturePipeline: NSObject, AVCapturePhotoCaptureDelegate, @unchecked Sendable {
  enum StartResult: Sendable {
    case running
    case noCamera
    case failed
  }

  let session = AVCaptureSession()
  let frames = LiveFrameAnalyzer()
  private let photoOutput = AVCapturePhotoOutput()
  private let queue = DispatchQueue(label: "outerlens.capture")
  private var input: AVCaptureDeviceInput?
  /// Keyed by `AVCapturePhotoSettings.uniqueID`. Touched only on `queue`.
  private var pendingPhotos:
    [Int64: (outcome: PhotoCaptureOutcome?, data: Data?, finish: (PhotoCaptureOutcome, Data?) -> Void)] = [:]

  func start(position: AVCaptureDevice.Position) async -> StartResult {
    await withCheckedContinuation { continuation in
      queue.async {
        continuation.resume(returning: self.configure(position: position))
      }
    }
  }

  func stop() {
    queue.async {
      self.session.stopRunning()
    }
  }

  func flip() async -> StartResult {
    await withCheckedContinuation { continuation in
      queue.async {
        let next: AVCaptureDevice.Position = self.input?.device.position == .back ? .front : .back
        continuation.resume(returning: self.configure(position: next))
      }
    }
  }

  func capturePhoto() async -> (PhotoCaptureOutcome, Data?) {
    await withCheckedContinuation { continuation in
      queue.async {
        // Capturing without an active video connection raises an Objective-C exception.
        guard self.session.isRunning,
          self.photoOutput.connection(with: .video)?.isActive == true
        else {
          continuation.resume(returning: (.failed, nil))
          return
        }
        let settings = AVCapturePhotoSettings()
        self.pendingPhotos[settings.uniqueID] = (nil, nil, { continuation.resume(returning: ($0, $1)) })
        self.photoOutput.capturePhoto(with: settings, delegate: self)
      }
    }
  }

  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    let data = photo.fileDataRepresentation()
    let outcome = PhotoCaptureOutcome(fileData: data, error: error)
    let id = photo.resolvedSettings.uniqueID
    queue.async {
      self.pendingPhotos[id]?.outcome = outcome
      self.pendingPhotos[id]?.data = outcome == .captured ? data : nil
    }
  }

  /// Always the last callback for a request, including failures before any photo was processed.
  func photoOutput(
    _ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings,
    error: Error?
  ) {
    let id = resolvedSettings.uniqueID
    queue.async {
      guard let pending = self.pendingPhotos.removeValue(forKey: id) else { return }
      let outcome = error == nil ? pending.outcome ?? .failed : .failed
      pending.finish(outcome, outcome == .captured ? pending.data : nil)
    }
  }

  private func configure(position: AVCaptureDevice.Position) -> StartResult {
    guard
      let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position)
        ?? AVCaptureDevice.default(for: .video)
    else {
      return .noCamera
    }
    session.beginConfiguration()
    session.sessionPreset = .photo
    if let input {
      session.removeInput(input)
    }
    guard let newInput = try? AVCaptureDeviceInput(device: device), session.canAddInput(newInput) else {
      session.commitConfiguration()
      return .failed
    }
    session.addInput(newInput)
    input = newInput
    if !session.outputs.contains(photoOutput), session.canAddOutput(photoOutput) {
      session.addOutput(photoOutput)
    }
    // Live frames feed the best-angle coach; the photo path works without them.
    if !session.outputs.contains(frames.output), session.canAddOutput(frames.output) {
      session.addOutput(frames.output)
    }
    frames.configureConnection()
    session.commitConfiguration()
    if !session.isRunning {
      session.startRunning()
    }
    return .running
  }
}

/// Live camera preview for the inner display.
struct CapturePreviewView: UIViewRepresentable {
  let session: AVCaptureSession

  func makeUIView(context: Context) -> PreviewView {
    let view = PreviewView()
    view.previewLayer.session = session
    view.previewLayer.videoGravity = .resizeAspectFill
    return view
  }

  func updateUIView(_ uiView: PreviewView, context: Context) {}

  final class PreviewView: UIView {
    override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }
    var previewLayer: AVCaptureVideoPreviewLayer { layer as! AVCaptureVideoPreviewLayer }
  }
}
