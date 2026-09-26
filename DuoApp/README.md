# Outer Lens scaffold

This project has a generated DuoApp target, DesignSystem tokens and motion, shared app types, and an isolated Frost standby slice. The root now hosts the initial capture shell and CameraCaptureAccessory tip handoff. The camera preview and shutter remain unwired to a capture session. Duo-core and the initial accessory host are merged. Capture-session behavior, RevenueCat purchases, and feature acceptance remain incomplete.

## Build

Open `DuoApp.xcodeproj` and select the `DuoApp` scheme. XcodeGen 2.46.0 generated the project. Regenerate after project configuration changes:

```sh
xcodegen generate --spec DuoApp/project.yml
```

Run that command from the repository root. The provisional bundle identifier is `dev.outerlens.DuoApp`; the integrator sets the signing team before device deployment. Duo APIs require the 27.1 SDK and availability guards when Duo-core implements them.

SPM references RevenueCat and RevenueCatUI from purchases-ios-spm, starting at 5.43.0. Package.resolved pins version 5.91.0. The SDK is referenced, but no RevenueCat configuration, entitlement flow, or purchase behavior is implemented.

## Evidence and ownership

The current Debug build passed with the iOS 27.1 SDK. The final integrated nine unit tests passed on an ordinary iPhone 17 Pro simulator running iOS 27.0. These tests are not Duo launch or fold evidence, and test fixtures do not prove a RevenueCat purchase. The final integrated Release build passed on the Duo simulator destination.

See `docs-runtime/GATE-SCAFFOLD.md` for current toolchain and Duo simulator evidence. The Duo simulator is booted and the placeholder launch is visually verified. Timed launch and fold behavior remain unverified. See `docs-runtime/DEMO-LAST-PASS.md` for acceptance statuses and `docs-runtime/GATE-FROST.md` for the isolated standby status.

Cursor integration remains pending the Duo-core, Capture/CCA, and RevenueCat handoffs. The cutover flag remains untouched. `docs-runtime/DEMO-SCRIPT.md` is planned and unrehearsed. No canonical acceptance gate is marked PASS.

Duo XCTest failed before connecting, with signal kill during bootstrap; no test cases ran in that attempt. Its cause remains unresolved. The integrated capture shell was visually observed in `/tmp/outer-lens-integrated-duo-inner.png`, with the accessory-unavailable banner and an unwired shutter. This is launch evidence only.

## Incoming RC handoff, 2026-09-26

At `7e6eb80`, RevenueCat and paywall sources are present but the handoff does not compile. SDK 27.1 Debug build failed at `Monetization/Entitlements.swift:19`: public `state` exposes internal `EntitlementState`. Log: `/tmp/outer-lens-rc-handoff-build.log`. The earlier successful builds and nine tests apply to the pre-RC integration revision.

The generated project now includes `OfferingsRepository.swift`. Root paywall and read-only entitlement wiring wait for a compiling RC handoff. `GATE-RC.md` readiness claims are not treated as observed purchase, restore, cancellation, or cross-display unlock proof. Cursor has not modified monetization or paywall implementation.
