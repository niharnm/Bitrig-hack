import SwiftUI

/// SCR-OL-E. Camera denied or restricted. Both offer the Settings recovery path (TC-C05).
struct CaptureDeniedView: View {
  let isRestricted: Bool
  @Environment(\.openURL) private var openURL

  var body: some View {
    VStack(spacing: FilmToolTokens.Space.s4) {
      Image(systemName: "camera.fill")
        .font(.system(size: 44))
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        .accessibilityHidden(true)
      Text(isRestricted ? "error.restricted.title" : "error.denied.title")
        .font(.title2.bold())
        .foregroundStyle(FilmToolTokens.Palette.ink)
      Text(isRestricted ? "error.restricted.body" : "error.denied.body")
        .font(.body)
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        .multilineTextAlignment(.center)
      if let settings = URL(string: UIApplication.openSettingsURLString) {
        Button("error.denied.openSettings") {
          openURL(settings)
        }
        .buttonStyle(.glassProminent)
        .tint(GuideOvalView.accent)
        .padding(.top, FilmToolTokens.Space.s2)
      }
    }
    .padding(FilmToolTokens.Space.s5)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(FilmToolTokens.Palette.canvas.ignoresSafeArea())
  }
}
