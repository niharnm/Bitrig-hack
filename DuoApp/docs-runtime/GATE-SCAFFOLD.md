# Scaffold and Cursor integration evidence

**Status: PARTIAL. Canonical Duo acceptance remains blocked.**

## Implemented

Generated app/test targets, frozen shared contracts, copy, DesignSystem tokens and motion, and isolated Frost standby are present. The incoming Duo-core and Capture/CCA handoffs are consumed. Root configuration calls the provided RC API, observes its entitlement model, and supplies a read-only snapshot to capture and accessory consumers. The supplied paywall host is inner-only; retained presenters check the current pose, and closing dismisses presentation. Pro rehearsal states are visibly labeled simulated.

Tip, countdown, guide-oval, and shutter consumers now use shared motion and Reduce Motion handling. The guide oval reacts to the entitlement snapshot or the explicit rehearsal override. Camera preview and photo capture remain unwired. No live purchase or cross-display unlock is claimed. Frost remains standby; `CUTOVER.flag` is untouched.

## Verification

- Xcode 27.1 build 27A9269, iOS SDK 27.1; registered Duo runtime 24A94401.
- Current Debug build: PASS, `/tmp/outer-lens-cursor-final-debug.log`.
- Current Release build: PASS, `/tmp/outer-lens-cursor-final-release.log`.
- Swift formatter lint for changed Swift files, localization/project plist validation, and `git diff --check`: PASS.
- Three paywall policy tests run in a hostless macOS package using the actual presenter and test source. Final rerun: 3 tests PASS, 0 failures, `/tmp/outer-lens-policy-final.log`.
- Historical pre-RC integration: nine unit tests passed on iPhone 17 Pro / iOS 27.0. This does not cover the current integrated app or live purchases.
- Current iOS app-host tests: BLOCKED. The test host stopped before app code at `_dyld_start`; after resuming only that host, simulator launch failed with `NoSuchProcess`. The run was cancelled without assertions. Log: `/tmp/outer-lens-root-bridge-final-tests.log`.
- Historical Duo placeholder/capture-shell screenshots prove launch only. Duo-core records partial pose evidence in `SHELL-READY.md`; timed launch, all fold poses, and live accessory behavior remain unverified here.

## Owner blockers

The incoming RC access-control error was resolved by `d0e4243`. Release still lacks SDK configuration, retains the supplied Test Store key, and DEBUG configuration logs the key. These findings were sent to the coordinating tasks for the RC owner. Cursor has not changed `Monetization/**` or `Features/Paywall/**`.

No canonical scaffold, CCA, RevenueCat, Frost, or demo PASS follows from these builds, tests, or source presence.
