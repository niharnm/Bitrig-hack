# Demo last pass

**State: Pending.** The demo script is planned and unrehearsed. No live feature or demo acceptance test is claimed as passed. Record each result only after observing it on the required target.

**Current evidence:** Xcode 27.1 build 27A9269 and iOS SDK 27.1 are installed. The registered iOS 27.1 runtime is build 24A94401. Duo simulator `AF299D52-1471-4F63-9B56-877C15E9C8A4` is booting; no Duo launch or fold proof exists. Debug SDK 27.1 build passed. Nine unit tests passed on ordinary iPhone 17 Pro / iOS 27.0; these are not Duo proof, and test fixtures do not prove a configured or successful RevenueCat purchase. Release is still running. The app root remains a placeholder. DesignSystem, shared types, and isolated Frost standby views exist. Duo-core, Capture/CCA, and RevenueCat handoffs are missing. No cutover decision or RC behavior exists.

## Canonical acceptance coverage

- **Shell:** TC-S01 BLOCKED pending Duo launch; TC-S02 BLOCKED pending Duo-core and fold proof; TC-S03 BLOCKED pending Duo-core implementation review; TC-S04 BLOCKED pending root cutover integration; TC-S05 NOT RUN; TC-S06 NOT RUN.
- **RevenueCat:** TC-R01 BLOCKED pending human RC IDs and configuration; TC-R02 BLOCKED; TC-R03 BLOCKED; TC-R04 BLOCKED; TC-R05 BLOCKED; TC-R06 BLOCKED; TC-R07 BLOCKED; TC-R08 BLOCKED. The SDK reference and unit-test fixtures do not establish a purchase path.
- **Outer Lens primary:** TC-C01 BLOCKED; TC-C02 BLOCKED; TC-C03 BLOCKED; TC-C04 BLOCKED; TC-C05 BLOCKED; TC-C06 BLOCKED; TC-C07 BLOCKED; TC-C08 BLOCKED; TC-C09 BLOCKED; TC-C10 BLOCKED; TC-C11 BLOCKED; TC-C12 BLOCKED. Capture and CameraCaptureAccessory are not implemented.
- **FrostDuo cutover:** TC-F01 NOT RUN; TC-F02 NOT RUN; TC-F03 BLOCKED pending Duo simulator integration; TC-F04 BLOCKED pending RC and entitlement integration; TC-F05 NOT RUN; TC-F06 NOT RUN; TC-F07 NOT RUN; TC-F08 NOT RUN; TC-F09 NOT RUN. Frost is isolated standby and cutover has not been selected. Do not mark these N/A until Orchestrator confirms Outer Lens mode.
- **Demo / rehearsal:** TC-D01 BLOCKED; TC-D02 BLOCKED; TC-D03 NOT RUN; TC-D04 NOT RUN; TC-D05 NOT RUN; TC-D06 NOT RUN; TC-D07 NOT RUN. `DEMO-SCRIPT.md` is planned and unrehearsed; rehearsal times are not measured.
- **Integration:** TC-I01 BLOCKED pending Debug and Release checks on the integrate branch and Duo simulator; TC-I02 NOT RUN; TC-I03 NOT RUN; TC-I04 BLOCKED pending lane gate artifacts; TC-I05 NOT RUN; TC-I06 NOT RUN.
- **Pitch / brand:** TC-P01 NOT RUN; TC-P02 NOT RUN; TC-P03 NOT RUN; TC-P04 NOT RUN; TC-P05 NOT RUN; TC-P06 NOT RUN.

## Downstream handoff

Cursor integration remains pending Duo-core, Capture/CCA, and RevenueCat handoffs. The Frost slice remains standby. Orchestrator owns cutover selection and gate decisions. No waiver or product behavior is inferred from builds, unit tests, previews, or source presence.
