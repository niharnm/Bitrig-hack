import SwiftUI

/// Film stock arc dial that wraps the left side of the shutter (SCR-OL-B).
/// Drag along the arc or tap a label; the active stock sits on the index next to the shutter.
/// Locked Pro stocks spring back and invoke paywall presentation.
/// Lay it over the shutter: the dial's anchor is the shutter centre and it never covers the shutter itself.
public struct FilmStockSelectorView: View {
  @Binding public var selectedStock: FilmStock
  public let isPro: Bool
  @Binding public var showPaywall: Bool
  public var onLockedSelected: (() -> Void)?

  @Environment(\.presentPaywall) private var presentPaywall
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  public init(
    selectedStock: Binding<FilmStock>,
    isPro: Bool,
    showPaywall: Binding<Bool> = .constant(false),
    onLockedSelected: (() -> Void)? = nil
  ) {
    self._selectedStock = selectedStock
    self.isPro = isPro
    self._showPaywall = showPaywall
    self.onLockedSelected = onLockedSelected
  }

  /// Width and height of the dial's touch area, which sits entirely left of the shutter.
  static let size = CGSize(width: 250, height: 300)
  /// Horizontal gap between the dial's trailing edge and the shutter centre.
  static let shutterClearance: CGFloat = 44
  /// Offset that centres the dial's anchor on the shutter when used as the shutter's overlay.
  static let overlayOffset = -(size.width / 2 + shutterClearance)

  private static let stocks = FilmStock.allCases
  private static let stepDegrees = 22.0
  private static let pointsPerStep: CGFloat = 44
  private static let trackRadius: CGFloat = 100
  private static let labelRadius: CGFloat = 122
  private static let labelWidth: CGFloat = 150

  /// Dial position in stock units: the selected index at rest, fractional while the finger drags.
  @State private var position: Double = 0
  @State private var dragStart: Double?
  @State private var lockedTapCount = 0
  @State private var isAwake = true
  @State private var interaction = 0

  private var anchor: CGPoint { CGPoint(x: Self.size.width + Self.shutterClearance, y: Self.size.height / 2) }
  private var selectedIndex: Int { Self.stocks.firstIndex(of: selectedStock) ?? 0 }
  private var detent: Int { min(max(Int(position.rounded()), 0), Self.stocks.count - 1) }

  public var body: some View {
    ZStack {
      track
      ForEach(Array(Self.stocks.enumerated()), id: \.element) { index, stock in
        stockLabel(stock, isSelected: index == selectedIndex)
          .modifier(
            ArcPlacement(
              angle: (Double(index) - position) * Self.stepDegrees,
              anchor: anchor,
              radius: Self.labelRadius,
              width: Self.labelWidth))
      }
    }
    .frame(width: Self.size.width, height: Self.size.height)
    .contentShape(Rectangle())
    .gesture(dialGesture)
    .onAppear { position = Double(selectedIndex) }
    .onChange(of: selectedStock) { _, stock in
      let index = Double(Self.stocks.firstIndex(of: stock) ?? 0)
      if position != index {
        withAnimation(settle) { position = index }
      }
    }
    // Unselected labels recede after two idle seconds so the picture stays the hero.
    .task(id: interaction) {
      try? await Task.sleep(for: .seconds(2))
      guard !Task.isCancelled, dragStart == nil else { return }
      withAnimation(.easeOut(duration: 0.4)) { isAwake = false }
    }
    .sensoryFeedback(.selection, trigger: detent)
    .sensoryFeedback(.impact(flexibility: .rigid), trigger: lockedTapCount)
    .accessibilityElement(children: .ignore)
    .accessibilityLabel(Text("filmStock.dial"))
    .accessibilityValue(accessibilityValue)
    .accessibilityAdjustableAction { direction in
      switch direction {
      case .increment: commit(min(selectedIndex + 1, Self.stocks.count - 1))
      case .decrement: commit(max(selectedIndex - 1, 0))
      @unknown default: break
      }
    }
  }

  private var accessibilityValue: Text {
    let name = Text(LocalizedStringKey(selectedStock.displayNameKey))
    return name
  }

  // MARK: Drawing

  /// Arc track with fine ticks, a major tick per stock, and the fixed index beside the shutter.
  private var track: some View {
    Canvas { context, _ in
      let point = { (degrees: Double, radius: CGFloat) -> CGPoint in
        let a = degrees * .pi / 180
        return CGPoint(x: anchor.x - radius * cos(a), y: anchor.y + radius * sin(a))
      }
      var arc = Path()
      arc.addArc(
        center: anchor, radius: Self.trackRadius,
        startAngle: .degrees(180 - 62), endAngle: .degrees(180 + 62), clockwise: false)
      context.stroke(arc, with: .color(.white.opacity(0.22)), lineWidth: 1.5)

      for degrees in stride(from: -60.0, through: 60.0, by: 4) {
        var tick = Path()
        tick.move(to: point(degrees, Self.trackRadius))
        tick.addLine(to: point(degrees, Self.trackRadius + 5))
        context.stroke(tick, with: .color(.white.opacity(0.28)), lineWidth: 1)
      }
      for index in Self.stocks.indices {
        let degrees = (Double(index) - position) * Self.stepDegrees
        guard abs(degrees) <= 62 else { continue }
        var tick = Path()
        tick.move(to: point(degrees, Self.trackRadius))
        tick.addLine(to: point(degrees, Self.trackRadius + 11))
        context.stroke(tick, with: .color(.white.opacity(0.6)), style: StrokeStyle(lineWidth: 2, lineCap: .round))
      }
      var index = Path()
      index.move(to: point(0, Self.trackRadius - 6))
      index.addLine(to: point(0, Self.trackRadius + 13))
      context.stroke(index, with: .color(.white), style: StrokeStyle(lineWidth: 2, lineCap: .round))
    }
    .allowsHitTesting(false)
    .accessibilityHidden(true)
  }

  private func stockLabel(_ stock: FilmStock, isSelected: Bool) -> some View {
    let isLocked = stock.requiresPro && !isPro
    return HStack(spacing: FilmToolTokens.Space.s1) {
      if isLocked {
        Image(systemName: "lock.fill")
          .imageScale(.small)
          .foregroundStyle(FilmToolTokens.Palette.accent)
      }
      Text(LocalizedStringKey(stock.displayNameKey))
        .textCase(.uppercase)
        .kerning(isSelected ? 0.6 : 0.8)
    }
    .font(.system(size: isSelected ? 15 : 12.5, weight: isSelected ? .semibold : .medium))
    .foregroundStyle(.white.opacity(isSelected ? 1 : (isAwake ? 0.8 : 0.45)))
    .shadow(color: .black.opacity(0.7), radius: 2, y: 1)
    .shadow(color: .black.opacity(0.4), radius: 8)
    .lineLimit(1)
    .fixedSize()
  }

  // MARK: Interaction

  /// One gesture handles both taps and drags so labels and track never compete for the touch.
  private var dialGesture: some Gesture {
    DragGesture(minimumDistance: 0)
      .onChanged { value in
        if dragStart == nil {
          dragStart = position
          wake()
        }
        guard abs(value.translation.height) > 4 || abs(value.translation.width) > 4 else { return }
        let raw = (dragStart ?? position) - value.translation.height / Self.pointsPerStep
        position = rubberBanded(raw)
      }
      .onEnded { value in
        let start = dragStart ?? position
        dragStart = nil
        wake()
        let isTap = abs(value.translation.height) <= 4 && abs(value.translation.width) <= 4
        if isTap {
          commit(nearestIndex(to: value.location))
        } else {
          // Project the flick forward, then snap to the stock nearest where it would come to rest.
          let projected = start - value.predictedEndTranslation.height / Self.pointsPerStep
          commit(min(max(Int(projected.rounded()), 0), Self.stocks.count - 1), afterFlick: true)
        }
      }
  }

  private func nearestIndex(to location: CGPoint) -> Int {
    let dx = anchor.x - location.x
    let dy = location.y - anchor.y
    let degrees = atan2(dy, dx) * 180 / .pi
    let index = (position + degrees / Self.stepDegrees).rounded()
    return min(max(Int(index), 0), Self.stocks.count - 1)
  }

  private func commit(_ index: Int, afterFlick: Bool = false) {
    let stock = Self.stocks[index]
    if stock.requiresPro && !isPro {
      lockedTapCount += 1
      withAnimation(settle) { position = Double(selectedIndex) }
      showPaywall = true
      presentPaywall()
      onLockedSelected?()
      return
    }
    withAnimation(afterFlick ? flick : settle) {
      selectedStock = stock
      position = Double(index)
    }
  }

  private func wake() {
    if !isAwake {
      withAnimation(.easeOut(duration: 0.15)) { isAwake = true }
    }
    interaction += 1
  }

  /// Resist progressively past the first and last stock instead of stopping hard.
  private func rubberBanded(_ raw: Double) -> Double {
    let last = Double(Self.stocks.count - 1)
    let band = { (overshoot: Double) in overshoot * 0.55 / (1 + 0.55 * overshoot) }
    if raw < 0 { return -band(-raw) }
    if raw > last { return last + band(raw - last) }
    return raw
  }

  /// Critically damped for taps; a little bounce only when a flick carried momentum.
  private var settle: Animation? { reduceMotion ? nil : .spring(response: 0.3, dampingFraction: 1) }
  private var flick: Animation? { reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.8) }
}

/// Places a label with its trailing edge on the arc. Animating the angle moves labels along the arc, not across it.
private struct ArcPlacement: ViewModifier, Animatable {
  var angle: Double
  let anchor: CGPoint
  let radius: CGFloat
  let width: CGFloat

  nonisolated var animatableData: Double {
    get { angle }
    set { angle = newValue }
  }

  func body(content: Content) -> some View {
    let a = angle * .pi / 180
    let x = anchor.x - radius * cos(a)
    let y = anchor.y + radius * sin(a)
    content
      .frame(width: width, alignment: .trailing)
      .position(x: x - width / 2, y: y)
      .opacity(abs(angle) > 70 ? 0 : 1)
  }
}
