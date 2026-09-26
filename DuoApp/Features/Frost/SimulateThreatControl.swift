import SwiftUI

struct SimulateThreatControl: View {
  @Binding var threatLevel: ThreatLevel

  var body: some View {
    Button {
      threatLevel = .locked
    } label: {
      Label("Simulate Threat", systemImage: "snowflake")
        .frame(minHeight: FilmToolTokens.Control.minHit)
    }
    .buttonStyle(.bordered)
    .accessibilityHint("Frosts the inner content and shows an outer cover until cleared.")
  }
}
