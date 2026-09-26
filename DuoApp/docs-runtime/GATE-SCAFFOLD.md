# Scaffold gate

Status: BLOCKED for Duo validation. Ordinary iPhone Debug build and visually verified launch passed. This does not satisfy TC-S01 on Duo.

## Scope

Cursor scaffold only: one app target, empty named lane stubs, asset catalog partitions, camera usage description, and RevenueCat package references. No capture, accessory, pose layout, purchases, paywall, or Frost behavior is implemented.

## Verified environment

- Xcode 27.0, build 27A5209h, at /Applications/Xcode-beta.app.
- Installed iOS SDK and simulator runtime: 27.0.
- No Duo simulator device type or runtime is installed.
- XcodeGen 2.46.0 generated DuoApp.xcodeproj from project.yml.
- RevenueCat and RevenueCatUI references resolved to purchases-ios-spm 5.91.0; Package.resolved is retained.
- Swift formatting lint, localization plist validation, asset JSON validation, and project.pbxproj validation passed.
- Debug build passed on the iPhone 17 Pro / iOS 27.0 simulator destination with signing disabled.
- Installation and launch succeeded on iPhone 17 Pro, iOS 27.0. The running app visibly displayed the charcoal Outer Lens placeholder. Screenshot: /tmp/outer-lens-scaffold-launch.png.
- The built Info.plist contains the expected camera usage description and Outer Lens display name.
- The first build failed because the AppIcon asset set was missing. Adding the reserved empty AppIcon slot fixed the asset compilation error.
- Xcode emitted one non-blocking App Intents metadata warning because this scaffold has no AppIntents.framework dependency.

The bible requires Xcode/iOS 27.1 and an iPhone Duo simulator. TC-S01 and the Device Hub fold check cannot pass on this machine yet. Ordinary iPhone results are smoke evidence only.

## Handoff

1. Provide the required 27.1 toolchain and Duo runtime, then repeat the empty-app launch and fold check.
2. On Duo PASS, hand RootArrangementView, PoseRouter, ArrangementRegions, and CutoverFlag to Duo-core.
3. CCA and RC owners supply their feature handoffs before Cursor performs integration.
4. Cursor applies design tokens and motion after feature inputs freeze, then runs the canonical acceptance suite.

No SHELL-READY or CCA gate is claimed. CUTOVER.flag and RC dashboard values were not changed.

## Reserved runtime leaves

SHELL-READY.md, feature gate files, RC-IDs.md, CUTOVER.flag, and DEMO-SCRIPT.md await their named owners. They are not evidence of completed feature work. The frozen tree is not yet eligible for GATE-SCAFFOLD=PASS. In particular, the cutover flag remains absent and no human dashboard values are populated.
