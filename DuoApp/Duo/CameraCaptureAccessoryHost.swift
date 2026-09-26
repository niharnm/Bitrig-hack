import SwiftUI

/// Registers the outer subject coach (SCR-OL-C, demo 0:15–0:45) on the capture view, not globally.
/// Inner capture keeps working when the system reports the accessory unavailable (TC-C03).
struct CameraCaptureAccessoryHost: ViewModifier {
  @Environment(\.entitlementState) private var entitlementState
  @Binding var isEnabled: Bool
  @Binding var isAvailable: Bool
  let model: CoachModel

  func body(content: Content) -> some View {
    if #available(iOS 27.1, *) {
      content.sceneAccessory {
        CameraCaptureAccessory(isEnabled: $isEnabled) {
          SubjectCoachView(model: model)
            .environment(\.entitlementState, entitlementState)
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
