import SwiftUI

/// Solid tip plate for the outer display. No glass over the tip or the subject's face (§11.3.4).
struct TipPlateView: View {
  let tipKey: LocalizedStringKey

  var body: some View {
    Text(tipKey)
      .font(FilmToolTokens.Tip.primaryFont)
      .foregroundStyle(FilmToolTokens.Palette.ink)
      .multilineTextAlignment(.center)
      .lineLimit(2)
      .padding(.horizontal, FilmToolTokens.Space.s5)
      .padding(.vertical, FilmToolTokens.Space.s4)
      .frame(maxWidth: .infinity)
      .background(
        FilmToolTokens.Palette.panel,
        in: RoundedRectangle(cornerRadius: FilmToolTokens.Radius.tip, style: .continuous))
  }
}
