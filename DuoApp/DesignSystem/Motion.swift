import SwiftUI

enum FilmToolMotion {
  static let durFrost: TimeInterval = 0.28
  static let durDecoy: TimeInterval = 0.40
  static let durTip: TimeInterval = 0.22
  static let durCountdownDigit: TimeInterval = 0.2
  static let durProBloom: TimeInterval = 0.36
  static let durReducedCrossfade: TimeInterval = 0.22
  static let tipRise: CGFloat = 10

  static func m1Animation(reduceMotion: Bool) -> Animation? {
    reduceMotion ? nil : easeOut(duration: durTip)
  }

  static func m1Rise(reduceMotion: Bool) -> CGFloat {
    reduceMotion ? 0 : -tipRise
  }

  static func m2Animation(reduceMotion: Bool) -> Animation? {
    reduceMotion ? nil : .snappy(duration: durCountdownDigit)
  }

  static func m2ContentTransition(reduceMotion: Bool) -> ContentTransition {
    reduceMotion ? .identity : .numericText(countsDown: true)
  }

  static func m3Animation(reduceMotion: Bool) -> Animation {
    reduceMotion
      ? .easeInOut(duration: durReducedCrossfade)
      : easeOut(duration: durProBloom)
  }

  static func m3Transition(reduceMotion: Bool) -> AnyTransition {
    reduceMotion ? .opacity : .identity
  }

  static func p1Animation(reduceMotion: Bool) -> Animation? {
    reduceMotion ? nil : easeOut(duration: FilmToolTokens.Press.duration)
  }

  static func p1Scale(reduceMotion: Bool) -> CGFloat {
    reduceMotion ? 1 : FilmToolTokens.Press.scaleShutter
  }

  static func p2Animation(reduceMotion: Bool) -> Animation? {
    reduceMotion ? nil : easeOut(duration: FilmToolTokens.Press.duration)
  }

  static func p2Scale(reduceMotion: Bool) -> CGFloat {
    reduceMotion ? 1 : FilmToolTokens.Press.scaleSide
  }

  static func p3Animation(reduceMotion: Bool) -> Animation? {
    reduceMotion ? nil : easeOut(duration: FilmToolTokens.Press.duration)
  }

  static func frostAnimation(reduceMotion: Bool) -> Animation? {
    reduceMotion ? nil : .easeInOut(duration: durFrost)
  }

  static func decoyAnimation(reduceMotion: Bool) -> Animation? {
    reduceMotion ? nil : .easeInOut(duration: durDecoy)
  }

  private static func easeOut(duration: TimeInterval) -> Animation {
    .timingCurve(0.16, 1, 0.3, 1, duration: duration)
  }
}

struct FilmToolShutterButtonStyle: ButtonStyle {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? FilmToolMotion.p1Scale(reduceMotion: reduceMotion) : 1)
      .animation(
        FilmToolMotion.p1Animation(reduceMotion: reduceMotion), value: configuration.isPressed
      )
  }
}
