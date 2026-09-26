import SwiftUI

/// SCR-OL-A. Explains the camera request before the system alert. Photo-only; no microphone.
struct PermissionPrimerView: View {
  let isRequesting: Bool
  let onContinue: () -> Void

  var body: some View {
    VStack(spacing: FilmToolTokens.Space.s5) {
      Spacer()
      Text("perm.brand")
        .font(FilmToolTokens.Brand.font)
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
      Image(systemName: "camera.fill")
        .font(.system(size: 56))
        .foregroundStyle(FilmToolTokens.Palette.ink)
        .accessibilityHidden(true)
      Text("perm.title")
        .font(.title2.bold())
        .foregroundStyle(FilmToolTokens.Palette.ink)
        .multilineTextAlignment(.center)
      Text("perm.body")
        .font(.body)
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
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
    .padding(FilmToolTokens.Space.s5)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(FilmToolTokens.Palette.canvas.ignoresSafeArea())
  }
}
