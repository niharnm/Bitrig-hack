# Demo last pass

**State:** Pending. No live app feature or demo acceptance test has been run. Keep each row `NOT RUN` or `BLOCKED` until observed and recorded by QA or its owner. No PASS, PASS-SIM, WAIVE, or N/A is claimed here.

**Environment / prerequisites:** The Cursor scaffold Debug build and ordinary iPhone 17 Pro launch passed; the placeholder was visually verified. These are smoke checks, not canonical Duo acceptance. The available setup is Xcode 27.0 build 27A5209h with an iOS 27.0 runtime; no Duo simulator is available. The app has no implemented features. TC-S01 needs a bootable Duo simulator and launchable target. TC-S02 through TC-S04 need the Duo pose/root/cutover implementation. Feature, purchase, pitch, and rehearsal checks need their corresponding merged app paths and live observation. TC-R01 also needs human-supplied `RC-IDs.md` values; do not invent keys or offering IDs. Confirm `CUTOVER.flag` mode with Orchestrator before selecting Outer Lens or Frost rows. Frost is cutover-only; mark its rows N/A only after Outer Lens is confirmed active.

## Canonical acceptance coverage

- **Shell:** TC-S01 BLOCKED; TC-S02 BLOCKED; TC-S03 BLOCKED; TC-S04 BLOCKED; TC-S05 NOT RUN; TC-S06 NOT RUN.
- **RevenueCat:** TC-R01 BLOCKED; TC-R02 BLOCKED; TC-R03 BLOCKED; TC-R04 BLOCKED; TC-R05 BLOCKED; TC-R06 BLOCKED; TC-R07 BLOCKED; TC-R08 BLOCKED.
- **Outer Lens primary:** TC-C01 BLOCKED; TC-C02 BLOCKED; TC-C03 BLOCKED; TC-C04 BLOCKED; TC-C05 BLOCKED; TC-C06 BLOCKED; TC-C07 BLOCKED; TC-C08 BLOCKED; TC-C09 BLOCKED; TC-C10 BLOCKED; TC-C11 BLOCKED; TC-C12 BLOCKED.
- **FrostDuo cutover:** TC-F01 NOT RUN; TC-F02 NOT RUN; TC-F03 NOT RUN; TC-F04 NOT RUN; TC-F05 NOT RUN; TC-F06 NOT RUN; TC-F07 NOT RUN; TC-F08 NOT RUN; TC-F09 NOT RUN. Mode is unconfirmed, so these are not yet N/A.
- **Demo / rehearsal:** TC-D01 BLOCKED; TC-D02 BLOCKED; TC-D03 NOT RUN; TC-D04 NOT RUN; TC-D05 NOT RUN; TC-D06 NOT RUN; TC-D07 NOT RUN. TC-D01 awaits the required live suite evidence or explicit written waivers. TC-D02 needs two timed rehearsals of the active 90-second script.
- **Integration:** TC-I01 BLOCKED; TC-I02 BLOCKED; TC-I03 NOT RUN; TC-I04 BLOCKED; TC-I05 NOT RUN; TC-I06 NOT RUN. TC-I01 needs Debug and Release builds on the integrate branch; TC-I04 needs the lane gate artifacts.
- **Pitch / brand:** TC-P01 NOT RUN; TC-P02 NOT RUN; TC-P03 NOT RUN; TC-P04 NOT RUN; TC-P05 NOT RUN; TC-P06 NOT RUN. Check the active mode and spoken/UI content during QA.

## Downstream handoff

Cursor INTEGRATOR work remains pending: receive named lane patches, merge in the prescribed order, wire `EntitlementState.isPro` to the other pane, and produce integration gate evidence. Cursor LANE-ASSETS late polish remains pending after feature inputs and freeze. These handoffs are not completed by this checklist. Orchestrator owns mode selection, gate decisions, and any waiver; QA records evidence and does not infer passes from scaffold or build availability.
