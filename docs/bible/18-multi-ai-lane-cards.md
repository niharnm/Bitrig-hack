# §18 — Multi-AI lane cards (paste-ready)

**Routing update, 2026-09-26:** Bitrig owns visual QA and Duo demo captures now, then replaces Cursor for ASSETS polish after the current owner hands off. Cursor retains scaffold, integration, and Frost standby. Use the Codex provider in Bitrig. See [Bitrig task assignment](../bitrig-task-plan.md) for evidence, exact file locks, handoff conditions, and the first task prompt. This update takes precedence over older tool assignments below; lane boundaries and the three-writer limit still apply.

**For:** Nihar · Bitrig Hacks iPhone Duo · Sat Sep 26, 2026  
**Role:** One paste block per AI session — **own X / don’t touch Y / read these / done when**  
**Tools:** Claude Code (Opus) · Codex CLI (or Cursor+GPT) · Cursor Agent on Xcode Mac · optional Gemini ingest · scope-guard Opus  
**Max live writers:** **3**  
**Inputs:** `docs/multi-ai-build-routing.md` · `docs/build-bible-blueprint.md` · `docs/bible-single-theme-contract.md` · `docs/outer-lens-3h-build-plan.md` · `docs/design-direction.md` · `docs/win-completeness-bar.md`  
**Constraint:** Cards are prompts + ownership — **no app source** in this chapter  
**Compiled:** Sat Sep 26, 2026

---

## 0. How to use lane cards

**DECISION:** Path mutex + **max three coding writers**. Cards > vibes. FrostDuo is cutover-only behind `CUTOVER.flag` — never a fourth equal product lane.

1. Every session starts with **§1 Shared §00 paste** + **one lane card** below.  
2. Attach / point at: single-theme contract, design-direction tokens, this chapter’s card, and the relevant research pack path.  
3. **≤3 writers hard gate:** Scaffold and Duo-core are **serial**. After `docs-runtime/SHELL-READY.md` (or `GATE-SHELL.md`) exists, those sessions go **read-only / closed** before opening the parallel trio. Live writers then = **CCA + RC + (FROST standby OR ASSETS polish OR idle)** — never four. Integrator merges are serial bursts (pause one feature writer if needed).  
4. Prefer live set after shell: **Claude LANE-CCA + Codex LANE-RC + (Cursor LANE-FROST standby OR ASSETS polish)**.  
5. If GATE-CCA RED → promote LANE-FROST card; demote LANE-CCA feature work.  
6. **INTEGRATOR** (human/Cursor) is the only merger across lane paths; **Orchestrator** alone writes gates / `CUTOVER.flag`.  
7. For tool fan-out, use **§17 HOW TO SEND TO CLAUDE / CODEX / CURSOR** paste packs — do not freestyle ownership.

**Prompt header template (all tools):**

```text
You are LANE-<ID> for Duo Sat Outer Lens build (FrostDuo = cutover only).
Read §00 invariants below, then your lane card only.
Refuse work outside owned paths. Do not invent Duo API signatures or RC IDs.
Do not expand scope. Done = lane TCs listed on your card.
```

---

## 1. Shared §00 invariants (paste into EVERY agent)

```text
§00 INVARIANTS — Outer Lens Film Tool (Bitrig Duo Sat)
1) Theme = Outer Lens only. FrostDuo is CUTOVER behind Shared/CutoverFlag + docs-runtime/CUTOVER.flag — not a second equal product.
2) Climax API = CameraCaptureAccessory / .sceneAccessory subject coach on the OUTER. One climax glass ≤30s.
3) Monetization = RevenueCat Test Store + RevenueCatUI ≥5.43; entitlement id exactly `pro`; unlock must change the OTHER pane.
4) Visual = Film Tool: canvas #050505, accent #E8A838, tip SF Rounded ≥28pt ≤8 words, solid outer tip plate (no glass on tip/face).
5) Layout via ArrangementView / reservedRegions; onHingeChange = effects ONLY — never layout.
6) Kill list: PoseAgent, HingeBeat/Accorduon-as-product, interview/sales coach, chat-on-fold, Multipeer/Watch, Vision-as-required, FM load-bearing, Supabase/auth/Sentry/OpenAI-as-product, ASC sandbox, paywall on outer, purple/cream AI-slop.
7) Human pastes RC-IDs.md; agents NEVER invent test_ keys / offering IDs. If placeholders remain → mark BLOCKED and stop.
8) Max 3 coding writers. Path mutex: write only owned paths. Integrator merges.
9) Simulator ≠ camera accessory hardware proof — ship Simulate tip / Simulate Pro / Simulate countdown.
10) After FREEZE 3:00 — no new features; hotfixes only if Orchestrator names file + demo-blocker.
11) Remix patterns only — never fork scored OSS into the submission.
12) Every change must map to a file path or a demo second (bible-single-theme-contract rule).
```

---

## 2. Master ownership table (quick)

| Lane ID | Tool primary | Owns (write window) | Must not touch |
|---------|--------------|---------------------|----------------|
| **ORCH** | Nihar + cheap Cursor | Clock, gates, `CUTOVER.flag`, `GATE-CCA.md`, merge call, demo | Feature Swift drive-by; fourth live writer |
| **SHELL** | Cursor Agent | Until `GATE-SCAFFOLD.md=PASS`: Xcode/SPM, tree stubs, empty Swift stubs, `App/DuoAppApp.swift`, placeholder `RootArrangementView`, stub `PoseRouter` / `ArrangementRegions` / `CutoverFlag` / `Types` | `Features/**`, `Monetization/**`, real Arrangement/CCA logic; **stop writing after GATE-SCAFFOLD** |
| **DUOCORE** | Claude Code Opus | After scaffold → until `SHELL-READY.md`: `Duo/PoseRouter.swift`, `App/RootArrangementView.swift`, `Duo/ArrangementRegions.swift`, `Shared/CutoverFlag.swift` (readable API; ORCH still owns flag flip), empty CCA host hook only | `Features/Capture/**`, `CoachOverlay/**`, `Frost/**`, `Monetization/**`; **stop writing after SHELL-READY handoff** |
| **CCA** | Claude Code Opus | After SHELL-READY: `Duo/CameraCaptureAccessoryHost.swift`, `Features/Capture/**`, `Features/CoachOverlay/**` | `Monetization/**`, `Features/Frost/**`, PoseRouter tables, invent RC IDs |
| **RC** | Codex CLI | `Monetization/**`, `Features/Paywall/**`, `GATE-RC.md` | Pose router, CCA/Frost layout, invent IDs |
| **FROST** | Cursor BG / 2nd Codex | `Features/Frost/**` only (standby or promoted) | Capture/Coach; flipping `CUTOVER.flag` alone |
| **ASSETS** | Bitrig with Codex after handoff | After feature inputs freeze: `DesignSystem/**`, `Resources/Assets.xcassets/{Coach,Frost,Shared}` | New screens, climax APIs, mid-day parallel token rewrites |
| **COPY** | Human / Cursor checklist | Strings, `DEMO-SCRIPT.md` | SDK logic; “improved” taglines |
| **QA** | Nihar + Bitrig visual evidence | TC ticks, `DEMO-LAST-PASS.md` | Drive-by refactors |
| **GUARD** | Claude Opus read-only | Nacks | Write access |
| **INTEG** | Nihar / Cursor | Cross-lane merges; `Shared/Types.swift` after stubs; EntitlementState → other-pane wire; root slot on cutover | Unowned feature invention; counting as a 4th parallel feature writer |

---

## 3. Card — ORCH (Orchestrator) · Human + cheap Cursor

### Paste

```text
LANE-ORCH — Orchestrator
YOU OWN: wall clock, gate decisions, docs-runtime/GATE-CCA.md, CUTOVER.flag, merge order calls, sim clicks, demo performance, DEMO-SCRIPT paste.
DO NOT TOUCH: implementing feature Swift yourself unless hotfix named; do not let a fourth writer start.
READ: docs/bible/17-saturday-clock.md; docs/bible/16-demo-script-90s.md; bible-single-theme-contract.md §3–§6.
DONE WHEN:
- 12:15 GATE-CCA written GREEN or RED
- 3:00 FREEZE declared
- 90s ×2 rehearsed; Brad+Matt memorized
- DEMO-LAST-PASS.md exists
CONCURRENCY: keep ≤3 coding writers. SHELL then DUOCORE are serial and must close before the trio. Preferred live set: CCA + RC + (FROST standby OR polish). Refuse a fourth terminal/agent.
```

### Conflict locks you enforce

| Hot file | Lock |
|----------|------|
| `CUTOVER.flag` / `GATE-CCA.md` | ORCH write only |
| `App/DuoAppApp.swift` / pbxproj after scaffold | ORCH/INTEG only |
| `RC-IDs.md` | Human paste; RC reads |

---

## 4. Card — SHELL / Scaffold · Cursor Agent on Mac

### Paste

```text
LANE-SHELL (Scaffold → later Integrate/Polish)
YOU OWN ONLY:
- Xcode project creation for DuoApp
- Folder tree stubs per bible-single-theme-contract §4
- Empty Swift file stubs with TODO → §08 (do not invent Duo signatures)
- SPM package refs: RevenueCat + RevenueCatUI from purchases-ios-spm ≥5.43.0 (configure NOT required yet)
- Later (Integrator phase): merge named patches; late DesignSystem apply if assigned

DO NOT TOUCH:
- ArrangementView real logic beyond placeholder RootArrangementView
- CameraCaptureAccessory implementation
- Paywall UI / Purchases.configure
- Features/Frost UI
- DesignSystem taste pass during scaffold window

READ:
- bible-single-theme-contract.md §4 tree
- multi-ai-build-routing.md Lane 2 stub
- research-duo-apis.md (quirks only — slow first boot)

DONE WHEN:
- Empty app ⌘R on Duo simulator
- Device Hub fold reacts
- docs-runtime/GATE-SCAFFOLD.md = PASS
- Tree matches §4 top-level folders

STOP at GATE-SCAFFOLD. Close or idle this writer. HANDOFF ARTIFACT: docs-runtime/GATE-SCAFFOLD.md=PASS → LANE-DUOCORE (Claude) owns PoseRouter / RootArrangementView.
```

### Owned paths

```text
App/DuoAppApp.swift
App/RootArrangementView.swift          # placeholder OK at scaffold; Duo-core fills
Duo/PoseRouter.swift                   # stub then Duo-core
Duo/ArrangementRegions.swift
Shared/CutoverFlag.swift
Shared/Types.swift                     # stubs; Integrator locks later
project.pbxproj / Package.resolved     # until GATE-SCAFFOLD; then ORCH/INTEG
```

### Lane TCs

TC-S01 launch · scaffolding for TC-S02–S04 (Duo-core completes pose proof).

---

## 5. Card — Duo core (pose shell) · Claude Code + Opus

### Paste

```text
LANE-DUOCORE (Claude Code / Opus) — starts only after GATE-SCAFFOLD=PASS
YOU OWN ONLY:
- Duo/PoseRouter.swift
- App/RootArrangementView.swift
- Duo/ArrangementRegions.swift wiring
- Shared/CutoverFlag.swift readability
- Pose → pane chrome visible on Duo sim
- Empty host hook for CCA if bible says shell hosts modifier empty — do NOT implement coach tips

RULES:
- Layout via ArrangementView / reservedRegions ONLY
- onHingeChange / hinge = effects/input ONLY — never layout
- idiom stays .phone; guard iOS 27.1

DO NOT TOUCH:
- Features/Capture/**
- Features/CoachOverlay/**
- Features/Frost/**
- Monetization/**
- DesignSystem tokens beyond placeholders
- CameraCaptureAccessory tip content (Outer Lens owns after SHELL-READY)

READ:
- research-duo-apis.md VERIFIED catalog
- design-direction.md dual-display choreography §5
- bible-single-theme-contract.md §4–§5

DONE WHEN:
- Pose remaps regions on Duo sim (TC-S02)
- Hinge effects-only verified in review notes (TC-S03)
- CutoverFlag readable (TC-S04)
- Write docs-runtime/SHELL-READY.md (alias GATE-SHELL.md OK) so CCA lane may attach .sceneAccessory

HANDOFF: close this writer (do not stay as a 4th live coder). HAND OFF to LANE-CCA. Do not start RevenueCat. Parallel trio may open only after this file exists.
```

---

## 6. Card — CCA / Outer Lens · Claude Code + Opus (PRIMARY FEATURE)

### Paste

```text
LANE-CCA — Outer Lens Coach (PRIMARY)
YOU OWN ONLY:
- Duo/CameraCaptureAccessoryHost.swift
- Features/Capture/**
  CaptureSessionController.swift
  InnerCaptureView.swift
  PermissionPrimerView.swift
  CaptureDeniedView.swift
- Features/CoachOverlay/**
  SubjectCoachView.swift
  TipPlateView.swift
  GuideOvalView.swift
  CountdownView.swift

PRODUCT RULES:
- Inner = controls + AV session + shutter + flip + Pro CTA (CTA may call paywall presenter owned by RC)
- Outer = subject coach via CameraCaptureAccessory — ONE tip (T1), optional countdown (T3), Pro guide oval (T2) when EntitlementState.isPro is true
- Free tip strings (verbatim): "Chin up · eyes to the lens" | "Fill the frame · step closer" | "Soft smile · both faces in"
- Tip ≥28pt SF Rounded; ≤8 words; solid tip plate + scrim — NO Liquid Glass on outer tip/face
- Film Tool charcoal #050505; amber #E8A838 ONLY for Pro oval / Pro moments
- Ship Settings: Simulate tip / Simulate Pro / Simulate countdown
- If accessory unavailable: keep inner capture alive; surface accessory.unavailable — NEVER brick
- Photo only — no mic/video

DO NOT TOUCH:
- Monetization/** (observe EntitlementState only — RC writes it)
- Features/Frost/**
- PoseRouter pose tables
- DesignSystem full rewrite (use token placeholders until polish)
- Foundation Models / Multipeer / Vision-as-required / Settings tabs forest
- Inventing RC dashboard IDs

READ:
- design-direction.md §2A tokens, §3A screens, §4 motions M1–M3, §10 glass rules
- research-outer-lens.md
- research-duo-apis.md CCA section
- win-completeness-bar.md Outer Lens MUST table
- docs/bible/16-demo-script-90s.md climax seconds 0:15–0:45

DONE WHEN lane TCs pass:
- TC-C01 Outer tip/preview readable ≤30s with zero narration (or Simulate tip path honest)
- TC-C02 Inner shutter + preview (or black+shutter)
- TC-C03 accessory.unavailable → inner still shoots
- TC-C04 Pro guide (T2) follows EntitlementState.isPro (after RC merge)
- TC-C05 Camera denied → Settings path
Stop at vertical slice for demo path. No tip-pack theater beyond 3 free strings.
```

### Motions you may implement

| ID | Where | Spec |
|----|-------|------|
| M1 | Outer T1 | Fade + rise 8–12pt · 220ms |
| M2 | Outer T3 | numericText punch |
| M3 | Outer T1→T2 | Amber oval bloom (needs isPro) |
| P1–P3 | Inner | Press micros only — optional if time |

---

## 7. Card — RC / RevenueCat · Codex CLI (or Cursor + GPT)

### Paste

```text
LANE-RC — RevenueCat Test Store
YOU OWN ONLY:
- Monetization/PurchasesConfig.swift
- Monetization/Entitlements.swift  → publishes EntitlementState (isPro; entitlement id "pro")
- Features/Paywall/PaywallHostView.swift
- docs-runtime/GATE-RC.md (write results)

SDK RULES:
- SPM: RevenueCat + RevenueCatUI from purchases-ios-spm, version ≥ 5.43.0
- Configure with human-provided test_ API key under #if DEBUG only
- Use RevenueCatUI paywall (PaywallView / presentPaywallIfNeeded pattern per research-revenuecat.md)
- Test Store Successful Purchase must flip entitlements["pro"].isActive
- Unlock must be consumable by OTHER pane (Outer Lens GuideOval / Frost vault) via EntitlementState — you do NOT layout coach views

READ RC-IDs.md FIRST:
- If placeholders remain → mark BLOCKED in GATE-RC.md and STOP
- Do NOT invent test_ keys, offering identifiers, or product ids

DO NOT TOUCH:
- Duo/PoseRouter.swift
- Features/Capture/** layout
- Features/CoachOverlay/** layout (observe-only integration hooks OK via Integrator)
- Features/Frost/**
- ASC / StoreKit .storekit / Apple sandbox fight

READ:
- internal/research-revenuecat.md
- bible-single-theme-contract.md TC-R01–R05
- docs/bible/17-saturday-clock.md Block E

DONE WHEN:
- TC-R01 Purchases.configure with test_ key
- TC-R02 Paywall presents
- TC-R03 Test Store Successful Purchase
- TC-R04 Unlock visible on other display (after Integrator wire)
- TC-R05 Cancel/Fail keeps gate locked (rehearse once)
- GATE-RC.md written PASS/FAIL
```

### RC-IDs.md consume shape (human fills)

```text
api_key: test_...
entitlement: pro
offering_id: ...
package_id: ...
product_id: ...
paywall: published y/n
notes:
```

---

## 8. Card — FROST standby / cutover · Cursor BG or 2nd Codex

### Paste

```text
LANE-FROST — FrostDuo cutover module
YOU OWN ONLY: Features/Frost/**
  SensitiveSurfaceView.swift
  FrostControlsView.swift
  FrostOverlayView.swift
  OuterDecoyStageView.swift
  SimulateThreatControl.swift
  ThreatLevel.swift

BEHAVIOR:
- Behind CutoverFlag / docs-runtime/CUTOVER.flag — do NOT flip the flag yourself (Orchestrator only)
- Inner progressive frost ladder: clear → cautious → threatened → locked
- Outer decoys: A Lock Lookalike (free) · B Busy Cover · C Vault Cover (Pro)
- Ship Simulate Threat (mandatory for sim — ARKit optional)
- Quiet copy "Covered" / "Private" — NEVER THREAT/INTRUDER traffic-light HUD
- Tokens: design-direction.md §2B when flag on
- Motions F1 frost settle · F2 decoy snap · F3 vault crossfade

DO NOT TOUCH:
- Features/Capture/** or CoachOverlay/**
- Monetization/** (observe EntitlementState for Pro vault C)
- App root / PoseRouter (Integrator swaps root slot on cutover)
- Film Tool redesign / second brand system

READ:
- research-frostduo.md
- design-direction.md §3B
- bible-single-theme-contract.md §5B
- docs/bible/16-demo-script-90s.md §8

DONE WHEN (standby): SCR-FD-* vertical slice builds in isolation without importing Capture.
DONE WHEN (promoted primary after RED): TC-F01–F04 pass; TC-F05 optional cut.
```

### Promote checklist (ORCH runs)

1. `CUTOVER.flag = frost`  
2. Root slot → Frost hosts  
3. Stop CCA feature work  
4. Paste Frost Brad/Matt  
5. Same RC `pro` path → vault C  

---

## 9. Card — ASSETS / Polish · Bitrig with Codex (late · Block G)

### Paste

```text
LANE-ASSETS — DesignSystem + motion polish (AFTER feature freeze inputs)
YOU OWN ONLY:
- DesignSystem/Tokens.swift
- DesignSystem/Motion.swift
- Resources/Assets.xcassets/Coach/**
- Resources/Assets.xcassets/Frost/** (if cutover)
- Resources/Assets.xcassets/Shared/**

APPLY:
- Outer Lens tokens: #050505 / #1C1C1E / #E8A838 / tip ≥28pt SF Rounded
- Liquid Glass ONLY on inner control pills; solid shutter; solid outer tip (ios-craft-addendum)
- Motions already timed: M1 M2 M3 and optional P1–P3 — do not invent new climax motions
- Brand whisper "Outer Lens" visible; never louder than tip

DO NOT TOUCH:
- New screens / SCR IDs
- Second climax API
- Monetization logic
- Card soup / purple-indigo / cream-terracotta / glow stacks / emoji chrome

DONE WHEN: demo path looks intentional; non-demo screens deferred.
READ: design-direction.md §2 §4 §10; ios-craft-addendum.md
```

---

## 10. Card — COPY · Human / Cursor checklist

### Paste

```text
LANE-COPY
YOU OWN: Localizable.strings (or SCR copy fields), docs-runtime/DEMO-SCRIPT.md
FREEZE VERBATIM:
Brad OL: Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.
Matt OL: Free: outer preview. Pro: pose overlays on the outer display.
Brad FD: Shoulder-surfers ruin private screens — Duo frosts the inner face and shows a decoy on the outer; Pro unlocks vault decoys.
Matt FD: Free: frost and a lock decoy. Pro: vault covers on the outer display.
Tips: Chin up · eyes to the lens | Fill the frame · step closer | Soft smile · both faces in
DO NOT "improve" taglines. TC-P01 P02 P03 P04.
```

---

## 11. Card — QA / Demo · Nihar + Bitrig

### Paste

```text
LANE-QA
YOU OWN ONLY: running TC-XXX from bible-single-theme-contract §6; writing DEMO-LAST-PASS.md; timing 90s/60s scripts from docs/bible/16-demo-script-90s.md
DO NOT drive-by refactor. File bugs with lane owners. Patch only if Orchestrator marks demo-blocker and names the file.
Include fallback checks: Simulate tip, Simulate Pro, Cancel once.
Stop coding at rehearsal (3:00+). TC-D01 D02.
```

---

## 12. Card — GUARD · Claude Opus read-only

### Paste

```text
LANE-GUARD — Scope guard (READ ONLY)
Nack any patch that:
- adds chat, agents, PoseAgent, HingeBeat, interview coach
- adds Supabase/auth/Sentry/OpenAI as product
- adds second climax API (CCA + frost live together)
- invents RC IDs or Duo API signatures
- uses hinge degrees for layout
- puts paywall on outer
- introduces purple/cream AI-slop visuals
- pastes pre-Saturday finished app sources
Cite bible-single-theme-contract.md §2 and §00. Do not write feature code.
```

---

## 13. Card — INTEGRATOR · Nihar / Cursor

### Paste

```text
LANE-INTEG
YOU OWN: merging branches/worktrees; Shared/Types.swift after initial stubs; cross-lane EntitlementState → GuideOval / Frost vault wire; App root slot swap on cutover.
MERGE ORDER (GREEN): SHELL → CCA compile → RC EntitlementState → wire isPro → smoke TC-C01+TC-R04 → ASSETS polish.
Only you may edit two lanes' files in one commit.
Refuse scope expansions during merge.
```

---

## 14. Conflict zone locks (bible encoding)

| Hot area | Owner | Forbidden writers |
|----------|-------|-------------------|
| `App/DuoAppApp.swift`, pbxproj | SHELL until GATE-SCAFFOLD; then ORCH/INTEG | Feature lanes |
| `RootArrangementView.swift` | **DUOCORE** after scaffold | CCA/Frost drive-by — inject via slots only |
| `PoseRouter.swift` | **DUOCORE** | Polish / Frost / SHELL after GATE-SCAFFOLD |
| `CameraCaptureAccessoryHost.swift` | **CCA** after SHELL-READY | DUOCORE after handoff (empty hook only before) |
| `Entitlements.swift` / `EntitlementState` | **RC writes** | Others observe |
| `Features/Paywall/*` | RC structure; ASSETS may restyle via tokens | CCA layout ownership |
| `DesignSystem/*` | ASSETS late | Parallel token rewrites mid-day |
| `Features/Frost/*` vs Capture | Isolated; no imports across | Panic merges |
| `CUTOVER.flag` / `GATE-CCA.md` | ORCH | All AIs |
| `RC-IDs.md` | Human | AI invention |
| Assets catalogs | Partition Coach/ / Frost/ / Shared/ | Cross-folder writes |
| Demo strings | COPY frozen | “Improved” taglines |

---

## 15. Start order (which AI first)

```text
1) Cursor SHELL scaffold          — serial; stop at GATE-SCAFFOLD
2) Claude DUOCORE shell           — serial; stop at SHELL-READY (close writer)
3) Parallel max 3 coding writers ONLY after SHELL-READY:
     Claude CCA (or Frost if RED)
     Codex RC
     Cursor Frost standby OR idle (ASSETS later, not a 4th alongside CCA+RC+Frost)
4) Cursor Integrator merge        — serial burst; pause a feature writer if merge needs two paths
5) Cursor ASSETS polish           — replaces Frost standby slot in the ≤3 budget (or runs alone)
6) Human QA + demo
```

### Two-AI fallback

**Cursor** = scaffold + RC + polish + integrate  
**Claude Code** = Duo-core + Outer Lens  
Drop live Frost writer until cutover.

---

## 16. Per-block paste cheat (ORCH assigns)

| Block | Paste into session |
|-------|--------------------|
| A | SHELL scaffold card |
| B | Duo-core card → then CCA tip-static |
| C | CCA card + RC card (+ FROST standby optional) |
| D | CCA card continued |
| E | RC card + Integrator watch |
| F | Integrator card |
| G | ASSETS card + GUARD |
| H–I | QA card; all others read-only |

---

## 17. HOW TO SEND TO CLAUDE / CODEX / CURSOR (paste packs)

**DECISION:** Max **three** coding writers at once. Preferred live set after shell: **Claude = LANE-CCA (or Duo-core then CCA)** · **Codex = LANE-RC** · **Cursor = LANE-SHELL → INTEGRATOR → LANE-ASSETS / optional LANE-FROST standby**. Orchestrator (human) is not a fourth Swift writer.

**DECISION:** Lane IDs in prompts must use exactly: `LANE-SHELL` · `LANE-CCA` · `LANE-RC` · `LANE-FROST` · `LANE-COPY` · `LANE-ASSETS` · `INTEGRATOR` · `Orchestrator` (plus optional GUARD / QA read-only).

### 17A. HOW TO SEND TO CLAUDE (Claude Code · Opus) — full paste pack

```text
=== HOW TO SEND TO CLAUDE ===
Attach: bible §00 + this lane card + design-direction.md + research pack for the lane.
You are ONE writer. Do not open Monetization or invent RC IDs.

PHASE 1 — LANE-SHELL Duo-core (until SHELL-READY):
YOU OWN: Duo/PoseRouter.swift, App/RootArrangementView.swift, Duo/ArrangementRegions.swift, Shared/CutoverFlag readability.
DO NOT TOUCH: Features/Capture, Features/CoachOverlay, Features/Frost, Monetization, DesignSystem taste.
DONE WHEN: pose chrome on Duo sim; SHELL-READY.md written; empty CCA host hook only.

PHASE 2 — LANE-CCA Outer Lens (after SHELL-READY; CLOSE Duo-core writer first if you need the slot):
YOU OWN: Duo/CameraCaptureAccessoryHost.swift, Features/Capture/**, Features/CoachOverlay/**
DO NOT TOUCH: Monetization/** (observe EntitlementState only), Features/Frost/**, PoseRouter tables, inventing PLACEHOLDER_RC_* values.
DONE WHEN: TC-C01–C05 path; M1 tip settle; M3 bloom when isPro; Simulate tip/Pro/countdown exist.
NEVER: Frost primary unless Orchestrator says GATE-CCA RED and promotes LANE-FROST.
```

### 17B. HOW TO SEND TO CODEX (Codex CLI or Cursor+GPT) — full paste pack

```text
=== HOW TO SEND TO CODEX ===
Attach: bible §00 + LANE-RC card + internal/research-revenuecat.md + docs-runtime/RC-IDs.md

YOU ARE: LANE-RC
YOU OWN ONLY: Monetization/**, Features/Paywall/**, docs-runtime/GATE-RC.md
SDK: purchases-ios / RevenueCatUI ≥5.43.0; Test Store; entitlement id exactly `pro`.

READ RC-IDs.md FIRST. Human fills:
  PLACEHOLDER_RC_API_KEY=test_...
  PLACEHOLDER_RC_ENTITLEMENT_ID  # expect: pro
  PLACEHOLDER_RC_OFFERING_ID
  PLACEHOLDER_RC_PACKAGE_ID
  PLACEHOLDER_RC_PRODUCT_ID
  PLACEHOLDER_RC_PAYWALL_PUBLISHED=y/n
If any PLACEHOLDER_RC_* remains empty → mark BLOCKED in GATE-RC.md and STOP. Do NOT invent IDs.

DO NOT TOUCH: Duo/PoseRouter, Features/Capture layout, Features/CoachOverlay layout, Features/Frost, ASC sandbox fight.
DONE WHEN: TC-R01–R05; EntitlementState.isPro publishes for OTHER pane (GuideOval or Frost vault C via Integrator).
```

### 17C. HOW TO SEND TO CURSOR (Agent on Xcode Mac) — full paste pack

```text
=== HOW TO SEND TO CURSOR ===
Attach: bible §00 + matching lane card + bible-single-theme-contract.md §4 tree.
You own the Mac merge seat. Cap total coding writers at 3 (you count if writing Swift).

MORNING — LANE-SHELL:
YOU OWN: Xcode proj, §4 tree stubs, SPM RevenueCat stubs, empty RootArrangementView.
DO NOT TOUCH: CCA tips, paywall configure, Frost UI, DesignSystem taste pass.
DONE WHEN: GATE-SCAFFOLD.md PASS; empty app ⌘R on Duo sim.

MID — INTEGRATOR (+ optional LANE-FROST files-only if still GREEN):
YOU OWN: merges; Shared/Types.swift; EntitlementState → GuideOval / vault wire; root slot swap if CUTOVER.flag=frost.
LANE-FROST (standby): Features/Frost/** only — do NOT flip CUTOVER.flag (Orchestrator only).
DO NOT TOUCH: inventing second climax; rewriting Brad/Matt.

LATE — LANE-ASSETS then LANE-QA assist:
YOU OWN: DesignSystem/Tokens.swift, DesignSystem/Motion.swift, Assets Coach/Frost/Shared.
APPLY: Film Tool #050505 / #E8A838; Liquid Glass on side pills only; M1–M3 / F1–F3 / P1–P3 only.
DO NOT TOUCH: new screens; purple/cream AI-slop; glass tip/shutter.
QA: TC ticks + DEMO-LAST-PASS.md — no drive-by refactors.
```

### 17D. Printable triple strip (one sheet)

| Tool | Lane IDs | Own X | Don’t touch Y |
|------|----------|-------|---------------|
| **Claude** | LANE-SHELL Duo-core → LANE-CCA | Pose shell then Capture/Coach | Monetization IDs · Frost primary |
| **Codex** | LANE-RC | Monetization + Paywall | Pose · CCA layout · invent PLACEHOLDER_RC_* |
| **Cursor** | LANE-SHELL → INTEGRATOR → LANE-ASSETS / LANE-FROST standby | Scaffold · merge · tokens · Frost files | Fourth writer · CUTOVER flip · Brad rewrite |

**Orchestrator / LANE-COPY / GUARD:** human + cheap Cursor checklists / read-only nacks — not coding-writer slots unless hotfix-named.

---

## 17E. PLACEHOLDER_RC_* lock (all tools)

**DECISION:** RevenueCat dashboard values are **human-only**. Agents never invent `test_` keys or offering strings.

```text
# docs-runtime/RC-IDs.md — human paste Saturday morning
# DECISION (Claude review P0): tokens = §00 PLACEHOLDER_RC_* only. GATE ticks §15 TC-R01–R05.
PLACEHOLDER_RC_API_KEY=
PLACEHOLDER_RC_ENTITLEMENT_ID  # expect: pro
PLACEHOLDER_RC_OFFERING_ID
PLACEHOLDER_RC_PACKAGE_ID
PLACEHOLDER_RC_PRODUCT_ID
PLACEHOLDER_RC_PAYWALL_PUBLISHED=
```

LANE-RC consumes after fill. Empty placeholders → **BLOCKED** (not guessed).

---

## 18. Handoff contracts (IN → OUT) — concrete, per lane

Every lane **blocks** until HANDOFF IN is true. Every lane **unblocks** the next only when HANDOFF OUT artifacts exist. Do not use chat lore as a gate.

### 18A. Contract table

| Lane | HANDOFF IN (must exist before you write) | HANDOFF OUT (you must produce) | Next consumer |
|------|------------------------------------------|--------------------------------|---------------|
| **SHELL scaffold** | Human: Xcode 27.1 + Duo sim booted; ORCH theme lock Outer Lens | `GATE-SCAFFOLD.md=PASS`; empty tree stubs; SPM refs present | Duo-core |
| **Duo-core** | `GATE-SCAFFOLD=PASS` | `GATE-SHELL.md` or `SHELL-READY.md`; pose chrome visible; empty CCA host hook **or** documented slot | CCA |
| **CCA** | `SHELL-READY`; `CutoverFlag` readable; `EntitlementState` stub type exists (even if RC not live) | Compile Capture+Coach; T1 tip path (live or Simulate); note for Integrator: `isPro` binding site | Integrator → bloom |
| **RC** | Human `RC-IDs.md` filled **or** explicit BLOCKED; SPM RevenueCat present | `EntitlementState.isPro` publishing; paywall presents; `GATE-RC.md` | Integrator + CCA observe |
| **FROST standby** | `GATE-SCAFFOLD=PASS`; flag still false | Frost slice builds **isolated** (no Capture import); `GATE-FROST.md=STANDBY` | ORCH on RED only |
| **FROST primary** | `CUTOVER.flag=frost` + `GATE-CCA=RED` | TC-F01–F04; decoy A/B + Pro C path | Integrator + DEMO |
| **INTEG** | CCA compile + RC `EntitlementState` + SHELL hosts | Single path tip→Pro→oval (or frost→vault); smoke TC-C01+TC-R04 (or F equiv) | ASSETS / QA |
| **ASSETS** | Integrate smoke green **or** ORCH waiver | Tokens applied on demo path; M1/M3 present | QA |
| **COPY** | Frozen Brad/Matt from theme contract | `DEMO-SCRIPT.md` + strings committed | QA / ORCH demo |
| **QA** | FREEZE declared **or** ORCH early dry-run | `DEMO-LAST-PASS.md`; 90s timed | Demo queue |

### 18B. Artifact schemas (copy into docs-runtime)

**SHELL-READY.md**
```text
time:
pose_chrome: pass|fail
hinge_effects_only: pass|fail
cca_host_hook: empty-modifier|slot-named|missing
cutover_flag_readable: y/n
notes:
```

**Lane done ping (paste in chat to ORCH only)**
```text
LANE=<id> STATUS=done|blocked|hotfix
OUT=<artifact files>
BLOCKED_REASON=<or none>
NEXT=<lane that may start>
```

### 18C. Binding sites (Integrator-owned wire list)

| Producer | Symbol / file | Consumer read site | Forbidden |
|----------|---------------|--------------------|-----------|
| RC | `EntitlementState.isPro` in `Monetization/Entitlements.swift` | `GuideOvalView` / CoachOverlay Pro branch; Frost vault C | CCA must not configure Purchases |
| SHELL | `PoseMode` from `PoseRouter` | Feature hosts read only | Features must not redefine pose table |
| SHELL | `CutoverFlag.isFrost` | Root slot picker (INTEG); Frost views gate | FROST must not write flag |
| CCA | `CaptureSessionPhase` / accessory availability | Inner chrome; Simulate tip | RC must not own session |
| COPY | tip string table | `TipPlateView` | Agents must not “improve” Brad/Matt |

---

## 19. Concurrent writers — hard cap ≤3

### 19A. Legal live sets (exactly these patterns)

| Clock | Slot 1 | Slot 2 | Slot 3 | Illegal 4th |
|-------|--------|--------|---------|-------------|
| 11:30–11:45 | SHELL (Cursor) | — | — | any feature writer |
| 11:45–12:15 | Duo-core (Claude) | — | — | RC+CCA parallel before shell ready |
| 12:15–2:15 GREEN | CCA (Claude) | RC (Codex) | FROST standby **files only** OR idle | ASSETS taste + CCA + RC + Frost root |
| 12:15–2:15 RED | FROST primary | RC | Duo-core help on Frost shell | CCA feature thrash |
| 2:15–2:45 | INTEG (Cursor/human) | CCA named-file patch | RC named-file patch | New feature writer |
| 2:45–3:00 | ASSETS (Cursor) | GUARD (read-only, not a writer) | — | Feature expansion |
| 3:00+ | QA notes only | hotfix if ORCH names file | — | anyone “just finishing” |

**Writer** = agent/human producing Swift or pbxproj diffs. Read-only GUARD and ORCH checklists do **not** count toward the 3 unless they edit feature files.

### 19B. Enforcement script (ORCH says aloud)

1. Count terminal/agent sessions with write access.  
2. If count > 3 → stop the newest session.  
3. If two sessions claim the same path → stop both; restart one with card re-paste.  
4. Frost standby writing `App/` or `Capture/` → kill session; re-paste FROST card.

### 19C. Worktree / branch suggestion (optional)

```text
main (or sat/trunk)     — Integrator only merges here
sat/shell               — SHELL + Duo-core
sat/cca                 — CCA only
sat/rc                  — RC only
sat/frost               — FROST only
sat/hotfix/<name>       — post-freeze named blocker
```

Merge order into trunk: `shell → cca → rc → (frost if RED) → integ wire → assets`.

---

## 20. Leaf-file OWNER map (paste into bible §06)

Every Saturday leaf gets one owner. If a file is missing from this list, **do not create it** without ORCH + theme-contract check.

| Path | OWNER | READERS | FORBIDDEN_WRITERS |
|------|-------|---------|-------------------|
| `App/DuoAppApp.swift` | SHELL→INTEG | all | CCA, RC, FROST, ASSETS |
| `App/RootArrangementView.swift` | Duo-core | CCA/FROST via slots | drive-by feature edits |
| `Duo/PoseRouter.swift` | Duo-core | features read PoseMode | polish redefine |
| `Duo/ArrangementRegions.swift` | Duo-core | features | RC |
| `Duo/CameraCaptureAccessoryHost.swift` | **CCA** | SHELL early empty hook only | RC, FROST |
| `Features/Capture/**` | CCA | QA | RC, FROST, ASSETS logic |
| `Features/CoachOverlay/**` | CCA (+ COPY strings) | RC observes isPro | FROST |
| `Features/Paywall/**` | RC | ASSETS restyle tokens only | CCA layout ownership |
| `Features/Frost/**` | FROST | QA | Capture imports |
| `Monetization/**` | RC | CCA/FROST observe | invent IDs |
| `DesignSystem/**` | ASSETS late | features use placeholders early | parallel rewrites mid-day |
| `Resources/Assets.xcassets/Coach/**` | ASSETS | CCA | FROST |
| `Resources/Assets.xcassets/Frost/**` | ASSETS | FROST | CCA |
| `Resources/Localizable.strings` | COPY | all | rewrite Brad/Matt |
| `Shared/Types.swift` | INTEG | all | unsupervised lane patches |
| `Shared/CutoverFlag.swift` | SHELL own / ORCH runtime flag file | all read | FROST flip |
| `docs-runtime/GATE-CCA.md` | ORCH | all | AI write |
| `docs-runtime/CUTOVER.flag` | ORCH | all | AI write |
| `docs-runtime/RC-IDs.md` | HUMAN | RC | AI invent |
| `docs-runtime/DEMO-SCRIPT.md` | COPY/ORCH | QA | improvised stage rewrite |
| `docs-runtime/DEMO-LAST-PASS.md` | QA | ORCH | feature lanes |

---

## 21. Conflict playbooks (when two AIs collide)

| Symptom | Likely fighters | Resolution |
|---------|-----------------|------------|
| Both editing `RootArrangementView` | Duo-core vs CCA | CCA reverts; inject via named `Group`/slot only |
| Both editing entitlements + tip view | RC vs CCA | RC keeps Entitlements; CCA only reads `isPro` |
| Frost imports Capture | FROST vs CCA | Delete import; keep isolation; cutover = root swap |
| SPM/pbxproj thrash | SHELL vs everyone | Freeze pbxproj to INTEG after GATE-SCAFFOLD |
| “Improved” Brad sentence in UI | COPY vs CCA | Revert to frozen string; nack by GUARD |
| Fourth Cursor BG agent started | ORCH fail | Quit newest; re-read §19A |

**One-message conflict nack (GUARD/ORCH):**

```text
NACK: path mutex violation on <file>. Owner is <LANE>. Revert your diff. Re-read lane card. Do not rewrite ownership.
```

---

## 22. Done-when scoreboard (tick at freeze)

| Lane | Required green | Waiver allowed? |
|------|----------------|-----------------|
| SHELL | GATE-SCAFFOLD | No |
| Duo-core | TC-S01–S04 / SHELL-READY | No |
| CCA | TC-C01–C03, C05; C04 after RC | C01 via Simulate tip + honest line |
| RC | TC-R01–R03, R05; R04 after integ | R04 via Simulate Pro **with waiver note** |
| FROST | STANDBY build **or** F01–F04 if RED | F05 always optional |
| ASSETS | Demo path intentional | Non-demo screens yes |
| COPY | TC-P01, P03 (P02 if frost) | No on Brad/Matt text |
| QA | DEMO-LAST-PASS + 90s×2 | 60s backup counts if documented |
| ORCH | GATE-CCA + FREEZE + demo ready | — |

---

## 23. Cross-links

| Need | Doc |
|------|-----|
| Clock | `docs/bible/17-saturday-clock.md` |
| Demo script | `docs/bible/16-demo-script-90s.md` |
| Human prep / what to paste tonight | `docs/bible/19-human-prep-tomorrow.md` |
| Routing rationale | `docs/multi-ai-build-routing.md` |
| Tree / TCs | `docs/bible-single-theme-contract.md` |
| Agent contract | `docs/bible/00-front-matter-agent-contract.md` |

---

*End §18. Path mutex. Handoff artifacts > chat. Three writers. Cards > vibes.*
