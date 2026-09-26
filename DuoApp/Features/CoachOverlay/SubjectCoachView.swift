import SwiftUI

/// Outer subject coach (SCR-OL-C). Exactly one tip, no controls. The brand stays quieter than the tip.
struct SubjectCoachView: View {
  let tipKey: LocalizedStringKey

  var body: some View {
    ZStack {
      // Tip-only stage until a shared preview is proven stable (§11.3.9 priority 1).
      Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255)
        .ignoresSafeArea()
      VStack {
        HStack {
          Text("outer.brand")
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.white.opacity(0.55))
          Spacer()
        }
        Spacer()
        TipPlateView(tipKey: tipKey)
      }
      .padding(.horizontal, 16)
      .padding(.top, 12)
      .padding(.bottom, 34)
    }
    .allowsHitTesting(false)
  }
}
