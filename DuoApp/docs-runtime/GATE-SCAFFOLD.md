# Scaffold gate

**Status: BLOCKED for canonical Duo acceptance.** The iOS 27.1 SDK Debug build passed, and the placeholder launch was visually verified on Duo. The timed launch and fold checks remain unverified. This is not `GATE-SCAFFOLD=PASS`.

## Scope and current implementation

The project has a generated DuoApp target, DesignSystem tokens and motion, shared app types, and an isolated Frost standby view slice. The app root remains a placeholder. Duo-core pose routing and arrangement, Outer Lens capture and CameraCaptureAccessory, RevenueCat configuration and purchase behavior, and root cutover integration are not implemented. The Frost views are not activated by a cutover decision.

## Verified environment and checks

- Xcode 27.1, build 27A9269, with iOS SDK 27.1.
- Registered iOS 27.1 simulator runtime, build 24A94401.
- Duo simulator UDID `AF299D52-1471-4F63-9B56-877C15E9C8A4` is Booted with SpringBoard running. DuoApp installed and launched successfully; `/tmp/outer-lens-duo-launch-inner.png` shows the charcoal Outer Lens placeholder on display 1. No timed launch or Device Hub fold proof is recorded.
- Debug build with the iOS 27.1 SDK passed.
- Nine unit tests passed on an ordinary iPhone 17 Pro simulator running iOS 27.0. These tests are not Duo device behavior evidence. Test fixtures are not proof of a configured RevenueCat purchase.
- Release build is in progress. No result is recorded.

## Remaining scaffold evidence

1. Measure a clean Duo launch against the TC-S01 time requirement. The first boot reported a migration progress-window incident, although the device and app became usable.
2. Preserve launch evidence; ordinary placeholder launch is verified, feature behavior is not.
3. Change pose in Device Hub and observe the arrangement response. The current root is a placeholder, so pose behavior is not implemented or verified.
4. Complete Duo-core and feature lane handoffs before integration checks. A regular iPhone simulator build does not substitute for these Duo checks.

`CUTOVER.flag` remains untouched. No canonical scaffold PASS, CCA gate, or RevenueCat gate is claimed here.
