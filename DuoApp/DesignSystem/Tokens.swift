import SwiftUI

enum FilmToolTokens {
  enum Brand {
    static let name = "Insider"
    static let nameFrost = "FrostDuo"
    static let size: CGFloat = 15
    static let font = Font.system(size: size, weight: .medium)
  }

  enum Blur {
    static let cautious: CGFloat = 8
    static let threatened: CGFloat = 16
    static let locked: CGFloat = 24
  }

  enum Palette {
    static let frostCanvas = Color(red: 243.0 / 255, green: 244.0 / 255, blue: 246.0 / 255)
    static let frostPanel = Color.white
    static let frostInk = Color(red: 28.0 / 255, green: 28.0 / 255, blue: 30.0 / 255)
    static let frostInkMuted = frostInk.opacity(0.62)
    static let frostIce = Color(red: 200.0 / 255, green: 230.0 / 255, blue: 240.0 / 255).opacity(
      0.10)
    static let frostAccent = Color(red: 74.0 / 255, green: 107.0 / 255, blue: 115.0 / 255)
    static let canvas = Color(red: 5.0 / 255, green: 5.0 / 255, blue: 5.0 / 255)
    static let panel = Color(red: 28.0 / 255, green: 28.0 / 255, blue: 30.0 / 255)
    static let panelRaised = Color(red: 44.0 / 255, green: 44.0 / 255, blue: 46.0 / 255)
    static let scrim = Color.black.opacity(0.55)
    static let ink = Color.white
    static let inkMuted = Color.white.opacity(0.62)
    static let inkFaint = Color.white.opacity(0.38)
    static let accent = Color(red: 232.0 / 255, green: 168.0 / 255, blue: 56.0 / 255)
    static let accentSoft = accent.opacity(0.22)
    static let success = Color(red: 92.0 / 255, green: 204.0 / 255, blue: 140.0 / 255)
    static let danger = Color(red: 255.0 / 255, green: 69.0 / 255, blue: 58.0 / 255)
    static let glassTintPro = Color(red: 232.0 / 255, green: 168.0 / 255, blue: 56.0 / 255).opacity(
      0.35)
  }

  enum Tip {
    static let primarySize: CGFloat = 28
    static let primaryFont = Font.system(size: primarySize, weight: .semibold, design: .rounded)
    static let maxWords = 8
    static let minimumScrimOpacity = 0.55
    static let countdownSize: CGFloat = 140
    static let countdownFont = Font.system(size: countdownSize, weight: .bold, design: .rounded)
      .monospacedDigit()
  }

  enum Control {
    static let shutterSize: CGFloat = 80
    static let minHit: CGFloat = 48
    static let iconSize: CGFloat = 20
    static let iconFont = Font.system(size: iconSize, weight: .semibold)
  }

  enum Space {
    static let s1: CGFloat = 4
    static let s2: CGFloat = 8
    static let s3: CGFloat = 12
    static let s4: CGFloat = 16
    static let s5: CGFloat = 24
    static let s6: CGFloat = 32
    static let safeTipBottom: CGFloat = 34
    static let outerInsetX: CGFloat = 16
    static let shutterSideGap: CGFloat = 16
  }

  enum Radius {
    static let control: CGFloat = 12
    static let tip: CGFloat = 14
    static let shutter: CGFloat = 9_999
  }

  enum Press {
    static let scaleShutter: CGFloat = 0.94
    static let scaleSide: CGFloat = 0.96
    static let fill = Color.white.opacity(0.12)
    static let duration: TimeInterval = 0.12
  }

  public enum KidMagnet {
    public static let pulseDuration: TimeInterval = 0.85
    public static let bounceOffset: CGFloat = 8.0
    public static let minScale: CGFloat = 0.96
    public static let maxScale: CGFloat = 1.16
  }

  struct FilmGrade: Sendable, Equatable {
    let contrast: Double
    let saturation: Double
    let amberTintOpacity: Double
    let tintColor: Color

    static let natural = FilmGrade(
      contrast: 1.0, saturation: 1.0, amberTintOpacity: 0.0, tintColor: .clear)
    static let leicaMono = FilmGrade(
      contrast: 1.28, saturation: 0.0, amberTintOpacity: 0.0, tintColor: .clear)
    static let warmAmber = FilmGrade(
      contrast: 1.08, saturation: 1.15, amberTintOpacity: 0.24,
      tintColor: FilmToolTokens.Palette.accent)
    static let portraSoft = FilmGrade(
      contrast: 0.94, saturation: 0.90, amberTintOpacity: 0.08,
      tintColor: Color(red: 245 / 255, green: 215 / 255, blue: 185 / 255))
  }
}

extension FilmStock {
  var grade: FilmToolTokens.FilmGrade {
    switch self {
    case .natural: return .natural
    case .leicaMono: return .leicaMono
    case .warmAmber: return .warmAmber
    case .portraSoft: return .portraSoft
    }
  }
}
