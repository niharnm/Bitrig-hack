import SwiftUI

/// Inner capture shell (SCR-OL-B). Hosts the outer coach and keeps the shutter working without it.
struct InnerCaptureView: View {
  @State private var coach = CoachModel()
  @State private var isSubjectEnabled = true
  @State private var isSubjectAvailable = false
  @State private var isSettingsPresented = false
  @Environment(\.entitlementState) private var entitlementState
  @Environment(\.presentPaywall) private var presentPaywall

  private var isPro: Bool { entitlementState.isPro || coach.isProSimulated }

  var body: some View {
    ZStack(alignment: .bottom) {
      // Black preview stand-in until CaptureSessionController lands.
      FilmToolTokens.Palette.canvas.ignoresSafeArea()
      if !isSubjectAvailable {
        subjectPreview
          .frame(maxHeight: .infinity)
      }
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
          .overlay(alignment: .trailing) {
            proControl
          }
      }
      .padding(.horizontal, 24)
      .padding(.bottom, 24)
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("capture.settings.title", systemImage: "gearshape") {
          isSettingsPresented = true
        }
      }
    }
    .sheet(isPresented: $isSettingsPresented) {
      settingsSheet
    }
    .task {
      await coach.runTipCycle()
    }
    .modifier(
      CameraCaptureAccessoryHost(
        isEnabled: $isSubjectEnabled,
        isAvailable: $isSubjectAvailable,
        model: coach))
  }

  /// While the system is not presenting the accessory, show the photographer what the subject would see.
  private var subjectPreview: some View {
    SubjectCoachView(model: coach)
      .frame(width: 466, height: 678)
      .scaleEffect(0.42)
      .frame(width: 196, height: 285)
      .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
      .overlay(
        RoundedRectangle(cornerRadius: 18, style: .continuous)
          .stroke(.white.opacity(0.2), lineWidth: 1)
      )
      .accessibilityHidden(true)
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

  @ViewBuilder
  private var proControl: some View {
    if isPro {
      Label(
        LocalizedStringKey(
          entitlementState.isPro ? "capture.proActive" : "capture.simulatedProActive"
        ), systemImage: "checkmark.seal.fill"
      )
      .font(.subheadline.weight(.semibold))
      .foregroundStyle(GuideOvalView.accent)
    } else {
      Button("capture.proCTA") {
        presentPaywall()
      }
      .buttonStyle(.glass)
      .tint(GuideOvalView.accent)
      .disabled(!presentPaywall.isAvailable)
    }
  }

  private var shutterButton: some View {
    Button {
      // Photo capture wires to CaptureSessionController next; the shutter also advances the tip (§11.3.6).
      coach.advanceTip()
    } label: {
      Circle()
        .fill(.white)
        .frame(width: 68, height: 68)
        .padding(6)
        .overlay(Circle().stroke(.white, lineWidth: 3))
    }
    .buttonStyle(FilmToolShutterButtonStyle())
    .accessibilityLabel("Shutter")
  }

  private var settingsSheet: some View {
    NavigationStack {
      List {
        Button("capture.settings.simulateTip") {
          coach.advanceTip()
        }
        Button {
          // Close first so the M3 bloom plays in view.
          isSettingsPresented = false
          coach.isProSimulated.toggle()
        } label: {
          LabeledContent("capture.settings.simulatePro") {
            if coach.isProSimulated {
              Image(systemName: "checkmark")
            }
          }
        }
        Button("capture.settings.simulateCountdown") {
          isSettingsPresented = false
          Task { await coach.startCountdown() }
        }
      }
      .navigationTitle("capture.settings.title")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button(role: .close) {
            isSettingsPresented = false
          }
        }
      }
    }
    .presentationDetents([.medium])
  }
}
