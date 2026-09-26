# Outer Lens demo script

**Status: PLANNED, NOT REHEARSED.** No Duo simulator is available, and the scaffold has no implemented capture, accessory, pose layout, purchases, or paywall behavior. The steps and outcomes below are unverified. Use this for rehearsal only after the prerequisites pass. Until then, use for internal readthrough only.

**Live-run prerequisites:** Confirm Outer Lens is the active mode with Orchestrator. Pass TC-S01; TC-C01 for the outer tip; TC-C02 if showing capture or flip; TC-R02, TC-R03, and TC-R04 for the paywall, successful Test Store purchase, and purchase-driven outer unlock. Pass TC-C09 before using any Simulate control. Grant camera permission or verify the permission primer. Simulate tip or Simulate Pro shows a simulated state only. Do not claim working device accessory behavior, a completed purchase, wired Test Store behavior, or a purchase-driven unlock until the relevant gate evidence exists. If a live-run prerequisite is missing, do not present this as a product demo.

## Planned 90-second path

| Time | Beat | Action and spoken copy |
|---|---|---|
| 0:00-0:03 | Open | Hold Duo so crease and both panes are visible. Pause briefly, then start Brad. |
| 0:03-0:10 | Brad | Speak the frozen line: “Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.” |
| 0:10-0:15 | Climax setup | Optional: “Watch the outer.” Ensure Subject is on if shown; unfold if closed. |
| 0:15-0:30 | Climax | Show T1: “Chin up · eyes to the lens.” Prefer silence while it is readable. |
| 0:30-0:40 | Hold | Keep the tip visible. Optional: “That’s the subject coach.” |
| 0:40-0:48 | Flip proof | Tap Flip once. Optional: “Flip keeps the coach.” |
| 0:48-0:55 | Countdown | Optional: use Simulate countdown. Optional: “One count.” Skip if late. |
| 0:55-1:02 | Pro CTA | Tap Pro coaching and start Matt’s frozen line: “Free: outer preview. Pro: pose overlays on the outer display.” |
| 1:02-1:12 | Paywall | Complete the actual RevenueCatUI Test Store flow with Successful Purchase. Finish Matt’s line while the sheet is up. |
| 1:12-1:20 | Unlock proof | Show purchase-driven T2 amber oval on the outer. Optional: “Pro on the outer.” |
| 1:20-1:30 | Close | Speak the frozen close: “Parents pay for the overlays that make the kid look good without turning the phone around. That’s Outer Lens.” Stop. |

## Planned 60-second backup

| Time | Beat | Action and spoken copy |
|---|---|---|
| 0:00-0:08 | Brad | Show crease and brand. Speak Brad’s frozen line. Skip the permission primer only if already authorized. |
| 0:08-0:28 | Climax | Show T1 in silence, or use Simulate tip and identify it as simulated. |
| 0:28-0:50 | Purchase | Run the actual Pro and Test Store purchase flow. Speak Matt’s frozen line: “Free: outer preview. Pro: pose overlays on the outer display.” |
| 0:50-1:00 | Bloom and close | Show purchase-driven T2, then say “Pro on the outer.” Speak the frozen who-pays close. |

## Rehearsal recovery

- **Tip unavailable:** Use Simulate tip only if TC-C09 passes. Identify the state as simulated. This does not verify CameraCaptureAccessory behavior or on-device presentation.
- **Paywall or purchase fails:** Stop the purchase beat and record the result. Do not pretend a purchase occurred, speak Matt’s line as a verified outcome, or continue to a purchase-driven bloom. Simulate Pro may show simulated styling only; it does not verify a purchase or entitlement.
- **Outer unlock absent:** Do not claim the other pane changed. Record TC-R04 as failed or blocked and end the planned purchase story.
- **Permission denied:** Use Open Settings or Not now. Rehearse this recovery separately.
- **Accessory unavailable:** Keep any Simulate tip clearly identified as simulated. Do not claim device accessory behavior.

## Rehearsal record

Path: __. Actual duration: __. Active mode: __. Gate outcomes and evidence: record in `DEMO-LAST-PASS.md` after live rehearsal.
