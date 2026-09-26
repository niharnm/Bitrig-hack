# Outer Lens

An iPhone Duo camera app with an inner capture surface and an outer subject coach. The primary demo is a readable free tip followed by a purchase-driven Pro guide on the other display. FrostDuo remains a parked fallback.

**Status: implementation integrated; demo acceptance incomplete.** The last recorded Test Store run could not find the requested subscription packages. Successful purchase, other-display unlock, complete fold behavior, visual checks and two timed rehearsals are still required.

- [Current completion board](docs/project-status.md)
- [Repository reconciliation and checks](docs/repository-cleanup-20260926.md)
- [Build instructions](DuoApp/README.md)
- [Acceptance ledger](DuoApp/docs-runtime/DEMO-LAST-PASS.md)
- [Original build plan](docs/outer-lens-3h-build-plan.md) and [canonical acceptance tests](docs/bible/15-acceptance-tests.md)
- [Demo script](DuoApp/docs-runtime/DEMO-SCRIPT.md) and [shot plan](DuoApp/docs-runtime/BITRIG-DEMO-PLAN.md)

Open `DuoApp/DuoApp.xcodeproj` with Xcode 27.1. The project includes the test target and pinned RevenueCat package resolution. Test Store configuration is Debug only; Release leaves purchases unavailable. A successful build does not establish a working purchase or Duo demo.
