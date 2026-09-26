import SwiftUI

/// Registers the outer subject coach (SCR-OL-C, demo 0:15–0:45) on the capture view, not globally.
/// Inner capture keeps working when the system reports the accessory unavailable (TC-C03).
struct CameraCaptureAccessoryHost: ViewModifier {
  @Binding var isEnabled: Bool
  @Binding var isAvailable: Bool
  let tipKey: LocalizedStringKey

  func body(content: Content) -> some View {
    if #available(iOS 27.1, *) {
      content.sceneAccessory {
        CameraCaptureAccessory(isEnabled: $isEnabled) {
          SubjectCoachView(tipKey: tipKey)
        }
        .onAvailabilityChange { available in
          isAvailable = available
        }
      }
    } else {
      content
    }
  }
}
