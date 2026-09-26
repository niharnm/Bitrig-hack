import SwiftUI

/// Tip state shared by the inner capture shell and the outer coach (§11.3.8: same observable model).
@MainActor
@Observable
final class CoachModel {
  static let freeTips = ["tip.free.1", "tip.free.2", "tip.free.3"]
  static let proTips = ["tip.kids.1", "tip.kids.2", "tip.kids.3"]
  static let tipInterval: Duration = .seconds(6)

  private(set) var tipIndex = 0
  private(set) var countdown: Int?
  /// Settings override for rehearsal. Real unlocks come from EntitlementsModel.
  var isProSimulated = false

  func tipKey(isPro: Bool) -> String {
    let tips = isPro ? Self.proTips : Self.freeTips
    return tips[tipIndex % tips.count]
  }

  func advanceTip() {
    tipIndex += 1
  }

  /// Advances the tip on a timer until the calling task is cancelled.
  func runTipCycle() async {
    while !Task.isCancelled {
      try? await Task.sleep(for: Self.tipInterval)
      if !Task.isCancelled, countdown == nil {
        advanceTip()
      }
    }
  }

  /// T3: counts 3, 2, 1 on the outer display.
  func startCountdown() async {
    guard countdown == nil else { return }
    for value in stride(from: 3, through: 1, by: -1) {
      countdown = value
      try? await Task.sleep(for: .seconds(1))
    }
    countdown = nil
  }
}

/// Outer subject coach (SCR-OL-C). Exactly one tip, no controls. The brand stays quieter than the tip.
struct SubjectCoachView: View {
  let model: CoachModel
  @Environment(\.entitlementState) private var entitlementState
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  private var isPro: Bool { entitlementState.isPro || model.isProSimulated }
  private var tipKey: String { model.tipKey(isPro: isPro) }

  var body: some View {
    ZStack {
      // Tip-only stage until a shared preview is proven stable (§11.3.9 priority 1).
      FilmToolTokens.Palette.canvas
        .ignoresSafeArea()
      if isPro {
        // T2 guide blooms in on unlock (M3).
        GuideOvalView()
          .transition(reduceMotion ? .opacity : .opacity.combined(with: .scale(scale: 0.9)))
      }
      VStack {
        HStack {
          Text("outer.brand")
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.white.opacity(0.55))
          Spacer()
          if isPro {
            Text(
              LocalizedStringKey(
                entitlementState.isPro ? "outer.proBadge" : "outer.simulatedProBadge"
              )
            )
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(GuideOvalView.accent)
          }
        }
        Spacer()
        ZStack {
          // Keyed by tip so a change settles in (M1) instead of stacking two plates.
          TipPlateView(tipKey: LocalizedStringKey(tipKey))
            .id(tipKey)
            .transition(
              reduceMotion
                ? .opacity
                : .asymmetric(
                  insertion: .opacity.combined(
                    with: .offset(y: -FilmToolMotion.m1Rise(reduceMotion: false))),
                  removal: .opacity))
        }
        .opacity(model.countdown == nil ? 1 : 0.25)
      }
      .padding(.horizontal, FilmToolTokens.Space.outerInsetX)
      .padding(.top, FilmToolTokens.Space.s3)
      .padding(.bottom, FilmToolTokens.Space.safeTipBottom)
      if let countdown = model.countdown {
        CountdownView(value: countdown)
      }
    }
    .animation(FilmToolMotion.m1Animation(reduceMotion: reduceMotion), value: tipKey)
    .animation(FilmToolMotion.m3Animation(reduceMotion: reduceMotion), value: isPro)
    .allowsHitTesting(false)
  }
}
