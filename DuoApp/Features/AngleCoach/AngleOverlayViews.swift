import SwiftUI

/// Outer display: the subject sees themselves like a mirror, with the saved face spot drawn where it belongs.
struct SubjectMirrorView: View {
  let frame: CGImage
  let target: FaceMeasurement?
  let isMatched: Bool

  var body: some View {
    GeometryReader { proxy in
      let imageSize = CGSize(width: frame.width, height: frame.height)
      ZStack(alignment: .topLeading) {
        Image(decorative: frame, scale: 1)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: proxy.size.width, height: proxy.size.height)
          .scaleEffect(x: -1, y: 1)
          .clipped()
        if let target {
          let rect = AspectFill.faceRect(for: target, image: imageSize, in: proxy.size, mirrored: true)
          TargetFaceOval(isMatched: isMatched)
            .frame(width: rect.width, height: rect.height)
            .offset(x: rect.minX, y: rect.minY)
        }
      }
    }
    .accessibilityHidden(true)
  }
}

/// Inner display: the same saved face spot over the photographer's preview, unmirrored.
struct PhotographerTargetView: View {
  let frameSize: CGSize
  let target: FaceMeasurement
  let isMatched: Bool

  var body: some View {
    GeometryReader { proxy in
      let rect = AspectFill.faceRect(for: target, image: frameSize, in: proxy.size, mirrored: false)
      TargetFaceOval(isMatched: isMatched)
        .frame(width: rect.width, height: rect.height)
        .offset(x: rect.minX, y: rect.minY)
    }
    .allowsHitTesting(false)
    .accessibilityHidden(true)
  }
}

/// Where the face should sit. Amber while searching, green once the angle holds.
struct TargetFaceOval: View {
  let isMatched: Bool
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  var body: some View {
    Ellipse()
      .stroke(
        isMatched ? FilmToolTokens.Palette.success : FilmToolTokens.Palette.accent,
        style: isMatched ? StrokeStyle(lineWidth: 4) : GuideOvalView.strokeStyle
      )
      .shadow(color: .black.opacity(0.35), radius: 3)
      .animation(FilmToolMotion.m3Animation(reduceMotion: reduceMotion), value: isMatched)
  }
}

/// One instruction for the photographer plus how close they are, as a percentage.
struct PhotographerCuePill: View {
  let guidance: AngleGuidance

  var body: some View {
    HStack(spacing: FilmToolTokens.Space.s2) {
      Image(systemName: guidance.photographer.symbolName)
        .foregroundStyle(guidance.isMatched ? FilmToolTokens.Palette.success : FilmToolTokens.Palette.accent)
      Text(LocalizedStringKey(guidance.photographer.key))
        .foregroundStyle(FilmToolTokens.Palette.ink)
      Text(guidance.score, format: .percent.precision(.fractionLength(0)))
        .monospacedDigit()
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
    }
    .font(.subheadline.weight(.semibold))
    .padding(.horizontal, FilmToolTokens.Space.s4)
    .padding(.vertical, FilmToolTokens.Space.s2)
    .glassEffect(in: Capsule())
    .accessibilityElement(children: .combine)
  }
}

/// The word shown at the instant the photo is taken, so the subject knows it is happening now.
struct CountdownCueView: View {
  let text: String
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  var body: some View {
    Text(text)
      .font(.system(size: 88, weight: .bold, design: .rounded))
      .foregroundStyle(FilmToolTokens.Palette.ink)
      .minimumScaleFactor(0.4)
      .lineLimit(1)
      .padding(.horizontal, FilmToolTokens.Space.s5)
      .shadow(color: .black.opacity(0.5), radius: 6)
      .transition(reduceMotion ? .opacity : .opacity.combined(with: .scale(scale: 0.8)))
      .accessibilityAddTraits(.updatesFrequently)
  }
}
