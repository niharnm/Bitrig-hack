import SwiftUI

/// T3 countdown numeral for the outer display (M2).
struct CountdownView: View {
  let value: Int
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  var body: some View {
    Text(value, format: .number)
      .font(FilmToolTokens.Tip.countdownFont)
      .foregroundStyle(FilmToolTokens.Palette.ink)
      .contentTransition(FilmToolMotion.m2ContentTransition(reduceMotion: reduceMotion))
      .animation(FilmToolMotion.m2Animation(reduceMotion: reduceMotion), value: value)
  }
}
