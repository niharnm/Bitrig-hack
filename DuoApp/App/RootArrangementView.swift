import SwiftUI

// Scaffold placeholder. Duo-core replaces this host after the Duo gate passes; see bible §08.
struct RootArrangementView: View {
  var body: some View {
    FilmToolTokens.Palette.canvas
      .ignoresSafeArea()
      .overlay {
        Text(FilmToolTokens.Brand.name)
          .font(.title.weight(.medium))
          .foregroundStyle(FilmToolTokens.Palette.ink)
          .accessibilityAddTraits(.isHeader)
      }
  }
}

#Preview {
  RootArrangementView()
}
