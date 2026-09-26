import SwiftUI

// Launch surface for the event demo. No camera, no capture session, no CameraCaptureAccessory.
// A drawn stand-in subject on the inner stage follows the one tip shown on the outer pane.
struct OuterLensDemoView: View {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @State private var tip: DemoTip = .lookAtOuter
  @State private var pose = SubjectPose.centered
  @State private var isPro = false
  @State private var isProSheetPresented = false
  @State private var pendingPro = false
  @State private var shutterFlash = false

  var body: some View {
    Group {
      if #available(iOS 27.1, *) {
        ArrangementView {
          innerPane
            .splitArrangementLayoutRatio(0.66)
        } secondary: {
          outerPane
        }
        .arrangementViewStyle(.split.axes([.horizontal, .vertical]))
      } else {
        VStack(spacing: 0) {
          innerPane
          outerPane
        }
      }
    }
    .background(FilmToolTokens.Palette.canvas.ignoresSafeArea())
    .sheet(
      isPresented: $isProSheetPresented,
      onDismiss: {
        // Reveal the oval after the sheet is gone so the room sees it land.
        guard pendingPro else { return }
        pendingPro = false
        withAnimation(springAnimation) { isPro = true }
      }
    ) {
      DemoProSheet(
        isPro: isPro,
        onSimulatePurchase: { pendingPro = true },
        onResetPro: { isPro = false }
      )
    }
  }

  private var springAnimation: Animation {
    reduceMotion ? .easeInOut(duration: 0.2) : .spring(response: 0.45, dampingFraction: 0.62)
  }

  private func select(_ next: DemoTip) {
    withAnimation(springAnimation) {
      tip = next
      pose = pose.applying(next)
    }
    if next == .thatsTheShot {
      flashShutter()
    }
  }

  private func flashShutter() {
    shutterFlash = true
    withAnimation(.easeOut(duration: 0.35)) { shutterFlash = false }
  }

  // MARK: Inner

  private var innerPane: some View {
    VStack(spacing: FilmToolTokens.Space.s3) {
      PaneLabel(title: "INNER", trailing: "Insider")
      stage
      tipControls
    }
    .padding(FilmToolTokens.Space.s4)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(FilmToolTokens.Palette.canvas)
  }

  private var stage: some View {
    ZStack {
      FilmToolTokens.Palette.canvas
      ViewfinderCorners()
        .stroke(FilmToolTokens.Palette.inkFaint, lineWidth: 2)
        .padding(FilmToolTokens.Space.s3)

      // Drawn at a fixed design size, then scaled to whatever the pane gives the stage.
      GeometryReader { proxy in
        let scale = min(
          proxy.size.width / Self.subjectCanvas.width,
          proxy.size.height / Self.subjectCanvas.height, 1.2)
        subjectLayer
          .frame(width: Self.subjectCanvas.width, height: Self.subjectCanvas.height)
          .scaleEffect(scale)
          .frame(width: proxy.size.width, height: proxy.size.height)
      }

      VStack {
        Spacer()
        Text("Stand-in subject. No camera in the room.")
          .font(.system(size: 12, weight: .medium, design: .rounded))
          .foregroundStyle(FilmToolTokens.Palette.inkFaint)
          .padding(.bottom, FilmToolTokens.Space.s4)
      }

      FilmToolTokens.Palette.ink
        .opacity(shutterFlash ? 0.5 : 0)
        .allowsHitTesting(false)
    }
    .clipShape(RoundedRectangle(cornerRadius: FilmToolTokens.Radius.tip, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: FilmToolTokens.Radius.tip, style: .continuous)
        .stroke(FilmToolTokens.Palette.panelRaised, lineWidth: 1)
    }
  }

  private static let subjectCanvas = CGSize(width: 380, height: 440)

  private var subjectLayer: some View {
    let settleDrop: CGFloat = pose.isSettled ? 8 : 0
    return ZStack {
      TimelineView(.animation(paused: pose.isFrozen || reduceMotion)) { context in
        let bob = pose.isFrozen || reduceMotion
          ? 0 : sin(context.date.timeIntervalSinceReferenceDate * 2.4) * 4
        SubjectFigure(chinLift: pose.chinLift, isBeaming: pose.isSettled)
          .rotationEffect(.degrees(pose.lean), anchor: .bottom)
          .scaleEffect(pose.isSettled ? 0.97 : 1, anchor: .bottom)
          .offset(x: pose.x, y: pose.y + settleDrop + bob)
      }

      if isPro {
        Ellipse()
          .stroke(FilmToolTokens.Palette.accent, style: GuideOvalView.strokeStyle)
          .frame(width: 210, height: 310)
          .offset(x: pose.x, y: pose.y + settleDrop)
          .transition(.scale(scale: 1.25).combined(with: .opacity))
          .accessibilityLabel("Pro guide oval")
      }

      if pose.isFrozen && !pose.isSettled {
        Text("…")
          .font(.system(size: 34, weight: .bold, design: .rounded))
          .foregroundStyle(FilmToolTokens.Palette.inkMuted)
          .offset(x: pose.x + 72, y: pose.y - 150)
          .transition(.opacity)
      }
    }
  }

  private var tipControls: some View {
    let columns = Array(
      repeating: GridItem(.flexible(), spacing: FilmToolTokens.Space.s2), count: 3)
    return LazyVGrid(columns: columns, spacing: FilmToolTokens.Space.s2) {
      ForEach(DemoTip.allCases) { item in
        Button {
          select(item)
        } label: {
          ControlLabel(title: item.buttonTitle, isSelected: tip == item)
        }
        .buttonStyle(FilmToolSideButtonStyle())
      }
      Button {
        isProSheetPresented = true
      } label: {
        ControlLabel(title: isPro ? "Pro on" : "Pro", isSelected: false, isAccent: true)
      }
      .buttonStyle(FilmToolSideButtonStyle())
    }
  }

  // MARK: Outer

  private var outerPane: some View {
    VStack(spacing: FilmToolTokens.Space.s3) {
      PaneLabel(title: "OUTER", trailing: "Subject coach")
      // The pose overlay takes whatever room is left; the tip plate never gets pushed out.
      ZStack {
        if isPro {
          Ellipse()
            .stroke(FilmToolTokens.Palette.accent, style: GuideOvalView.strokeStyle)
            .aspectRatio(0.7, contentMode: .fit)
            .frame(maxWidth: 110, maxHeight: 160)
            .padding(.vertical, FilmToolTokens.Space.s1)
            .transition(.scale(scale: 1.25).combined(with: .opacity))
            .accessibilityLabel("Pro pose overlay")
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      Text(tip.outerCopy)
        .font(.system(size: 32, weight: .semibold, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.accent)
        .multilineTextAlignment(.center)
        .lineLimit(2)
        .minimumScaleFactor(0.8)
        .padding(.horizontal, FilmToolTokens.Space.s5)
        .padding(.vertical, FilmToolTokens.Space.s5)
        .frame(maxWidth: .infinity)
        .background(
          FilmToolTokens.Palette.panel,
          in: RoundedRectangle(cornerRadius: FilmToolTokens.Radius.tip, style: .continuous)
        )
        .id(tip)
        .transition(.opacity.combined(with: .offset(y: FilmToolMotion.tipRise)))
        .layoutPriority(1)
    }
    .padding(FilmToolTokens.Space.s4)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(FilmToolTokens.Palette.canvas)
  }
}

// MARK: - Model

enum DemoTip: CaseIterable, Identifiable, Hashable {
  case lookAtOuter
  case stepLeft
  case chinUp
  case holdStill
  case thatsTheShot

  var id: Self { self }

  var buttonTitle: String {
    switch self {
    case .lookAtOuter: "Reset"
    case .stepLeft: "Step left"
    case .chinUp: "Chin up"
    case .holdStill: "Hold still"
    case .thatsTheShot: "That's the shot"
    }
  }

  /// Outer plate copy. Five words or fewer.
  var outerCopy: String {
    switch self {
    case .lookAtOuter: "Look at the outer"
    case .stepLeft: "Step left"
    case .chinUp: "Chin up"
    case .holdStill: "Hold still"
    case .thatsTheShot: "That's the shot"
    }
  }
}

/// Where the stand-in subject stands. Tips build on each other; Reset returns to center.
struct SubjectPose: Equatable {
  var x: CGFloat = 0
  var y: CGFloat = 0
  var lean: Double = 0
  var chinLift: Double = 0
  var isFrozen = false
  var isSettled = false

  static let centered = SubjectPose()

  func applying(_ tip: DemoTip) -> SubjectPose {
    var next = self
    switch tip {
    case .lookAtOuter:
      next = .centered
    case .stepLeft:
      next.x = -72
      next.lean = -8
      next.isFrozen = false
      next.isSettled = false
    case .chinUp:
      next.y = -36
      next.lean = 0
      next.chinLift = 1
      next.isFrozen = false
      next.isSettled = false
    case .holdStill:
      next.isFrozen = true
      next.isSettled = false
    case .thatsTheShot:
      next.lean = 0
      next.isFrozen = true
      next.isSettled = true
    }
    return next
  }
}

// MARK: - Pieces

private struct PaneLabel: View {
  let title: String
  let trailing: String

  var body: some View {
    HStack {
      Text(title)
        .font(.system(size: 13, weight: .semibold, design: .rounded))
        .tracking(1.5)
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
        .accessibilityAddTraits(.isHeader)
      Spacer()
      Text(trailing)
        .font(FilmToolTokens.Brand.font)
        .foregroundStyle(FilmToolTokens.Palette.inkFaint)
    }
  }
}

private struct ControlLabel: View {
  let title: String
  let isSelected: Bool
  var isAccent = false

  var body: some View {
    Text(title)
      .font(.system(size: 15, weight: .semibold, design: .rounded))
      .lineLimit(1)
      .minimumScaleFactor(0.75)
      .foregroundStyle(
        isAccent
          ? FilmToolTokens.Palette.canvas
          : (isSelected ? FilmToolTokens.Palette.accent : FilmToolTokens.Palette.ink)
      )
      .frame(maxWidth: .infinity, minHeight: FilmToolTokens.Control.minHit)
      .background(
        isAccent ? FilmToolTokens.Palette.accent : FilmToolTokens.Palette.panel,
        in: RoundedRectangle(cornerRadius: FilmToolTokens.Radius.control, style: .continuous)
      )
      .overlay {
        RoundedRectangle(cornerRadius: FilmToolTokens.Radius.control, style: .continuous)
          .stroke(isSelected ? FilmToolTokens.Palette.accent : .clear, lineWidth: 1.5)
      }
      .contentShape(Rectangle())
  }
}

/// Drawn stand-in for the kid in front of the lens. No image assets.
private struct SubjectFigure: View {
  let chinLift: Double
  let isBeaming: Bool

  private let skin = Color(red: 0.84, green: 0.66, blue: 0.52)
  private let shirt = Color(white: 0.58)
  private let legs = Color(white: 0.34)
  private let feature = FilmToolTokens.Palette.canvas

  var body: some View {
    VStack(spacing: 4) {
      ZStack {
        Circle().fill(skin)
        HStack(spacing: 20) {
          Circle().fill(feature).frame(width: 9, height: 9)
          Circle().fill(feature).frame(width: 9, height: 9)
        }
        .offset(y: -6 - chinLift * 6)
        Smile(depth: isBeaming ? 1 : 0.55)
          .stroke(feature, style: StrokeStyle(lineWidth: 3, lineCap: .round))
          .frame(width: 28, height: 12)
          .offset(y: 16 - chinLift * 4)
      }
      .frame(width: 80, height: 80)
      .offset(y: -chinLift * 6)

      ZStack(alignment: .top) {
        Capsule().fill(shirt)
          .frame(width: 20, height: 86)
          .rotationEffect(.degrees(16), anchor: .top)
          .offset(x: -50, y: 6)
        Capsule().fill(shirt)
          .frame(width: 20, height: 86)
          .rotationEffect(.degrees(-16), anchor: .top)
          .offset(x: 50, y: 6)
        RoundedRectangle(cornerRadius: 26, style: .continuous).fill(shirt)
          .frame(width: 88, height: 112)
      }

      HStack(spacing: 12) {
        Capsule().fill(legs).frame(width: 24, height: 64)
        Capsule().fill(legs).frame(width: 24, height: 64)
      }
      .offset(y: -8)
    }
    .accessibilityElement()
    .accessibilityLabel("Stand-in subject")
  }
}

private struct Smile: Shape {
  var depth: Double

  var animatableData: Double {
    get { depth }
    set { depth = newValue }
  }

  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
    path.addQuadCurve(
      to: CGPoint(x: rect.maxX, y: rect.minY),
      control: CGPoint(x: rect.midX, y: rect.minY + rect.height * 2 * depth))
    return path
  }
}

private struct ViewfinderCorners: Shape {
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

private struct DemoProSheet: View {
  let isPro: Bool
  let onSimulatePurchase: () -> Void
  let onResetPro: () -> Void
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    VStack(alignment: .leading, spacing: FilmToolTokens.Space.s4) {
      Text("Insider Pro")
        .font(.system(size: 28, weight: .semibold, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.ink)
      Text("Free: outer preview. Pro: pose overlays on the outer display.")
        .font(.system(size: 17, weight: .regular, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)

      Button {
        onSimulatePurchase()
        dismiss()
      } label: {
        Text(isPro ? "Pro is on" : "Simulate Test Store purchase")
          .font(.system(size: 17, weight: .semibold, design: .rounded))
          .foregroundStyle(FilmToolTokens.Palette.canvas)
          .frame(maxWidth: .infinity, minHeight: 52)
          .background(
            FilmToolTokens.Palette.accent,
            in: RoundedRectangle(cornerRadius: FilmToolTokens.Radius.control, style: .continuous))
      }
      .disabled(isPro)
      .opacity(isPro ? 0.5 : 1)

      if isPro {
        Button("Turn Pro off for rehearsal") {
          onResetPro()
          dismiss()
        }
        .font(.system(size: 15, weight: .medium, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.inkMuted)
      }

      Text("Demo purchase. No charge, no store account.")
        .font(.system(size: 13, weight: .regular, design: .rounded))
        .foregroundStyle(FilmToolTokens.Palette.inkFaint)
    }
    .padding(FilmToolTokens.Space.s5)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .background(FilmToolTokens.Palette.panel.ignoresSafeArea())
    .presentationDetents([.medium])
    .preferredColorScheme(.dark)
  }
}

#Preview {
  OuterLensDemoView()
    .preferredColorScheme(.dark)
}
