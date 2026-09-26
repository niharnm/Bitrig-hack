import SwiftUI

struct FrostControlsView: View {
  @Binding var protectEnabled: Bool
  @Binding var threatLevel: ThreatLevel
  let entitlementState: EntitlementState
  let onUnlockCoverVault: () -> Void

  var body: some View {
    VStack(alignment: .leading, spacing: FilmToolTokens.Space.s4) {
      Toggle("Protect", isOn: $protectEnabled)
        .frame(minHeight: FilmToolTokens.Control.minHit)

      SimulateThreatControl(threatLevel: $threatLevel)

      if entitlementState.isPro {
        Label("Cover Vault unlocked", systemImage: "checkmark")
          .font(.subheadline)
      } else {
        Button {
          onUnlockCoverVault()
        } label: {
          Label("Unlock Cover Vault", systemImage: "lock")
            .foregroundStyle(.white)
            .frame(minHeight: FilmToolTokens.Control.minHit)
        }
        .buttonStyle(.borderedProminent)
      }
    }
    .padding(FilmToolTokens.Space.s5)
    .foregroundStyle(FilmToolTokens.Palette.frostInk)
    .tint(FilmToolTokens.Palette.frostAccent)
    .background(FilmToolTokens.Palette.frostPanel)
  }
}
