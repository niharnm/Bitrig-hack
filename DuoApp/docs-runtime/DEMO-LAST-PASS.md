# Demo last pass

**State: Pending.** `DEMO-SCRIPT.md` is planned and unrehearsed. Record acceptance only after observing the required target.

## Current implementation and evidence

Cursor has integrated the Duo-core and Capture/CCA handoffs, root entitlement snapshot, inner-only paywall host, and shared motion consumers. The coach cycles tips and shows the guide oval for actual or explicitly simulated Pro. Simulation labels distinguish rehearsal from purchase evidence. Owner commit `fc65ca8` adds preview and photo-capture wiring; live behavior remains unverified. Frost remains standby; no cutover flag was changed.

`GATE-SCAFFOLD.md` records current build and policy-test results, historical nine-test coverage, and the blocked iOS app-host attempt. `SHELL-READY.md` contains the Duo-core owner's partial shell evidence. `BITRIG-REVIEW.md` contains external visual review limits. These reports do not establish all-pose behavior, live capture, purchases, or other-display unlock.

## Acceptance coverage

| Area | Status and missing evidence |
| --- | --- |
| Shell | PARTIAL. Timed clean launch and all fold poses are unverified. Hinge effects have source review; launch-argument cutover has owner simulator evidence. |
| RevenueCat | BLOCKED. Release key removal/configuration and live purchase, restore, cancellation, and entitlement propagation need owner evidence. The supplied key remains in the Release executable and is logged during DEBUG configuration. |
| Capture/CCA | BLOCKED. Camera session and photo capture are implemented in the owner handoff but unverified live; live accessory behavior and entitlement unlock across displays are unverified. |
| Frost | STANDBY. Views and contracts exist, but cutover and live entitlement integration are not accepted. |
| Demo | NOT RUN. Rehearsal timing and complete free-to-Pro path are unmeasured. |
| Integration | PARTIAL. Current build and logic evidence are recorded separately from failed app-host startup and live acceptance. |
| Pitch / brand | NOT RUN. No pitch or final brand acceptance is claimed. |

## Handoff

Capture owner validates preview and photo capture and resolves the dirty-checkout constructor failure reported by Bitrig QA. RC owner fixes Release key retention and key logging, then provides live purchase/restore evidence. QA records full Duo pose and accessory behavior. Orchestrator owns cutover and canonical gates. Cursor does not infer acceptance from simulation controls, previews, build success, or a lane's readiness claim.
