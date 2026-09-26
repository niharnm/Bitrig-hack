# Scaffold gate

**Status: BLOCKED for canonical Duo acceptance.** The iOS 27.1 SDK Debug build passed, and the placeholder launch was visually verified on Duo. The timed launch and fold checks remain unverified. This is not `GATE-SCAFFOLD=PASS`.

## Scope and current implementation

The project has a generated DuoApp target, DesignSystem tokens and motion, shared app types, and an isolated Frost standby view slice. The root now hosts the initial capture shell and CameraCaptureAccessory tip handoff. The camera preview and shutter remain unwired to a capture session. Duo-core pose routing, arrangement slots, and the initial CameraCaptureAccessory host are present. Capture-session behavior, RevenueCat configuration and purchases, and Frost slot wiring remain incomplete. The Frost views are not activated by a cutover decision.

## Verified environment and checks

- Xcode 27.1, build 27A9269, with iOS SDK 27.1.
- Registered iOS 27.1 simulator runtime, build 24A94401.
- Duo simulator UDID `AF299D52-1471-4F63-9B56-877C15E9C8A4` is Booted with SpringBoard running. DuoApp installed and launched successfully; `/tmp/outer-lens-duo-launch-inner.png` shows the charcoal Outer Lens placeholder on display 1. No timed launch or Device Hub fold proof is recorded.
- Debug build with the iOS 27.1 SDK passed.
- The final integrated nine unit tests passed on an ordinary iPhone 17 Pro simulator running iOS 27.0. These tests are not Duo device behavior evidence. Test fixtures are not proof of a configured RevenueCat purchase.
- The final integrated Release build passed on the Duo simulator destination.

## Remaining scaffold evidence

1. Measure a clean Duo launch against the TC-S01 time requirement. The first boot reported a migration progress-window incident, although the device and app became usable.
2. Preserve launch evidence; ordinary placeholder launch is verified, feature behavior is not.
3. Change pose in Device Hub and observe the arrangement response. The merged root has pose routing and arrangement slots; their fold behavior remains unverified.
4. Complete the remaining Capture/CCA and RevenueCat handoffs before final integration acceptance. A regular iPhone simulator build does not substitute for these Duo checks.

`CUTOVER.flag` remains untouched. No canonical scaffold PASS, CCA gate, or RevenueCat gate is claimed here.

Duo XCTest failed before connecting, with signal kill during bootstrap; no test cases ran in that attempt. Its cause remains unresolved. The integrated capture shell was visually observed in `/tmp/outer-lens-integrated-duo-inner.png`, with the accessory-unavailable banner and an unwired shutter. This is launch evidence only.

## Incoming RC handoff, 2026-09-26

At `7e6eb80`, RevenueCat and paywall sources are present but the handoff does not compile. SDK 27.1 Debug build failed at `Monetization/Entitlements.swift:19`: public `state` exposes internal `EntitlementState`. Log: `/tmp/outer-lens-rc-handoff-build.log`. The earlier successful builds and nine tests apply to the pre-RC integration revision.

The generated project now includes `OfferingsRepository.swift`. Root paywall and read-only entitlement wiring wait for a compiling RC handoff. `GATE-RC.md` readiness claims are not treated as observed purchase, restore, cancellation, or cross-display unlock proof. Cursor has not modified monetization or paywall implementation.
