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
  @ObservedObject private var entitlements = EntitlementsModel.shared
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  private var isPro: Bool { entitlements.state.isPro || model.isProSimulated }
  private var tipKey: String { model.tipKey(isPro: isPro) }

  var body: some View {
    ZStack {
      // Tip-only stage until a shared preview is proven stable (§11.3.9 priority 1).
      Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255)
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
            Text("outer.proBadge")
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
                : .asymmetric(insertion: .opacity.combined(with: .offset(y: 10)), removal: .opacity))
        }
        .opacity(model.countdown == nil ? 1 : 0.25)
      }
      .padding(.horizontal, 16)
      .padding(.top, 12)
      .padding(.bottom, 34)
      if let countdown = model.countdown {
        CountdownView(value: countdown)
      }
    }
    .animation(reduceMotion ? nil : .easeOut(duration: 0.22), value: tipKey)
    .animation(reduceMotion ? nil : .easeOut(duration: 0.36), value: isPro)
    .allowsHitTesting(false)
  }
}
