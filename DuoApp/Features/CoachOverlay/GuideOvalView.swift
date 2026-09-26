import SwiftUI

/// T2 Pro framing guide: a faint amber oval around the face region. Never shown on the free tier.
struct GuideOvalView: View {
  static let accent = Color(red: 232 / 255, green: 168 / 255, blue: 56 / 255)

  var body: some View {
    Ellipse()
      .stroke(Self.accent, lineWidth: 3)
      .aspectRatio(0.75, contentMode: .fit)
      .frame(maxWidth: 260)
      .padding(.bottom, 120)
      .accessibilityHidden(true)
  }
}
