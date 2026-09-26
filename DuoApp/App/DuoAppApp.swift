import SwiftUI

@main
struct DuoAppApp: App {
  init() {
    PurchasesConfig.configureIfNeeded()
  }

  var body: some Scene {
    // Event demo: capture session, CCA, and permission screens stay off the launch path. RootArrangementView is unchanged.
    WindowGroup {
      OuterLensDemoView()
        .preferredColorScheme(.dark)
    }
  }
}
