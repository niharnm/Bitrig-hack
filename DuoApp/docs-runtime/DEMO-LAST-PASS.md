# Demo last pass

**State: NOT ACCEPTED.** Updated 2026-09-26. Primary mode: Outer Lens. No final demo freeze, waiver, successful purchase or other-display unlock is recorded.

This ledger follows the test inventory in [Bible section 15](../../docs/bible/15-acceptance-tests.md). Source checks and historical simulator observations have limited scope. NOT RUN and BLOCKED keep unfinished requirements explicit; neither is a waiver or a PASS.

| Test | Requirement | Status | Evidence or remaining work |
| --- | --- | --- | --- |
| TC-S01 | Duo launch | NOT RUN | Historical launch of 28717dc; final build not launched in this cleanup. |
| TC-S02 | Pose remapping | BLOCKED | Last preview could not change fold poses. |
| TC-S03 | Hinge effects only | NOT RUN | Observe on the final accepted Duo revision. |
| TC-S04 | Cutover flag | NOT RUN | Observe on the final accepted Duo revision. |
| TC-S05 | Repository layout | NOT RUN | Observe on the final accepted Duo revision. |
| TC-S06 | Single demo capability | NOT RUN | Observe on the final accepted Duo revision. |
| TC-R01 | Debug Test Store configuration | NOT RUN | Observe on the final accepted Duo revision. |
| TC-R02 | Inner paywall | NOT RUN | Observe on the final accepted Duo revision. |
| TC-R03 | Successful purchase | BLOCKED | Historical package lookup errors; no transaction sheet. |
| TC-R04 | Other-display unlock | BLOCKED | No purchase-driven outer guide observed. |
| TC-R05 | Cancel and fail | NOT RUN | Code covers errors; actual Test Store cancel/fail not observed. |
| TC-R06 | pro entitlement | PASS, source scope | Only pro is used by access logic. |
| TC-R07 | RevenueCat package version | PASS, source scope | Pinned purchases-ios-spm 5.91.0. |
| TC-R08 | Free/paid claim on screen | NOT RUN | Observe on the final accepted Duo revision. |
| TC-C01 | Readable outer tip | NOT RUN | Observe on the final accepted Duo revision. |
| TC-C02 | Shutter and preview | NOT RUN | Historical no-camera shutter taps; live capture remains unverified. |
| TC-C03 | Accessory-unavailable recovery | NOT RUN | Observe on the final accepted Duo revision. |
| TC-C04 | Pro guide follows entitlement | NOT RUN | Observe on the final accepted Duo revision. |
| TC-C05 | Denied permission recovery | NOT RUN | Observe on the final accepted Duo revision. |
| TC-C06 | T1 to T3 style cap | NOT RUN | Observe on the final accepted Duo revision. |
| TC-C07 | Countdown | NOT RUN | Observe on the final accepted Duo revision. |
| TC-C08 | Tip and unlock motion | NOT RUN | Observe on the final accepted Duo revision. |
| TC-C09 | Simulation controls | NOT RUN | Observe on the final accepted Duo revision. |
| TC-C10 | Photo-only permission scope | PASS, source scope | No microphone request; photo-only source. |
| TC-C11 | Visible brand | NOT RUN | Observe on the final accepted Duo revision. |
| TC-C12 | No Vision or FM dependency | PASS, source scope | Neither dependency is required by the app. |
| TC-F01 | Threat to frost | N/A | Frost is not selected; this is not a fallback acceptance pass. |
| TC-F02 | Locked outer decoy | N/A | Frost is not selected; this is not a fallback acceptance pass. |
| TC-F03 | Simulate Threat | N/A | Frost is not selected; this is not a fallback acceptance pass. |
| TC-F04 | Pro outer pack C | N/A | Frost is not selected; this is not a fallback acceptance pass. |
| TC-F05 | Optional closed cover | N/A | Frost is not selected; this is not a fallback acceptance pass. |
| TC-F06 | Quiet copy | N/A | Frost is not selected; this is not a fallback acceptance pass. |
| TC-F07 | Frost motion | N/A | Frost is not selected; this is not a fallback acceptance pass. |
| TC-F08 | Inner paywall | N/A | Frost is not selected; this is not a fallback acceptance pass. |
| TC-F09 | Cutover enforcement | N/A | Frost is not selected; this is not a fallback acceptance pass. |
| TC-D01 | Acceptance recorded | NOT RUN | Script exists; no complete timed rehearsal or acceptance waiver is recorded. |
| TC-D02 | Two timed rehearsals | NOT RUN | Script exists; no complete timed rehearsal or acceptance waiver is recorded. |
| TC-D03 | 60-second backup | NOT RUN | Script exists; no complete timed rehearsal or acceptance waiver is recorded. |
| TC-D04 | Recovery lines | NOT RUN | Script exists; no complete timed rehearsal or acceptance waiver is recorded. |
| TC-D05 | Opening line | NOT RUN | Script exists; no complete timed rehearsal or acceptance waiver is recorded. |
| TC-D06 | Who-pays close | NOT RUN | Script exists; no complete timed rehearsal or acceptance waiver is recorded. |
| TC-D07 | One demo feature | NOT RUN | Script exists; no complete timed rehearsal or acceptance waiver is recorded. |
| TC-I01 | Debug and Release compilation | PENDING CHECK | See reconciliation receipt for final compile results. |
| TC-I02 | Shared types | PASS, source scope | Shared contracts in Shared/Types.swift. |
| TC-I03 | Integration history | RECORDED | Cleanup reconciles the superseded PR #13 with main changes through PR #18. |
| TC-I04 | Gate artifacts | PASS, source scope | Canonical shell, capture, RC and demo files exist. |
| TC-I05 | Package scope | PASS, source scope | Project package graph contains purchases-ios-spm. |
| TC-I06 | Final freeze | NOT RUN | Repository merge does not select a demo freeze or waive failed gates. |
| TC-P01 | Outer Lens opening | NOT RUN | Copy or tokens exist; delivery and visible result need final acceptance. |
| TC-P02 | Frost opening | N/A | Frost is not selected; this is not a fallback acceptance pass. |
| TC-P03 | Free/paid sentence | NOT RUN | Copy or tokens exist; delivery and visible result need final acceptance. |
| TC-P04 | Pitch vocabulary | NOT RUN | Copy or tokens exist; delivery and visible result need final acceptance. |
| TC-P05 | Film Tool appearance | NOT RUN | Copy or tokens exist; delivery and visible result need final acceptance. |
| TC-P06 | Frost appearance | N/A | Frost is not selected; this is not a fallback acceptance pass. |

## Required rehearsals

| Run | Revision | Duration | Result |
| --- | --- | --- | --- |
| 1 | Not selected | Not measured | NOT RUN |
| 2 | Not selected | Not measured | NOT RUN |

The plan requires two complete runs of at most 100 seconds each. [DEMO-SCRIPT.md](DEMO-SCRIPT.md) remains planned. The black-preview fallback, simulated Pro and no-camera flash must be identified as simulation; none establishes a real photo or transaction.

## Evidence

- [Repository reconciliation and build checks](../../docs/repository-cleanup-20260926.md)
- [Current completion board](../../docs/project-status.md)
- [Shell gate](GATE-SHELL.md), [capture gate](GATE-CCA.md), [RevenueCat gate](GATE-RC.md), [Frost standby gate](GATE-FROST.md)
- [Historical visual QA](BITRIG-REVIEW.md) and [planned shots](BITRIG-DEMO-PLAN.md)
