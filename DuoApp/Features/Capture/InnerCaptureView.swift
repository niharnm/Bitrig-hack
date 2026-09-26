import SwiftUI

/// Inner capture shell (SCR-OL-B). Hosts the outer coach and keeps the shutter working without it.
struct InnerCaptureView: View {
  @State private var isSubjectEnabled = true
  @State private var isSubjectAvailable = false

  var body: some View {
    ZStack(alignment: .bottom) {
      // Black preview stand-in until CaptureSessionController lands.
      Color.black.ignoresSafeArea()
      VStack(spacing: 16) {
        if !isSubjectAvailable {
          Text("capture.banner.accessoryUnavailable")
            .font(.footnote.weight(.medium))
            .foregroundStyle(.white.opacity(0.7))
        }
        shutterButton
          .frame(maxWidth: .infinity)
          .overlay(alignment: .leading) {
            subjectToggle
          }
      }
      .padding(.horizontal, 24)
      .padding(.bottom, 24)
    }
    .modifier(
      CameraCaptureAccessoryHost(
        isEnabled: $isSubjectEnabled,
        isAvailable: $isSubjectAvailable,
        tipKey: "tip.free.1"))
  }

  @ViewBuilder
  private var subjectToggle: some View {
    // Shown only while the system can present the accessory; enabled is the user's choice.
    if isSubjectAvailable {
      Toggle("capture.subjectToggle", systemImage: "person.crop.rectangle", isOn: $isSubjectEnabled)
        .toggleStyle(.button)
        .labelStyle(.iconOnly)
        .tint(.white)
    }
  }

  private var shutterButton: some View {
    Button {
      // Photo capture wires to CaptureSessionController next.
    } label: {
      Circle()
        .fill(.white)
        .frame(width: 68, height: 68)
        .padding(6)
        .overlay(Circle().stroke(.white, lineWidth: 3))
    }
    .accessibilityLabel("Shutter")
  }
}
