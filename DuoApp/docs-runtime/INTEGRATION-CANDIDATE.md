# Outer Lens combined candidate

Build source: `28717dc7d939252e8ad67ee45d66f3ec4d33f300`. Base: `6d559c4`. Branch: `integrate/outer-lens-combined-20260926`. Isolated checkout: `/tmp/outer-lens-main-review-20260926`.

## Inputs and changes

Consumed capture result `9ec83f9`, subscriber settings `975b694` / `c0e2fa9`, and the owner's committed `pro` correction `6bed301`. The shared checkout was read only. Stable snapshot at 2026-09-26T20:33:21Z had no dirty changes in the permitted paths because the owner had just committed them. Snapshot SHA256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

The configuration conflict preserves main's DEBUG key guard and Release behavior. Unlock uses only `pro`; packages remain `lifetime`, `yearly`, and `monthly`. Existing purchase/restore and Customer Center controls are retained. Capture result handling, shutter flash, and failure feedback are consumed without adding photo persistence.

The integration rechecks authorization on scene activation after Settings, preserves stopped state when startup returns late, and guards Customer Center when Purchases is unconfigured. Bootstrap status printing contains no key interpolation or prefix. No Frost, cutover, SDK identifier, or product identifier changes were made.

## Checks run

- SDK 27.1 generic simulator Debug test-target build: PASS, `/tmp/outer-lens-combined-delivery-debug.log`. Tests compiled; this is not an iOS test-execution pass.
- SDK 27.1 generic simulator Release build: PASS, `/tmp/outer-lens-combined-delivery-release.log`.
- Fresh Release executable scan against the original supplied Test Store key: NOT PRESENT.
- Eight focused macOS logic tests: PASS, zero failures, `/tmp/outer-lens-combined-ready-logic.log`. Harness uses actual capture controller excluding the UIKit preview, actual presenter, access/package helpers and constants, and their test sources. Coverage includes permission grant/revocation refresh, idle shutter, photo-result classification, pose guards and `pro` package policy. It does not exercise RevenueCat SDK transactions or the Duo UI.
- Formatter lint on changed capture/controller/test sources, localization and project plist validation, and `git diff --check`: PASS.

## Frozen Bitrig handoff

App: `/tmp/outer-lens-candidates/28717dc/DuoApp.app`.

Executable SHA256: `10f6415e2612165b3650756d10af768cbbe4ae26b7e43232a8c4ff8e9563109d`.

Debug code dylib SHA256: `c7df37222e70c52c7103691863fc7c901eb19470fe02d006e11560abd6f44d83`.

The existing Bitrig operator received the source hash, copied artifact, hashes and logs. This integration task did not control any simulator or preview. Earlier handed-off `bcd6d97` differs only in the bootstrap log string; use the final artifact for exact-revision acceptance.

## Six completion gates

| Gate | Candidate status |
| --- | --- |
| 1. Integrated candidate | Prepared and committed on an isolated branch; draft PR for review, not merged. |
| 2. Build and regression | Generic Debug/Release and focused logic checks pass. Native UI/runtime tests remain with Bitrig. |
| 3. Duo capture and shell | Pending current Bitrig observations, including permission recovery, poses, shutter, and accessory. |
| 4. Real monetization | Pending offering, Test Store purchase, cancellation/failure, restore, Customer Center, and purchase-driven outer unlock. |
| 5. Visual acceptance | Pending clipping, Dynamic Type, Reduce Motion, contrast, countdown and guide checks on the integrated revision. |
| 6. Demo closure | Pending ordered evidence, two timed rehearsals, gate updates and Nihar's final decision. |

Builds and simulation controls do not establish live acceptance. Release intentionally leaves RevenueCat unconfigured; unavailable UI remains guarded. No final product PASS or readiness percentage is claimed.

## Sprint freeze and observed runtime limit

Source frozen at `5b14d9defffe3276d3cb28db73eb5bddca555537`, including main `49bb414` countdown hook. Its incremental builds remain in progress at this receipt update: `/tmp/outer-lens-combined-main-debug.log` and `/tmp/outer-lens-combined-main-release.log`. Earlier passing builds and the copied artifact apply to `28717dc`; Bitrig observations apply to `bcd6d97`, which differs from it only in logging.

Coordinator reports Bitrig at `bcd6d97`: Settings with Simulate Pro OFF, Monthly purchase showed “Package monthly is not in the current offering.” No Test Store transaction sheet opened. Closed-pose launch and three shutter taps were observed within no-camera simulator limits; fold controls remained disabled. This does not establish purchase, real photo capture, all-pose behavior or full demo readiness.

Main's later `1ec017a` countdown-before-photo correction is pending after the explicit sprint freeze. No identifiers or dashboard settings were guessed or changed.
