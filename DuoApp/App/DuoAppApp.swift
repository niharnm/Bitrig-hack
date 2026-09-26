import SwiftUI

@main
struct DuoAppApp: App {
  init() {
    PurchasesConfig.configureIfNeeded()
  }

  var body: some Scene {
    // Launch flow: account, angle setup, then the two-pane stranger guide. No camera on this path.
    WindowGroup {
      InsiderRootView()
        .preferredColorScheme(.dark)
    }
  }
}
