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
  @ObservationIgnored private let pipeline = CapturePipeline()

  var session: AVCaptureSession { pipeline.session }

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
    guard permission == .authorized, phase == .idle else { return }
    phase = .starting
    let result = await pipeline.start(position: .back)
    hasCamera = result != .noCamera
    phase = result == .running ? .live : .idle
    if result == .failed {
      phase = .failed(.configuration)
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

  func capturePhoto() {
    guard phase == .live else { return }
    pipeline.capturePhoto()
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
  private let photoOutput = AVCapturePhotoOutput()
  private let queue = DispatchQueue(label: "outerlens.capture")
  private var input: AVCaptureDeviceInput?

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

  func capturePhoto() {
    queue.async {
      // Photo-only slice: the capture proves the pipeline; saving needs an add-only library key first.
      self.photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
  }

  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {}

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
    if session.outputs.isEmpty, session.canAddOutput(photoOutput) {
      session.addOutput(photoOutput)
    }
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
