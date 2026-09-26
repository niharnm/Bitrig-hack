import SwiftUI

/// Animated visual cue near the top camera lens to engage children and direct their gaze (M1).
/// Respects `accessibilityReduceMotion` by freezing animations and remaining stationary.
struct KidMagnetView: View {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @State private var isPulsing = false

  var body: some View {
    HStack(spacing: 10) {
      Image(systemName: "pawprint.fill")
        .font(.system(size: 20, weight: .bold))
        .rotationEffect(.degrees(isPulsing && !reduceMotion ? -12 : 0))

      Image(systemName: "face.smiling")
        .font(.system(size: 26, weight: .bold))

      Image(systemName: "pawprint.fill")
        .font(.system(size: 20, weight: .bold))
        .rotationEffect(.degrees(isPulsing && !reduceMotion ? 12 : 0))
    }
    .foregroundStyle(FilmToolTokens.Palette.accent)
    .padding(.horizontal, 16)
    .padding(.vertical, 8)
    .background(
      Capsule()
        .fill(FilmToolTokens.Palette.panel.opacity(0.88))
        .overlay(
          Capsule()
            .stroke(FilmToolTokens.Palette.accent.opacity(0.45), lineWidth: 1.5)
        )
    )
    .scaleEffect(FilmToolMotion.kidMagnetScale(reduceMotion: reduceMotion, phase: isPulsing))
    .offset(y: FilmToolMotion.kidMagnetBounceOffset(reduceMotion: reduceMotion, phase: isPulsing))
    .onAppear {
      guard !reduceMotion else { return }
      withAnimation(FilmToolMotion.kidMagnetPulseAnimation(reduceMotion: false)) {
        isPulsing = true
      }
    }
    .onChange(of: reduceMotion) { _, newValue in
      if newValue {
        isPulsing = false
      } else {
        withAnimation(FilmToolMotion.kidMagnetPulseAnimation(reduceMotion: false)) {
          isPulsing = true
        }
      }
    }
    .accessibilityElement(children: .combine)
    .accessibilityLabel(Text("Kid Magnet"))
  }
}
