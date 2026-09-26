import SwiftUI

/// SCR-OL-E. Camera denied or restricted. Denied offers the Settings path (TC-C05).
struct CaptureDeniedView: View {
  let isRestricted: Bool
  @Environment(\.openURL) private var openURL

  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "camera.fill")
        .font(.system(size: 44))
        .foregroundStyle(.white.opacity(0.7))
        .accessibilityHidden(true)
      Text(isRestricted ? "error.restricted.title" : "error.denied.title")
        .font(.title2.bold())
        .foregroundStyle(.white)
      Text(isRestricted ? "error.restricted.body" : "error.denied.body")
        .font(.body)
        .foregroundStyle(.white.opacity(0.7))
        .multilineTextAlignment(.center)
      if !isRestricted, let settings = URL(string: UIApplication.openSettingsURLString) {
        Button("error.denied.openSettings") {
          openURL(settings)
        }
        .buttonStyle(.glassProminent)
        .tint(GuideOvalView.accent)
        .padding(.top, 8)
      }
    }
    .padding(24)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255).ignoresSafeArea())
  }
}
