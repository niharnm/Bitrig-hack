# Outer Lens: iPhone Duo demo shots

Historical record. For the current combined source and acceptance gaps, see [completion board](../../docs/project-status.md) and [reconciliation receipt](../../docs/repository-cleanup-20260926.md).

Plan dated 2026-09-26. Source checkout at writing: branch `cursor/revenuecat-photon-4c5a`, HEAD `c0e2fa9f69e01add2a31213b1c8a260b7d7d031c`. Dirty files: `docs-runtime/BITRIG-REVIEW.md` and `../docs/bitrig-task-plan.md`. The checkout changed during planning from `docs/bitrig-routing` at `975b6947d61b830a13cc1940dfcca0d53fd2c391`; no build or simulator check was run here. Recheck HEAD and dirty state before recording any shot.

## Evidence boundary

- **Verified, historical:** `BITRIG-REVIEW.md` records a successful Duo build at `975b6947`, but the app stayed on the Duo home screen. At clean `bd010b2`, one free capture frame and the `SIMULATED PRO` outer / `Simulated Pro` inner labels were observed. The five Duo shell poses were observed at `4dda7f0` while the app was behind the camera permission prompt. These are separate revisions, not a completed app-pose sequence.
- **Blocked now:** No current Outer Lens launch, app layout in a fold pose, camera capture or saved photo, purchase, purchase-driven Pro state, or timed recording has been verified. The preview owner must restore app launch and supply current-revision evidence.
- **Source only:** `InnerCaptureView` hosts `SubjectCoachView` through `CameraCaptureAccessoryHost`. When the accessory is unavailable, the inner display shows a small subject preview. Settings exposes Simulate tip, Simulate Pro, and Simulate countdown. Source does not prove the accessory appears on Duo or that a photo is saved.

## Shot order

| Order and status | Required Duo pose | Visible result to record | Dependency | Fallback |
| --- | --- | --- | --- | --- |
| 1. Planned, blocked at current launch | Fully Open / flat | Inner capture shell with shutter and one readable free tip on the outer subject stage. Show both displays in one view. | Launch Outer Lens on the recorded revision; grant camera permission; confirm subject accessory availability and tip readability (TC-S01, TC-C01, TC-C02). | If the accessory does not appear, show the inner subject preview and use **Simulate tip** only after confirming that control works. Say it is simulated; do not call it an outer-display pass. |
| 2. Planned, blocked | Seated / tabletop | Capture and tip remain legible, controls remain reachable, with the fold visible. | Shot 1 works; preview owner confirms actual app layout in this pose (TC-S02). | Return to flat and record that tabletop app layout was blocked. Device geometry alone is insufficient. |
| 3. Planned, blocked | Partially Open / book | Both display roles remain clear as the fold changes. | Shot 1 works; preview owner confirms actual app layout and accessory presentation in book pose (TC-S02). | Return to flat and omit the fold transition if the app disappears or clips. Record the failure. |
| 4. Simulated option, blocked at current launch | Fully Open / flat | Settings > Simulate Pro, then show the amber guide and explicit `SIMULATED PRO` outer / `Simulated Pro` inner labels. | App launches; Simulate Pro control and both labels are rechecked on the recording revision (TC-C09). Historical label evidence is from `bd010b2` only. | If simulation fails, omit this shot. A real purchase and purchase-driven outer Pro state need separate TC-R03, TC-R04, and TC-C04 evidence before they can be described as such. |
| 5. Optional, planned, blocked | Closed | Show only a verified Outer Lens continuation if one actually appears. | Preview owner confirms Outer Lens remains visible after closing on the recording revision. Current source has no separate Outer Lens closed-stage route. | End on the verified flat view. Do not substitute the Duo home screen or FrostDuo closed stage. |

## Recording limits

Pre-grant camera permission for the main sequence. If permission is denied, `CaptureDeniedView` offers Open Settings, but the capture shell, subject stage, and Simulate controls are not shown in that state. Record the denied path separately only if it is observed; it cannot stand in for shots 1 through 4. A simulator black preview or no-camera banner is an honest device limitation, not capture proof. Do not claim a saved photo, live camera feed, purchase, entitlement, or pose acceptance without new evidence. Save any screenshots or video outside the repository with the source revision and pose; recording availability remains unconfirmed.
