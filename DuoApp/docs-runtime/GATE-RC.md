# GATE-RC

Status: BLOCKED. Updated 2026-09-26 during repository reconciliation.

This record replaces earlier PASS labels that described source wiring without observed transactions. The implementation uses the existing `pro` entitlement and RevenueCat/RevenueCatUI 5.91.0. The public Test Store key is configured only in Debug; Release intentionally leaves purchases unavailable.

| Test | Status | Evidence and remaining requirement |
| --- | --- | --- |
| TC-R01 | Implemented; runtime recheck required | Guarded Debug configuration exists. Final build evidence is in the reconciliation receipt. |
| TC-R02 | NOT RUN on final build | Inner RevenueCatUI paywall exists. The last Duo run was closed, where the Pro CTA is disabled. |
| TC-R03 | BLOCKED | Monthly, Yearly and Lifetime each returned a missing-package error in the recorded Bitrig run. No transaction sheet or successful purchase was observed. |
| TC-R04 | NOT RUN | No purchase-driven Pro guide on the other display has been observed. |
| TC-R05 | NOT RUN | Source handles cancellation/errors, but cancel and failure inside an actual Test Store transaction have not been observed. |
| TC-R06 | PASS, source and logic scope | Unlock checks only the existing `pro` entitlement. |
| TC-R07 | PASS, package scope | Package.resolved pins purchases-ios-spm 5.91.0, above the plan minimum. |
| TC-R08 | NOT RUN | The free/paid statement still needs a successful observed demo. |
| Restore | Partial historical response | `No active pro entitlement was found.` Successful restoration and outer unlock remain untested. |
| Customer Center | Implemented; NOT RUN | The view is guarded when Purchases is unconfigured. Live management and restore remain unverified. |

The operator's final installed app was `28717dc`; this receipt does not transfer its observations to later source. No dashboard, package or product identifier was changed during cleanup. Inspect the current offering to determine why its packages do not match the requested identifiers before attempting another purchase.

See [current completion board](../../docs/project-status.md), [integration history](INTEGRATION-CANDIDATE.md), and [reconciliation checks](../../docs/repository-cleanup-20260926.md). Simulation, a build, or a unit test does not establish a Test Store transaction or cross-display unlock.
