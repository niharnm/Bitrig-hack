# Demo last pass

**State: Pending.** The demo script is planned and unrehearsed. No live feature or demo acceptance test is claimed as passed. Record each result only after observing it on the required target.

**Current evidence:** Xcode 27.1 build 27A9269 and iOS SDK 27.1 are installed. The registered iOS 27.1 runtime is build 24A94401. Duo simulator `AF299D52-1471-4F63-9B56-877C15E9C8A4` is Booted, and the placeholder launch is visually verified on display 1. Timed launch and fold proof remain absent. Debug SDK 27.1 build passed. The final integrated nine unit tests passed on ordinary iPhone 17 Pro / iOS 27.0; these are not Duo proof, and test fixtures do not prove a configured or successful RevenueCat purchase. The final integrated Release build passed on the Duo simulator destination. The root now hosts the initial capture shell and CameraCaptureAccessory tip handoff. The camera preview and shutter remain unwired to a capture session. DesignSystem, shared types, and isolated Frost standby views exist. Duo-core and the initial CaptureAccessory handoffs are merged; complete Capture/CCA and RevenueCat handoffs are still needed. No cutover decision or RC behavior exists.

## Canonical acceptance coverage

- **Shell:** TC-S01 BLOCKED pending timed Duo launch; TC-S02 BLOCKED pending fold proof; TC-S03 BLOCKED pending Duo-core implementation review; TC-S04 NOT RUN pending live cutover-reader verification; TC-S05 NOT RUN; TC-S06 NOT RUN.
- **RevenueCat:** TC-R01 BLOCKED pending human RC IDs and configuration; TC-R02 BLOCKED; TC-R03 BLOCKED; TC-R04 BLOCKED; TC-R05 BLOCKED; TC-R06 BLOCKED; TC-R07 BLOCKED; TC-R08 BLOCKED. The SDK reference and unit-test fixtures do not establish a purchase path.
- **Outer Lens primary:** TC-C01 BLOCKED; TC-C02 BLOCKED; TC-C03 BLOCKED; TC-C04 BLOCKED; TC-C05 BLOCKED; TC-C06 BLOCKED; TC-C07 BLOCKED; TC-C08 BLOCKED; TC-C09 BLOCKED; TC-C10 BLOCKED; TC-C11 BLOCKED; TC-C12 BLOCKED. The accessory host and static tip are present; complete capture behavior and live accessory acceptance remain unverified.
- **FrostDuo cutover:** TC-F01 NOT RUN; TC-F02 NOT RUN; TC-F03 BLOCKED pending Duo simulator integration; TC-F04 BLOCKED pending RC and entitlement integration; TC-F05 NOT RUN; TC-F06 NOT RUN; TC-F07 NOT RUN; TC-F08 NOT RUN; TC-F09 NOT RUN. Frost is isolated standby and cutover has not been selected. Do not mark these N/A until Orchestrator confirms Outer Lens mode.
- **Demo / rehearsal:** TC-D01 BLOCKED; TC-D02 BLOCKED; TC-D03 NOT RUN; TC-D04 NOT RUN; TC-D05 NOT RUN; TC-D06 NOT RUN; TC-D07 NOT RUN. `DEMO-SCRIPT.md` is planned and unrehearsed; rehearsal times are not measured.
- **Integration:** TC-I01 BLOCKED pending Debug and Release checks on the integrate branch and Duo simulator; TC-I02 NOT RUN; TC-I03 NOT RUN; TC-I04 BLOCKED pending lane gate artifacts; TC-I05 NOT RUN; TC-I06 NOT RUN.
- **Pitch / brand:** TC-P01 NOT RUN; TC-P02 NOT RUN; TC-P03 NOT RUN; TC-P04 NOT RUN; TC-P05 NOT RUN; TC-P06 NOT RUN.

## Downstream handoff

Cursor integration has consumed Duo-core and the initial accessory host. Complete Capture/CCA and RevenueCat handoffs are still required for the final demo path. The Frost slice remains standby. Orchestrator owns cutover selection and gate decisions. No waiver or product behavior is inferred from builds, unit tests, previews, or source presence.

Duo XCTest failed before connecting, with signal kill during bootstrap; no test cases ran in that attempt. Its cause remains unresolved. The integrated capture shell was visually observed in `/tmp/outer-lens-integrated-duo-inner.png`, with the accessory-unavailable banner and an unwired shutter. This is launch evidence only.
