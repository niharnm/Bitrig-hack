# GATE-CCA

**Status: PARTIAL — tip story coded; live Duo CCA / purchase→oval BLOCKED.**

`time_local:` 13:50 (Sat Sep 26, 2026)  
`lane:` Capture / CameraCaptureAccessory / outer coach  
`scope_frozen:` Tip-only outer + guide oval on Pro. FilmStock, KidMagnet, tip-pack theater **out of win bar** (parked on `sat/capture` / `sat/coach`, not merged).

---

## What is coded (source evidence only — not live PASS)

| Piece | Evidence |
| --- | --- |
| CCA host | `CameraCaptureAccessoryHost` on `InnerCaptureView`; binds `isEnabled` / `isAvailable` and shared `CoachModel` |
| Tip-only outer | `SubjectCoachView`: free tips cycle; Pro shows `GuideOvalView` bloom; brand quieter than tip |
| Simulate controls | Settings: Simulate tip, Simulate Pro (labeled simulated), Simulate countdown |
| Shutter → tip + T3 | Shutter advances tip, awaits countdown, then `capturePhoto()` (not Settings-only; `1ec017a` + polish) |
| Photo result | shutter flash, failure banner + Retry, `CaptureSessionTests`; photo not saved |
| Inner paywall host | Pro CTA → `presentPaywall()`; Outer Lens allows **closed** (capture + CCA pose); Frost closed still blocked |
| Unlock wire | `SubjectCoachView` / `InnerCaptureView` observe `EntitlementsModel.shared`; paywall `apply(customerInfo:)` on purchase/restore |
| Sim no-camera path | Banner when no devices; idle+`!hasCamera` Peak-End flash; tips still advance |
| Recovery | Restricted/denied Settings path; session-failed Retry → `start()`; accessory-unavailable banner |
| Debug build | **PASS** — Xcode 27.1 (`Desktop/Xcode.app` 27A9269), SDK 27.1, `generic/platform=iOS Simulator`, log `/tmp/duoapp-polish-build.log` |
| Unit tests | **PASS** — `CaptureSessionTests` 3/3 on Duo sim `A5F8B31A…`, log `/tmp/duoapp-capture-tests.log` |

---

## What still needs LIVE observation on Duo

| Beat | Status |
| --- | --- |
| Real `CameraCaptureAccessory` on folded Duo outer display | **BLOCKED** — coded host; no live accessory observation this gate |
| Inner live `AVCaptureSession` preview + shutter on device | **BLOCKED** — simulator/unit only so far |
| Free tip readable at 2–3 m on outer | **NEEDS LIVE** — Simulate tip honesty OK for rehearsal; not substitute for accessory |
| Test Store purchase → `pro` → oval on **other** pane | **SOURCE FIXED** — shared `EntitlementsModel` + paywall `apply`; still needs live Test Store observation |
| 90s full path rehearsal (grant → tip → Pro → oval) | ignored for this pass (human practice) |
| All fold poses + accessory unavailable recovery | **NEEDS LIVE** |

---

## Gate verdict

| Claim | Result |
| --- | --- |
| Tip story can demo in simulator / with Simulate controls | **PARTIAL / GREEN for rehearsal** — tip cycle, simulate tip, simulate Pro (honest label), shutter→countdown |
| Live CCA climax on Duo | **BLOCKED** |
| Purchase → outer oval | **BLOCKED** until human runs Test Store → other-pane unlock |
| FilmStock / KidMagnet / filters-integrate | **OUT OF BAR** — parked, not on main |

**Do not treat this file as PASS for Duo CCA.** Integrator: source + unit tests ≠ live accessory or Matt Berry purchase proof.

---

## Next steps (human)

1. On Duo hardware: grant camera → confirm outer tip via real CCA (or document accessory unavailable + inner subject preview fallback).
2. Pro → RevenueCatUI → Test Store **Successful Purchase** → confirm oval on outer (not toast-only).
3. 90s rehearse; Brad one-liner + Matt free-vs-paid sentence.
4. Leave parked filter branches alone unless win bar changes.

---

## Parked (do not merge for demo)

- `sat/coach` @ `672f39b` — KidMagnet + tip packs  
- `sat/capture` @ `4b1acc8` — FilmStock selector / grades  
- No `sat/filters-integrate` branch created.
