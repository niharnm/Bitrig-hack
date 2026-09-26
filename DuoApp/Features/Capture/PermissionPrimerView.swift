import SwiftUI

/// SCR-OL-A. Explains the camera request before the system alert. Photo-only; no microphone.
struct PermissionPrimerView: View {
  let isRequesting: Bool
  let onContinue: () -> Void

  var body: some View {
    VStack(spacing: 20) {
      Spacer()
      Text("perm.brand")
        .font(.headline)
        .foregroundStyle(.white.opacity(0.7))
      Image(systemName: "camera.fill")
        .font(.system(size: 56))
        .foregroundStyle(.white)
        .accessibilityHidden(true)
      Text("perm.title")
        .font(.title2.bold())
        .foregroundStyle(.white)
        .multilineTextAlignment(.center)
      Text("perm.body")
        .font(.body)
        .foregroundStyle(.white.opacity(0.7))
        .multilineTextAlignment(.center)
        .lineLimit(3)
      Spacer()
      Button(action: onContinue) {
        Text("perm.cta")
          .font(.headline)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 6)
      }
      .buttonStyle(.glassProminent)
      .tint(GuideOvalView.accent)
      .disabled(isRequesting)
    }
    .padding(24)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255).ignoresSafeArea())
  }
}
