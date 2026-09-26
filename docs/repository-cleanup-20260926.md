# Repository reconciliation, 2026-09-26

Requested scope: account for completed work, commit loose reports, reconcile useful branches into main, preserve superseded work and check the original plan.

## Inputs

- Former PR #13: subscriber settings, restore, Customer Center, pro-only entitlement checks, permission refresh and Release safeguards. Another collaborator closed it during reconciliation; its useful changes are retained in the new candidate.
- Main updates through PRs #14 to #17: capture polish, shutter countdown ordering and haptic correction, parked coach/FilmStock source, folded paywall and immediate entitlement updates.
- Four previously uncommitted documents: BITRIG-REVIEW, BITRIG-DEMO-PLAN, bitrig-task-plan and project-status. Their original snapshots are committed before status corrections.
- Superseded RevenueCat/Frost work and the separate filter proposal remain historical inputs, not authority to replace the current app or activate optional features.

## Verification in progress

Source `930253f` passed generic simulator Debug test-target and Release compilation. Eight focused macOS logic tests passed against the extracted capture, presenter, shared types and subscription policy source. The UIKit preview and app host were excluded, as was the environment-dependent no-camera test. These results are not iOS UI, camera or RevenueCat transaction evidence.

PR #17 arrived afterward. The final combined revision and its fresh checks will be recorded here before publication.

Logs are local files outside the repository: `/tmp/outer-lens-cleanup-final-debug.log`, `/tmp/outer-lens-cleanup-final-release.log` and `/tmp/outer-lens-cleanup-logic.log`. The project and all native test sources are tracked.

## Acceptance boundary

The [completion board](project-status.md) and [54-row acceptance ledger](../DuoApp/docs-runtime/DEMO-LAST-PASS.md) identify outstanding work. Builds and logic tests do not establish successful purchase, outer-display unlock, fold behavior, accessibility acceptance or two timed rehearsals. No final demo freeze or product PASS is implied by merging this cleanup.
