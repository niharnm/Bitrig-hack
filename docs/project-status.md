# Outer Lens completion board

For Nihar. Snapshot: 2026-09-26, 13:29 PDT. This is a coordination snapshot, not a live acceptance gate. Refresh refs and dirty state before acting.

## Active finish sprint, 13:32 to 13:47 PDT

Nihar requested a 15-minute finish attempt. Primary scope is Outer Lens on iPhone Duo. Frost and optional polish remain parked.

- At 13:35, the corrected `pro` source was committed as `6bed301`. The integrator combined it with capture result handling and the Release safeguards in isolated candidate `1990631`, branch `integrate/outer-lens-combined-20260926`, at `/tmp/outer-lens-main-review-20260926`.
- Candidate `1990631` also adds camera authorization refresh when the app becomes active. Builds, regression checks and independent source review are in progress. These changes are not yet accepted runtime behavior.
- Bitrig remains the preview owner. Its worker distinguished the visible Bitrig simulator container from a separate CoreSimulator device, verified the installed capture-failure resource, and is testing the current capture build. The combined candidate still needs installation and runtime checks in that same preview.
- Finish target: one checked candidate and an observed primary demo path. Remaining live blockers must be stated at 13:47; the deadline does not turn unrun checks into passes.

### 13:45 delivery checkpoint

- [Draft PR #13](https://github.com/niharnm/Bitrig-hack/pull/13) contains the combined candidate. Tested code is `28717dc`; subsequent commits update its receipt only. It is open and unmerged.
- Final Debug test-target build and Release build passed. Eight focused macOS tests using extracted application sources passed; these are not iOS UI or RevenueCat transaction tests. The fresh Release executable excludes the supplied Test Store key. Source review's Customer Center crash finding was fixed and rechecked.
- Frozen app: `/tmp/outer-lens-candidates/28717dc/DuoApp.app`. Full receipt: `/tmp/outer-lens-main-review-20260926/DuoApp/docs-runtime/INTEGRATION-CANDIDATE.md`.
- Bitrig installed the preceding `bcd6d97` candidate and verified both installed executable hashes. Closed-pose launch and three shutter taps were observed without a crash. The simulator has no live camera feed. Final `28717dc` differs only by removal of a key-prefix log; exact final-artifact installation is still being checked.
- **Confirmed transaction blocker:** Settings > Monthly, with Simulate Pro off, showed `Package monthly is not in the current offering.` No Test Store purchase sheet appeared. This does not prove whether the cause is offering configuration or identifier mapping. Do not invent replacement identifiers or treat simulation as a purchase.
- Flat/book/tabletop and other-display purchase behavior remain blocked by disabled Fold controls. The idle demo-plan preview window was closed to remove contention; its saved conversation and files remain.
- Gates 1 and scoped build/regression checks are delivered. The full live demo, transaction acceptance, visual pass and timed rehearsal remain incomplete. The code handoff is ready; the product is not yet demo-ready.

### 13:47 cutoff

- The 15-minute target did not achieve full demo readiness. Monthly, Yearly and Lifetime each returned a missing-package error. Restore returned `No active pro entitlement was found`. No Test Store purchase or purchase-driven Pro state was observed.
- Keep the known passing frozen `28717dc` app. PR #13 later incorporated a concurrent main countdown change at `5b14d9d`, followed by receipt-only `bc61f29`. An incremental build overlapped an attempted merge and reported a source conflict marker. Current source is clean and contains no marker, but this later PR source has not earned a new build pass in this audit. The earlier passing build must not be attributed to the later head.
- Integration was instructed to stop taking new main changes, settle the current operation, and record checks by exact revision. The draft remains unmerged. Next work is exact-head revalidation, actual offering/package diagnosis, and reliable open-pose Duo testing, followed by rehearsal.

The sections below preserve the earlier audit snapshot. This sprint update supersedes the earlier uncommitted `pro` and missing permission-refresh implementation status.

## Direction and scope

Outer Lens remains the primary product. Finish its capture, subject-screen, and real RevenueCat free-to-Pro path on iPhone Duo. FrostDuo stays a fallback until Nihar explicitly selects cutover. It is not a second product to finish in parallel.

Use the existing `pro` entitlement and existing offering packages `lifetime`, `yearly`, and `monthly`. The current owner is removing `photon_pro`. Runtime acceptance uses Bitrig and iPhone Duo only. Photo persistence is optional under `docs/bible/11-outer-lens-product.md`; do not add a Photos-library requirement to the completion checklist.

## Verified source snapshot

| Source | Revision | Meaning |
| --- | --- | --- |
| Fetched `origin/main` | `6d559c4` | Contains `2b321c1`, the Release key-retention and bootstrap-logging fix, plus its recorded verification. |
| Shared checkout, `cursor/revenuecat-photon-4c5a` | `c0e2fa9` | Includes subscriber settings from `975b694`; differs from main by two exclusive commits versus three on main. |
| Active shared edits | Uncommitted | `pro`-only correction in monetization/tests/docs, plus existing localization and QA/planning work. Preserve all of it. |
| Clean capture worktree, `sat/capture-result` | `9ec83f9` | Based on `6d559c4`; adds capture result handling, shutter flash, failure feedback, and two tests. Not yet on main or the shared branch at this snapshot. |

PR #11 merged into `docs/bitrig-routing`, not `main`. PR #9 is closed. A merged PR label therefore does not establish that the subscriber work is integrated into main.

`PurchasesConfig.swift` and `RCIdentifiers.swift` conflict between main and the subscriber branch. Integrating the subscriber versions wholesale would lose the Release safeguards. Preserve main's guarded key handling and key-free bootstrap logging while retaining the corrected `pro` entitlement and subscriber controls.

## Ownership and current activity

| Owner or task | Status | Next deliverable and boundary |
| --- | --- | --- |
| Cursor RevenueCat task | Active at UI inspection | Finish its current `pro`-only correction; provide a scoped commit and checks. Owns the current dirty RevenueCat edit. No duplicate writer. |
| Existing capture task, `Camera capture/accessory photo handling` | Capture commit ready; Bitrig validation active | Validate `9ec83f9` through Bitrig on Duo. Address permission refresh after returning from Settings. Its existing branch owns capture changes. |
| Existing Duo-core task, `Job in repo` | Boot/install activity observed | Coordinate any further simulator work with the active Bitrig capture review. Its earlier shell/permission observations are historical, not final combined-build acceptance. |
| Bitrig capture review on `sat/capture-result` | Active | Sole current preview operator. UI showed clean `9ec83f9`, iPhone Duo selected, and build in progress. Record actual launch, fold, shutter and accessory results. |
| `Control Bitrig with computer use` | Waiting | Confirmed it will wait for a stable integrated revision and simulator handoff before another QA run. No competing build or preview control. |
| `Coordinate Cursor model updates` | Clean integration checkout prepared; waiting on RC commit | Branch `integrate/outer-lens-combined-20260926` starts at `6d559c4` in `/tmp/outer-lens-main-review-20260926`. No combined code or draft PR yet. Reconcile corrected subscriber and capture commits there; current request does not authorize a merge. |
| `Keep chats updated` | Monitor active | Safe fetch/pull checks every 10 minutes. Meaningful changes go to the single integration coordinator. No broadcast acknowledgment loops. |
| This completion board | Snapshot complete | Update from new evidence, not from source-only readiness claims. App code was not changed for this audit. |

The existing QA heartbeat is paused. The Git heartbeat was narrowed to skip pulls when the checkout is dirty or an active writer owns it. No branch switching, stashing, reset, automatic merge, or simulator control belongs in the sync lane.

## Per-mode progress

| Mode or area | Implemented or historically checked | Still required |
| --- | --- | --- |
| Outer Lens | Shell, pose routing, camera preview/session, permission screens, tips, Pro guide, simulation labels, paywall and subscriber settings. Historical Duo app frames exist. Capture-result handling is ready on its branch. | One integrated revision; current Duo launch and app layouts; capture/accessory behavior; permission recovery; real purchase-driven outer guide; visual checks and rehearsal. |
| FrostDuo fallback | Frost views, manual threat simulation, free decoys and Pro pack C are present; root slots are wired. | Open-pose outer decoy hosting, threat-to-frost observation, purchase-driven outer pack C, exact cutover-token agreement, and fallback rehearsal. Leave parked unless selected. |
| RevenueCat shared behavior | Configuration, offering load, entitlement observation, PaywallView, purchase/restore and Customer Center code exist. Release safeguards were independently checked by the existing coordinator at `2b321c1`. | Commit the `pro` correction; reconcile configuration; rerun checks on combined code; observe real Test Store purchase, cancel/fail, restore and other-display unlock. |
| Visuals and demo | Copy, motion/tokens, script, QA report and ordered shot plan exist. | Current fold-pose app screenshots, Dynamic Type, Reduce Motion, readability, actual transaction sequence, two timed rehearsals and freeze. |

Frost's open-pose root currently renders the sensitive surface and controls; the decoy is hosted only for closed pose. `Shared/CutoverFlag.swift` also accepts `true` and `frostDuo` while the canonical contract requires exact `frost`. These are fallback-specific gaps, not reasons to expand the primary build now.

## Six remaining primary completion gates

All six gates remain open. This measures final acceptance, not the percentage of code written.

1. **Integrated candidate:** land the owner's committed `pro` correction and `9ec83f9` into one reviewable branch from current main; resolve the two RC conflicts without losing Release safeguards. Record a clean revision. Owner: integration coordinator, consuming feature-owner commits.
2. **Build and regression evidence:** run Debug/Release builds and relevant tests on that exact candidate; repeat the fresh Release binary key check. Earlier successful builds apply only to their own revisions. Owner: integration coordinator. Do not compete for the active Duo simulator.
3. **Duo capture and shell:** launch reliably through Bitrig; verify flat, book, tabletop and required closed behavior, subject-screen accessory or honest unavailable state, shutter success/failure where supported, and permission recovery. Owner: capture task with the single Bitrig preview operator.
4. **Real monetization:** current offering, inner paywall, Test Store purchase, cancellation/failure, restore, Customer Center and purchase-driven `pro` on the other display. Simulate Pro is not transaction evidence. Owner: RevenueCat task with the same preview operator.
5. **Visual acceptance:** check clipping, text size, contrast, Dynamic Type, Reduce Motion, countdown and guide behavior on the integrated revision. ASSETS changes require an explicit path handoff. Owner: Bitrig QA.
6. **Demo closure:** correct gate records, capture the ordered demo evidence, run two timed rehearsals, record remaining limitations, and let Nihar decide mode/freeze/final acceptance. Owner: Nihar with demo/QA support.

## Evidence that must not be treated as current acceptance

- `DuoApp/docs-runtime/GATE-RC.md` says PASS for purchase and outer unlock but provides implementation descriptions rather than live transaction evidence. Treat those acceptance items as pending until replaced by observations.
- `GATE-FROST.md` still describes missing root and RC wiring that source now includes. Its runtime checks are still incomplete.
- The shared `DEMO-LAST-PASS.md` and `BITRIG-REVIEW.md` contain historical Release key findings. Those were fixed and checked at `2b321c1`, but that fix is absent from the current shared branch. Keep the revision distinction.
- The earlier dirty `CustomerCenterView` constructor failure is resolved in current source. The later successful build does not itself establish current launch or layouts.
- The capture owner reports 19/19 tests passed on Duo. This audit verified the branch and test source, not the result log. The current Bitrig run will supply separate UI evidence.
- No complete, current, integrated Duo free-to-purchase-to-outer-unlock demo was verified in this audit. A readiness percentage or all-green claim would be unsupported.

## References

- [Canonical acceptance tests](bible/15-acceptance-tests.md)
- [Bitrig QA report](../DuoApp/docs-runtime/BITRIG-REVIEW.md)
- [Duo shot plan](../DuoApp/docs-runtime/BITRIG-DEMO-PLAN.md)
- [RevenueCat owner task](tasks/revenuecat-photon.md)
- [Capture result commit](https://github.com/niharnm/Bitrig-hack/commit/9ec83f93505da5c2cf84100faa58d2af9b7883cc)
- [Subscriber PR #11](https://github.com/niharnm/Bitrig-hack/pull/11)
- [Release verification PR #10](https://github.com/niharnm/Bitrig-hack/pull/10)
