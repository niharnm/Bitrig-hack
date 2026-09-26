import SwiftUI

struct FrostOverlayView: View {
  let threatLevel: ThreatLevel

  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

  var body: some View {
    ZStack(alignment: .topTrailing) {
      if threatLevel >= .threatened {
        Rectangle()
          .fill(.ultraThinMaterial)
          .opacity(threatLevel == .locked ? 1 : 0.3)
        Rectangle()
          .fill(FilmToolTokens.Palette.frostIce)
      }

      if threatLevel == .locked {
        if reduceTransparency {
          FilmToolTokens.Palette.frostCanvas
        }

        Label("Private", systemImage: "snowflake")
          .font(.footnote.weight(.medium))
          .foregroundStyle(FilmToolTokens.Palette.frostInk)
          .padding(FilmToolTokens.Space.s4)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .allowsHitTesting(false)
    .animation(
      FilmToolMotion.frostAnimation(reduceMotion: reduceMotion),
      value: threatLevel
    )
    .accessibilityElement(children: .ignore)
    .accessibilityLabel(threatLevel == .locked ? "Private" : "")
    .accessibilityHidden(threatLevel != .locked)
  }
}
