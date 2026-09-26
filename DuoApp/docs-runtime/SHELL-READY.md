# SHELL-READY

time: 12:20 Sat Sep 26
pose_chrome: partial (closed verified on the Duo sim; open, flat, book, and tabletop not yet observed)
hinge_effects_only: pass (code review)
cca_host_hook: slot-named
cutover_flag_readable: y

## Environment

- Xcode 27.1, build 27A9269, at /Applications/Xcode-27.1-beta.app. `xcode-select` still points at Xcode 27.0, so builds set `DEVELOPER_DIR=/Applications/Xcode-27.1-beta.app/Contents/Developer`.
- iOS 27.1 simulator runtime 24A94401. Device: iPhone Duo, AF299D52-1471-4F63-9B56-877C15E9C8A4, booted in the closed pose.
- Revision: Duo-core and CCA slice on `main` at 226a8b1.

## Evidence

| TC | Result | Evidence |
|----|--------|----------|
| TC-S01 | PASS-SIM | Debug build installed and launched on the iPhone Duo sim; first frame shows the Outer Lens capture shell on the outer display (`simctl io --display=1` screenshot). |
| TC-S02 | PARTIAL | PoseRouter reported `closed` on the outer display. Fold changes need Device Hub; open, book, and tabletop are NOT RUN. |
| TC-S03 | PASS (review) | `onHingeChange` appears only in `Duo/PoseRouter.swift`. It sets `hingeStatus` and `effectAngle`; no view reads either for frames, offsets, or arrangement style. |
| TC-S04 | PASS-SIM | Launch argument `-cutover frost` swapped the root to FrostDuo and showed the outer decoy slot; no argument showed Outer Lens. The file path `docs-runtime/CUTOVER.flag` uses the same parser and was not written by this lane. |

## What Duo-core provides

- `Shared/CutoverFlag.swift`: `CutoverFlag.current`, `isFrost`, and `\.cutoverFlag` in the environment. Sources in order: `-cutover` launch argument, then `docs-runtime/CUTOVER.flag` from the host checkout on Debug simulator builds, then a bundled `CUTOVER.flag` if one is added. `frost`, `true`, and `frostDuo` select frost; anything else is Outer Lens. Relaunch after the flag changes.
- `Duo/PoseRouter.swift`: `@Observable PoseRouter` in the environment with `mode: PoseMode`, `hingeStatus`, and `effectAngle` (effects only, nil unless partially open). `HingeStatusKind` lives here; the Integrator may move it to `Shared/Types.swift`.
- `Duo/ArrangementRegions.swift`: `RegionHints` (active and inactive division frames, occlusion frames, crease orientation) and `publishRegions(to:)`.
- `App/RootArrangementView.swift`: NavigationStack root, named slots, inner-only paywall sheet, and Frost `ArrangementView` split.

## Slots for other lanes

| Slot | Current content | Owner who swaps it |
|------|-----------------|--------------------|
| `outerLensPrimarySlot` | `InnerCaptureView()` (CCA host attached inside) | CCA |
| `paywallSlot` | placeholder | RC supplies `PaywallHostView`; features open it with `@Environment(\.presentPaywall)` |
| `frostPrimarySlot` / `frostSecondarySlot` / `frostOuterDecoySlot` | placeholders | FROST supplies views; Integrator swaps them in |

## Notes for the Integrator

- `Shared/Types.swift` on `main` carries only `CutoverFlag` and `PoseMode` from §07.2. Replace it with the full §07 file; both shapes match it exactly.
- Crease orientation follows §08.10: a wide division rect is a horizontal crease (tabletop), a tall one is vertical (book). The §08.15D pseudocode has these inverted.
- `App/DuoAppApp.swift` is unchanged.

## Next action

Unfold the Duo sim in Device Hub (Xcode 27.1) and check flat, book, and tabletop, plus whether `onAvailabilityChange` reports the camera accessory available on the sim.
