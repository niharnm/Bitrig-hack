# Frost standby gate

**Status: STANDBY.** Frost views and supporting DesignSystem/shared types are present as an isolated slice. No Frost Duo launch, fold behavior, purchase flow, or cutover demo has been verified. This file does not claim `GATE-FROST=PASS`.

## Current evidence

- DesignSystem tokens and motion, shared `ThreatLevel` and `DecoyPack` types, and the isolated Frost views are implemented.
- The app root is still a placeholder. Duo-core and root cutover integration are pending.
- The Duo simulator is booted. An isolated, explicitly labeled free fixture rendered locked frost and the free lock-style decoy on display 1. Screenshot: `/tmp/outer-lens-frost-duo-inner.png`. Both views share one fixture display; this is not separate inner/outer arrangement proof or a purchase. The production root remains unchanged.
- Nine unit tests passed on an ordinary iPhone 17 Pro simulator running iOS 27.0. Test fixtures do not prove Duo behavior or a RevenueCat purchase.
- RevenueCat configuration, entitlement updates, paywall presentation, and successful purchase behavior are not implemented.
- No cutover decision has been made. `CUTOVER.flag` remains untouched.

## Acceptance status

- TC-F01: NOT RUN. No integrated Duo threat-to-frost observation.
- TC-F02: NOT RUN. No Duo outer decoy observation.
- TC-F03: BLOCKED pending Duo simulator integration and observation of Simulate Threat.
- TC-F04: BLOCKED pending RevenueCat purchase and entitlement integration, followed by outer pack C observation.
- TC-F05: NOT RUN. Optional closed-cover path.
- TC-F06: NOT RUN.
- TC-F07: NOT RUN. Motion is present in source but not observed in the integrated Duo flow.
- TC-F08: NOT RUN. Shared inner paywall flow is not integrated.
- TC-F09: NOT RUN. Orchestrator has not selected cutover; the root flag consumer is not integrated.
- TC-P02: NOT RUN. Frost copy and the cutover demo have not been rehearsed.

## Handoff and limits

Keep Frost isolated standby until Orchestrator records `GATE-CCA.md = RED` and writes the exact cutover token `frost`. Before any canonical gate decision, complete Duo-core and root integration, then integrate RevenueCat and verify the entitlement-gated pack C on the outer display. Builds, previews, and unit-test fixtures are not proof of a Duo demo or purchase. No privacy guarantee is claimed here.
