# §06 — Repo & file tree (frozen)

**Bible ID:** §06  
**Product:** Outer Lens Film Tool · FrostDuo cutover behind flag only  
**Obeys:** [`docs/bible-single-theme-contract.md`](../bible-single-theme-contract.md) §4 · [`docs/build-bible-blueprint.md`](../build-bible-blueprint.md) §06/§18B · [`docs/multi-ai-build-routing.md`](../multi-ai-build-routing.md) §4  
**Constraint:** Spec only — Saturday agents emit files; this chapter does not ship Swift sources.  
**Rename rule:** Leaf renames only via Integrator + changelog row in §06.9. Tree text below is **verbatim freeze**.

---

## 06.0 How agents use this chapter

1. Paste **§00 invariants** (blueprint §3D) into the session.  
2. Open **your lane card** (§06.3). Write **only** OWNER paths.  
3. Read **conflict locks** (§06.4) before touching any hot file.  
4. Update the matching `docs-runtime/GATE-*.md` when your leaf set is done.  
5. If a needed path is missing from this tree → **Integrator nack**; do not invent top-level folders.

**Every leaf below maps to a Saturday path or a demo second.** No idea clouds.

---

## 06.1 Root product folder

| Lock | Value |
|------|-------|
| Root folder | **`DuoApp/`** |
| Xcode product name | Outer Lens (display) / FrostDuo when `CUTOVER.flag` true — same target |
| SPM packages | `RevenueCat` + `RevenueCatUI` from `purchases-ios-spm` ≥ **5.43.0** |
| Forbidden packages | PrivacyScreen, SnapShield, Moments, Accorduon, any scored OSS fork |

**Forbidden new top-level folders on Saturday:** `Agents/`, `Chat/`, `Interview/`, `HingeBeat/`, `PoseAgent/`, `Backend/`, `Marketing/`, `Watch/`, `Multipeer/`.

---

## 06.2 Frozen tree (verbatim)

Print this tree into every lane prompt. Annotations: `# LANE-…` = OWNER. `READ` = may import/observe. `INT` = Integrator merge-only.

```text
DuoApp/
  App/
    DuoAppApp.swift                      # LANE-SHELL · OWNER · READ:all · FORBIDDEN: feature writers after GATE-SCAFFOLD
    RootArrangementView.swift            # LANE-SHELL · OWNER · READ:all · slots only for features
  Duo/
    PoseRouter.swift                     # LANE-SHELL · OWNER · READ:all · FORBIDDEN: CCA/FROST/RC/ASSETS redefine table
    ArrangementRegions.swift             # LANE-SHELL · OWNER · reservedRegions hosts
    CameraCaptureAccessoryHost.swift     # LANE-CCA · OWNER · empty hook until Outer Lens handoff
  Features/
    Capture/                             # LANE-CCA
      CaptureSessionController.swift     # session owner · maps CaptureSessionPhase
      InnerCaptureView.swift             # SCR-OL-B
      PermissionPrimerView.swift         # SCR-OL-A
      CaptureDeniedView.swift            # SCR-OL-E
    CoachOverlay/                        # LANE-CCA (+ COPY strings)
      SubjectCoachView.swift             # SCR-OL-C
      TipPlateView.swift                 # T1/T2 plate
      GuideOvalView.swift                # T2 Pro oval
      CountdownView.swift                # T3
    Paywall/                             # LANE-RC
      PaywallHostView.swift              # SCR-OL-D / SCR-FD-D (shared host)
    Frost/                               # LANE-FROST (behind CutoverFlag)
      SensitiveSurfaceView.swift         # SCR-FD-A
      FrostControlsView.swift            # SCR-FD-B
      FrostOverlayView.swift             # inner frost render
      OuterDecoyStageView.swift          # SCR-FD-C
      SimulateThreatControl.swift        # sim recovery
      ThreatLevel.swift                  # ThreatLevel enum (lane-local OK; mirror §07)
  Monetization/
    PurchasesConfig.swift                # LANE-RC · configure(test_) DEBUG only
    Entitlements.swift                   # LANE-RC · publishes EntitlementState (§07)
    RCIdentifiers.swift                  # LANE-RC · REQUIRED transcription of RC-IDs.md (PLACEHOLDER_RC_* until human)
  DesignSystem/
    Tokens.swift                         # LANE-ASSETS · Film Tool + Frost token swap
    Motion.swift                         # LANE-ASSETS · M1–M3 / F1–F3 / P1–P3
  Resources/
    Assets.xcassets/
      Coach/                             # LANE-ASSETS · tip glyphs / guide art
      Frost/                             # LANE-ASSETS · decoy packs A/B/C
      Shared/                            # LANE-ASSETS · brand marks only
    Localizable.strings                  # LANE-COPY
  Shared/
    Types.swift                          # INTEGRATOR · AppState TipKind CaptureSessionPhase …
    CutoverFlag.swift                    # LANE-SHELL · READ:all · WRITE: Orchestrator via docs-runtime
  docs-runtime/
    SHELL-READY.md                        # LANE-SHELL writes
    GATE-CCA.md                          # Orchestrator writes at 12:15
    GATE-RC.md                           # LANE-RC writes
    GATE-FROST.md                        # LANE-FROST writes
    GATE-SCAFFOLD.md                     # Scaffold / SHELL early
    RC-IDs.md                            # HUMAN paste only
    CUTOVER.flag                         # Orchestrator write only
    DEMO-SCRIPT.md                       # LANE-COPY
    DEMO-LAST-PASS.md                    # LANE-DEMO
```

**Scaffold may also create (Integrator-owned after B0):** `DuoApp.xcodeproj/**`, `Package.resolved`, Info.plist camera strings, empty `#Preview` stubs. Feature lanes must not edit `.pbxproj` except via Integrator merge window.

---

## 06.3 Leaf ownership matrix

Columns: **Owner** writes; **Readers** may import; **Produces** / **Consumes** are §07 contracts; **Demo secs** if the leaf is on the 90s path.

### 06.3A App /

| Path | Owner | Readers | Responsibility (one sentence) | Consumes | Produces | Demo |
|------|-------|---------|-------------------------------|----------|----------|------|
| `App/DuoAppApp.swift` | SHELL | all | `@main` entry; `#if DEBUG` Purchases bootstrap call site only via RC API; selects root from `CutoverFlag` | `CutoverFlag`, `AppState` | Window group | 0:00 launch |
| `App/RootArrangementView.swift` | SHELL | CCA, FROST, RC (slots) | Hosts `ArrangementView` + named feature slots; never embeds paywall on outer | `PoseMode`, slots | Region hosts | 0:00–1:30 chrome |

### 06.3B Duo /

| Path | Owner | Readers | Responsibility | Consumes | Produces | Demo |
|------|-------|---------|----------------|----------|----------|------|
| `Duo/PoseRouter.swift` | SHELL | all | Maps pose → region layout; `onHingeChange` = effects only | Duo pose APIs | `PoseMode` | TC-S02 |
| `Duo/ArrangementRegions.swift` | SHELL | CCA, FROST | Declares `reservedRegions` / pane hosts | PoseMode | Region IDs | shell |
| `Duo/CameraCaptureAccessoryHost.swift` | **CCA** | SHELL (hook) | `.sceneAccessory { CameraCaptureAccessory… }` + availability binding | `CaptureSessionPhase`, tip model | accessory enabled/available | **0:15–0:45** |

**Handoff:** SHELL leaves empty `.sceneAccessory` hook **or** `SHELL-READY` note in `SHELL-READY.md`. CCA owns the host file after handoff (routing conflict lock).

### 06.3C Features/Capture / (LANE-CCA)

| Path | Owner | SCR | Responsibility | Consumes | Produces | Demo |
|------|-------|-----|----------------|----------|----------|------|
| `CaptureSessionController.swift` | CCA | — | Owns `AVCaptureSession`; advances `CaptureSessionPhase` | perm APIs | `CaptureSessionPhase` | 0:10–0:40 |
| `PermissionPrimerView.swift` | CCA | **SCR-OL-A** | Camera primer → system alert; photo only | — | perm request | **0:00–0:10** |
| `InnerCaptureView.swift` | CCA | **SCR-OL-B** | Full-bleed preview, shutter, flip, Subject toggle, Pro CTA | phase, `EntitlementState` (observe) | shutter events | **0:10–0:40** |
| `CaptureDeniedView.swift` | CCA | **SCR-OL-E** | Denied / unavailable recovery; Settings path; never bricks shutter path when accessory down | phase | Settings deep link | fallback |

### 06.3D Features/CoachOverlay / (LANE-CCA + COPY strings)

| Path | Owner | SCR | Responsibility | Consumes | Produces | Demo |
|------|-------|-----|----------------|----------|----------|------|
| `SubjectCoachView.swift` | CCA | **SCR-OL-C** | Outer subject stage; one tip; brand whisper | `TipKind`, entitlement | tip render | **0:15–0:45** · **1:05–1:20** |
| `TipPlateView.swift` | CCA | SCR-OL-C | Solid tip plate ≥28pt; no glass over tip text | COPY strings | T1/T2 chrome | tip readable |
| `GuideOvalView.swift` | CCA | SCR-OL-C | Pro amber oval; gated `isPro` | `EntitlementState` | T2 bloom | **1:05–1:20** |
| `CountdownView.swift` | CCA | SCR-OL-C | T3 `3·2·1` once in script | TipKind.countdown | M2 | optional 0:30 |

### 06.3E Features/Paywall / (LANE-RC)

| Path | Owner | SCR | Responsibility | Consumes | Produces | Demo |
|------|-------|-----|----------------|----------|----------|------|
| `PaywallHostView.swift` | RC | **SCR-OL-D** / **SCR-FD-D** | RevenueCatUI host; **inner only**; never present on outer | `RC-IDs.md`, `EntitlementState` | purchase flow | **0:50–1:05** |

### 06.3F Features/Frost / (LANE-FROST · behind CutoverFlag)

| Path | Owner | SCR | Responsibility | Consumes | Produces | Demo (cutover) |
|------|-------|-----|----------------|----------|----------|----------------|
| `SensitiveSurfaceView.swift` | FROST | **SCR-FD-A** | Inner sensitive content host | ThreatLevel | clear/frost surface | 0:00–0:15 |
| `FrostControlsView.swift` | FROST | **SCR-FD-B** | Simulate Threat + privacy controls | ThreatLevel | simulate action | 0:15–0:35 |
| `FrostOverlayView.swift` | FROST | SCR-FD-A | Progressive frost render (F1) | ThreatLevel | frost layers | 0:25 |
| `OuterDecoyStageView.swift` | FROST | **SCR-FD-C** | Outer decoy packs A/B/C | packs, `isPro` | decoy stage | 0:25–0:45 · 1:05–1:20 |
| `SimulateThreatControl.swift` | FROST | SCR-FD-B | Force locked for demo | — | ThreatLevel.locked | sim recovery |
| `ThreatLevel.swift` | FROST | — | Lane enum; must match §07 names | — | ThreatLevel | — |

**Hard rule:** Frost **never imports** Capture/Coach. Cutover = Orchestrator flag + root slot swap, not file merge of CCA into Frost.

### 06.3G Monetization / (LANE-RC)

| Path | Owner | Responsibility | Consumes | Produces | Demo |
|------|-------|----------------|----------|----------|------|
| `PurchasesConfig.swift` | RC | `Purchases.configure` with human `test_` under `#if DEBUG` | `RCIdentifiers` ← `RC-IDs.md` | configured SDK | TC-R01 |
| `RCIdentifiers.swift` | RC | Mechanical string constants from human `RC-IDs.md` (`PLACEHOLDER_RC_*` until paste) | Human paste | Constants for configure + gate | TC-R01 |
| `Entitlements.swift` | RC | Observes `CustomerInfo`; publishes §07 `EntitlementState` | entitlement id `pro` | `EntitlementState.isPro` | **1:05–1:20** unlock |

### 06.3H DesignSystem / + Resources / (LANE-ASSETS · LANE-COPY)

| Path | Owner | Responsibility | Demo |
|------|-------|----------------|------|
| `DesignSystem/Tokens.swift` | ASSETS | Film Tool charcoal `#050505` / amber `#E8A838`; Frost swap §2B | win visual |
| `DesignSystem/Motion.swift` | ASSETS | M1 tip settle · M2 countdown · M3 unlock bloom · F1–F3 · P1–P3 | win motion |
| `Resources/Assets.xcassets/Coach/` | ASSETS | Coach glyphs only | SCR-OL-C |
| `Resources/Assets.xcassets/Frost/` | ASSETS | Decoy stills A/B/C | SCR-FD-C |
| `Resources/Assets.xcassets/Shared/` | ASSETS | Brand marks Outer Lens / FrostDuo | brand hero |
| `Resources/Localizable.strings` | COPY | Brad/Matt + tip strings frozen | 0:00–1:20 voice |

**Catalog partition lock:** no cross-writes between `Coach/` and `Frost/`.

### 06.3I Shared / (INTEGRATOR · SHELL)

| Path | Owner | Readers | Responsibility |
|------|-------|---------|----------------|
| `Shared/Types.swift` | **INTEGRATOR** | all | Canonical `AppState`, `EntitlementState`, `TipKind`, `CutoverFlag`, `CaptureSessionPhase`, `PoseMode`, `ThreatLevel` mirrors |
| `Shared/CutoverFlag.swift` | SHELL (file) · **Orchestrator** (value via `CUTOVER.flag`) | all | Runtime read of cutover; features must not write |

### 06.3J docs-runtime / (Saturday handoff artifacts)

| Path | Writer | Readers | When |
|------|--------|---------|------|
| `GATE-SCAFFOLD.md` | Scaffold/SHELL | all | ~11:45 |
| `SHELL-READY.md` | SHELL | all | after TC-S01/S02 |
| `GATE-CCA.md` | **Orchestrator** | all | **12:15 sharp** |
| `GATE-RC.md` | RC | Integrator, DEMO | ~2:15 |
| `GATE-FROST.md` | FROST | Orchestrator | standby done / cutover live |
| `RC-IDs.md` | **Human only** | RC | pre-doors |
| `CUTOVER.flag` | **Orchestrator only** | all | 12:15 if RED |
| `DEMO-SCRIPT.md` | COPY | DEMO, O | continuous |
| `DEMO-LAST-PASS.md` | DEMO | O | 3:00–3:15 |

---

## 06.4 Conflict locks (OWNER / READERS / FORBIDDEN_WRITERS)

Bible encoding for every hot zone. Crossing without Integrator = defect.

| Hot path | OWNER | READERS | FORBIDDEN_WRITERS | Lock rule |
|----------|-------|---------|-------------------|-----------|
| `App/DuoAppApp.swift`, `.pbxproj`, `Package.resolved` | Scaffold until `GATE-SCAFFOLD=PASS`, then **Orchestrator/Integrator** | all | Feature lanes | Scaffold owns creation; afterward only Integrator adds targets |
| `App/RootArrangementView.swift` | **SHELL** | CCA, FROST, RC via **named slots** | Drive-by feature root edits | Features inject via `Group` / slot hooks specified here — no rewrite of pose chrome |
| `Duo/PoseRouter.swift` | **SHELL** | all (read `PoseMode`) | CCA, FROST, RC, ASSETS, COPY | Features never redefine the pose table |
| `Duo/CameraCaptureAccessoryHost.swift` | **CCA** after shell handoff | SHELL (empty hook) | FROST, RC, polish inventing CCA | One owner; shell leaves hook or forbids CCA until `SHELL-READY` |
| `Monetization/Entitlements.swift` / `EntitlementState` | **RC** | CCA, FROST observe | CCA/FROST writing entitlement truth | RC writes; others observe; unlock on **other pane** |
| `Features/Paywall/**` | **RC** | ASSETS restyle via tokens only | CCA layout ownership | Structure = RC; polish = DesignSystem APIs |
| `DesignSystem/**` | **ASSETS** (late polish) | all consume tokens | Parallel token rewrites by feature lanes | Features use placeholders until ~T+2:30 |
| `Features/Frost/**` vs `Features/Capture/**` | FROST vs CCA | none across | Mutual imports | Frost never imports Capture; cutover = flag + slot swap |
| `docs-runtime/CUTOVER.flag` | **Orchestrator** | all | Every coding AI | AIs read only |
| `docs-runtime/GATE-CCA.md` | **Orchestrator** | all | Feature writers claiming green | Written at 12:15 |
| `docs-runtime/RC-IDs.md` | **Human** | RC | AIs inventing `test_` / offering strings | If placeholder → `BLOCKED`, stop |
| `Resources/Assets.xcassets/**` | ASSETS by folder | CCA reads Coach; FROST reads Frost | Cross-catalog writes | Partition `Coach/` · `Frost/` · `Shared/` |
| String tables / Brad-Matt | COPY | feature lanes paste | “Improved” taglines mid-merge | §01 frozen strings verbatim |
| `Shared/Types.swift` | **INTEGRATOR** | all | Lane drive-by edits | Lanes submit type snippets in notes; Integrator merges |

### 06.4A Conflict resolution timer

If a merge conflict on a hot file exceeds **15 minutes**: revert the lane commit, re-apply a smaller patch, keep green build. Prefer deleting duplicate symbols to keep §07 names.

---

## 06.5 Lane cards (path mutex)

Copy one card into each agent session. Paths are exclusive write sets.

### LANE-SHELL

```text
OWNER paths:
  App/**
  Duo/PoseRouter.swift
  Duo/ArrangementRegions.swift
  Shared/CutoverFlag.swift
  docs-runtime/SHELL-READY.md (and early GATE-SCAFFOLD.md)
FORBIDDEN: Features/**, Monetization/**, asset binaries, inventing RC IDs
DONE when: TC-S01, TC-S02, TC-S03, TC-S04
HANDOUT: PoseMode, region hosts, feature slots ready for CCA/FROST
```

### LANE-CCA

```text
OWNER paths:
  Duo/CameraCaptureAccessoryHost.swift
  Features/Capture/**
  Features/CoachOverlay/**
FORBIDDEN: Monetization/**, Features/Frost/**, App/** (except Integrator-approved slot hooks), PoseRouter table
DONE when: TC-C01…TC-C05
HANDOUT: CaptureSessionPhase live, CCA binding, TipKind render
```

### LANE-FROST

```text
OWNER paths: Features/Frost/**
FORBIDDEN: Capture/Coach, Monetization, flipping CUTOVER.flag
DONE when: TC-F01…TC-F04 (TC-F05 optional)
HANDOUT: ThreatLevel + frost/decoy views behind flag
```

### LANE-RC

```text
OWNER paths: Monetization/**, Features/Paywall/**
FORBIDDEN: PoseRouter, CCA session logic, Frost threat logic, inventing RC-IDs.md values
DONE when: TC-R01…TC-R05
HANDOUT: EntitlementState.isPro observed by other panes
```

### LANE-COPY

```text
OWNER paths: Resources/Localizable.strings, docs-runtime/DEMO-SCRIPT.md, SCR copy fields
FORBIDDEN: SDK calls, feature logic
DONE when: TC-P01…TC-P03 (+ script coverage)
```

### LANE-ASSETS

```text
OWNER paths: Resources/Assets.xcassets/**, DesignSystem/Tokens.swift, DesignSystem/Motion.swift
FORBIDDEN: Behavior / RC / Duo API invention
DONE when: TC-A01…TC-A03
```

### LANE-DEMO

```text
OWNER paths: docs-runtime/DEMO-LAST-PASS.md; read-only app unless Orchestrator assigns sat/hotfix/*
FORBIDDEN: New features after freeze
DONE when: TC-D01, TC-D02 (+ TC-D03 if cutover rehearsed)
```

### INTEGRATOR

```text
OWNER paths: Shared/Types.swift, project files; any path ONLY in merge windows
FORBIDDEN: Owning whole features as a parallel writer
DONE when: TC-I01…TC-I04
```

---

## 06.6 Mode → active tree

| Mode | `CUTOVER.flag` | Live feature folders | Parked |
|------|----------------|----------------------|--------|
| Primary Outer Lens | false / absent | `Capture/`, `CoachOverlay/`, `Paywall/` | `Frost/` stubs only |
| Cutover FrostDuo | true / `frost` | `Frost/`, `Paywall/` | Stop CCA feature work; keep compile stubs |

Root slot rule (`RootArrangementView.swift`):

- Outer Lens: inner slot → Capture shell; outer/CCA slot → SubjectCoach.  
- FrostDuo: inner slot → SensitiveSurface + controls; outer slot → OuterDecoyStage.  
- Paywall sheet always attaches to **inner** host.

---

## 06.7 Consumes / produces graph (by folder)

```text
SHELL ──produces──► PoseMode, region hosts, CutoverFlag reader
   │
   ├──► CCA consumes hosts ──produces──► CaptureSessionPhase, TipKind render
   │         │ observes EntitlementState
   │         ▼
   ├──► RC ──produces──► EntitlementState ──► other pane unlock (CCA TipKind.proGuide OR Frost decoy C)
   │
   └──► FROST (if flag) ──produces──► ThreatLevel UI ── observes EntitlementState for vault C

COPY ──produces──► strings ──► CCA/FROST/DEMO
ASSETS ──produces──► tokens/motions/assets ──► all UI
INTEGRATOR ──produces──► Shared/Types.swift canonical names
```

---

## 06.8 Scaffold checklist (empty leaves)

At `GATE-SCAFFOLD=PASS`, every leaf file in §06.2 **exists** as empty stub or `#warning("LANE-…")` placeholder. No feature logic required. Empty app ⌘R on Duo sim.

| Check | Evidence |
|-------|----------|
| Tree exists | Finder / `find DuoApp` |
| SPM stubs | Package refs for RevenueCat ≥5.43 |
| No forbidden folders | Scan root |
| Info.plist camera string stub | `NSCameraUsageDescription` Outer Lens purpose |

---

## 06.9 Changelog (tree freezes)

| Rev | Date | Change | Integrator |
|-----|------|--------|------------|
| 0 | 2026-09-26 | Initial freeze from single-theme contract §4 | bible author |
| | | *(add rows only when renaming leaves)* | |

---

## 06.10 Anti-patterns (nack immediately)

| Anti-pattern | Why banned | Cite |
|--------------|------------|------|
| New `Features/Agents/` or chat tab | Kill list | contract §2 |
| Hinge degrees drive layout | Duo DQ risk | §08 / TC-S03 |
| Paywall view on outer | Design lock | contract §2B |
| Frost importing Capture to “share camera” | Cutover must be slot swap | routing §4 |
| Inventing `test_` key in Swift | Human dashboard fact | RC research |
| Second climax API in one demo path | One climax | 3h plan §1 |

---

## 06.11 Pointers

| Need | Doc |
|------|-----|
| Theme / kill list / SCR freeze | `docs/bible-single-theme-contract.md` |
| Lane OS / merge order | `docs/build-bible-blueprint.md` §18 |
| Tool → lane + prompt stubs | `docs/multi-ai-build-routing.md` |
| Minute plan owning these paths | `docs/outer-lens-3h-build-plan.md` |
| Types for Consumes/Produces | `docs/bible/07-types-state-machines.md` |
| TC suite per leaf | `docs/bible/15-acceptance-tests.md` |

---



## 06.12 Saturday create order (serial → parallel)

Agents must create leaves in this order so path mutex holds.

| Step | Clock | Actor | Creates / fills | Gate |
|------|-------|-------|-----------------|------|
| 1 | 11:30–11:45 | Scaffold (Cursor) | Xcode project, empty `DuoApp/` tree stubs, SPM RevenueCat refs, Info.plist camera string stub | `GATE-SCAFFOLD.md=PASS` |
| 2 | 11:45–12:00 | SHELL | `PoseRouter`, `ArrangementRegions`, `RootArrangementView` slots, `CutoverFlag` reader | TC-S01/S02 emerging |
| 3 | 12:00–12:10 | CCA (same Mac session OK) | `CameraCaptureAccessoryHost` empty→wired; static T1 in coach stub | Gate probe |
| 4 | 12:15 | Orchestrator | `GATE-CCA.md` + optional `CUTOVER.flag` | Mode lock |
| 5a | 12:15–2:15 | CCA ∥ RC | Fill Capture/Coach **or** stop CCA if red; RC fills Monetization/Paywall | Parallel ≤3 |
| 5b | 12:15–2:15 | FROST | Only `Features/Frost/**` stubs if Outer Lens green; primary if red | File-isolated |
| 6 | anytime | COPY / ASSETS | Strings + xcassets + late Tokens/Motion | Soft merge |
| 7 | ~2:30 | Integrator | `Shared/Types.swift` canonical; merge RC then feature | TC-I01 |
| 8 | 3:00 | DEMO | `DEMO-LAST-PASS.md` | Freeze |

**Worktree suggestion (optional):** `sat/shell`, `sat/cca`, `sat/rc`, `sat/frost`, `sat/copy`, `sat/assets` → merge into `sat/integrate`. One lane per worktree. Integrator alone touches `.pbxproj`.

---

## 06.13 Info.plist & project leaves (owned)

| Leaf | Owner | Required keys / notes | Maps |
|------|-------|----------------------|------|
| `Info.plist` (or generate) | Scaffold → Integrator | `NSCameraUsageDescription` = Outer Lens coach purpose (photo). **No mic** for win slice. | SCR-OL-A |
| `DuoApp.entitlements` | Scaffold | Camera if required by tooling — mark `UNKNOWN` if Xcode 27.1 key unclear; do not invent | research-duo-apis |
| `Package.resolved` | Scaffold / Integrator | Lock RevenueCat ≥5.43.0 | TC-R01 |
| Preview macros / `#Preview` | Lane of the view file | Optional; never block compile | polish |

---

## 06.14 Slot injection API (RootArrangementView)

SHELL owns the root. Features **must not** rewrite root structure. Contractual slots:

| Slot ID | Hosted when Outer Lens | Hosted when Frost | Writer of content |
|---------|------------------------|-------------------|-------------------|
| `slot.inner.primary` | `InnerCaptureView` | `SensitiveSurfaceView` | CCA / FROST |
| `slot.inner.controls` | shutter rail / FrostControls | FrostControls | CCA / FROST |
| `slot.inner.sheet.paywall` | `PaywallHostView` | same shared host | RC |
| `slot.outer.cca` | `SubjectCoachView` via CCA host | unused / withdrawn | CCA |
| `slot.outer.decoy` | unused | `OuterDecoyStageView` | FROST |
| `slot.chrome.brand` | Outer Lens wordmark | FrostDuo quiet mark | ASSETS+COPY |

**Integrator rule:** Changing slot names requires §06.9 changelog + all lane cards updated.

---

## 06.15 Consumes/produces per leaf (expanded)

### CaptureSessionController.swift
- **Consumes:** system camera auth; `CutoverFlag` (park if frost)
- **Produces:** `CaptureSessionPhase` published to views
- **Must NOT:** present paywall; write `EntitlementState`; import Frost

### SubjectCoachView.swift
- **Consumes:** `CoachTip` / `TipKind`; `EntitlementState.isPro` (observe); phase for eligibility
- **Produces:** rendered T1/T2/T3 only
- **Must NOT:** own `AVCaptureSession`; call Purchases

### Entitlements.swift
- **Consumes:** `CustomerInfo` from SDK; `RC-IDs.md` entitlement id
- **Produces:** `EntitlementState` to environment/observable
- **Must NOT:** hard-code tip oval drawing; flip cutover

### OuterDecoyStageView.swift
- **Consumes:** `ThreatLevel`, `DecoyPack`, `isPro`
- **Produces:** outer decoy pixels
- **Must NOT:** import Capture; read hinge for layout

---

## 06.16 Conflict drill scripts (Integrator)

When two lanes touch a hot file:

1. Identify OWNER from §06.4.  
2. Non-owner reverts; re-applies via slot/observe only.  
3. If both claim OWNER → bible bug → Orchestrator decides; update §06.9.  
4. Timebox 15 min; prefer green build over clever merge.

**Example:** CCA edits `RootArrangementView` to embed coach → **nack**; move coach into `slot.outer.cca` content provider.

**Example:** RC duplicates `struct EntitlementState` in Paywall file → **nack**; import Shared.

**Example:** Frost adds `import Capture` “to reuse shutter” → **nack**; cutover is flag+slot.

---

## 06.17 Repo hygiene bans

| Ban | Why | Enforcement |
|-----|-----|-------------|
| Commit real `test_` keys | Leak / Release crash footgun | Human paste local only; gitignore secrets |
| Pre-Saturday shipping sources | Event rule | Scope guard |
| Screenshots of Moments/PrivacyScreen in pitch | Fork optics | DEMO lane |
| Fourth live coding writer | Merge tax | Orchestrator concurrency cap |
| New SCR-IDs outside contract | Kill list | Integrator nack |

---

## 06.18 Verification checklist for this chapter

- [ ] Tree text matches contract §4 leaf-for-leaf  
- [ ] Every leaf has OWNER lane  
- [ ] Conflict locks cover routing §4 hot files  
- [ ] Mode table matches CutoverFlag  
- [ ] No PoseAgent/HingeBeat/Agents folders  




## 06.19 Branch naming cheat-sheet

| Branch | Lane | Merge into |
|--------|------|------------|
| `sat/shell` | SHELL | `sat/integrate` first |
| `sat/cca` | CCA | after RC stubs preferred |
| `sat/rc` | RC | before Pro overlays |
| `sat/frost` | FROST | replaces CCA merge if cutover |
| `sat/copy` / `sat/assets` | soft | anytime before freeze |
| `sat/hotfix/*` | DEMO only post-freeze | one-at-a-time |
| `sat/freeze` | tag | demo branch pin |

PR title pattern: `LANE-CCA: TC-C01 outer tips` — links bible §§ + TCs.

---

## 06.20 Empty-stub comment contract

Every Saturday-created stub file starts with:

```swift
// OWNER: LANE-XXX
// READERS: …
// FORBIDDEN_WRITERS: …
// BIBLE: §06 / §07 / §15 TC-…
#warning("LANE-XXX: implement per bible")
```

Integrator rejects stubs missing OWNER banner after B1.

*End §06. Tree is law. Path mutex is law. Integrator alone rewrites ownership.*
