import SwiftUI

/// T2 Pro framing guide: a faint amber oval around the face region. Never shown on the free tier.
struct GuideOvalView: View {
  static let accent = FilmToolTokens.Palette.accent
  static let strokeStyle = StrokeStyle(lineWidth: 3, lineCap: .round, dash: [8, 6])

  var body: some View {
    Ellipse()
      .stroke(Self.accent, style: Self.strokeStyle)
      .aspectRatio(0.75, contentMode: .fit)
      .frame(maxWidth: 260)
      .padding(.bottom, 120)
      .accessibilityHidden(true)
  }
}
