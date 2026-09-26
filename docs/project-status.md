# Outer Lens completion board

Updated 2026-09-26 for the repository reconciliation requested by Nihar. This replaces the earlier coordination snapshot; its full contents remain in Git history. See [reconciliation receipt](repository-cleanup-20260926.md) for exact inputs and checks.

## Completion decision

The plan is **not complete**. The primary implementation is combined, but its required live purchase, other-display result, visual acceptance and two timed rehearsals have not passed. No readiness percentage or product PASS is claimed.

| Completion gate | Current state | Remaining work |
| --- | --- | --- |
| Combined implementation | Reconciled in the cleanup candidate, including newer main changes | Publish the verified reconciliation and confirm clean main |
| Build and regression | See the revision-specific reconciliation receipt | Build results do not count as live acceptance |
| Duo capture and shell | Partial historical observations | Current launch, flat/book/tabletop layouts, accessory or labeled fallback, permission recovery and capture behavior |
| Real monetization | Blocked by observed package lookup failures | Verify the current offering, then purchase, cancel/fail, restore, Customer Center and purchase-driven outer guide |
| Visual acceptance | Pending | Clipping, text size, contrast, Dynamic Type, Reduce Motion, countdown and guide behavior on one accepted revision |
| Demo closure | Pending | Record each acceptance result, two timed full rehearsals and the final freeze decision |

## What is present

- Shared contracts, pose routing, root slots, permission primer and denied recovery, camera preview/session, shutter result handling and failure feedback.
- Countdown before capture, disabled shutter during countdown, loading/retry feedback, camera permission refresh on return from Settings and protection against a late startup result.
- Subject accessory host, free tips, Pro guide, explicit simulation labels, copy, motion and design tokens.
- `pro` entitlement observation, inner paywall, purchase and restore actions, subscriber settings and guarded Customer Center. Debug key configuration and Release key exclusion are preserved.
- The QA report, demo shot plan, shell/capture/RevenueCat/Frost gate records, demo script and acceptance ledger are committed.

## Latest recorded runtime evidence

The existing Bitrig operator reported the final `28717dc` app installed and launched on iPhone Duo with a matching installed Debug dylib hash. Closed-state shutter taps kept the app responsive. Fold controls were inaccessible, so flat, book, tabletop, open-pose paywall and outer accessory behavior were not accepted.

With Simulate Pro off, Monthly, Yearly and Lifetime each returned `Package [name] is not in the current offering.` Restore returned `No active pro entitlement was found.` No successful transaction or purchase-driven unlock was observed. These are historical observations on the earlier binary, not runtime checks of the reconciliation build.

The no-camera flash in the newer capture source is simulation feedback. It can increment `capturedPhotoCount` without taking a photo. Neither this counter nor Simulate Pro proves the real operation.

## Scope and next steps

1. Inspect the actual current RevenueCat offering and compare package identifiers with the application. Do not guess identifiers or substitute a product ID for a package ID.
2. Use one Bitrig iPhone Duo operator to verify the final merged revision, including permission recovery, poses, accessory behavior and the purchase path.
3. Complete the [acceptance ledger](../DuoApp/docs-runtime/DEMO-LAST-PASS.md), visual checks and two timed rehearsals.

Photo saving is optional and remains absent. FilmStock, extra tip packs and KidMagnet are outside the primary demo requirements, even where their parked source is merged. Frost remains STANDBY, with open-pose decoy hosting and exact cutover-token handling still incomplete. Do not expand or activate the fallback as part of repository cleanup.

Historical lane reports retain their revision boundaries. [GATE-RC](../DuoApp/docs-runtime/GATE-RC.md) supersedes its earlier source-only PASS claims. [GATE-SHELL](../DuoApp/docs-runtime/GATE-SHELL.md) provides the canonical shell gate name and links its historical evidence.
