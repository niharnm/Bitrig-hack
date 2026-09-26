# Bitrig Hack

Outer Lens is the iOS SwiftUI app in `DuoApp/`. Monetization uses the RevenueCat Swift package `purchases-ios-spm` (RevenueCat and RevenueCatUI).

## Build

```sh
DEVELOPER_DIR=/Applications/Xcode-27.1-beta.app/Contents/Developer \
  xcodebuild -project DuoApp/DuoApp.xcodeproj -scheme DuoApp \
  -destination 'generic/platform=iOS Simulator' build
```

## Monetization

- `PurchasesConfig` calls `Purchases.configure` with the public Test Store key in `RCIdentifiers`.
- Unlock checks the existing Test Store entitlement `pro`.
- Current-offering package identifiers are `lifetime`, `yearly`, and `monthly`.
- The inner paywall presents RevenueCat `PaywallView`. Capture settings is the subscriber surface: Customer Center, restore, and those three packages.

Do not add App Store product ids beyond the identifiers already in source.
