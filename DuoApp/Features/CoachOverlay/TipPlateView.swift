import SwiftUI

/// Solid tip plate for the outer display. No glass over the tip or the subject's face (§11.3.4).
struct TipPlateView: View {
  let tipKey: LocalizedStringKey

  var body: some View {
    Text(tipKey)
      .font(.system(size: 30, weight: .semibold, design: .rounded))
      .foregroundStyle(.white)
      .multilineTextAlignment(.center)
      .lineLimit(2)
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
      .frame(maxWidth: .infinity)
      .background(
        Color(red: 28 / 255, green: 28 / 255, blue: 30 / 255),
        in: RoundedRectangle(cornerRadius: 20, style: .continuous))
  }
}
