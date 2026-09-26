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

  public var body: some View {
    HStack(spacing: 4) {
      ForEach(FilmStock.allCases) { stock in
        stockChip(for: stock)
      }
    }
    .padding(4)
    .background(.ultraThinMaterial, in: Capsule())
    .overlay(
      Capsule()
        .stroke(Color.white.opacity(0.18), lineWidth: 1)
    )
    .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)
  }

  @ViewBuilder
  private func stockChip(for stock: FilmStock) -> some View {
    let isSelected = selectedStock == stock
    let isLocked = stock.requiresPro && !isPro

    Button {
      handleSelection(stock)
    } label: {
      HStack(spacing: 4) {
        Text(LocalizedStringKey(stock.displayNameKey))
          .font(.system(size: 13, weight: isSelected ? .semibold : .medium, design: .rounded))
          .foregroundStyle(isSelected ? Color.white : Color.white.opacity(0.70))

        if isLocked {
          Image(systemName: "lock.fill")
            .font(.system(size: 10, weight: .bold))
            .foregroundStyle(FilmToolTokens.Palette.accent)
        }
      }
      .padding(.horizontal, 10)
      .padding(.vertical, 6)
      .background {
        if isSelected {
          Capsule()
            .fill(Color.white.opacity(0.20))
            .overlay(
              Capsule()
                .stroke(Color.white.opacity(0.25), lineWidth: 0.8)
            )
        }
      }
      .contentShape(Capsule())
    }
    .buttonStyle(FilmStockChipButtonStyle())
    .accessibilityLabel(Text(LocalizedStringKey(stock.displayNameKey)))
    .accessibilityValue(isLocked ? "Locked" : (isSelected ? "Selected" : ""))
  }

  private func handleSelection(_ stock: FilmStock) {
    if stock.requiresPro && !isPro {
      // Rigid haptic feedback on locked attempt
      UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
      showPaywall = true
      presentPaywall()
      onLockedSelected?()
    } else {
      // Light haptic feedback on unlocked selection
      UIImpactFeedbackGenerator(style: .light).impactOccurred()
      withAnimation(.spring(response: 0.25, dampingFraction: 0.75)) {
        selectedStock = stock
      }
    }
  }
}

/// Subtle tactile button style for film stock chips
private struct FilmStockChipButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
      .opacity(configuration.isPressed ? 0.85 : 1.0)
      .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
  }
}
