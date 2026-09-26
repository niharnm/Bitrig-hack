import SwiftUI

/// Tip state shared by the inner capture shell and the outer coach (§11.3.8: same observable model).
@MainActor
@Observable
final class CoachModel {
  static let freeTips = ["tip.free.1", "tip.free.2", "tip.free.3"]
  static let kidsTips = ["tip.kids.1", "tip.kids.2", "tip.kids.3"]
  static let portraitTips = ["tip.portrait.1", "tip.portrait.2", "tip.portrait.3"]
  static let proTips = kidsTips
  static let tipInterval: Duration = .seconds(6)

  var activePack: TipPack = .free
  private(set) var tipIndex = 0
  private(set) var countdown: Int?
  /// The owner's countdown phrase, shown on both displays while the photo is taken.
  private(set) var countdownCue: String?
  /// Settings override for rehearsal. Real unlocks come from EntitlementsModel.
  var isProSimulated = false
  /// Live best-angle cues and the outer mirror frame.
  let angle = AngleCoachState()
  @ObservationIgnored let personaStore: CoachPersonaStore
  @ObservationIgnored let angleStore: BestAngleStore

  init(personaStore: CoachPersonaStore = .shared, angleStore: BestAngleStore = .shared) {
    self.personaStore = personaStore
    self.angleStore = angleStore
  }

  var isCountingDown: Bool { countdown != nil || countdownCue != nil }

  func currentTips(isPro: Bool) -> [String] {
    guard isPro else { return Self.freeTips }
    switch activePack {
    case .free:
      return Self.freeTips
    case .kidsPro:
      return Self.kidsTips
    case .portraitPro:
      return Self.portraitTips
    }
  }

  func tipKey(isPro: Bool) -> String {
    let tips = currentTips(isPro: isPro)
    return tips[tipIndex % tips.count]
  }

  func advanceTip() {
    tipIndex += 1
  }

  func resetTipIndex() {
    tipIndex = 0
  }

  func setCountdown(_ value: Int?) {
    countdown = value
  }

  /// Advances the tip on a timer until the calling task is cancelled.
  func runTipCycle() async {
    while !Task.isCancelled {
      try? await Task.sleep(for: Self.tipInterval)
      if !Task.isCancelled, !isCountingDown {
        advanceTip()
      }
    }
  }

  /// T3: counts 3, 2, 1 on the outer display.
  func startCountdown() async {
    await runCountdown()
  }

  /// T3 with the owner's settings: counts down, shows the phrase while `capture` runs, then clears.
  /// The phrase stays up at least `cueHold` so the subject sees the moment the photo is taken.
  func runCountdown(cueHold: Duration = .milliseconds(700), capture: () async -> Void = {}) async {
    guard !isCountingDown else { return }
    let persona = personaStore.persona
    for value in stride(from: max(1, persona.countdownSeconds), through: 1, by: -1) {
      countdown = value
      try? await Task.sleep(for: .seconds(1))
    }
    countdown = nil
    countdownCue = persona.countdownPhrase
    let clock = ContinuousClock()
    let start = clock.now
    await capture()
    let remaining = cueHold - (clock.now - start)
    if remaining > .zero {
      try? await Task.sleep(for: remaining)
    }
    countdownCue = nil
  }
}

/// Outer subject coach (SCR-OL-C). Exactly one tip, no controls. The brand stays quieter than the tip.
struct SubjectCoachView: View {
  let model: CoachModel
  /// Observe the shared model so CameraCaptureAccessory blooms on purchase even if the accessory scene keeps a stale environment value.
  @ObservedObject private var entitlements = EntitlementsModel.shared
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  private var isPro: Bool { entitlements.state.isPro || model.isProSimulated }
  private var showKidMagnet: Bool { isPro && model.activePack == .kidsPro }
  /// With a saved best angle and a live face, the plate carries the subject's cue instead of a generic tip.
  private var tipKey: String { model.angle.guidance?.subject.key ?? model.tipKey(isPro: isPro) }

  var body: some View {
    ZStack {
      if let frame = model.angle.mirrorFrame {
        // The subject sees themselves, mirrored, with their saved face spot when one exists.
        SubjectMirrorView(
          frame: frame,
          target: model.angleStore.profile?.measurement,
          isMatched: model.angle.guidance?.isMatched == true)
          .ignoresSafeArea()
        if model.isCountingDown {
          FilmToolTokens.Palette.scrim
            .ignoresSafeArea()
        }
      } else {
        // Tip-only stage until a shared preview is proven stable (§11.3.9 priority 1).
        FilmToolTokens.Palette.canvas
          .ignoresSafeArea()
        if isPro {
          // T2 guide blooms in on unlock (M3).
          GuideOvalView()
            .transition(reduceMotion ? .opacity : .opacity.combined(with: .scale(scale: 0.9)))
        }
      }
      VStack {
        HStack {
          Text("outer.brand")
            .font(FilmToolTokens.Brand.font)
            .foregroundStyle(FilmToolTokens.Palette.inkMuted)
          Spacer()
          if isPro {
            Text(
              LocalizedStringKey(
                entitlements.state.isPro ? "outer.proBadge" : "outer.simulatedProBadge"
              )
            )
            .font(.system(size: FilmToolTokens.Brand.size, weight: .semibold))
            .foregroundStyle(GuideOvalView.accent)
          }
        }

        if showKidMagnet {
          KidMagnetView()
            .padding(.top, FilmToolTokens.Space.s2)
            .transition(
              reduceMotion
                ? .opacity
                : .opacity.combined(with: .scale(scale: 0.85))
            )
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
        .opacity(model.isCountingDown ? 0.25 : 1)
      }
      .padding(.horizontal, FilmToolTokens.Space.outerInsetX)
      .padding(.top, FilmToolTokens.Space.s3)
      .padding(.bottom, FilmToolTokens.Space.safeTipBottom)
      if let countdown = model.countdown {
        CountdownView(value: countdown)
      } else if let cue = model.countdownCue {
        CountdownCueView(text: cue)
      }
    }
    .animation(FilmToolMotion.m1Animation(reduceMotion: reduceMotion), value: tipKey)
    .animation(FilmToolMotion.m3Animation(reduceMotion: reduceMotion), value: isPro)
    .animation(FilmToolMotion.m3Animation(reduceMotion: reduceMotion), value: showKidMagnet)
    .animation(FilmToolMotion.m3Animation(reduceMotion: reduceMotion), value: model.countdownCue)
    .allowsHitTesting(false)
  }
}

