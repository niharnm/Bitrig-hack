# GATE-FROST.md — FrostDuo Standby & Cutover Verification

status: PASS
cutover_flag: frost
tc_f01: PASS — SCR-FD-A inner frost ladder reaches 24pt milky blur with quiet "Covered" badge (F1 280ms)
tc_f02: PASS — SCR-FD-C outer display presents Decoy Pack A (Lock Lookalike) on lock (F2 snap)
tc_f03: PASS — SCR-FD-B SimulateThreatControl drives threat ladder in simulator with 0 TrueDepth faces
tc_f04: PASS — SCR-FD-C Decoy Pack C (Vault Cover) unlocks on outer display via F3 (400ms) when isPro == true
tc_f05: N/A — Closed-cover vault deferred per cut list
isolation_check: PASS — Zero imports of Features/Capture or Features/CoachOverlay; zero edits to RootArrangementView.swift
worktree: sat/frost
timestamp: 2026-09-26T19:02:00Z

## Verification Summary
- **SCR-FD-A (SensitiveSurfaceView.swift)**: Progressive frost ladder (.clear: 0pt, .cautious: 8pt, .threatened: 16pt, .locked: 24pt max). Mail thread option with confidential escrow wire token and >=18pt room-readable body. F1 easeInOut 280ms transition with accessibility Reduce Motion support.
- **SCR-FD-B (FrostControlsView.swift & SimulateThreatControl.swift)**: Quiet controls with Protect toggle, Simulate Threat 3s climax trigger, manual Frost Now fallback, and Unlock Cover Vault Pro CTA. Jane Manchun Wong on-device privacy guarantee ("On-device. Faces never leave this iPhone."). Status flake symbol at 80% opacity when locked.
- **SCR-FD-C (OuterDecoyStageView.swift)**: Decoy Pack A (Lock Lookalike - free iOS lock screen with time, date, weather, flashlight/camera shortcuts), Decoy Pack B (Busy Cover - free teaser with messages and calendar), Decoy Pack C (Vault Cover - editorial frosted-glass wallpaper gated strictly by `isPro == true`). F2 snap (~280ms) and F3 crossfade (400ms).
- **Isolation Compliance**: Zero references or imports to `Features/Capture` or `Features/CoachOverlay`. Zero changes to `RootArrangementView.swift` or `Shared/Types.swift` or `Monetization/**`.
- **Toolchain Status**: Compiles cleanly with `swiftlang-6.4` / Apple Swift 6.4 against iPhoneSimulator SDK 27.0 (`arm64-apple-ios18.0-simulator`). 100% test pass on standalone suite `FrostTests.swift`.
