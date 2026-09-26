import SwiftUI

/// Two faces of the Duo while someone else takes your photo.
/// INNER faces the photographer: your stick figure, a dashed ghost of your saved angle, and arrows to follow.
/// OUTER faces you: how you look right now and a live match percentage.
/// No camera on the simulator, so the phone's position is simulated: tap an arrow or drag the stage.
struct StrangerShootView: View {
  let target: PreferredAngle
  let ownerName: String
  let isPro: Bool
  let onEditAngles: () -> Void
  let onSignOut: () -> Void

  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @State private var current: PreferredAngle
  @State private var dragAnchor: CGSize = .zero
  @State private var shutterFlash = false
  @State private var shotCount = 0

  init(
    target: PreferredAngle, ownerName: String, isPro: Bool,
    onEditAngles: @escaping () -> Void, onSignOut: @escaping () -> Void
  ) {
    self.target = target
    self.ownerName = ownerName
    self.isPro = isPro
    self.onEditAngles = onEditAngles
    self.onSignOut = onSignOut
    _current = State(initialValue: AngleGuide.startingPoint(for: target))
  }

  private var percent: Int { AngleGuide.matchPercent(current: current, target: target) }
  private var isPerfect: Bool { percent == 100 }
  private var moves: [PhoneMove] { AngleGuide.moves(current: current, target: target) }
  private var matchColor: Color {
    isPerfect ? FilmToolTokens.Palette.success : FilmToolTokens.Palette.accent
  }

  var body: some View {
    Group {
      if #available(iOS 27.1, *) {
        ArrangementView {
          photographerPane
            .splitArrangementLayoutRatio(0.66)
        } secondary: {
          subjectPane
        }
        .arrangementViewStyle(.split.axes([.horizontal, .vertical]))
      } else {
        VStack(spacing: 0) {
          photographerPane
          subjectPane
        }
      }
    }
    .background(FilmToolTokens.Palette.canvas.ignoresSafeArea())
    .sensoryFeedback(.success, trigger: isPerfect) { _, perfect in perfect }
    .onChange(of: target) { _, newTarget in
      current = AngleGuide.startingPoint(for: newTarget)
    }
  }

  private var spring: Animation {
    reduceMotion ? .easeInOut(duration: 0.2) : .spring(response: 0.4, dampingFraction: 0.72)
  }

  private func follow(_ move: PhoneMove) {
    withAnimation(spring) { current = AngleGuide.nudged(current, by: move) }
  }

  // MARK: Inner (photographer)

  private var photographerPane: some View {
    VStack(spacing: FilmToolTokens.Space.s3) {
      HStack {
        PaneTag(title: "INNER", detail: "for the photographer")
        Spacer()
        if isPro { ProBadge() }
        menu
      }

      StageFrame {
        ZStack {
          StickSubjectStage(view: target, ghost: true)
          StickSubjectStage(view: current)
          arrowOverlay
          FilmToolTokens.Palette.ink
            .opacity(shutterFlash ? 0.6 : 0)
            .allowsHitTesting(false)
        }
        .contentShape(Rectangle())
        .gesture(dragToMovePhone)
      }

      Text(moves.first?.instruction ?? "Perfect angle. Take it.")
        .font(.system(size: 24, weight: .bold, design: .rounded))
        .foregroundStyle(isPerfect ? FilmToolTokens.Palette.success : FilmToolTokens.Palette.accent)
        .contentTransition(.opacity)
        .animation(.easeOut(duration: 0.2), value: moves.first)
        .frame(maxWidth: .infinity)
        .accessibilityAddTraits(.updatesFrequently)

      HStack {
        Button {
          withAnimation(spring) { current = AngleGuide.startingPoint(for: target) }
        } label: {
          Label("New stranger", systemImage: "arrow.counterclockwise")
            .font(.system(size: 14, weight: .semibold, design: .rounded))
            .foregroundStyle(FilmToolTokens.Palette.inkMuted)
            .frame(minHeight: FilmToolTokens.Control.minHit)
        }
        Spacer()
        shutter
        Spacer()
        Text("Simulator: tap arrows or drag")
          .font(.system(size: 12, weight: .medium, design: .rounded))
          .foregroundStyle(FilmToolTokens.Palette.inkFaint)
          .multilineTextAlignment(.trailing)
          .frame(width: 110, alignment: .trailing)
      }
    }
    .padding(FilmToolTokens.Space.s4)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(FilmToolTokens.Palette.canvas)
  }

  private var menu: some View {
    Menu {
      Button("Edit my angles", systemImage: "slider.horizontal.3", action: onEditAngles)
      Button("Sign out", systemImage: "rectangle.portrait.and.arrow.right", role: .destructive, action: onSignOut)
    } label: {
      Image(systemName: "person.crop.circle")
        .font(.system(size: 22, weight: .semibold))
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        .frame(width: FilmToolTokens.Control.minHit, height: 32)
    }
    .accessibilityLabel("Account")
  }

  private var shutter: some View {
    Button {
      shotCount += 1
      shutterFlash = true
      withAnimation(.easeOut(duration: 0.35)) { shutterFlash = false }
    } label: {
      ZStack {
        Circle()
          .stroke(isPerfect ? FilmToolTokens.Palette.success : FilmToolTokens.Palette.ink, lineWidth: 4)
          .frame(width: 64, height: 64)
        Circle()
          .fill(isPerfect ? FilmToolTokens.Palette.success : FilmToolTokens.Palette.panelRaised)
          .frame(width: 52, height: 52)
      }
    }
    .buttonStyle(FilmToolShutterButtonStyle())
    .accessibilityLabel(isPerfect ? "Take photo, angle matched" : "Take photo")
  }

  private var arrowOverlay: some View {
    let needed = Set(moves)
    return ZStack {
      VStack {
        if needed.contains(.raise) { ArrowCue(move: .raise) { follow(.raise) } }
        Spacer()
        HStack(spacing: FilmToolTokens.Space.s2) {
          if needed.contains(.lower) { ArrowCue(move: .lower) { follow(.lower) } }
          if needed.contains(.stepCloser) { ArrowCue(move: .stepCloser) { follow(.stepCloser) } }
          if needed.contains(.stepBack) { ArrowCue(move: .stepBack) { follow(.stepBack) } }
        }
      }
      HStack {
        if needed.contains(.moveLeft) { ArrowCue(move: .moveLeft) { follow(.moveLeft) } }
        Spacer()
        if needed.contains(.moveRight) { ArrowCue(move: .moveRight) { follow(.moveRight) } }
      }
    }
    .padding(FilmToolTokens.Space.s3)
    .animation(spring, value: needed)
  }

  /// Drag the way you would move the phone: right moves right, up raises it.
  private var dragToMovePhone: some Gesture {
    DragGesture(minimumDistance: 6)
      .onChanged { value in
        let delta = CGSize(
          width: value.translation.width - dragAnchor.width,
          height: value.translation.height - dragAnchor.height)
        dragAnchor = value.translation
        var next = current
        next.orbit += Double(delta.width) / 180
        next.height -= Double(delta.height) / 180
        current = next.clamped()
      }
      .onEnded { _ in dragAnchor = .zero }
  }

  // MARK: Outer (you)

  private var subjectPane: some View {
    VStack(spacing: FilmToolTokens.Space.s3) {
      HStack {
        PaneTag(title: "OUTER", detail: "for \(ownerName.isEmpty ? "you" : ownerName)")
        Spacer()
      }
      HStack(spacing: FilmToolTokens.Space.s4) {
        StageFrame {
          StickSubjectStage(view: current)
        }
        .frame(maxWidth: 150)

        VStack(alignment: .leading, spacing: FilmToolTokens.Space.s2) {
          Text("\(percent)%")
            .font(.system(size: 56, weight: .bold, design: .rounded).monospacedDigit())
            .foregroundStyle(matchColor)
            .contentTransition(.numericText(value: Double(percent)))
            .animation(spring, value: percent)
            .minimumScaleFactor(0.6)
            .lineLimit(1)
          Text("match to your angles")
            .font(.system(size: 15, weight: .medium, design: .rounded))
            .foregroundStyle(FilmToolTokens.Palette.inkMuted)
          ProgressView(value: Double(percent), total: 100)
            .tint(matchColor)
          Text(subjectStatus)
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .foregroundStyle(isPerfect ? FilmToolTokens.Palette.success : FilmToolTokens.Palette.ink)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .frame(maxHeight: .infinity)
    }
    .padding(FilmToolTokens.Space.s4)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(FilmToolTokens.Palette.canvas)
    .accessibilityElement(children: .combine)
  }

  private var subjectStatus: String {
    if shotCount > 0 && isPerfect { return "Got it. Perfect angle." }
    if isPerfect { return "Perfect angle. Smile!" }
    if percent >= 75 { return "Almost there" }
    return "Guiding your photographer"
  }
}

// MARK: - Pieces

private struct ArrowCue: View {
  let move: PhoneMove
  let action: () -> Void
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  var body: some View {
    Button(action: action) {
      VStack(spacing: 2) {
        Image(systemName: move.symbol)
          .font(.system(size: 26, weight: .heavy))
          .symbolEffect(.pulse, options: .repeating, isActive: !reduceMotion)
        Text(move.shortLabel)
          .font(.system(size: 12, weight: .bold, design: .rounded))
      }
      .foregroundStyle(FilmToolTokens.Palette.accent)
      .frame(minWidth: 56, minHeight: 56)
      .background(FilmToolTokens.Palette.canvas.opacity(0.75), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
      .overlay {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
          .stroke(FilmToolTokens.Palette.accent.opacity(0.6), lineWidth: 1.5)
      }
    }
    .buttonStyle(FilmToolSideButtonStyle())
    .transition(.scale.combined(with: .opacity))
    .accessibilityLabel(move.instruction)
  }
}

private struct PaneTag: View {
  let title: String
  let detail: String

  var body: some View {
    HStack(spacing: FilmToolTokens.Space.s2) {
      Text(title)
        .font(.system(size: 13, weight: .semibold, design: .rounded))
        .tracking(1.5)
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
      Text(detail)
        .font(.system(size: 13, weight: .medium, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.inkFaint)
    }
    .accessibilityAddTraits(.isHeader)
  }
}

/// Charcoal viewfinder frame shared by setup, the photographer, and the subject pane.
struct StageFrame<Content: View>: View {
  @ViewBuilder let content: Content

  var body: some View {
    ZStack {
      FilmToolTokens.Palette.canvas
      ViewfinderBrackets()
        .stroke(FilmToolTokens.Palette.inkFaint, lineWidth: 2)
        .padding(FilmToolTokens.Space.s3)
      content
    }
    .clipShape(RoundedRectangle(cornerRadius: FilmToolTokens.Radius.tip, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: FilmToolTokens.Radius.tip, style: .continuous)
        .stroke(FilmToolTokens.Palette.panelRaised, lineWidth: 1)
    }
  }
}

/// Draws the stick figure at a fixed design size and scales it to the space it gets.
struct StickSubjectStage: View {
  let view: PreferredAngle
  var ghost = false

  private static let canvas = CGSize(width: 380, height: 440)

  var body: some View {
    GeometryReader { proxy in
      let scale = min(proxy.size.width / Self.canvas.width, proxy.size.height / Self.canvas.height)
      StickSubject(view: view, ghost: ghost)
        .frame(width: Self.canvas.width, height: Self.canvas.height)
        .scaleEffect(scale)
        .frame(width: proxy.size.width, height: proxy.size.height)
    }
    .allowsHitTesting(false)
  }
}

/// You, as the camera sees you from `view`. The ghost is a dashed amber outline of your saved angle.
struct StickSubject: View {
  let view: PreferredAngle
  var ghost = false

  private let skin = Color(red: 0.84, green: 0.66, blue: 0.52)
  private let shirt = Color(white: 0.58)
  private let legs = Color(white: 0.34)
  private let feature = FilmToolTokens.Palette.canvas

  var body: some View {
    figure
      .rotation3DEffect(.degrees(view.orbit * 38), axis: (x: 0, y: 1, z: 0), perspective: 0.5)
      .rotation3DEffect(.degrees(-view.height * 24), axis: (x: 1, y: 0, z: 0), perspective: 0.5)
      .scaleEffect(pow(1.6, -view.distance))
      .offset(y: max(0, -view.distance) * 90)
      .accessibilityHidden(true)
  }

  private var figure: some View {
    VStack(spacing: 4) {
      ZStack {
        paint(Circle(), skin)
        if !ghost {
          HStack(spacing: 20) {
            Circle().fill(feature).frame(width: 9, height: 9)
            Circle().fill(feature).frame(width: 9, height: 9)
          }
          .offset(x: -view.orbit * 12, y: -6 + view.height * 6)
          SmileArc()
            .stroke(feature, style: StrokeStyle(lineWidth: 3, lineCap: .round))
            .frame(width: 28, height: 12)
            .offset(x: -view.orbit * 12, y: 16 + view.height * 4)
        }
      }
      .frame(width: 80, height: 80)

      ZStack(alignment: .top) {
        paint(Capsule(), shirt)
          .frame(width: 20, height: 86)
          .rotationEffect(.degrees(16), anchor: .top)
          .offset(x: -50, y: 6)
        paint(Capsule(), shirt)
          .frame(width: 20, height: 86)
          .rotationEffect(.degrees(-16), anchor: .top)
          .offset(x: 50, y: 6)
        paint(RoundedRectangle(cornerRadius: 26, style: .continuous), shirt)
          .frame(width: 88, height: 112)
      }

      HStack(spacing: 12) {
        paint(Capsule(), legs).frame(width: 24, height: 64)
        paint(Capsule(), legs).frame(width: 24, height: 64)
      }
      .offset(y: -8)
    }
  }

  @ViewBuilder
  private func paint<S: Shape>(_ shape: S, _ color: Color) -> some View {
    if ghost {
      shape.stroke(
        FilmToolTokens.Palette.accent.opacity(0.75),
        style: StrokeStyle(lineWidth: 2.5, lineCap: .round, dash: [7, 6]))
    } else {
      shape.fill(color)
    }
  }
}

private struct SmileArc: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
    path.addQuadCurve(
      to: CGPoint(x: rect.maxX, y: rect.minY),
      control: CGPoint(x: rect.midX, y: rect.maxY))
    return path
  }
}

private struct ViewfinderBrackets: Shape {
  func path(in rect: CGRect) -> Path {
    let arm: CGFloat = 22
    var path = Path()
    for (corner, dx, dy) in [
      (CGPoint(x: rect.minX, y: rect.minY), arm, arm),
      (CGPoint(x: rect.maxX, y: rect.minY), -arm, arm),
      (CGPoint(x: rect.minX, y: rect.maxY), arm, -arm),
      (CGPoint(x: rect.maxX, y: rect.maxY), -arm, -arm),
    ] {
      path.move(to: CGPoint(x: corner.x + dx, y: corner.y))
      path.addLine(to: corner)
      path.addLine(to: CGPoint(x: corner.x, y: corner.y + dy))
    }
    return path
  }
}
