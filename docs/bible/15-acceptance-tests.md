---
cursor:
  subagentId: "bc-c0fee9b3-73c4-5b74-937e-40ecbaff62fa"
chapter: "15"
title: "Acceptance tests — TC-S / TC-R / TC-C / TC-F / TC-D / TC-I"
product: "Outer Lens (Film Tool) + FrostDuo cutover"
status: "canonical for Saturday LANE-DEMO / Orchestrator / Integrator"
constraint: "Spec only — tick boxes live into docs-runtime/DEMO-LAST-PASS.md"
compiled: "Sat Sep 26, 2026"
---

# §15 Acceptance tests — win-slice “done”

**Event:** Bitrig Hacks iPhone Duo · Sat Sep 26, 2026 · demos 3:30+  
**Win bar:** Polished live vertical slice — not App Store completeness (`docs/win-completeness-bar.md`).  
**Theme:** Outer Lens Film Tool primary; FrostDuo = hour-one cutover only (`docs/bible-single-theme-contract.md` §6).  
**DECISION (Claude review P0):** `CUTOVER.flag` cutover write = exact `frost` (never `true`). Primary = absent/empty/`false`. Gate TCs = this chapter’s IDs (not TC-RC / TC-OL substitutes).

**Pass rule:** Pass **all Always** rows + (**all Primary Outer Lens** if `CUTOVER.flag` absent/empty/`false`) **OR** (**all Cutover FrostDuo** if flag = `frost`). Waivers must be written in `docs-runtime/DEMO-LAST-PASS.md` — silent skips = fail.  
**Owners:** LANE-DEMO / Orchestrator ticks · Integrator owns TC-I* · feature lanes supply evidence.

**Parallel style:** Cutover TC block mirrors [`12-frostduo-cutover.md`](./12-frostduo-cutover.md) §12.13. Outer Lens screen-local TC-OL-* live in [`11-outer-lens-product.md`](./11-outer-lens-product.md) §11.8 — this chapter is the **integrate suite** with demo seconds.

Every TC maps to a **path**, a **SCR-ID**, a **gate artifact**, or a **demo timestamp**. No vibe checks.

---

## 15.0 How to run this suite Saturday

### 15.0.1 When to run

| Wall clock | Suite slice | Who |
|------------|-------------|-----|
| ~11:45 | TC-S01 smoke | SHELL |
| ~12:00 | TC-S02 / S03 pose hygiene | SHELL |
| **12:15** | GATE-CCA → chooses Primary vs Cutover suite | Orchestrator |
| ~1:45 | TC-C* core (or TC-F* if cutover) mid-check | CCA or FROST |
| ~2:15 | TC-R01–R05 | RC + Orchestrator |
| ~2:45 | TC-C04 / F04 other-pane unlock | Integrator |
| **3:00–3:15** | Full suite tick + TC-D* + TC-I* | DEMO + Integrator |
| 3:15–3:30 | Second 90s; no new TC invention | Orchestrator |

### 15.0.2 Evidence grades

| Grade | Meaning | Allowed for win? |
|-------|---------|------------------|
| **PASS** | Observed live on Duo sim (or device) this afternoon | Yes |
| **PASS-SIM** | Observed via Simulate control + honest verbal | Yes if named in script |
| **WAIVE** | Written reason in DEMO-LAST-PASS; Orchestrator initials | Yes only if non-load-bearing or clock death with Simulate covering climax story |
| **FAIL** | Broken on critical path | No — hotfix or cutover |
| **N/A** | Wrong mode (e.g. TC-F* while Outer Lens green) | Yes |

### 15.0.3 Critical path (cannot WAIVE without cutover or Simulate story)

| Mode | Non-waivable core |
|------|-------------------|
| Outer Lens | TC-S01 · TC-C01 (or PASS-SIM tip) · TC-C02 · TC-R02 · TC-R03 · TC-R04 · TC-D02 |
| FrostDuo | TC-S01 · TC-F01 · TC-F02 · TC-F03 · TC-R02 · TC-R03 · TC-R04 · TC-D02 |

### 15.0.4 Demo-second legend

| Band | Name | Outer Lens | FrostDuo |
|------|------|------------|----------|
| **0:00–0:10** | Cold open / Brad | SCR-OL-A | SCR-FD-A |
| **0:10–0:45** | Climax glass | SCR-OL-B/C T1 | SCR-FD-B/C frost+decoy |
| **0:50–1:05** | Monetize | SCR-OL-D | SCR-FD-D |
| **1:05–1:20** | Other-pane unlock | SCR-OL-C T2 | SCR-FD-C pack C |
| **1:20–1:30** | Close / Matt | spoken | spoken |

### 15.0.5 Film Tool locks under test

| Lock | Asserted by |
|------|-------------|
| Charcoal `#050505` · amber `#E8A838` | Win visual / TC-C* visual notes |
| Tip SF Rounded ≥28pt · ≤8 words · solid plate | TC-C01 evidence |
| CCA via `.sceneAccessory` | TC-C01 / GATE-CCA |
| Free T1 · Pro T2 other pane | TC-C01 + TC-C04 + TC-R04 |
| Paywall inner only | TC-R02 location note |
| No Vision/FM load-bearing | Explicit non-goals |
| `PLACEHOLDER_RC_*` replaced before R01 PASS | TC-R01 |
| Paths `Features/Capture/**` · `CoachOverlay/**` · `Paywall/**` | path column |

---

## 15.1 Always — TC-S* (shell / Duo hygiene)

Run in **both** modes. Evidence → `docs-runtime/GATE-SHELL.md`.

### TC-S01 — App launches on Duo sim

| Field | Spec |
|-------|------|
| **Assertion** | Empty-to-featured Duo app target ⌘R launches on iPhone Duo simulator without crash |
| **Path** | `App/DuoAppApp.swift` · project target |
| **Demo sec** | Pre-demo / cold open readiness (not spoken) |
| **Procedure** | Boot Duo sim → select scheme → ⌘R → springboard icon → first frame within ~10s |
| **Pass** | Window visible; no immediate fatal |
| **Fail** | Wrong Xcode · missing Duo sim · crash loop |
| **Owner** | LANE-SHELL |
| **Gate** | `GATE-SHELL.md` |

### TC-S02 — Pose remaps regions / panes without hinge-driven layout

| Field | Spec |
|-------|------|
| **Assertion** | Changing Duo pose (Device Hub / fold) remaps Arrangement regions; UI regions follow pose API, not raw hinge degrees |
| **Path** | `Duo/PoseRouter.swift` · `Duo/ArrangementRegions.swift` · `App/RootArrangementView.swift` |
| **Demo sec** | Soft STEM inside 0:10–0:35 (tabletop optional Outer Lens; primary Frost) |
| **Procedure** | Flat → tabletop (or book) → confirm content/control regions move · inspect PoseRouter for pose enums not angle math driving frames |
| **Pass** | Visible region remap OR documented pose chrome for mode |
| **Fail** | Layout equations from hinge angle |
| **Owner** | LANE-SHELL |
| **Maps** | Contract TC-S02 |

### TC-S03 — `onHingeChange` effects-only

| Field | Spec |
|-------|------|
| **Assertion** | Any `onHingeChange` usage is effects (parallax-light, haptics, audio skip) — **not** SCR layout |
| **Path** | Code review `Duo/PoseRouter.swift` + feature views |
| **Demo sec** | N/A (review) |
| **Procedure** | rg `onHingeChange` / hinge angle; confirm no frame/layout dependency |
| **Pass** | Zero layout-from-degrees |
| **Fail** | Accorduon-class hinge layout |
| **Owner** | SHELL + Scope guard |
| **Maps** | Contract TC-S03 · kill list |

### TC-S04 — `CutoverFlag` readable by feature lanes

| Field | Spec |
|-------|------|
| **Assertion** | `Shared/CutoverFlag.swift` reads `docs-runtime/CUTOVER.flag` (or bundled equivalent); RootArrangementView swaps OL ↔ FD host |
| **Path** | `Shared/CutoverFlag.swift` · `App/RootArrangementView.swift` |
| **Demo sec** | Build-clock 12:15 (not demo beat) |
| **Procedure** | With flag absent → Outer Lens root; write `frost` → Frost root after rebuild/relaunch per SHELL recipe |
| **Pass** | Flag drives slot; feature lanes can read without writing |
| **Fail** | Feature lane writes flag; dual roots both live |
| **Owner** | LANE-SHELL · Orchestrator writes disk flag |
| **Maps** | Contract TC-S04 · §12.1.4 |

### TC-S05 — (extended) No banned top-level folders

| Field | Spec |
|-------|------|
| **Assertion** | Saturday tree has no `Agents/`, `Chat/`, `Interview/`, `HingeBeat/`, `PoseAgent/`, `Backend/`, `Marketing/` |
| **Path** | `DuoApp/` tree vs contract §4 |
| **Demo sec** | N/A |
| **Procedure** | `ls` / Integrator tree diff |
| **Pass** | Tree matches freeze |
| **Owner** | Integrator / Scope guard |

### TC-S06 — (extended) Single climax API on demo path

| Field | Spec |
|-------|------|
| **Assertion** | Demo path exercises **either** CCA Outer Lens **or** Frost dual-face — not both in one 90s |
| **Path** | DEMO-SCRIPT.md active appendix |
| **Demo sec** | Entire 0:00–1:30 |
| **Pass** | One climax glass ≤30s |
| **Owner** | Orchestrator |

---

## 15.2 Always — TC-R* (RevenueCat / other-pane)

Run in **both** modes. Unlock target differs: Outer Lens = T2 oval · Frost = decoy pack C. Evidence → `docs-runtime/GATE-RC.md`.

### TC-R01 — `Purchases.configure` with human `test_` key (DEBUG)

| Field | Spec |
|-------|------|
| **Assertion** | DEBUG configure uses key from `docs-runtime/RC-IDs.md` — **not** invented `PLACEHOLDER_RC_*` left as fake success |
| **Path** | `Monetization/PurchasesConfig.swift` · `RC-IDs.md` |
| **Demo sec** | Pre-0:50 (configure at launch) |
| **Procedure** | Confirm RC-IDs pasted · app logs configure OK · `#if DEBUG` · Release does not embed `test_` |
| **Pass** | Configure succeeds; placeholder string gone |
| **Fail** | Nil key · invented key · Release leak |
| **Owner** | LANE-RC · Human paste |
| **DECISION:** If RC-IDs missing at 1:45, Orchestrator pastes or marks BLOCKED — agents must not invent IDs. |

### TC-R02 — Paywall presents (RevenueCatUI)

| Field | Spec |
|-------|------|
| **Assertion** | Pro CTA opens RevenueCatUI paywall **on inner** (SCR-OL-D or SCR-FD-D) |
| **Path** | `Features/Paywall/PaywallHostView.swift` |
| **Demo sec** | **0:50–1:05** |
| **Procedure** | Tap Pro coaching / Unlock Cover Vault → sheet visible · outer does **not** host paywall |
| **Pass** | Sheet on inner within ≤10s of tap |
| **Fail** | Crash · paywall on outer · blank |
| **Owner** | LANE-RC |
| **Maps** | Contract TC-R02 |

### TC-R03 — Test Store Successful Purchase

| Field | Spec |
|-------|------|
| **Assertion** | Test Store path completes **Successful Purchase**; `entitlements["pro"].isActive` true |
| **Path** | PaywallHost · `Monetization/Entitlements.swift` |
| **Demo sec** | **0:50–1:05** (purchase action) |
| **Procedure** | In paywall choose Test Store → Successful Purchase → observe CustomerInfo / EntitlementState |
| **Pass** | `isPro == true` without ASC sandbox theater |
| **Fail** | Wrong entitlement id (`Pro` typo) · offering nil · stuck spinner |
| **Owner** | LANE-RC + Orchestrator click |
| **Maps** | Contract TC-R03 · win bar Matt depth |

### TC-R04 — Unlock visible on the **other** display

| Field | Spec |
|-------|------|
| **Assertion** | After purchase, **outer** changes: Outer Lens T2 amber guide oval **or** Frost decoy pack **C** — not merely an inner toast |
| **Path** | OL: `Features/CoachOverlay/GuideOvalView.swift` · FD: `Features/Frost/OuterDecoyStageView.swift` |
| **Demo sec** | **1:05–1:20** |
| **Procedure** | Complete R03 → look at outer within 5s → confirm M3 bloom / F3 crossfade |
| **Pass** | Room-readable other-pane change |
| **Fail** | Only inner checkmark · outer unchanged |
| **Owner** | Integrator merge + feature observe |
| **Maps** | Contract TC-R04 · Matt sentence truth |

### TC-R05 — Cancel / Fail keeps gate locked

| Field | Spec |
|-------|------|
| **Assertion** | Dismiss/Cancel (and one Fail if available) leaves `isPro` false; outer stays free tier (T1 / decoy A) |
| **Path** | Entitlements · CoachOverlay / OuterDecoyStage |
| **Demo sec** | Rehearsal only (once) — not in judged 90s unless recovery |
| **Procedure** | Open paywall → Cancel → confirm T1/A · then do Successful path for real demo |
| **Pass** | Gate holds |
| **Fail** | Cancel unlocks Pro |
| **Owner** | LANE-RC |
| **Maps** | Contract TC-R05 |

### TC-R06 — (extended) Entitlement id literal `pro`

| Field | Spec |
|-------|------|
| **Assertion** | Code and dashboard entitlement id is lowercase `pro` |
| **Path** | `Entitlements.swift` · RC-IDs.md |
| **Demo sec** | N/A |
| **Pass** | String match |
| **Owner** | LANE-RC |

### TC-R07 — (extended) SPM RevenueCat ≥ 5.43.0

| Field | Spec |
|-------|------|
| **Assertion** | Resolved packages include RevenueCat + RevenueCatUI ≥ 5.43.0 from purchases-ios-spm |
| **Path** | Xcode package resolve |
| **Pass** | Version gate |
| **Owner** | SHELL / RC |

### TC-R08 — (extended) Matt sentence true on glass

| Field | Spec |
|-------|------|
| **Assertion** | Spoken Matt line matches visible free→Pro other-pane unlock |
| **Demo sec** | **~1:20** |
| **OL line** | Free: outer preview. Pro: pose overlays on the outer display. |
| **FD line** | Free blurs secrets on the inner; Pro puts believable decoys on the outer. |
| **Owner** | COPY + Orchestrator |
| **Maps** | TC-P03 / TC-P02 |

---

## 15.3 Primary Outer Lens — TC-C* (`CUTOVER.flag` absent/empty/`false`)

Evidence → `docs-runtime/GATE-CCA.md` + DEMO-LAST-PASS. Screen-local detail in §11.8 (TC-OL-*).

### TC-C01 — Outer tip/preview readable ≤30s with zero narration

| Field | Spec |
|-------|------|
| **Assertion** | Within 30s of capture live, outer (or tip-only / Simulate tip) shows **one** tip ≥28pt ≤8 words on solid plate, readable at 2–3 m |
| **Path** | `Duo/CameraCaptureAccessoryHost.swift` · `Features/CoachOverlay/SubjectCoachView.swift` · `TipPlateView.swift` |
| **SCR** | SCR-OL-C |
| **Demo sec** | **0:15–0:45** |
| **Procedure** | Grant camera → enable Subject screen if available → confirm T1 (“Chin up · eyes to the lens” or cycle) · if sim won’t present, PASS-SIM via Simulate tip + verbal `demo.verbal.ccaFlake` |
| **Pass** | PASS or PASS-SIM with scripted line |
| **Fail** | Blank outer · tip list · glass tip unreadable · requires narration to notice |
| **Owner** | LANE-CCA |
| **Maps** | Contract TC-C01 · win climax |
| **Visual locks** | `#050505` stage · solid plate · SF Rounded · brand whisper Outer Lens |

### TC-C02 — Inner shutter + live preview

| Field | Spec |
|-------|------|
| **Assertion** | Inner capture shell shows live preview **or** honest black + banner; shutter ~80pt works (photo-only) |
| **Path** | `Features/Capture/InnerCaptureView.swift` · `CaptureSessionController.swift` |
| **SCR** | SCR-OL-B |
| **Demo sec** | **0:10–0:40** |
| **Procedure** | After auth, confirm preview or black+`tips still work` · tap shutter · optional flip once |
| **Pass** | Capture chrome usable; tip still legible after flip |
| **Fail** | Crash on shutter · fake coaching before session · mic prompt |
| **Owner** | LANE-CCA |
| **Maps** | Contract TC-C02 · TC-OL-B01 |

### TC-C03 — `accessory.unavailable` → inner still shoots

| Field | Spec |
|-------|------|
| **Assertion** | When `onAvailabilityChange(false)`, Subject toggle hidden; shutter still enabled; no brick |
| **Path** | CCA host · InnerCaptureView · SCR-OL-E banner path |
| **SCR** | SCR-OL-B / E |
| **Demo sec** | Recovery (rehearsal); may not appear in happy 90s |
| **Procedure** | Force unavailable (sim or toggle path) → shutter still · optional Simulate tip |
| **Pass** | Inner shoots |
| **Fail** | Entire capture disabled when accessory missing |
| **Owner** | LANE-CCA |
| **Maps** | Contract TC-C03 · Apple CCA “controls stay inner” |

### TC-C04 — Pro guide (T2) follows `EntitlementState.isPro`

| Field | Spec |
|-------|------|
| **Assertion** | `isPro` false → TipKind.line (T1); `isPro` true → TipKind.guide (T2) amber oval `#E8A838` with M3 bloom |
| **Path** | `GuideOvalView.swift` · observe Entitlements |
| **SCR** | SCR-OL-C after D |
| **Demo sec** | **1:05–1:20** |
| **Procedure** | Complete TC-R03 → watch outer oval · Confirm Cancel path kept T1 earlier |
| **Pass** | Oval appears only when pro (or Simulate Pro flagged) |
| **Fail** | Oval always on · oval never on after purchase · paywall on outer |
| **Owner** | CCA + RC Integrator |
| **Maps** | Contract TC-C04 · TC-OL-D03 |

### TC-C05 — Camera denied → Settings path

| Field | Spec |
|-------|------|
| **Assertion** | Denied/restricted shows SCR-OL-E with Open Settings; re-check on active |
| **Path** | `PermissionPrimerView.swift` · `CaptureDeniedView.swift` |
| **SCR** | SCR-OL-A → E |
| **Demo sec** | Recovery (prefer pre-grant for judged demo) |
| **Procedure** | Reset sim privacy → Don’t Allow → Open Settings affordance visible |
| **Pass** | Settings path exists |
| **Fail** | Silent fail · crash · infinite primer |
| **Owner** | LANE-CCA |
| **Maps** | Contract TC-C05 · TC-OL-E01 |

### TC-C06 — (extended) Tip style hard cap T1–T3

| Field | Spec |
|-------|------|
| **Assertion** | Outer renders only line / guide / countdown — no skeleton free HUD, no tip lists |
| **Path** | CoachOverlay/** |
| **Demo sec** | 0:15–1:20 |
| **Pass** | Visual QA |
| **Owner** | CCA + Scope guard |

### TC-C07 — (extended) Countdown T3 once (or Simulate)

| Field | Spec |
|-------|------|
| **Assertion** | Countdown 3·2·1 fires once in rehearsal/demo (M2) or Simulate countdown |
| **Path** | `CountdownView.swift` |
| **Demo sec** | Optional inside **0:30–0:45** |
| **Pass** | PASS or PASS-SIM |
| **Owner** | LANE-CCA |
| **Non-blocking?** | Soft — drop polish if behind at 2:00 per build plan |

### TC-C08 — (extended) Motions M1 + M3

| Field | Spec |
|-------|------|
| **Assertion** | Tip settle M1 observed on tip change; Pro bloom M3 on unlock; Reduce Motion → crossfade |
| **Path** | `DesignSystem/Motion.swift` |
| **Demo sec** | M1 in 0:15–0:45 · M3 in 1:05–1:20 |
| **Pass** | Intentional motion, not noise |
| **Owner** | ASSETS + CCA |

### TC-C09 — (extended) Simulate tip / Pro / countdown reachable

| Field | Spec |
|-------|------|
| **Assertion** | Settings on SCR-OL-B exposes all three Simulate controls; each changes outer/inner tip theater |
| **Path** | InnerCapture Settings sheet |
| **Demo sec** | Rehearsal recoveries |
| **Pass** | Judge-safe recovery proven |
| **Owner** | LANE-CCA |
| **Maps** | TC-OL-E03 / E04 · §11b.8 |

### TC-C10 — (extended) Photo-only — no mic prompt

| Field | Spec |
|-------|------|
| **Assertion** | Win slice never requests microphone |
| **Path** | Info.plist · session config |
| **Pass** | No mic dialog in dance |
| **Owner** | LANE-CCA |

### TC-C11 — (extended) Brand Outer Lens hero-visible

| Field | Spec |
|-------|------|
| **Assertion** | Wordmark Outer Lens visible on B and C without nav-only burial |
| **Demo sec** | 0:00–0:45 |
| **Pass** | Brand test |
| **Owner** | COPY / ASSETS |

### TC-C12 — (extended) Vision/FM not required

| Field | Spec |
|-------|------|
| **Assertion** | Happy path tips work with Vision disabled / unavailable; static fallback always |
| **Path** | Tip resolver §11b.5 |
| **Pass** | No Vision dependency |
| **Owner** | LANE-CCA |

---

## 15.4 Cutover FrostDuo — TC-F* (`CUTOVER.flag` = frost)

**Parallel to §12.13.** N/A when Outer Lens green. Evidence → `docs-runtime/GATE-FROST.md`.

### TC-F01 — Threat → inner frost

| Field | Spec |
|-------|------|
| **Assertion** | Threat / Simulate Threat moves inner sensitive surface through frost ladder to locked (blur + quiet Covered/Private) |
| **Path** | `Features/Frost/SensitiveSurfaceView.swift` · `FrostOverlayView.swift` · F1 |
| **SCR** | SCR-FD-A |
| **Demo sec** | **0:25–0:45** (frost visible) |
| **Procedure** | Clear mail/notes → Simulate Threat → observe F1 settle · no “INTRUDER” chrome |
| **Pass** | Ice-soft frost readable |
| **Fail** | Cyber HUD · no frost · malware aesthetic |
| **Owner** | LANE-FROST |
| **Maps** | Contract TC-F01 |

### TC-F02 — Outer decoy at locked

| Field | Spec |
|-------|------|
| **Assertion** | On lock, outer shows decoy pack **A** (Lock Lookalike) or selected free pack — calm, believable |
| **Path** | `Features/Frost/OuterDecoyStageView.swift` · F2 |
| **SCR** | SCR-FD-C |
| **Demo sec** | **0:25–0:45** |
| **Procedure** | After F01, look outer → mismatch readable at 3–5 m |
| **Pass** | Decoy A (or B teaser) visible |
| **Fail** | Outer blank · second clock app nonsense · PrivacyScreen fork chrome |
| **Owner** | LANE-FROST |
| **Maps** | Contract TC-F02 |

### TC-F03 — Simulate Threat works in sim

| Field | Spec |
|-------|------|
| **Assertion** | SCR-FD-B Simulate Threat control drives ladder without TrueDepth |
| **Path** | `FrostControlsView.swift` · `SimulateThreatControl.swift` |
| **SCR** | SCR-FD-B |
| **Demo sec** | **0:15–0:35** |
| **Procedure** | Tap Simulate → F01+F02 fire |
| **Pass** | Zero faces required |
| **Fail** | Hard-depends on real second face |
| **Owner** | LANE-FROST |
| **Maps** | Contract TC-F03 · Jane-safe |

### TC-F04 — Pro vault / decoy C gated by `pro`

| Field | Spec |
|-------|------|
| **Assertion** | After TC-R03, outer crossfades to pack **C** (Vault Cover) via F3 |
| **Path** | OuterDecoyStageView · EntitlementState |
| **SCR** | SCR-FD-C |
| **Demo sec** | **1:05–1:20** |
| **Procedure** | Purchase → outer C · Cancel earlier kept A |
| **Pass** | Other-pane vault proof |
| **Fail** | Pack C free · unlock inner-only |
| **Owner** | FROST + RC |
| **Maps** | Contract TC-F04 |

### TC-F05 — Closed-cover optional — not required

| Field | Spec |
|-------|------|
| **Assertion** | SCR-FD-E closed-cover vault is nice-only; **must not block win** |
| **Path** | Optional outer-only branch |
| **Demo sec** | Only if M8 early |
| **Procedure** | Mark N/A or PASS if built |
| **Pass** | Always for win bar if A–D green |
| **Owner** | LANE-FROST |
| **Maps** | Contract TC-F05 |

### TC-F06 — (extended) Quiet copy — Covered / Private

| Field | Spec |
|-------|------|
| **Assertion** | No traffic-light threat banners; no INTRUDER / THREAT shouty chrome |
| **Demo sec** | 0:25–0:45 |
| **Owner** | COPY + FROST |

### TC-F07 — (extended) Motions F1+F2 on Simulate; F3 on unlock

| Field | Spec |
|-------|------|
| **Assertion** | Frost settle + decoy snap on Simulate; vault crossfade on purchase |
| **Path** | `DesignSystem/Motion.swift` |
| **Demo sec** | 0:25–0:45 · 1:05–1:20 |
| **Owner** | ASSETS + FROST |

### TC-F08 — (extended) Paywall inner only (Frost)

| Field | Spec |
|-------|------|
| **Assertion** | SCR-FD-D never mounts on outer decoy stage |
| **Demo sec** | 0:50–1:05 |
| **Owner** | LANE-RC |

### TC-F09 — (extended) Cutover flag enforced

| Field | Spec |
|-------|------|
| **Assertion** | With flag frost, Outer Lens capture feature work stopped; Frost primary |
| **Path** | CUTOVER.flag · GATE-CCA.md RED |
| **Demo sec** | Build clock 12:15 |
| **Owner** | Orchestrator |

---

## 15.5 Always — TC-D* (demo / rehearsal)

### TC-D01 — Suite (or waivers) recorded

| Field | Spec |
|-------|------|
| **Assertion** | `docs-runtime/DEMO-LAST-PASS.md` lists each TC-S/R/C-or-F/D/I with PASS / PASS-SIM / WAIVE / FAIL / N/A |
| **Path** | `docs-runtime/DEMO-LAST-PASS.md` |
| **Demo sec** | Written **3:00–3:15** |
| **Procedure** | Copy template §15.9 → tick live |
| **Pass** | File exists; critical path green or waived with reason |
| **Owner** | LANE-DEMO / Orchestrator |
| **Maps** | Contract TC-D01 |

### TC-D02 — 90s script ×2 rehearsal

| Field | Spec |
|-------|------|
| **Assertion** | Full script timed twice (first in freeze window, second 3:15–3:30) without new features mid-run |
| **Path** | `docs-runtime/DEMO-SCRIPT.md` (+ cutover appendix if frost) |
| **Demo sec** | Entire **0:00–1:30** live |
| **Procedure** | Stopwatch · Brad · climax ≤30s · RC · other-pane · Matt · stop |
| **Pass** | Two completes ≤100s each (air OK) |
| **Fail** | Never timed · talking over broken glass |
| **Owner** | Orchestrator |
| **Maps** | Contract TC-D02 · Hsu rehearse |

### TC-D03 — (extended) Backup 60s path known

| Field | Spec |
|-------|------|
| **Assertion** | Team can skip flip / tabletop polish and still hit tip→purchase→bloom (or frost Simulate→purchase→C) |
| **Demo sec** | Compressed 0:00–1:00 |
| **Owner** | Orchestrator |

### TC-D04 — (extended) Verbal flake lines memorized

| Field | Spec |
|-------|------|
| **Assertion** | CCA flake / Simulate Threat lines spoken without reading |
| **Demo sec** | As needed |
| **Owner** | Orchestrator / COPY |

### TC-D05 — (extended) Brad frozen for active mode

| Field | Spec |
|-------|------|
| **Assertion** | Correct Brad for Outer Lens **or** Frost spoken at 0:00–0:10 |
| **Maps** | TC-P01 / TC-P02 |
| **Owner** | COPY |

### TC-D06 — (extended) Who-pays close

| Field | Spec |
|-------|------|
| **Assertion** | 1:20–1:30 names buyer + why Duo this week · stop talking |
| **Owner** | Orchestrator |

### TC-D07 — (extended) No second feature in demo

| Field | Spec |
|-------|------|
| **Assertion** | Demo does not open gallery / FM / Multipeer / hinge instrument |
| **Owner** | Scope guard |

---

## 15.6 Always — TC-I* (integrator / compile)

### TC-I01 — Release/Debug compile on integrate branch

| Field | Spec |
|-------|------|
| **Assertion** | Integrate branch builds Debug for Duo sim; Release compile checked at least once (test_ key stripped) |
| **Path** | sat/integrate (or venue branch name) |
| **Demo sec** | Pre-freeze |
| **Procedure** | ⌘B Debug · spot-check Release config |
| **Pass** | Green build |
| **Fail** | Merge conflicts · missing files · unsigned mess blocking ⌘R |
| **Owner** | Integrator |
| **Maps** | Contract TC-I01 |

### TC-I02 — (extended) Types unify to §07 names

| Field | Spec |
|-------|------|
| **Assertion** | No lane-local duplicate enums surviving merge (`TipKind`, `CaptureSessionPhase`, `EntitlementState`, `ThreatLevel`, `CutoverFlag`) |
| **Path** | `Shared/Types.swift` |
| **Pass** | One source |
| **Owner** | Integrator |

### TC-I03 — (extended) Merge order respected

| Field | Spec |
|-------|------|
| **Assertion** | Feature branches merge SHELL → (CCA|FROST) → RC → COPY/ASSETS → integrate; no force-push over freeze |
| **Path** | git log / Integrator notes |
| **Owner** | Integrator |

### TC-I04 — (extended) Gate artifacts present

| Field | Spec |
|-------|------|
| **Assertion** | `GATE-SHELL.md`, `GATE-CCA.md` (or FROST), `GATE-RC.md`, `DEMO-LAST-PASS.md` exist at freeze |
| **Path** | `docs-runtime/**` |
| **Owner** | Orchestrator + lanes |

### TC-I05 — (extended) No PrivacyScreen / Moments / Shot Caller SPM

| Field | Spec |
|-------|------|
| **Assertion** | Package graph is RevenueCat only for monetization; pattern remix without forks |
| **Owner** | Integrator / Scope guard |

### TC-I06 — (extended) Freeze tag / verbal lock at 3:00

| Field | Spec |
|-------|------|
| **Assertion** | No new features after freeze; only sat/hotfix/* for named demo-blockers |
| **Owner** | Orchestrator |

---

## 15.7 Pitch / brand — TC-P* (mode-specific)

| TC | Mode | Assertion | Demo sec |
|----|------|-----------|----------|
| **TC-P01** | Outer Lens | Outer Lens Brad frozen in spoken script | 0:00–0:10 |
| **TC-P02** | Frost | Frost Brad ready in cutover appendix | 0:00–0:10 |
| **TC-P03** | Outer Lens | Matt free outer tip / Pro overlays on outer | ~1:20 |
| **TC-P04** | Both | No banned nouns (PoseAgent, HingeBeat, interview agents, Accorduon) in pitch or UI | whole |
| **TC-P05** | Outer Lens | Film Tool charcoal + amber Pro; no purple/cream/broadsheet slop | visual |
| **TC-P06** | Frost | Ice-soft; quiet Covered/Private; no cyber HUD | visual |

---

## 15.8 Mode matrices

### 15.8.1 Outer Lens required set

```text
ALWAYS:  S01 S02 S03 S04  R01 R02 R03 R04 R05  D01 D02  I01
PRIMARY: C01 C02 C03 C04 C05
PITCH:   P01 P03 P05
SOFT:    C07 C08 C09 (waive OK if Simulate covers + clock)
```

### 15.8.2 FrostDuo required set

```text
ALWAYS:  S01 S02 S03 S04  R01 R02 R03 R04 R05  D01 D02  I01
CUTOVER: F01 F02 F03 F04   (F05 = N/A OK)
PITCH:   P02 P06
SOFT:    F07 (motion polish)
```

### 15.8.3 Explicit non-goals (do not block done)

Vision/pose ML accuracy · real second-face without Simulate · ASC/sandbox restore · StandBy/widgets · multiple tip packs beyond T1–T3 chrome · SCR-FD-E · Perfect Liquid Glass on every control · gallery picker · video REC · Foundation Models tips · Supabase/Sentry/OpenAI as product · marketing site · multi-user sync.

---

## 15.9 DEMO-LAST-PASS template (paste Saturday)

```text
# DEMO-LAST-PASS
date: 2026-09-26
mode: outerLens | frost   # reader enum; disk cutover write = frost only
cutover_flag: <value>
gate_cca: GREEN | RED
owner: <Orchestrator>

## Always
- TC-S01: PASS|FAIL|WAIVE — notes:
- TC-S02: …
- TC-S03: …
- TC-S04: …
- TC-R01: …  (RC-IDs pasted: yes/no)
- TC-R02: …  demo 0:50–1:05
- TC-R03: …  demo 0:50–1:05
- TC-R04: …  demo 1:05–1:20
- TC-R05: …
- TC-D01: PASS (this file)
- TC-D02: PASS|FAIL — rehearsal1: __s · rehearsal2: __s
- TC-I01: …

## Primary Outer Lens (N/A if frost)
- TC-C01: PASS|PASS-SIM|FAIL — demo 0:15–0:45
- TC-C02: … — demo 0:10–0:40
- TC-C03: …
- TC-C04: … — demo 1:05–1:20
- TC-C05: …

## Cutover Frost (N/A if outerLens)
- TC-F01: … — demo 0:25–0:45
- TC-F02: …
- TC-F03: … — demo 0:15–0:35
- TC-F04: … — demo 1:05–1:20
- TC-F05: N/A|PASS

## Pitch
- TC-P01/P02: …
- TC-P03: …
- Win visual: …
- Win motion: …

## Waivers
- <TC>: reason · Simulate used? · initials

## Hotfixes after 3:00
- none | sat/hotfix/<name>
```

---

## 15.10 Procedure scripts (copy for Q lane)

### 15.10.1 Outer Lens 90s acceptance dance

| t | Action | TC expected green |
|--:|--------|-------------------|
| 0:00 | Speak Brad; show brand | P01 · C11 |
| 0:05 | Primer or skip | C05 path ready |
| 0:10 | Inner preview/black live | C02 |
| 0:15 | Outer T1 or Simulate tip | **C01** |
| 0:35 | Optional countdown | C07 |
| 0:40 | Flip once | C02 |
| 0:50 | Pro CTA → paywall | R02 |
| 1:00 | Successful Purchase | R03 |
| 1:05 | Outer T2 oval | **C04 · R04** |
| 1:20 | Matt · who pays · stop | R08 · D06 |

### 15.10.2 FrostDuo 90s acceptance dance

| t | Action | TC expected green |
|--:|--------|-------------------|
| 0:00 | Frost Brad; clear inner | P02 · F01 setup |
| 0:15 | Controls + Simulate | F03 |
| 0:25 | Frost + decoy A | **F01 · F02** |
| 0:50 | Unlock Cover Vault | R02 |
| 1:00 | Successful Purchase | R03 |
| 1:05 | Outer pack C | **F04 · R04** |
| 1:20 | Matt · Jane on-device line · stop | D06 |

### 15.10.3 Cancel gate dance (once, rehearsal)

1. Reach paywall.  
2. Cancel.  
3. Confirm outer still free (T1 or A).  
4. Tick TC-R05.  
5. Re-open and complete Successful Purchase for real path.

### 15.10.4 Unavailable / denied dances (rehearsal)

**Unavailable:** Hide toggle path → shutter → Simulate tip → tick C03.  
**Denied:** Don’t Allow → Open Settings visible → tick C05 — then reset privacy for judged demo.

---

## 15.11 Mapping — contract §6 ↔ this chapter ↔ screen locals

| Contract | §15 | Screen-local / cutover |
|----------|-----|------------------------|
| TC-S01–S04 | §15.1 | GATE-SHELL |
| TC-R01–R05 | §15.2 | GATE-RC · §12.8.4 |
| TC-C01–C05 | §15.3 | TC-OL-* in §11.8 |
| TC-F01–F05 | §15.4 | §12.13 |
| TC-D01–D02 | §15.5 | DEMO-* |
| TC-I01 | §15.6 | Integrator |
| TC-P01–P03 | §15.7 | DEMO-SCRIPT |

---

## 15.12 Failure → recovery → re-tick

| Failure | Immediate recovery | Re-tick |
|---------|--------------------|---------|
| C01 outer blank | Simulate tip + verbal | C01 PASS-SIM |
| R03 offering nil | Fix RC dashboard / RC-IDs | R01→R03 |
| R04 no oval | Check isPro observe · Integrator wire | C04 · R04 |
| C02 session fail | Black+tips path · Retry | C02 |
| F03 Simulate dead | Hotfix control binding | F03 |
| I01 compile red | Integrator only; feature freeze | I01 |
| Clock <20m & RC dead | Simulate Pro + WAIVE R03 with reason — last resort | D01 waiver |

**Never:** invent entitlement IDs · put paywall on outer · start Vision project to “save” C01 · half-enable Frost while still demoing CCA.

---

## 15.13 Gate file stubs

### GATE-SHELL.md

```text
# GATE-SHELL
status: PASS|FAIL
tc_s01: …
tc_s02: …
tc_s03: …
tc_s04: …
notes: …
```

### GATE-CCA.md

```text
# GATE-CCA
status: GREEN|RED
time: 12:15
tc_c01_probe: …
tc_c02_probe: …
tip_only_story_ok: yes|no
reason: …
```

### GATE-RC.md

```text
# GATE-RC
status: PASS|FAIL
tc_r01: …
tc_r02: …
tc_r03: …
tc_r04: …
tc_r05: …
offering: …
entitlement: pro
```

### GATE-FROST.md

```text
# GATE-FROST
status: PASS|FAIL
cutover_flag: frost
tc_f01: …
tc_f02: …
tc_f03: …
tc_f04: …
notes: …
```

---

## 15.14 Saturday ownership cheat sheet

| Lane | Must tick before merge |
|------|------------------------|
| SHELL | S01–S04 |
| CCA | C01–C05 · C09 Simulate |
| FROST | F01–F04 (if cutover) |
| RC | R01–R05 |
| COPY | P01/P02 · P03 · tip strings ≤8 words |
| ASSETS | Win visual · M1/M3 or F1–F3 |
| DEMO | D01–D02 · last-pass file |
| Integrator | I01–I06 · R04 wiring |
| Orchestrator | Gate files · freeze · waivers |

---

## 15.15 Concrete build instructions tied to TCs

| Milestone | Minutes | TC unlock |
|-----------|--------:|-----------|
| M0 toolchain | 10 | enables S01 |
| M1 scaffold | 15 | tree for I05 |
| M2 Duo shell | 25 | S02 S03 S04 |
| M3 GATE-CCA | 5 | chooses C* vs F* |
| M4a Outer Lens | 55 | C01 C02 C03 C05 |
| M4b Frost | 55 | F01 F02 F03 |
| M5 RC | 35 | R01 R02 R03 R05 |
| M6 integrate unlock | 15 | R04 · C04 or F04 |
| M7 copy/assets | 10 | P* · win visual |
| M8 freeze | 10 | D01 D02 I01 |

---

## 15.16 Scoreboard (print for table)

```text
OUTER LENS WIN
[ ] S01 Launch
[ ] S02 Pose remap
[ ] S03 Hinge effects-only
[ ] S04 CutoverFlag
[ ] C01 Outer tip ≤30s (0:15–0:45)
[ ] C02 Inner shutter (0:10–0:40)
[ ] C03 Unavailable survivable
[ ] C04 T2 after pro (1:05–1:20)
[ ] C05 Denied→Settings
[ ] R01 Configure test_
[ ] R02 Paywall inner (0:50–1:05)
[ ] R03 Successful Purchase
[ ] R04 Other pane unlock
[ ] R05 Cancel holds
[ ] D01 Last-pass written
[ ] D02 90s ×2
[ ] I01 Compile
[ ] P01 Brad · P03 Matt

FROST WIN (replace C* with F*)
[ ] F01 Frost (0:25–0:45)
[ ] F02 Decoy A
[ ] F03 Simulate
[ ] F04 Vault C (1:05–1:20)
[ ] F05 N/A OK
```

---

## 15.17 DECISION register (fill live)

| ID | Topic | Default | Live decision |
|----|-------|---------|---------------|
| D-15-1 | C01 PASS-SIM allowed? | Yes if verbal + tip visible somewhere | DECISION: |
| D-15-2 | Waive R03 for Simulate Pro? | Only after 2:30 with written waiver | DECISION: |
| D-15-3 | Require T3 in judged demo? | No — soft C07 | DECISION: |
| D-15-4 | Tabletop required for S02? | No — any pose remap OK | DECISION: |
| D-15-5 | Release compile blocking? | Spot-check once; Debug is demo path | DECISION: |

---

## 15.18 Anti-cheat / honesty rules

1. Do not tick PASS for a TC not observed this afternoon.  
2. PASS-SIM must name the Simulate control used.  
3. WAIVE must name clock reason and residual risk.  
4. Do not demo ASC sandbox as “more real” if it burns the slot.  
5. Do not claim Vision coaching if static tips carry the story.  
6. Do not show both CCA tip and Frost decoy as one product.  
7. `PLACEHOLDER_RC_*` in shipping DEBUG demo = R01 FAIL until pasted.

---

## 15.19 Relationship to win completeness bar

| Win-bar must | Covered by |
|--------------|------------|
| Duo API climax visible | C01 or F01–F02 |
| Live demo path | D02 |
| Empty/denied recoveries | C03 C05 / F03 |
| RC Test Store other pane | R02–R04 |
| Brad one-liner | P01/P02 |
| 10–20 min rehearsal | D02 second pass |
| Polished slice ≠ full app | Non-goals §15.8.3 |

---

## 15.20 Source index

| Source | Use |
|--------|-----|
| `docs/bible-single-theme-contract.md` §6 | Canonical TC IDs |
| `docs/win-completeness-bar.md` | What “done” means |
| `docs/outer-lens-3h-build-plan.md` §5 | DoD + 90s |
| `docs/design-direction.md` | Visual locks under test |
| `docs/bible/11-outer-lens-product.md` §11.8 | TC-OL-* detail |
| `docs/bible/11b-outer-lens-flows.md` | Flow recoveries / Simulate |
| `docs/bible/12-frostduo-cutover.md` §12.13 | Frost TC parallel |
| `internal/research-outer-lens.md` | CCA / tip / cutover |
| `internal/design-research-outer-lens-ui.md` | Tip readability |

---

*End §15. Tick live. One climax. Other-pane unlock. Freeze at 3:00. Ship the Film Tool tip — or Frost cutover — not a platform.*
