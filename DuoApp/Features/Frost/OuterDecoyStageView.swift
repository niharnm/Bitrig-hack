import SwiftUI

struct OuterDecoyStageView: View {
  let threatLevel: ThreatLevel
  let entitlementState: EntitlementState
  var preferredPack: DecoyPack? = nil

  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  var visiblePack: DecoyPack {
    let requestedPack = preferredPack ?? (entitlementState.isPro ? .cVaultCover : .aLockLookalike)
    return requestedPack == .cVaultCover && !entitlementState.isPro
      ? .aLockLookalike : requestedPack
  }

  var body: some View {
    ZStack {
      LinearGradient(
        colors: [
          FilmToolTokens.Palette.frostCanvas,
          FilmToolTokens.Palette.frostAccent.opacity(0.18),
          FilmToolTokens.Palette.frostCanvas,
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )

      if threatLevel == .locked {
        cover
          .id(visiblePack)
          .transition(reduceMotion ? .identity : .opacity)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .foregroundStyle(FilmToolTokens.Palette.frostInk)
    .clipped()
    .allowsHitTesting(false)
    .animation(
      FilmToolMotion.decoyAnimation(reduceMotion: reduceMotion),
      value: threatLevel
    )
    .animation(
      FilmToolMotion.decoyAnimation(reduceMotion: reduceMotion),
      value: visiblePack
    )
  }

  @ViewBuilder
  private var cover: some View {
    switch visiblePack {
    case .aLockLookalike:
      TimelineView(.periodic(from: .now, by: 60)) { context in
        VStack(spacing: FilmToolTokens.Space.s3) {
          Image(systemName: "lock.fill")
            .font(.title2)
          Text(context.date, format: .dateTime.weekday(.wide).month(.wide).day())
            .font(.title3)
          Text(context.date, format: .dateTime.hour().minute())
            .font(.system(size: 88, weight: .medium, design: .rounded))
            .monospacedDigit()
            .minimumScaleFactor(0.5)
            .lineLimit(1)
        }
        .padding(FilmToolTokens.Space.s5)
      }
    case .bBusyCover:
      VStack(alignment: .leading, spacing: FilmToolTokens.Space.s5) {
        Label("Calendar", systemImage: "calendar")
          .font(.title3)
        Text("Busy until 4")
          .font(.largeTitle.weight(.semibold))
        Text("Team lunch")
          .font(.title2)
        Text("Coffee with Mom")
          .font(.title2)
      }
      .padding(FilmToolTokens.Space.s6)
    case .cVaultCover:
      VStack(spacing: FilmToolTokens.Space.s5) {
        Image(systemName: "lock.fill")
          .font(.title2)
        Text("Commuter")
          .font(.largeTitle.weight(.medium))
        Text("Cover Vault")
          .font(.title3)
          .foregroundStyle(FilmToolTokens.Palette.frostInkMuted)
      }
      .padding(FilmToolTokens.Space.s6)
    }
  }
}

#Preview("Static Pro fixture, no purchase") {
  OuterDecoyStageView(
    threatLevel: .locked,
    entitlementState: EntitlementState(status: .active, entitlementID: "pro")
  )
}
