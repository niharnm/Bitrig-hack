import SwiftUI

/// T3 countdown numeral for the outer display (M2).
struct CountdownView: View {
  let value: Int

  var body: some View {
    Text(value, format: .number)
      .font(.system(size: 140, weight: .bold, design: .rounded).monospacedDigit())
      .foregroundStyle(.white)
      .contentTransition(.numericText(countsDown: true))
      .animation(.snappy, value: value)
  }
}
