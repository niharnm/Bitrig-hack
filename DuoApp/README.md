# Outer Lens

The app contains the generated DuoApp target, shared contracts, DesignSystem tokens and motion, Duo pose routing, and the Capture/CCA coaching handoff. The root observes the supplied entitlement model and publishes a read-only snapshot to both capture and accessory consumers. Unknown poses block paywall requests. Outer Lens permits its closed capture pose; Frost keeps the closed decoy pose blocked. An unconfigured SDK shows a dismissible unavailable state.

The coach cycles tips, displays the Pro guide oval, and supports rehearsal controls. Rehearsal unlocks explicitly say “Simulated Pro”; they are not purchase evidence. Tip, countdown, guide, and shutter motion use the shared tokens and respect Reduce Motion. Owner commit `fc65ca8` adds the capture session, permission screens, preview, and photo-capture call. Live capture remains unverified. Frost stays isolated standby, and `CUTOVER.flag` remains untouched.

## Build

Open `DuoApp.xcodeproj` and select `DuoApp`. Duo APIs require Xcode 27.1. Builds use `DEVELOPER_DIR=/Applications/Xcode-27.1-beta.app/Contents/Developer` without changing the global Xcode selection. Regenerate from the repository root after project configuration changes:

```sh
xcodegen generate --spec DuoApp/project.yml
```

The provisional bundle identifier is `dev.outerlens.DuoApp`. Device deployment needs the signing team. Package.resolved pins RevenueCat and RevenueCatUI to purchases-ios-spm 5.91.0. The generated project includes the owner-supplied `OfferingsRepository.swift`.

## Evidence and remaining work

See `docs-runtime/GATE-SCAFFOLD.md` for build and test evidence and `docs-runtime/DEMO-LAST-PASS.md` for acceptance limits. Live capture, purchase, restore, and cross-display unlock are not verified. The RC owner configures DEBUG only; Release purchase behavior is unavailable, but owner revision `2b321c1` passed a fresh Release executable key-removal scan and removed key interpolation from the bootstrap print. Live purchase and restore still need acceptance evidence. Subscriber settings, restore and Customer Center are included in the reconciliation. See `../docs/project-status.md` for the current acceptance gaps.

The initial RC access-control build error at `7e6eb80` was resolved by owner commit `d0e4243`. `GATE-RC.md` readiness claims are not treated as observed purchase proof. No canonical CCA, RevenueCat, or demo PASS is claimed here.
