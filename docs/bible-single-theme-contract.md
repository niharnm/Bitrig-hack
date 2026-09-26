# Bible single-theme contract — Outer Lens only

**For:** Nihar · Project Duo · mega build bible authors  
**Event:** Bitrig Hacks: iPhone Duo · Sat Sep 26, 2026 · ~3h coding slice inside the 11:30–3:30 window  
**Role:** One design theme + one direct build plan. Every bible paragraph must map to a **file path** or a **demo second**. No idea clouds.  
**Constraint:** Spec / planning only — **no app/Swift sources** in this doc.  
**Canonical looks:** [`docs/design-direction.md`](./design-direction.md) · [`docs/ios-craft-addendum.md`](./ios-craft-addendum.md)  
**Architecture:** [`docs/build-bible-blueprint.md`](./build-bible-blueprint.md) · [`docs/multi-ai-build-routing.md`](./multi-ai-build-routing.md)  
**Ready signal:** [`docs/design-research-ready.md`](./design-research-ready.md)  
**Compiled:** Sat Sep 26, 2026

---

## 1. Theme lock statement

**ONE product theme for the mega bible: Outer Lens — Film Tool.**

| Lock | Value | Maps to |
|------|-------|---------|
| Product noun | **Outer Lens** (Coach) | Brad line · `docs-runtime/DEMO-SCRIPT.md` · string tables |
| Visual theme | **Film Tool** — charcoal `#050505`, amber `#E8A838`, SF Rounded tip ≥28pt, solid outer tip plate | `DesignSystem/Tokens.swift` · §13 |
| Climax API | **`CameraCaptureAccessory`** via `.sceneAccessory` | `Duo/CameraCaptureAccessoryHost.swift` · demo 0:15–0:45 |
| Free vs Pro | Free outer T1 tip; Pro T2 guide oval on the **other** pane after RevenueCat Test Store | `Features/Paywall/**` · `Monetization/**` · demo 0:50–1:20 |
| Brand | Wordmark **Outer Lens** is a hero-level signal on every primary surface — not nav-only | SCR-OL-B / SCR-OL-C chrome |

**FrostDuo is not a second product to design “insufficiently.”** It is the **hour-one CUTOVER module**:

- Built **behind** `Shared/CutoverFlag.swift` / `docs-runtime/CUTOVER.flag`.
- Spec lives in bible **§12 only** (SCR-FD-*), with tokens in design-direction §2B.
- Active lanes after gate red (~12:15): SHELL · FROST · RC · COPY · ASSETS · DEMO · INTEGRATOR.
- **Do not** give FrostDuo a parallel Film Tool redesign, second brand system, or equal page budget to Outer Lens. Cutover = swap root slot + flip flag + switch DEMO-SCRIPT appendix — not a second bible.

**Brad (Outer Lens, frozen):** Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.

**Brad (FrostDuo, cutover only):** Shoulder-surfers ruin private screens — Duo frosts the inner face and shows a decoy on the outer; Pro unlocks vault decoys.

If a bible paragraph cannot point at Outer Lens Film Tool **or** the FrostDuo cutover flag path, **delete it**.

---

## 2. Out of scope kill list (banned from bible)

These concepts scored, scanned, or appeared in Luma/intel. They are **forbidden** as screens, lanes, SCR-IDs, types, demo beats, or “nice if time” appendix product slices.

### 2A. Rejected product concepts (hard ban)

| Banned noun | Why dead | Do not invent |
|-------------|----------|---------------|
| **PoseAgent** / PoseAgent lite / LocalAssist agent | Lost score-off (7.3–7.6); FM + multi-pose = 4h trap | Agent panes, listen mode, map/plan tools |
| **HingeBeat** / Accorduon-as-product | Crowded hinge-instrument lane (6.7); DQ-adjacent | Reed synth, bellows, hinge→layout |
| **Interview coach** / sales voice coach / Pitchée Flex Voice | Mix #4 — not locked; second climax surface | FoldAware voice packs as product |
| **Generic “agents”** / chat-on-fold / OYI agent thesis | Anti-pattern; cloud-chat wrapper DQ risk | Chat tabs, tool-calling kabuki as climax |
| Cover Stage Lens as **primary** (mix #2) | Pattern fuel only; CCA already owned by Outer Lens | Second CCA product identity |
| Stickless Outer Preview / Flex Tabletop Drill / Pose Shelf / Scrunch Breath / Folio Study / FoldingVideo Media | Lower mixes; dilute Film Tool | Alternate product nouns in §01–§02 |
| SalesCue / SnapDecoy / YogaTable (dark-horse mixes) | Not the lock | Alternate RC stories |
| Tabletop Drill Coach as **primary** | Dark horse only; tabletop = **polish pose**, not product | ClawKit game/cabinet as entry |

### 2B. Feature / tech kill list

| Banned | File/demo consequence |
|--------|------------------------|
| Multipeer / Watch / second-phone remote | No transport code paths |
| Multicam grid, lens rack, Watch remote | No SCR for camera matrix |
| Foundation Models / cloud tips as load-bearing | Optional one tip string **after** climax or **cut** (§15 max 1 beat) |
| PrivacyScreen / SnapShield / Moments / Shot Caller / ClawKit / Cosign **forks** | Remix patterns; cite only |
| Accorduon / Flex video / Flip launcher / Android folio chrome | No screenshots in pitch; no layout clones |
| Paywall on the **outer** | Paywall = SCR-OL-D / SCR-FD-D **inner only** |
| Tip lists, icon grids, floating face badges on outer | Outer = one tip · T1–T3 only |
| Skeleton HUD on free tier; traffic-light threat banners | Frost copy = quiet “Covered” / “Private” |
| Layout from `onHingeChange` degrees | Hinge = effects only · `Duo/PoseRouter.swift` |
| Second climax API in one build (CCA **and** frost live in one demo path) | One climax glass ≤30s |
| Auth, Supabase, Sentry, OpenAI, backend, ASC production, marketing site, multi-user sync | Out of bible §00 |
| Purple→indigo / cream+terracotta / broadsheet / glow stacks / emoji chrome | Banned in §13 tokens |
| Liquid Glass over outer tip text / face; glass shutter; carnival glass frost | See ios-craft-addendum |
| Pre-Saturday shipping app sources / secret finished binary | Human prep rule |

### 2C. Bible author rule

Any draft that introduces a banned noun, SCR outside §5, or a path outside §4 → **Integrator nack**. Scope guard (routing lane 9) cites this contract.

---

## 3. Exact build target for 3h (numbered milestones + minute budgets)

**Clock assumption:** Coding slice **180 minutes** (aligns with blueprint T+0 → FREEZE; lunch absorbed outside these blocks). Orchestrator owns gate flips.

| # | Milestone | Minutes | Done when | Primary paths / demo secs |
|---|-----------|--------:|-----------|---------------------------|
| **M0** | Toolchain + §00 paste | **10** | Xcode 27.1 · Duo sim booted · every agent has §00 + this contract | Human · no feature files yet |
| **M1** | Scaffold tree | **15** | Empty app ⌘R on Duo sim; §4 tree stubs exist | `App/**` · project · SPM RevenueCat stubs |
| **M2** | Duo shell green | **25** | Arrangement chrome + pose remaps regions; hinge effects-only | `Duo/PoseRouter.swift` · `App/RootArrangementView.swift` · `Shared/CutoverFlag.swift` |
| **M3** | **GATE-CCA** (~T+50 / ~12:15) | **5** | Outer path green **or** `CUTOVER.flag` → Frost primary | `docs-runtime/GATE-CCA.md` · `docs-runtime/CUTOVER.flag` |
| **M4a** | Outer Lens vertical slice *(if gate green)* | **55** | SCR-OL-A→C live: perm → inner capture → outer T1 tip | `Duo/CameraCaptureAccessoryHost.swift` · `Features/Capture/**` · `Features/CoachOverlay/**` · demo **0:00–0:45** |
| **M4b** | FrostDuo cutover slice *(if gate red)* | **55** | SCR-FD-A→C: clear → Simulate Threat → frost + decoy A | `Features/Frost/**` · demo cutover appendix **0:00–0:45** |
| **M5** | RevenueCat Test Store | **35** | Configure `test_` · paywall · Successful Purchase · **other pane** unlock | `Monetization/**` · `Features/Paywall/**` · `docs-runtime/RC-IDs.md` · demo **0:50–1:20** |
| **M6** | Integrate + Pro bloom / vault | **15** | `EntitlementState.isPro` drives T2 (OL) or decoy C (FD) | Shared observe · Integrator merge · demo **1:05–1:20** |
| **M7** | Copy / assets soft land | **10** | Brad/Matt strings + tip glyphs / decoy stills resolve | `Resources/**` · `DesignSystem/Tokens.swift` · `docs-runtime/DEMO-SCRIPT.md` |
| **M8** | Freeze + acceptance | **10** | Tag freeze · TC suite or waivers · 90s ×1 dry | `docs-runtime/DEMO-LAST-PASS.md` · §6 tests |

**Parallel rule (after M2):** max **three** coding writers — feature (CCA **or** FROST) ∥ RC ∥ COPY/ASSETS. Frost standby files OK while Outer Lens green; **no fourth live writer**.

**Hard stops**

- After M3 red → **stop all CCA feature work**; do not half-build both.
- After M8 → no new screens, packs, climax APIs.
- Optional on-device Vision tip / tabletop polish / Frost closed-cover: **only if M8 green early** — never steal M4–M5 minutes.

---

## 4. File tree freeze (exact paths Saturday)

Root product folder name: **`DuoApp/`**. Every leaf has one owner lane. Bible §06 must print this tree verbatim (rename only via Integrator + changelog).

```text
DuoApp/
  App/
    DuoAppApp.swift                      # LANE-SHELL
    RootArrangementView.swift            # LANE-SHELL
  Duo/
    PoseRouter.swift                     # LANE-SHELL
    ArrangementRegions.swift             # LANE-SHELL
    CameraCaptureAccessoryHost.swift     # LANE-CCA (empty hook until Outer Lens)
  Features/
    Capture/                             # LANE-CCA
      CaptureSessionController.swift
      InnerCaptureView.swift
      PermissionPrimerView.swift
      CaptureDeniedView.swift
    CoachOverlay/                        # LANE-CCA (+ COPY strings)
      SubjectCoachView.swift
      TipPlateView.swift
      GuideOvalView.swift
      CountdownView.swift
    Paywall/                             # LANE-RC
      PaywallHostView.swift
    Frost/                               # LANE-FROST (behind CutoverFlag)
      SensitiveSurfaceView.swift
      FrostControlsView.swift
      FrostOverlayView.swift
      OuterDecoyStageView.swift
      SimulateThreatControl.swift
      ThreatLevel.swift
  Monetization/
    PurchasesConfig.swift                # LANE-RC
    Entitlements.swift                   # LANE-RC → EntitlementState
  DesignSystem/
    Tokens.swift                         # LANE-ASSETS
    Motion.swift                         # LANE-ASSETS (M1–M3 / F1–F3 / P1–P3)
  Resources/
    Assets.xcassets/
      Coach/                             # LANE-ASSETS
      Frost/                             # LANE-ASSETS (packs A/B/C)
      Shared/
    Localizable.strings                  # LANE-COPY
  Shared/
    Types.swift                          # INTEGRATOR
    CutoverFlag.swift                    # LANE-SHELL (read by all)
  docs-runtime/
    GATE-SHELL.md
    GATE-CCA.md
    GATE-RC.md
    GATE-FROST.md
    RC-IDs.md                            # HUMAN paste only
    CUTOVER.flag                         # Orchestrator write only
    DEMO-SCRIPT.md
    DEMO-LAST-PASS.md
```

**Forbidden new top-level folders on Saturday:** `Agents/`, `Chat/`, `Interview/`, `HingeBeat/`, `PoseAgent/`, `Backend/`, `Marketing/`.

**SPM (locked):** `RevenueCat` + `RevenueCatUI` from `purchases-ios-spm` ≥ **5.43.0**. No PrivacyScreen / SnapShield / Moments packages.

---

## 5. Screen ID freeze

### 5A. Primary — only these Outer Lens IDs

| SCR-ID | Screen | Path anchor | Demo seconds (90s) |
|--------|--------|-------------|--------------------|
| **SCR-OL-A** | Permission primer (inner) | `Features/Capture/PermissionPrimerView.swift` | **0:00–0:10** |
| **SCR-OL-B** | Capture shell (inner) | `Features/Capture/InnerCaptureView.swift` | **0:10–0:40** · shutter / flip / Pro CTA |
| **SCR-OL-C** | Subject coach (outer CCA) | `Features/CoachOverlay/SubjectCoachView.swift` | **0:15–0:45** T1 · **1:05–1:20** T2 bloom |
| **SCR-OL-D** | Paywall (inner only) | `Features/Paywall/PaywallHostView.swift` | **0:50–1:05** |
| **SCR-OL-E** | Empty / denied / unavailable | `Features/Capture/CaptureDeniedView.swift` | Fallback if needed; never bricks inner |

**Tip styles (only):** **T1** line · **T2** Pro guide · **T3** countdown — rendered inside SCR-OL-C.

**Motions (only):** **M1** tip settle · **M2** countdown punch · **M3** Pro unlock bloom · press micros **P1–P3** on SCR-OL-B.

### 5B. Cutover — only these FrostDuo IDs (behind flag)

| SCR-ID | Screen | Path anchor | Demo seconds (cutover script) |
|--------|--------|-------------|-------------------------------|
| **SCR-FD-A** | Sensitive surface (inner) | `Features/Frost/SensitiveSurfaceView.swift` | **0:00–0:15** |
| **SCR-FD-B** | Controls / Simulate (inner) | `Features/Frost/FrostControlsView.swift` | **0:15–0:35** |
| **SCR-FD-C** | Outer decoy stage | `Features/Frost/OuterDecoyStageView.swift` | **0:25–0:45** A/B · **1:05–1:20** C |
| **SCR-FD-D** | Paywall (inner) | `Features/Paywall/PaywallHostView.swift` *(shared RC host)* | **0:50–1:05** |
| **SCR-FD-E** | Closed-cover vault (nice) | Optional outer-only; **cut first** | Only if M8 early |

**Decoy packs (only):** **A** Lock Lookalike · **B** Busy Cover · **C** Vault Cover (Pro).  
**Motions (only):** **F1** frost settle · **F2** decoy snap · **F3** vault crossfade.

### 5C. Naming rule

- Bible, TC IDs, and agent prompts use **`SCR-OL-*` / `SCR-FD-*` only**.
- Aliases like `OL-A` in design-direction map 1:1 to `SCR-OL-A` — do not invent `SCR-I-01`, `SCR-01`, or third product prefixes.
- **Zero** SCR-IDs for PoseAgent, HingeBeat, interview, agents, Accorduon, Flex, etc.

---

## 6. Acceptance tests — “done” for the win slice

Win slice = **one** live Duo climax + RC other-pane unlock + 90s script. Pass **all Primary** rows **or** (after cutover) **all Cutover** rows, plus **Always**.

### 6A. Always (both modes)

| TC | Assertion | Evidence |
|----|-----------|----------|
| **TC-S01** | App launches on Duo sim | `GATE-SHELL.md` |
| **TC-S02** | Pose remaps regions / panes without hinge-driven layout | `Duo/PoseRouter.swift` |
| **TC-S03** | `onHingeChange` used for effects only | Code review + GATE-SHELL |
| **TC-S04** | `CutoverFlag` readable by feature lanes | `Shared/CutoverFlag.swift` |
| **TC-R01** | `Purchases.configure` with human `test_` key (DEBUG) | `Monetization/PurchasesConfig.swift` |
| **TC-R02** | Paywall presents (RevenueCatUI) | SCR-OL-D / SCR-FD-D |
| **TC-R03** | Test Store **Successful Purchase** | Live modal |
| **TC-R04** | Unlock visible on the **other** display | Demo **1:05–1:20** |
| **TC-R05** | Cancel / Fail keeps gate locked | Rehearsed once |
| **TC-D01** | This suite (or written waivers) recorded | `docs-runtime/DEMO-LAST-PASS.md` |
| **TC-D02** | 90s script ×2 rehearsal | `docs-runtime/DEMO-SCRIPT.md` |
| **TC-I01** | Release/Debug compile on integrate branch | Integrator |

### 6B. Primary Outer Lens (CUTOVER.flag = false)

| TC | Assertion | Demo sec / path |
|----|-----------|-----------------|
| **TC-C01** | Outer tip/preview readable ≤30s with zero narration | **0:15–0:45** · SCR-OL-C · T1 |
| **TC-C02** | Inner shutter + live preview | SCR-OL-B · `Features/Capture/**` |
| **TC-C03** | `accessory.unavailable` → inner still shoots | SCR-OL-E path |
| **TC-C04** | Pro guide (T2) follows `EntitlementState.isPro` | SCR-OL-C after TC-R03 |
| **TC-C05** | Camera denied → Settings path | SCR-OL-A → SCR-OL-E |
| **TC-P01** | Outer Lens Brad frozen in spoken script | DEMO-SCRIPT 0:00–0:10 voice |
| **TC-P03** | Matt: free outer tip / Pro overlays on outer | DEMO-SCRIPT ~1:20 |
| **Win visual** | Film Tool charcoal + amber Pro; brand **Outer Lens** visible | Tokens + SCR-OL-B/C |
| **Win motion** | M1 once · M3 on unlock (M2 if countdown in script) | `DesignSystem/Motion.swift` |

### 6C. Cutover FrostDuo (CUTOVER.flag = true)

| TC | Assertion | Demo sec / path |
|----|-----------|-----------------|
| **TC-F01** | Threat → inner frost | SCR-FD-A · F1 |
| **TC-F02** | Outer decoy at locked | SCR-FD-C · pack A |
| **TC-F03** | **Simulate Threat** works in sim | SCR-FD-B |
| **TC-F04** | Pro vault/decoy C gated by `pro` | SCR-FD-C after TC-R03 · F3 |
| **TC-F05** | Closed-cover beat optional — **not** required for win | SCR-FD-E |
| **TC-P02** | Frost Brad ready | DEMO-SCRIPT cutover appendix |
| **Win visual** | Ice-soft frost; quiet Covered/Private; no cyber HUD | Tokens §2B |
| **Win motion** | F1+F2 on Simulate; F3 on unlock | Motion.swift |

### 6D. Explicit non-goals (do not block “done”)

Vision/pose ML accuracy · real second-face without Simulate · ASC/sandbox restore · StandBy/widgets · multiple tip packs beyond T1–T3 · closed-cover SCR-FD-E · marketing site · Perfect Liquid Glass on every control.

---

## 7. Rule — no idea clouds

**Every bible paragraph must map to a file path or a demo second.**

| If the paragraph is about… | It must name… |
|----------------------------|---------------|
| UI / state / tip / decoy | A **SCR-OL-*** or **SCR-FD-*** ID + Swift path from §4 |
| Duo / RC / frost behavior | A **VERIFIED** symbol or recipe file (`research-*.md` cite OK) + Saturday owner path |
| Time / rehearsal | A **demo timestamp** (`0:00–1:30`) or milestone **M0–M8** |
| Lanes / agents | A **LANE-*** ID + owned paths from blueprint §18B |
| Visual / motion | A token / **M# · F# · P# · T#** ID + `DesignSystem/` path |
| Cutover | `docs-runtime/CUTOVER.flag` + which SCR set is live |

**Delete or rewrite** any prose that is: alternate product brainstorming, “future roadmap,” multi-agent platforms, interview/sales/hinge toys, or unowned “we could also…”.

**Bible author checklist (paste into §00):**

1. Theme = Outer Lens Film Tool; FrostDuo = flagged cutover only.  
2. Kill list §2 obeyed — no PoseAgent / HingeBeat / interview / agents product.  
3. 3h plan = M0–M8 only.  
4. Tree = §4 only.  
5. Screens = SCR-OL-* (+ SCR-FD-* behind flag) only.  
6. Done = §6 TCs.  
7. Every paragraph → path or demo second.

---

## Pointers

| Need | Doc |
|------|-----|
| Tokens / SCR map / motion | `docs/design-direction.md` |
| Liquid Glass additive | `docs/ios-craft-addendum.md` |
| Lane OS / merge | `docs/build-bible-blueprint.md` |
| Tool → lane | `docs/multi-ai-build-routing.md` |
| CCA / tips / cutover gate | `internal/research-outer-lens.md` |
| Frost / Simulate / decoys | `internal/research-frostduo.md` |
| RC Test Store | `internal/research-revenuecat.md` |
| Duo API VERIFIED catalog | `internal/research-duo-apis.md` |
| Green light | `docs/design-research-ready.md` |

---

*End of single-theme contract. Mega bible must obey this before expanding §00–§20.*
