# Original User Request

## 2026-09-26T18:50:00Z

Build and integrate all Codex backend modules for Outer Lens and FrostDuo cutover on iPhone Duo—covering RevenueCat Test Store monetization, RevenueCatUI inner paywalls, and isolated Frost standby views across dedicated git worktrees, verified through multi-agent architecture, code review, UI polish, behavioral psychology, and marketing review loops.

Working directory: `/Users/vachanbhogi/Desktop/Bitrig-hack`
Integrity mode: development

## Requirements

### R1. RevenueCat Test Store Engine (`Monetization/**`)
Implement the complete RevenueCat backend integration using `purchases-ios-spm` ≥ 5.43.0:
- `Monetization/PurchasesConfig.swift`: `#if DEBUG` configuration with `test_` API key from `docs-runtime/RC-IDs.md`.
- `Monetization/RCIdentifiers.swift`: Exact transcription of dashboard constants (`PLACEHOLDER_RC_*` namespace).
- `Monetization/Entitlements.swift`: Observable `EntitlementsModel` maintaining `EntitlementState` (`isPro`, status machine) listening to `Purchases.shared.customerInfoStream`.
- `Monetization/OfferingsRepository.swift`: Asynchronous `Offerings` and package fetching with dashboard validation.
- Output: `docs-runtime/GATE-RC.md` verifying TC-R01 to TC-R05.

### R2. Freemium Inner Paywall (`Features/Paywall/**`)
Implement `Features/Paywall/PaywallHostView.swift` embedding `RevenueCatUI` `PaywallView(displayCloseButton: true)`:
- Strictly confined to the inner display; never hosted on the outer display or camera accessory.
- Includes presentation/dismissal bindings and purchase completion hooks updating `EntitlementsModel`.
- Formatted with marketing psychology and high-converting freemium value framing.

### R3. Isolated FrostDuo Standby Layer (`Features/Frost/**` in separate worktree)
In an isolated git worktree (`sat/frost`), implement the complete standby FrostDuo screen slice:
- `SensitiveSurfaceView.swift` (SCR-FD-A): Inner sensitive document with progressive frost filter.
- `FrostControlsView.swift` (SCR-FD-B): Inner quiet controls ("Covered" / "Private", never alarmist).
- `FrostOverlayView.swift`: Multi-layer blur and frost shaders responding to threat level.
- `OuterDecoyStageView.swift` (SCR-FD-C): Outer decoy display supporting Lock Lookalike A (Free), Busy Cover B, and Vault Cover C (Pro).
- `SimulateThreatControl.swift` & `ThreatLevel.swift`: Sim test controls (clear -> locked).
- Must NEVER import `Capture` or touch `RootArrangementView.swift`.
- Output: `docs-runtime/GATE-FROST.md`.

### R4. Specialized Agent Review Loops (Architecture, UI, Psychology, Marketing)
Deploy dedicated review agents equipped with specialized skills:
- **Software Architecture & Code Review (`agency-software-architect`, `agency-code-reviewer`):** Validate adherence to §06 tree, §07 domain types, strict path mutex, and zero runtime crashes.
- **UI & Motion Polish (`agency-ui-designer`, `emil-design-eng`):** Audit Film Tool color palette (`#050505`, `#E8A838`), typography (SF Rounded), and fluid animation timings.
- **Behavioral Psychology (`agency-behavioral-nudge-engine`):** Validate calm, non-intrusive threat messaging on Frost and clear freemium contrast on Outer Lens.
- **Marketing & Pitch Alignment (`agency-ad-creative-strategist`):** Ensure paywall and copy map 1:1 to frozen Brad and Matt pitch lines.

### R5. Worktree Integration & Cohesion Verification
Verify that `sat/rc` and `sat/frost` worktrees merge cleanly into trunk:
- Verify that `EntitlementsModel.shared.state.isPro` unblocks both the Outer Lens T2 Guide Oval and the Frost Vault Cover C without cross-lane pollution.
- Programmatic build passes with zero missing symbols.

## Acceptance Criteria

### Monetization & Paywall (TC-R01..TC-R05)
- [ ] `PurchasesConfig.configureIfNeeded()` compiles cleanly and guards `test_` under `#if DEBUG`.
- [ ] `RCIdentifiers.swift` compiles and uses only `PLACEHOLDER_RC_*` tokens.
- [ ] `EntitlementsModel` publishes observable `isPro` state matching `Shared/Types.swift`.
- [ ] `PaywallHostView` presents on inner display and handles completion without crashing.
- [ ] `docs-runtime/GATE-RC.md` is generated with pass status.

### Frost Standby Slice (TC-F01..TC-F04)
- [ ] All 6 files in `Features/Frost/**` compile in total isolation without importing `Features/Capture`.
- [ ] Decoy stages A, B, and C render distinct layouts corresponding to free vs. pro entitlements.
- [ ] `SimulateThreatControl` cycles through threat levels 0 to 3.
- [ ] `docs-runtime/GATE-FROST.md` is generated.

### Integration & Quality Gates
- [ ] Zero merge conflicts between worktrees on `Shared/Types.swift` and `.pbxproj`.
- [ ] Code review passes with zero P0 violations (no invented keys, no paywall on outer display, no hinge-driven layout).
- [ ] Swift syntax / compile check succeeds with zero compiler errors.
