# Outer Lens scaffold

This is the Cursor scaffold from bible §06 and §18. The app currently opens a charcoal placeholder with the Outer Lens wordmark. Named feature files contain only ownership stubs.

## Build

Open `DuoApp.xcodeproj` and select the `DuoApp` scheme. XcodeGen 2.46.0 generated the project. Regenerate after project configuration changes:

```sh
xcodegen generate --spec DuoApp/project.yml
```

Run that command from the repository root. The provisional bundle identifier is `dev.outerlens.DuoApp`; the integrator sets the signing team before device deployment. Deployment starts at iOS 26.0 for the ordinary single-display scaffold. Duo APIs require the 27.1 SDK and availability guards when Duo-core implements them.

SPM references RevenueCat and RevenueCatUI from purchases-ios-spm, starting at 5.43.0. No SDK configuration or purchase behavior is present. Package.resolved pins version 5.91.0 after successful dependency resolution.

## Ownership and readiness

See `docs-runtime/GATE-SCAFFOLD.md` for verified build and launch evidence and remaining Duo prerequisites. See `docs-runtime/DEMO-LAST-PASS.md` for the pending acceptance suite.

Scaffold stubs in Monetization, Paywall, and Frost are reserved paths only. Their implementations belong to separate lanes. Cursor integration and polish wait for Duo-core, CCA, and RC handoffs. No cutover decision is made here.
