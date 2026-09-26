# Outer Lens scaffold

This project has a generated DuoApp target, DesignSystem tokens and motion, shared app types, and an isolated Frost standby slice. The app root remains a placeholder. Duo-core pose and arrangement, Outer Lens capture and CameraCaptureAccessory, RevenueCat configuration and purchase flow, and cutover integration are not complete.

## Build

Open `DuoApp.xcodeproj` and select the `DuoApp` scheme. XcodeGen 2.46.0 generated the project. Regenerate after project configuration changes:

```sh
xcodegen generate --spec DuoApp/project.yml
```

Run that command from the repository root. The provisional bundle identifier is `dev.outerlens.DuoApp`; the integrator sets the signing team before device deployment. Duo APIs require the 27.1 SDK and availability guards when Duo-core implements them.

SPM references RevenueCat and RevenueCatUI from purchases-ios-spm, starting at 5.43.0. Package.resolved pins version 5.91.0. The SDK is referenced, but no RevenueCat configuration, entitlement flow, or purchase behavior is implemented.

## Evidence and ownership

The current Debug build passed with the iOS 27.1 SDK. Nine unit tests passed on an ordinary iPhone 17 Pro simulator running iOS 27.0. These tests are not Duo launch or fold evidence, and test fixtures do not prove a RevenueCat purchase. The Release build is still running; no result is recorded.

See `docs-runtime/GATE-SCAFFOLD.md` for current toolchain and Duo simulator evidence. The Duo simulator is booted and the placeholder launch is visually verified. Timed launch and fold behavior remain unverified. See `docs-runtime/DEMO-LAST-PASS.md` for acceptance statuses and `docs-runtime/GATE-FROST.md` for the isolated standby status.

Cursor integration remains pending the Duo-core, Capture/CCA, and RevenueCat handoffs. The cutover flag remains untouched. `docs-runtime/DEMO-SCRIPT.md` is planned and unrehearsed. No canonical acceptance gate is marked PASS.
