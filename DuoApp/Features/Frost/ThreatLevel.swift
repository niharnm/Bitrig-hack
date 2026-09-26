import SwiftUI

extension ThreatLevel {
  var frostBlurRadius: CGFloat {
    switch self {
    case .clear: 0
    case .cautious: FilmToolTokens.Blur.cautious
    case .threatened: FilmToolTokens.Blur.threatened
    case .locked: FilmToolTokens.Blur.locked
    }
  }
}
