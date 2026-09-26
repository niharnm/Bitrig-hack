import SwiftUI

/// Tactile glass selector pill allowing the photographer to switch between film stocks (SCR-OL-B).
/// Displays lock badges on Pro presets when the user is not Pro and invokes paywall presentation on locked taps.
public struct FilmStockSelectorView: View {
  @Binding public var selectedStock: FilmStock
  public let isPro: Bool
  @Binding public var showPaywall: Bool
  public var onLockedSelected: (() -> Void)?

  @Environment(\.presentPaywall) private var presentPaywall

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

  @State private var lockedTapCount = 0

  public var body: some View {
    // Plain text strip like the Camera app's mode picker: the selection is the only highlighted item.
    // Scrolls only when the names don't fit, such as on the narrow outer display or with larger text.
    ViewThatFits(in: .horizontal) {
      stockRow
      ScrollView(.horizontal) {
        stockRow
          .padding(.horizontal, FilmToolTokens.Space.s2)
      }
      .scrollIndicators(.hidden)
    }
    .sensoryFeedback(.selection, trigger: selectedStock)
    .sensoryFeedback(.impact(flexibility: .rigid), trigger: lockedTapCount)
  }

  private var stockRow: some View {
    HStack(spacing: FilmToolTokens.Space.s5) {
      ForEach(FilmStock.allCases) { stock in
        stockChip(for: stock)
      }
    }
  }

  @ViewBuilder
  private func stockChip(for stock: FilmStock) -> some View {
    let isSelected = selectedStock == stock
    let isLocked = stock.requiresPro && !isPro

    Button {
      handleSelection(stock)
    } label: {
      HStack(spacing: FilmToolTokens.Space.s1) {
        Text(LocalizedStringKey(stock.displayNameKey))
          .textCase(.uppercase)
          .kerning(0.8)
        if isLocked {
          Image(systemName: "lock.fill")
            .imageScale(.small)
            .accessibilityHidden(true)
        }
      }
      .font(.footnote.weight(.semibold))
      .foregroundStyle(isSelected ? FilmToolTokens.Palette.accent : FilmToolTokens.Palette.ink)
      .shadow(color: .black.opacity(0.35), radius: 2)
      .frame(minHeight: 32)
      .contentShape(Rectangle())
    }
    .buttonStyle(FilmStockChipButtonStyle())
    .accessibilityLabel(Text(LocalizedStringKey(stock.displayNameKey)))
    .accessibilityValue(isLocked ? Text("filmStock.locked") : Text(verbatim: ""))
    .accessibilityAddTraits(isSelected ? .isSelected : [])
  }

  private func handleSelection(_ stock: FilmStock) {
    if stock.requiresPro && !isPro {
      lockedTapCount += 1
      showPaywall = true
      presentPaywall()
      onLockedSelected?()
    } else {
      withAnimation(.snappy) {
        selectedStock = stock
      }
    }
  }
}

/// Subtle tactile button style for film stock labels
private struct FilmStockChipButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .opacity(configuration.isPressed ? 0.6 : 1.0)
      .animation(.snappy(duration: 0.12), value: configuration.isPressed)
  }
}
