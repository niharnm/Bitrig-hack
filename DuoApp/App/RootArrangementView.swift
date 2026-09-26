import SwiftUI

// Scaffold placeholder. Duo-core replaces this host after the Duo gate passes; see bible §08.
struct RootArrangementView: View {
  var body: some View {
    Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255)
      .ignoresSafeArea()
      .overlay {
        Text("Outer Lens")
          .font(.title.weight(.medium))
          .foregroundStyle(.white)
          .accessibilityAddTraits(.isHeader)
      }
  }
}

#Preview {
  RootArrangementView()
}
