import SwiftUI

struct SensitiveSurfaceView: View {
  let threatLevel: ThreatLevel
  let title: String
  let secret: String
  let bodyText: String

  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  var body: some View {
    ZStack {
      FilmToolTokens.Palette.frostCanvas

      ScrollView {
        VStack(alignment: .leading, spacing: FilmToolTokens.Space.s5) {
          Text(FilmToolTokens.Brand.nameFrost)
            .font(FilmToolTokens.Brand.font)
            .foregroundStyle(FilmToolTokens.Palette.frostInkMuted)

          VStack(alignment: .leading, spacing: FilmToolTokens.Space.s4) {
            Text(title)
              .font(.largeTitle.weight(.semibold))
            Text(secret)
              .font(.title2.weight(.medium))
          }
          .blur(radius: threatLevel.frostBlurRadius)
          .accessibilityHidden(threatLevel >= .cautious)

          Text(bodyText)
            .font(.title3)
            .blur(radius: threatLevel >= .threatened ? threatLevel.frostBlurRadius : 0)
            .accessibilityHidden(threatLevel >= .threatened)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(FilmToolTokens.Space.s6)
        .foregroundStyle(FilmToolTokens.Palette.frostInk)
        .brightness(threatLevel >= .threatened ? -0.06 : 0)
        .accessibilityHidden(threatLevel == .locked)
      }

      FrostOverlayView(threatLevel: threatLevel)
    }
    .clipped()
    .animation(
      FilmToolMotion.frostAnimation(reduceMotion: reduceMotion),
      value: threatLevel
    )
  }
}

#Preview("Frost standby") {
  @Previewable @State var threatLevel = ThreatLevel.clear
  @Previewable @State var protectEnabled = false
  @Previewable @State var showUnwiredPaywall = false

  VStack(spacing: 0) {
    HStack(spacing: 0) {
      SensitiveSurfaceView(
        threatLevel: threatLevel,
        title: "Weekend plans",
        secret: "Entry code: 4826",
        bodyText: "Meet at the station at noon. Bring the tickets and a light jacket."
      )
      OuterDecoyStageView(
        threatLevel: threatLevel,
        entitlementState: EntitlementState(status: .inactive, entitlementID: "pro")
      )
    }

    FrostControlsView(
      protectEnabled: $protectEnabled,
      threatLevel: $threatLevel,
      entitlementState: EntitlementState(status: .inactive, entitlementID: "pro"),
      onUnlockCoverVault: { showUnwiredPaywall = true }
    )

    Picker("Preview state", selection: $threatLevel) {
      Text("Clear").tag(ThreatLevel.clear)
      Text("Cautious").tag(ThreatLevel.cautious)
      Text("Threatened").tag(ThreatLevel.threatened)
      Text("Locked").tag(ThreatLevel.locked)
    }
    .pickerStyle(.segmented)
    .padding()
  }
  .alert("Paywall not connected in standby preview", isPresented: $showUnwiredPaywall) {
    Button("OK", role: .cancel) {}
  }
}
