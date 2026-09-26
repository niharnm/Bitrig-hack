import SwiftUI

@main
struct DuoAppApp: App {
  init() {
    PurchasesConfig.configureIfNeeded()
  }

  var body: some Scene {
    WindowGroup {
      RootArrangementView()
        .preferredColorScheme(.dark)
    }
  }
}
