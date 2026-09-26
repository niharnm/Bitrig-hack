# RevenueCat in DuoApp

## Objective

Integrate the RevenueCat iOS SDK into the SwiftUI app in this repo: configure the public Test Store key, check `photon_pro`, purchase and restore with error handling, and present Paywall plus Customer Center.

## Scope

`DuoApp` only. There is no separate photon Xcode project in this folder. SPM `purchases-ios-spm` (RevenueCat and RevenueCatUI, minimum 5.43.0, resolved 5.91.0) was already on the DuoApp target.

## Decisions

- Kept the existing Test Store entitlement `pro` and also unlock on `photon_pro`.
- Package lookup uses offering package identifiers `lifetime`, `yearly`, and `monthly`. No new App Store product ids.
- Paywall stays `PaywallView` on the inner sheet. Customer Center, restore, and package purchase live in capture settings so a custom `purchase(package:)` is not running inside `PaywallView`.
- `Purchases.configure` runs for Debug and Release with `RCIdentifiers.apiKey` (environment override, otherwise the public test key).

## Checks

- `xcodebuild` Debug iphonesimulator with Xcode 27.1 beta: BUILD SUCCEEDED (2026-09-26).
- `DuoAppTests/PaywallPresentationTests` on iPhone 17 Pro simulator: TEST SUCCEEDED, including `testWiredPackageIdentifiersAndPhotonProAccess`.
- A live Test Store purchase was not run.

## Next action

Publish the current offering with packages `lifetime`, `yearly`, and `monthly`, and an entitlement `photon_pro`, then exercise paywall purchase, restore, and Customer Center on a simulator.
