# §08 — Shell, ArrangementView & poses (Outer Lens Film Tool)

**Bible chapter:** `docs/bible/08-shell-arrangement-poses.md`  
**Product:** Outer Lens · Film Tool (FrostDuo = cutover shell swap only)  
**Event:** Bitrig Hacks: iPhone Duo · Sat Sep 26, 2026 · YC SF  
**Lane:** **LANE-SHELL** (Scaffold + Duo core) — primary Claude Code / Opus; Cursor on Mac for merge  
**Owns:** `DuoApp/App/DuoAppApp.swift` · `DuoApp/App/RootArrangementView.swift` · `DuoApp/Duo/PoseRouter.swift` · `DuoApp/Duo/ArrangementRegions.swift` · `DuoApp/Shared/CutoverFlag.swift`  
**Does not own:** Capture session · CCA host body · Paywall · Frost feature UI · DesignSystem tokens beyond placeholders  
**Obeys:** [`docs/bible-single-theme-contract.md`](../bible-single-theme-contract.md) §3–§4 · [`docs/multi-ai-build-routing.md`](../multi-ai-build-routing.md) lanes 2–3 · bible §05 / §06 / §07  
**Ingest:** [`internal/research-duo-apis.md`](../../internal/research-duo-apis.md) · [`internal/research-duo-hig-poses.md`](../../internal/research-duo-hig-poses.md)  
**Constraint:** Spec + paste recipes only. **No shipping Swift in this store.** Agents implement Saturday.  
**Toolchain:** Xcode **27.1** / iOS **27.1** SDK.

---

## 8.0 How to use this chapter

| If you are… | Read | Then implement in |
|-------------|------|-------------------|
| LANE-SHELL (hour 0–1) | Entire chapter | Owned paths above → write `docs-runtime/GATE-SHELL.md` |
| LANE-CCA | §8.3 slots · §8.6 CCA hook · §8.11 errors | Inject into named slots only — do not redefine pose table |
| LANE-FROST | §8.3 cutover slot · §8.5 pose matrix FD column | Swap via Orchestrator flag — do not edit PoseRouter table |
| LANE-RC | §8.3 paywall slot note only | Paywall stays **inner**; never touch shell layout |
| Integrator / QA | §8.12 TC map · §8.13 DECISION fills | Merge · `TC-S01`–`TC-S04` |

**Every paragraph maps to a file path, a demo second, a TC id, or a DECISION fill.** Theme contract §7 — no idea clouds.

### Verification tiers (reuse from §05)

| Tag | Meaning | Saturday action |
|-----|---------|-----------------|
| **VERIFIED** | Apple docs + SDK typecheck snapshot (bunn/iphone-duo-skill · 19 Sep 2026 · Xcode 27.1) and/or matching secondaries | Use as written; reconfirm compile |
| **SIM-OBS** | Duo sim / Artem Examples / DuoInspector observation | Demo OK; not App Store contract |
| **UNVERIFIED** | Blog/example named; signature not re-checked | Prefer VERIFIED twin; SDK-probe first |
| **UNKNOWN** | Conflict or no public contract | Do **not** invent; `BLOCKED:` or cut |

---

## 8.1 Hard rules for the shell (non-negotiable)

| # | Rule | Owner path | Evidence / TC |
|---|------|------------|---------------|
| S1 | **Layout ≠ hinge.** Drive panes with size classes, `ArrangementView`, `reservedRegions`. `onHingeChange` / `UIHingeInteraction` = **effects only**. | `Duo/PoseRouter.swift` · `Duo/ArrangementRegions.swift` · `App/RootArrangementView.swift` | **TC-S02** · **TC-S03** · Tech Talk 111464 |
| S2 | **Two size classes, not five apps.** Compact width on outer · regular width on inner. Do not ship a layout per marketing pose. | `PoseRouter.swift` · Root | Vince / Tech Talk 111466 |
| S3 | **Idiom stays `.phone`.** Wide Duo scenes are still phone. | All layout | Integrator review |
| S4 | **Guard `iOS 27.1`.** Duo APIs introduce at 27.1; keep single-column / no-accessory fallbacks. | Every Duo call site | Compile |
| S5 | **Nesting:** `NavigationStack` → `ArrangementView` → content. Never ArrangementView inside `List`/`ScrollView`. Never navigation *inside* arrangement. | `RootArrangementView.swift` | **VERIFIED** Apple 111463 |
| S6 | **Hierarchy identical closed↔open.** Open shows more of the same structure. | Root + feature slots | Vince |
| S7 | **One climax glass.** CCA **or** frost — never both live. Shell reads `CutoverFlag` and swaps root slot. | `Shared/CutoverFlag.swift` · `docs-runtime/CUTOVER.flag` | Theme §2B |
| S8 | **Paywall never on outer.** Shell must not place paywall slot on outer / accessory surface. | Root slots · SCR-OL-D / SCR-FD-D | Theme §2B · demo **0:50–1:05** |
| S9 | **Features inject via named slots** — they do not redefine the pose table or rewrite Root. | Conflict lock routing §4 | Scope Guard nack |

**Banned inventions (Integrator nack):**

- Layout keyed off hinge degrees / π equality / `UIDeviceHingeDidChangeNotification`  
- `UIScreen.main.bounds` / device-name branches / pad idiom branches  
- New windows on the **outer** (`UIWindowScene.ActivationAction` = **inner only** — **VERIFIED**)  
- Accorduon / HingeBeat / PoseAgent / Flex Mode cargo-cult as shell product  
- Symmetric `safeAreaInsets.left * 2` math (**SIM-OBS** DuoInspector: asymmetric)  
- StandBy / widget / extension dependencies in Duo runtime (release notes — skip)

---

## 8.2 Owned files — Saturday responsibilities

### 8.2A `DuoApp/App/DuoAppApp.swift` — LANE-SHELL

| Duty | Detail | Demo / TC |
|------|--------|-----------|
| `@main` entry | `WindowGroup` → `RootArrangementView` | **TC-S01** launch |
| RC bootstrap call site | Call into `Monetization/PurchasesConfig.swift` **once** early under `#if DEBUG` — SHELL may host the call; **RC owns** configure body | **TC-R01** |
| Cutover read | Select outer-lens vs frost root via `CutoverFlag` helper | Gate **12:15** |
| Log / debug | Optional `Purchases.logLevel` stays in RC file — do not duplicate | — |

**Does not:** invent `PLACEHOLDER_RC_*` values · implement paywall · implement capture session.

### 8.2B `DuoApp/App/RootArrangementView.swift` — LANE-SHELL

| Duty | Detail | Demo / TC |
|------|--------|-----------|
| Host `NavigationStack` | Single nav root for both product modes | Continuity across fold |
| Host `ArrangementView` when needed | Default Outer Lens hour-1 may be single-column capture; tabletop polish optional after CCA green | Optional polish ≥2:45 |
| Named feature slots | `primarySlot` · `secondarySlot` · `paywallSlot` (inner) · `outerAccessoryHook` (empty until CCA) | Features inject |
| Pose chrome | Read `PoseMode` from PoseRouter; remap regions | **TC-S02** |
| Cutover swap | `if CutoverFlag.isFrost { frostRoot() } else { outerLensRoot() }` | Orchestrator flag |

### 8.2C `DuoApp/Duo/PoseRouter.swift` — LANE-SHELL

| Duty | Detail | Demo / TC |
|------|--------|-----------|
| Publish `PoseMode` | Design pose from size class + division activity + hinge **status** (not angle→layout) | §07 `PoseMode` |
| Attach `onHingeChange` | Effects only: reset partial-bend when non-partial; optional polish amp | **TC-S03** |
| Never set frames | No `offset` / pane width from degrees | Scope Guard |

### 8.2D `DuoApp/Duo/ArrangementRegions.swift` — LANE-SHELL

| Duty | Detail | Demo / TC |
|------|--------|-----------|
| Query `reservedRegions` | Always `.includeInactive` then filter — practical rule (**UNKNOWN** default vs Tech Talk) | §05 |
| Expose region hosts | Division + occlusion frames in local coords | Tabletop / book polish |
| Re-read each layout | Do not cache once (**SIM-OBS** Artem) | Shell green |

### 8.2E `DuoApp/Shared/CutoverFlag.swift` — LANE-SHELL (reader)

| Duty | Detail | Demo / TC |
|------|--------|-----------|
| Read `docs-runtime/CUTOVER.flag` | Map disk → `CutoverFlag.outerLens` / `.frost` per §07 | **TC-S04** |
| Publish to Environment | All lanes observe | Gate |
| **Never write** the flag file | Orchestrator-only write | Routing §4 |

---

## 8.3 Named slots (conflict lock)

Features **must** inject through these hooks. Drive-by Root edits = defect.

```text
FILE: DuoApp/App/RootArrangementView.swift
LANE: LANE-SHELL
SLOTS (names locked — Integrator may rename only via §06 changelog):

  // Outer Lens mode (CUTOVER.flag absent / false)
  @ViewBuilder var outerLensPrimarySlot: some View
      // default: Features/Capture/InnerCaptureView.swift  (SCR-OL-B)
  @ViewBuilder var outerLensPaywallSlot: some View
      // Features/Paywall/PaywallHostView.swift  (SCR-OL-D) — INNER ONLY
  // Outer tip is NOT a Root slot — it lives in Duo/CameraCaptureAccessoryHost.swift (LANE-CCA)

  // FrostDuo mode (CUTOVER.flag = frost / true)
  @ViewBuilder var frostPrimarySlot: some View
      // Features/Frost/SensitiveSurfaceView.swift  (SCR-FD-A)
  @ViewBuilder var frostSecondarySlot: some View
      // Features/Frost/FrostControlsView.swift  (SCR-FD-B)
  @ViewBuilder var frostOuterDecoySlot: some View
      // Features/Frost/OuterDecoyStageView.swift  (SCR-FD-C)
      // DECISION: Integrator — outer decoy may be scene-migration chrome OR arrangement secondary;
      //           do not invent a second window on outer (VERIFIED: ActivationAction = inner only)
  @ViewBuilder var frostPaywallSlot: some View
      // shared PaywallHostView (SCR-FD-D) — INNER ONLY
```

**DECISION:** Integrator fills whether Frost outer decoy is presented via system scene migration to closed-outer vs an ArrangementView secondary that only appears when geometry allows. Prefer system closed-outer continuity over inventing windows. Document choice in `GATE-SHELL.md`.

---

## 8.4 Pose vocabulary (Apple) → `PoseMode` (app)

Apple does **not** ship a public `Pose` enum named open/closed/tabletop/tent. Poses are **design situations** composed from: active display, size classes, active `.division` regions, hinge **status**, orientation.

Map Apple wording → locked §07 `PoseMode`:

| Apple / HIG wording | App `PoseMode` | Typical cues | Shell layout job |
|---------------------|----------------|--------------|------------------|
| Closed (outer) | `.closed` | Compact width; often shorter canvas; **no division regions on outer** (**SIM-OBS** Artem) | Glanceable chrome; vertical bar pressure; CCA separate if capturing |
| Fully open / flat | `.flat` **and** `.open` (both kept) | Inner; regular width when full; division **inactive** (zero-width fold) | Extra room; no blank fold gutter; Arrangement optional |
| Partially folded like a book | `.book` | Active `.division`; vertical crease | Split L/R; displace chrome off crease; hinge = effects only |
| Seated like a laptop | `.tabletop` | Partial fold; media↑ controls↓ | ArrangementView vertical split **or** reserved-region hosts |
| Standing on edges (tent) | `.closed` or `.tabletop` polish | Often outer landscape / short height | Continuity; optional glance — **not** a fifth product UI |
| Unknown / transition | `.unknown` | `hinge == nil` or size-class churn | Keep last stable chrome; reset effects |

**FROZEN (Codex review P0):** Keep **both** `.flat` and `.open` in `PoseMode` (§07). Do not collapse. Normative cues for `PoseRouter`:

| Case | Prefer when | Outer Lens layout job |
|------|-------------|------------------------|
| `.flat` | `hinge.status == .fullyOpen` and division inactive | Inner full-bleed SCR-OL-B; CCA outer when available — same climax chrome as `.open` |
| `.open` | Inner fully usable / not book or tabletop (may also see `.fullyOpen`) | Same SCR-OL-B + CCA slot as `.flat` for win path |

Both cases share the Outer Lens climax layout. Features must not branch product logic on flat vs open — only shell chrome/polish may distinguish. Document the comments in `Shared/Types.swift` / PoseRouter; no further Integrator decision required Saturday morning.

### Size-class cheat (Apple prepare talk + DuoInspector **SIM-OBS**)

| Situation | Typical traits (verify live Saturday) |
|-----------|----------------------------------------|
| Outer portrait | compact width / regular height |
| Outer landscape | compact / compact |
| Inner fully open landscape | regular / regular; vertical tab bar trailing (**SIM-OBS**) |
| Partial fold | Treat as **active division**, not a separate size-class enum |

**Do not** invent breakpoints tied to DuoInspector pt sizes (669×951 inner / 466×678 outer — **SIM-OBS** only). Prefer size classes + regions.

---

## 8.5 Pose matrix — Outer Lens vs FrostDuo

### 8.5A Outer Lens (`CutoverFlag.outerLens`)

| PoseMode | Layout / chrome | Hinge API role | Demo beat |
|----------|-----------------|----------------|-----------|
| `.closed` | If app migrates to outer without CCA: glance brand + tip plate rules still apply if showing coach; normally capture is inner + CCA outer | Status `.closed` if observed; **reset** partial effects | Continuity — not climax |
| `.open` / `.flat` | Inner capture full-bleed SCR-OL-B; CCA outer SCR-OL-C when available | `.fullyOpen`; clear stuck bend | **0:10–0:45** climax |
| `.book` | Optional: preview ‖ controls if Arrangement polish on; else single column still OK | `.partiallyOpen` effects only | Optional polish |
| `.tabletop` | **Preferred optional polish:** media↑ / shutter rail↓ via ArrangementView | Optional shake/mode effect — not layout | Kyle craft; after CCA green |
| `.unknown` | Keep inner shutter alive | Reset effects | Recovery |

### 8.5B FrostDuo (`CutoverFlag.frost`) — shell only

| PoseMode | Layout / chrome | Hinge API role | Demo beat (cutover script) |
|----------|-----------------|----------------|----------------------------|
| `.closed` | Outer decoy stage SCR-FD-C; inner may be frost or clear | Reset effects | **0:25–0:45** decoy |
| `.open` / `.flat` | Arrangement: sensitive↑ / controls↓ preferred | Effects only | **0:00–0:35** |
| `.book` / `.tabletop` | Same hierarchy; frost overlays follow ThreatLevel | Optional F1 amp | Simulate Threat |
| `.unknown` | Keep Simulate Threat reachable | Reset | TC-F03 |

**Shell must not** implement frost materials — only slots. Feature UI stays in `Features/Frost/**`.

---

## 8.6 ArrangementView recipes (VERIFIED)

**Imports:** `import SwiftUI`  
**Availability:** `@available(iOS 27.1, *)`  
**Owner:** `DuoApp/App/RootArrangementView.swift`

### 8.6A Symbols used by shell

| Symbol | Tier | Saturday use |
|--------|------|--------------|
| `ArrangementView` | **VERIFIED** | Primary + secondary roles — **not** navigation |
| `arrangementViewStyle(_:)` | **VERIFIED** | `.split` default; `.overlay` rare |
| `SplitArrangementViewStyle.axes(_:)` | **VERIFIED** | Allow `[.horizontal, .vertical]` unless intentionally restricting |
| `splitArrangementLayoutRatio(_:)` | **VERIFIED** | Preference — system may override on fold (**SIM-OBS**) |
| `EnvironmentValues.splitArrangementAxis` | **VERIFIED** API; **SIM-OBS** often `nil` | Do not gate UI on it |
| `EnvironmentValues.overlayArrangementZIndex` | **VERIFIED** | Read from **subview** (root reads 0 — **SIM-OBS** Artem) |

### 8.6B Hour-1 Outer Lens (single column — preferred until CCA green)

```text
FILE: DuoApp/App/RootArrangementView.swift
LANE: LANE-SHELL
DEMO: 0:00–0:45 chrome under capture
MILESTONE: M2 (shell green) before M4a

PSEUDO:
  NavigationStack {
    Group {
      if CutoverFlag.current == .frost {
        frostArrangement()
      } else {
        // Hour-1: NO ArrangementView required for win slice.
        // CCA host attaches on capture view (LANE-CCA owns host file).
        outerLensPrimarySlot
          .navigationTitle("Outer Lens")   // brand hero signal — Film Tool
          // paywall presented as sheet/cover FROM INNER only — RC owns PaywallHostView
      }
    }
  }
  .modifier(PoseRouter.hingeEffectsOnly())
```

### 8.6C Optional tabletop polish (after CCA green · clock ≥ ~2:45)

```text
FILE: DuoApp/App/RootArrangementView.swift
LANE: LANE-SHELL
DEMO: optional polish — not required for TC-C01
GATE: only if GATE-CCA green AND Orchestrator says polish OK

PSEUDO:
  ArrangementView {
    CapturePreviewPane()                 // media / preview — primary
      .splitArrangementLayoutRatio(0.55)
  } secondary: {
    CaptureControlsPane()                // shutter · flip · Pro CTA — same controls as flat
  }
  .arrangementViewStyle(.split.axes([.horizontal, .vertical]))

RULES:
  - Same hierarchy as single-column (Vince): do NOT strip features in tabletop
  - If axes hide secondary, essential shutter MUST remain inside primary fallback
  - Do NOT put ArrangementView inside ScrollView/List
  - Scrolling INSIDE a pane is OK
```

### 8.6D FrostDuo arrangement (cutover)

```text
FILE: DuoApp/App/RootArrangementView.swift
LANE: LANE-SHELL (slots) · LANE-FROST fills views
DEMO cutover: 0:00–0:45

PSEUDO:
  ArrangementView {
    frostPrimarySlot                     // SensitiveSurfaceView SCR-FD-A
      .splitArrangementLayoutRatio(0.6)
  } secondary: {
    frostSecondarySlot                   // FrostControlsView SCR-FD-B + Simulate
  }
  .arrangementViewStyle(.split.axes([.horizontal, .vertical]))
  // Outer decoy: DECISION Integrator — typically closed-outer migration, not this secondary
```

### 8.6E Style chooser

| Style | Choose when | Outer Lens | FrostDuo |
|-------|-------------|------------|----------|
| `.split` | Main–detail; neither obscured | Optional tabletop polish | **Preferred** content↑ / controls↓ |
| `.overlay` | Clear FG/BG | Rare — tip plate is **solid**, not overlay arrangement | Optional frost chrome |
| Custom `ArrangementViewStyle` | Avoid Saturday | Prefer built-ins | Prefer built-ins |

**Axis hide pitfall (**VERIFIED** Apple):** restricting axes can show **only primary**. For Outer Lens, shutter is load-bearing → keep essential controls in primary **or** allow both axes.

**Nesting with NavigationSplitView:** overview vs video disagree. **Safe reusable pattern:** `NavigationStack → ArrangementView → content` only.

---

## 8.7 Reserved regions recipes (VERIFIED)

**Imports:** `import SwiftUI`  
**Owner:** `DuoApp/Duo/ArrangementRegions.swift`

| Symbol | Tier | Notes |
|--------|------|-------|
| `ReservedRegion` | **VERIFIED** | `id`, `kind`, `frame`, `margins`, `isActive` — frame **includes** margins |
| `ReservedRegion.Kind.division` | **VERIFIED** | Fold / content-splitting; active when partially folded |
| `ReservedRegion.Kind.occlusion` | **VERIFIED** | Camera / obstruction |
| `ReservedRegion.QueryOptions.includeInactive` | **VERIFIED** | Practical always-on |
| `GeometryProxy.reservedRegions(kind:options:layoutDirectionBehavior:)` | **VERIFIED** | Local coords; default `layoutDirectionBehavior: .mirrors` |

```text
FILE: DuoApp/Duo/ArrangementRegions.swift
LANE: LANE-SHELL

PSEUDO:
  GeometryReader { proxy in
    let allFolds = proxy.reservedRegions(kind: .division, options: .includeInactive)
    let activeFolds = allFolds.filter(\.isActive)
    let cameras = proxy.reservedRegions(kind: .occlusion, options: .includeInactive)

    // Publish to PoseRouter / Root:
    // - activeFolds.nonEmpty → prefer .book or .tabletop depending on axis of fold
    // - empty on outer (**SIM-OBS**) → .closed chrome path
    // NEVER add margins twice — region.frame already includes them
  }
```

**Displacement rules (Maria / Tech Talk 111463) → shell:**

| Situation | Move | Don’t move |
|-----------|------|------------|
| Book | Independent chrome off crease; alerts → **trailing** | Continuous scroll content |
| Tabletop | Glanceable → **top**; touch → **bottom** | Features (rearrangement ≠ reduced mode) |
| Any | Prefer context | Primary taps in the crease |

**SIM-OBS pitfalls (Artem / DuoInspector):**

- Division active only when partially folded; flat → inactive; inactive frame still ~40 pt with ~20 pt margins each side of zero-width crease — **do not hardcode 40**  
- Regions may arrive after first layout — re-read in body  
- Outer display: **no** reserved regions at all  
- Trailing safe area ~84 pt landscape can be **camera occlusion** (84×120), not the tab bar  
- Asymmetric safe areas → never `left * 2`

---

## 8.8 Hinge = effects only (VERIFIED)

**Imports:** `import SwiftUI`  
**Owner:** `DuoApp/Duo/PoseRouter.swift`  
**Forbidden:** using angle to set pane widths, offsets, or Arrangement style.

| Symbol | Tier | Use |
|--------|------|-----|
| `onHingeChange(isEnabled:_:)` | **VERIFIED** | Attach once; pause with `isEnabled: false` if needed |
| `DeviceHingeContext` / `DeviceHinge` | **VERIFIED** | Read `.hinge` optional; `.angle: Angle`; `.status` |
| `DeviceHinge.Status` | **VERIFIED** | `.closed` · `.partiallyOpen` · `.fullyOpen` |
| `UIHingeInteraction` / `UIHinge` | **VERIFIED** | UIKit twin; angle is **radians** CGFloat — prefer SwiftUI path |

```text
FILE: DuoApp/Duo/PoseRouter.swift
LANE: LANE-SHELL
TC: TC-S03

PSEUDO:
  Content()
    .onHingeChange { _, context in
      guard let hinge = context.hinge, hinge.status == .partiallyOpen else {
        // RESET — do not leave last angle stuck when fully open/closed/nil
        effectBend = 0
        return
      }
      // EFFECTS ONLY — e.g. subtle tip flash amp, frost settle intensity
      effectBend = hinge.angle.degrees   // Angle, not CGFloat
      // NEVER: setArrangementRatio(from: effectBend)
      // NEVER: primary.frame(width: effectBend)
    }
```

**UNKNOWN (carry from §05):** numeric angle range, zero convention, update rate; whether SwiftUI status exposes `.unknown` (UIKit does). Prefer **status** for posture; continuous angle only for effects.

**Product anti-patterns:** Accorduon-class hinge toys as the whole shell; layout from thresholds; invented notifications.

---

## 8.9 Vertical toolbar / bars (supporting shell)

Shell should prefer **system** `NavigationStack` / `TabView` bars so vertical behavior comes free on Duo.

| Symbol | Tier | Saturday note |
|--------|------|---------------|
| `toolbarVerticalBehavior(_:)` | **VERIFIED** | Opt out `.disabled` only for bottom-heavy single-page UIs if needed |
| `toolbarVerticalCompressionBehavior(_:)` | **VERIFIED** | SDK spelling — Labs may say `toolbarCompressionBehavior` (**wrong**) |
| `toolbarVerticalEdge` (Environment) | **VERIFIED** | Preferred edge — **not** a visibility flag |
| `ToolbarContent.axisBehavior(_:)` | **VERIFIED** | `.horizontalOnly` for Edit/Done text swaps |
| `ToolbarContent.visibilityPriority(_:)` | **VERIFIED** | Overflow order |
| `.topBarPinnedTrailing` | **VERIFIED** (27.0) | Pinned completion — Pro CTA candidate on SCR-OL-B |

**Rules:** Symbol-only items prefer vertical; always supply title + image for overflow; custom `UIToolbar` instances **won’t** adopt. Portrait inner may keep horizontal bars (enough vertical space — Apple).

**Outer Lens:** keep shutter / flip / Subject as primary chrome in SCR-OL-B; use toolbar for secondary actions. Do not fight Film Tool full-bleed preview with a dense top bar cluster.

---

## 8.10 `PoseRouter` state machine (maps to §07)

```text
INPUTS (recomputed each layout / hinge event):
  - horizontalSizeClass / verticalSizeClass
  - active division regions (from ArrangementRegions)
  - DeviceHinge.Status? (optional)
  - CutoverFlag (does not change pose math — only which slots bind)

OUTPUT:
  PoseMode ∈ { flat, open, tabletop, book, closed, unknown }

SUGGESTED MAPPING (DECISION: Integrator may tighten):
  1. If on outer / compact-width closed chrome → .closed
  2. Else if active division present:
       - fold axis roughly horizontal (media above) → .tabletop
       - fold axis roughly vertical → .book
  3. Else if hinge.status == .fullyOpen OR regular/regular room → .open / .flat
  4. Else → .unknown (keep last stable UI)

EFFECTS CHANNEL (separate from PoseMode):
  hingeAngleDegrees?: Double?   // only while .partiallyOpen
  effectIntensity: Double       // 0 when reset
```

Publish via `@Observable` / Environment so Root and features **observe** without rewriting the table.

---

## 8.11 Saturday minute recipes (LANE-SHELL)

Aligns with theme-contract M0–M2 and routing serial Duo-core start.

### 8.11A Pre-doors / M0 (~10 min) — human + shell assist

| Step | Action | Path / proof |
|------|--------|--------------|
| 1 | Confirm Xcode **27.1** + iOS **27.1** runtime | `xcodebuild -version` |
| 2 | Boot **iPhone Duo** sim early (slow first launch — release notes) | Device Hub reacts to fold |
| 3 | Paste §00 + this chapter into shell AI session | Prompt pack |
| 4 | Confirm `CUTOVER.flag` absent (Outer Lens default) | `docs-runtime/` |

### 8.11B M1 Scaffold handoff (~15 min)

| Step | Action | Path |
|------|--------|------|
| 1 | Empty app ⌘R on Duo sim | **TC-S01** |
| 2 | Tree stubs exist per §06 | `DuoApp/**` |
| 3 | SPM stubs for RevenueCat ≥5.43 OK — configure body still RC | Package products |
| 4 | Write `GATE-SCAFFOLD.md` pass | docs-runtime |

### 8.11C M2 Duo shell green (~25 min) — **this chapter’s climax**

| Step | Action | Path / TC |
|------|--------|-----------|
| 1 | Implement `CutoverFlag` reader | `Shared/CutoverFlag.swift` · **TC-S04** |
| 2 | Implement `PoseRouter` pose publish + hinge effects-only | `Duo/PoseRouter.swift` · **TC-S02/S03** |
| 3 | Implement `ArrangementRegions` queries | `Duo/ArrangementRegions.swift` |
| 4 | Wire `RootArrangementView` slots + NavigationStack | `App/RootArrangementView.swift` |
| 5 | Leave empty CCA hook / SHELL-READY note | `GATE-SHELL.md` — CCA owns host after handoff |
| 6 | Fold/unfold mid-placeholder: selection/state preserved | Continuity |
| 7 | Prove pose change → chrome change with **zero narration** | Demo proof for judges later |
| 8 | Write `GATE-SHELL.md` pass / fail | Orchestrator reads before GATE-CCA |

**Done definition (shell):** pose remaps regions/panes without hinge-driven layout; CutoverFlag readable; Outer Lens primary slot shows placeholder capture chrome; Frost slots compile behind flag without being live.

### 8.11D After GATE-CCA (~12:15)

| Gate | Shell action |
|------|--------------|
| **GREEN** | Keep Outer Lens slots; do not start Frost as primary; optional tabletop polish only if Orchestrator allows late |
| **RED** | Orchestrator writes `CUTOVER.flag`; shell Root swaps to frost slots; **stop** assisting CCA feature work |

---

## 8.12 Error paths & recoveries

| Failure | Detection | Shell recovery | Owner |
|---------|-----------|----------------|-------|
| Duo APIs unavailable (pre-27.1 / non-Duo) | `#available` / runtime nil hinge | Single-column phone layout; no Arrangement | SHELL |
| `reservedRegions` empty on outer | Expected **SIM-OBS** | Treat as `.closed`; do not invent regions | SHELL |
| `reservedRegions` empty when expected on partial | First-layout race **SIM-OBS** | Re-query each body pass; don’t cache | SHELL |
| Arrangement hides secondary | Axis restrict / narrow bounds | Essential controls in primary fallback | SHELL |
| Hinge nil / exit hierarchy | `context.hinge == nil` | Reset effects; keep PoseMode last-stable | SHELL |
| CCA unavailable | `onAvailabilityChange(false)` | **Not shell’s job to brick** — CCA keeps shutter; shell keeps slots | CCA · **TC-C03** |
| Cutover mid-session | Orchestrator flips flag | Root re-reads flag; swap slots; preserve EntitlementState | ORCH + SHELL |
| Paywall presented on outer | Review defect | Remove — paywall slot inner only | Scope Guard |
| Layout from hinge degrees | Code review | Nack · rewrite to regions/Arrangement | Scope Guard · **TC-S03** |
| StandBy / widget path | Temptation | Delete — Duo runtime gaps | SHELL |
| Second climax both live | Flag + CCA + frost UI | Orchestrator enforces one glass | Theme §2B |

---

## 8.13 Camera accessory hook (shell boundary)

SHELL does **not** implement Outer Lens coach UI. After handoff:

| Item | Owner | Path |
|------|-------|------|
| Empty `.sceneAccessory` hook **or** SHELL-READY note | SHELL early | `GATE-SHELL.md` |
| `CameraCaptureAccessoryHost.swift` body | **LANE-CCA** | `DuoApp/Duo/CameraCaptureAccessoryHost.swift` |
| Subject coach | CCA | `Features/CoachOverlay/SubjectCoachView.swift` · SCR-OL-C · demo **0:15–0:45** |

**VERIFIED pattern reminder (implement in CCA chapter / §05 / §11):**

```text
CaptureView()
  .sceneAccessory {
    CameraCaptureAccessory(isEnabled: $enabled) {
      SubjectCoachView(...)
    }
    .onAvailabilityChange { available = $0 }
  }
```

States to keep distinct (**VERIFIED** craft): Available (system) · Enabled (user/app) · Presented (lifecycle). Essential capture actions must work **without** accessory.

**UNKNOWN:** camera-companion entitlement string — do not invent; confirm Apple provisioning if hardware path needed. Sim may never present accessory usefully → Frost cutover at ~12:15.

---

## 8.14 Vertical slice acceptance for shell (map to theme §6)

| TC | Assertion | Evidence |
|----|-----------|----------|
| **TC-S01** | App launches on Duo sim | `GATE-SHELL.md` |
| **TC-S02** | Pose remaps regions / panes without hinge-driven layout | `PoseRouter` + Root |
| **TC-S03** | `onHingeChange` used for effects only | Code review |
| **TC-S04** | `CutoverFlag` readable by feature lanes | `Shared/CutoverFlag.swift` |

Shell also enables later TCs by leaving slots correct: CCA can pass **TC-C01**; RC can present paywall **inner** (**TC-R02**); Frost can mount without Capture imports (**TC-F01**).

---

## 8.15 Demo choreography — what shell must make true

Shell is invisible when perfect. Judges should see:

| Seconds | What must be true (shell contribution) |
|---------|----------------------------------------|
| **0:00–0:10** | App up; brand **Outer Lens** visible on inner primer/chrome — not nav-only whisper |
| **0:10–0:45** | Inner capture chrome stable while outer CCA tip appears (CCA feature) — shell must not steal vertical space with card soup |
| **0:50–1:05** | Paywall on **inner** only — shell slot correct |
| **1:05–1:20** | Pro unlock on **other** pane — shell must not block Environment entitlement observe |
| Fold mid-demo | Selection/scroll/media continuity — Vince rule |

Cutover appendix: Simulate Threat → frost + decoy without hinge-layout kabuki.

---

## 8.15B Dual-pane Outer Lens Film Tool shell (architecture)

Outer Lens is a **dual-display** product. That is not the same as an ArrangementView **dual-pane** layout. Confusing the two is the most common shell failure on Saturday. This section freezes the difference and the exact pseudo-Swift wiring.

### 8.15B-1 Three surfaces, unequal jobs

| Surface | Mechanism | Who | Job | Path | Demo sec |
|---------|-----------|-----|-----|------|----------|
| **Inner capture (primary)** | NavigationStack root slot · optional ArrangementView primary | Photographer | Full-bleed charcoal preview · shutter · flip · Subject toggle · Pro CTA | `Features/Capture/InnerCaptureView.swift` (SCR-OL-B) hosted by `App/RootArrangementView.swift` | **0:10–0:40** |
| **Inner controls (secondary)** | ArrangementView secondary — **optional polish only** | Photographer | Stable touch half in tabletop — **same** shutter hierarchy | Split from SCR-OL-B chrome when `PoseMode.tabletop` + polish flag | Optional ≥2:45 |
| **Outer subject coach** | `CameraCaptureAccessory` via `.sceneAccessory` — **not** ArrangementView | Subject | One tip T1–T3 · brand whisper · non-interactive | `Duo/CameraCaptureAccessoryHost.swift` → `Features/CoachOverlay/SubjectCoachView.swift` (SCR-OL-C) | **0:15–0:45** T1 · **1:05–1:20** T2 |

**Law:** SCR-OL-C is never an ArrangementView secondary and never a `NavigationStack` push. Paywall SCR-OL-D is never on the outer. Shell enforces slots; CCA/RC fill content.

### 8.15B-2 Hour-1 dual-DISPLAY architecture (single-column inner)

Default from **DECISION: D-SHELL-02**: single column until CCA green. The product is still Duo-native because the outer coach is CCA.

```text
FILE: DuoApp/App/RootArrangementView.swift
LANE: LANE-SHELL
THEME: Film Tool --canvas #050505 · brand "Outer Lens" hero-level on SCR-OL-B
IMPORTS: import SwiftUI
AVAILABILITY: @available(iOS 27.1, *) for Duo APIs; fallback single column otherwise

PSEUDO:
struct RootArrangementView: View {
  @Environment(PoseRouter.self) private var pose
  @Environment(CutoverFlag.self) private var cutover
  // Subject bindings owned at shell edge; CCA host consumes them
  @State private var subjectEnabled = true
  @State private var subjectAvailable = false

  var body: some View {
    NavigationStack {
      Group {
        if cutover.isFrost {
          frostDualPaneShell()
        } else {
          outerLensFilmToolShell()
        }
      }
      .navigationTitle("Outer Lens")
    }
    .modifier(pose.hingeEffectsOnlyModifier())   // onHingeChange — effects only
  }

  @ViewBuilder
  private func outerLensFilmToolShell() -> some View {
    switch pose.mode {
    case .tabletop where tabletopPolishEnabled:
      filmToolTabletopSplit()                 // §8.6C
    case .book where bookPolishEnabled:
      filmToolBookSplit()                     // cut first — not win-slice
    default:
      filmToolSingleColumn()                  // M2 done look — PREFERRED
    }
  }

  @ViewBuilder
  private func filmToolSingleColumn() -> some View {
    GeometryReader { proxy in
      let hints = ArrangementRegions.snapshot(proxy: proxy)
      Color(/* Tokens.canvas #050505 */).ignoresSafeArea()
      // Slot: LANE-CCA fills InnerCaptureView — shell hosts only
      outerLensPrimarySlot
        .environment(\.regionHints, hints)
        .modifier(CameraCaptureAccessoryHost(
          isEnabled: $subjectEnabled,
          isAvailable: $subjectAvailable
        ))
        // SCR-OL-C renders INSIDE host — not here as a sibling pane
    }
  }
}
```

### 8.15B-3 Tabletop dual-PANE (Kyle laptop — polish)

Bitrig Kyle (Sep 18, 2026): use ArrangementView for **media upper / controls lower** when seated like a laptop. Maps to `PoseMode.tabletop` only after `GATE-CCA` green and Orchestrator polish OK.

```text
FILE: DuoApp/App/RootArrangementView.swift
CONDITION: pose.mode == .tabletop && tabletopPolishEnabled
NESTING: NavigationStack { ArrangementView { … } }   // VERIFIED safe
DEMO: silhouette beat only — CCA tip remain climax glass

PSEUDO:
@ViewBuilder
private func filmToolTabletopSplit() -> some View {
  ArrangementView {
    // PRIMARY — distance / glanceable media
    CapturePreviewPane()                              // full-bleed preview
      .splitArrangementLayoutRatio(0.55)
  } secondary: {
    // SECONDARY — stable base
    CaptureControlsPane(
      subjectAvailable: subjectAvailable,
      subjectEnabled: $subjectEnabled
    )                                                 // flip · ◎ shutter · Pro CTA
  }
  .arrangementViewStyle(.split.axes([.horizontal, .vertical]))
  .modifier(CameraCaptureAccessoryHost(
    isEnabled: $subjectEnabled,
    isAvailable: $subjectAvailable
  ))
}

AXIS-HIDE GUARD (Apple VERIFIED):
  Restricting axes can hide secondary entirely.
  → CapturePreviewPane MUST embed a minimal shutter if secondary can disappear
  → OR keep axes = [.horizontal, .vertical] and accept system choice
  → NEVER leave photographer without shutter because polish hid the rail
```

### 8.15B-4 Book dual-PANE (backup — cut first)

```text
PSEUDO — only if Orchestrator sets bookPolishEnabled:
ArrangementView {
  CapturePreviewPane()
    .splitArrangementLayoutRatio(0.55)
} secondary: {
  TipPackInspectorStub()   // INNER tip-pack picker — NOT SubjectCoachView
}
.arrangementViewStyle(.split.axes(.horizontal))

BANNED as secondary:
  SubjectCoachView (SCR-OL-C) — that is CCA
  PaywallHostView (SCR-OL-D) — inner sheet only
  PoseAgent / chat / interview panes — theme kill list
```

### 8.15B-5 Frost dual-PANE (cutover root)

```text
PSEUDO frostDualPaneShell():
  ArrangementView {
    frostPrimarySlot                                  // SCR-FD-A SensitiveSurfaceView
      .splitArrangementLayoutRatio(0.6)               // DECISION D-SHELL-06 default
  } secondary: {
    frostSecondarySlot                                // SCR-FD-B controls + Simulate Threat
  }
  .arrangementViewStyle(.split.axes([.horizontal, .vertical]))

OUTER SCR-FD-C decoy:
  Frost lane / closed-outer migration — NOT ArrangementView secondary (D-SHELL-03).
  Do NOT call UIWindowScene.ActivationAction targeting outer (inner only — VERIFIED).
```

### 8.15B-6 What judges see vs what shell built

| Second | Audience sees | Shell mechanism | Feature mechanism |
|--------|---------------|-----------------|-------------------|
| 0:10–0:40 | Inner Film Tool | Single column or tabletop ArrangementView | Capture session + chrome |
| 0:15–0:45 | Outer tip | Host modifier call site only | CCA + SubjectCoachView T1 |
| 0:50–1:05 | Paywall | NavigationStack sheet slot | RevenueCatUI |
| 1:05–1:20 | Outer T2 bloom | Stable env for `isPro` | GuideOvalView |

---

## 8.15C `onHingeChange` cookbook (expanded pseudo-Swift)

**Path:** `DuoApp/Duo/PoseRouter.swift` · **TC-S03**  
**Source symbols:** §05 hinge catalog · Tech Talk 111464

```text
FILE: DuoApp/Duo/PoseRouter.swift
IMPORTS: import SwiftUI
LANE: LANE-SHELL

PSEUDO:
@available(iOS 27.1, *)
@Observable final class PoseRouter {
  var mode: PoseMode = .unknown
  var hingeStatus: HingeStatusKind = .unavailable
  var hingeDegrees: Double? = nil
  var effectBend: Double = 0
  var regionHints: RegionHints = .empty
  var horizontalSizeClass: UserInterfaceSizeClass?
  var verticalSizeClass: UserInterfaceSizeClass?

  struct HingeEffectsOnlyModifier: ViewModifier {
    var router: PoseRouter
    func body(content: Content) -> some View {
      content.onHingeChange { _, newContext in
        router.handle(newContext)
      }
    }
  }

  func hingeEffectsOnlyModifier() -> HingeEffectsOnlyModifier {
    HingeEffectsOnlyModifier(router: self)
  }

  func handle(_ context: DeviceHingeContext) {
    guard let hinge = context.hinge else {
      // nil = no hinge in THIS context (phone OR hierarchy exit) — not permanent "not Duo"
      hingeStatus = .unavailable
      hingeDegrees = nil
      resetEffects(reason: "hinge-nil")
      reclassify()
      return
    }
    switch hinge.status {
    case .closed:
      hingeStatus = .closed
      hingeDegrees = hinge.angle.degrees
      resetEffects(reason: "closed")
    case .partiallyOpen:
      hingeStatus = .partiallyOpen
      hingeDegrees = hinge.angle.degrees
      // OPTIONAL effect fuel ONLY — default Saturday = leave effectBend at 0
      effectBend = 0
      // NEVER: if hinge.angle.degrees > 90 { mode = .tabletop }
    case .fullyOpen:
      hingeStatus = .fullyOpen
      hingeDegrees = hinge.angle.degrees
      resetEffects(reason: "fullyOpen")
    default:
      hingeStatus = .unavailable
      resetEffects(reason: "unhandled-status")
    }
    reclassify()
  }

  func resetEffects(reason: String) {
    effectBend = 0
    #if DEBUG
    print("PoseRouter.resetEffects", reason)
    #endif
  }

  func reclassify() {
    mode = PoseClassifier.classify(
      h: horizontalSizeClass,
      v: verticalSizeClass,
      regions: regionHints,
      hinge: hingeStatus
    )
  }
}

enum PoseClassifier {
  static func classify(
    h: UserInterfaceSizeClass?,
    v: UserInterfaceSizeClass?,
    regions: RegionHints,
    hinge: HingeStatusKind
  ) -> PoseMode {
    // Apple has NO public Pose enum — this is app design vocabulary (§05 §2)
    if regions.hasActiveDivision {
      return regions.divisionAxisGuess == .horizontal ? .tabletop : .book
    }
    if hinge == .closed || (h == .compact && !regions.everSawDivision) {
      return .closed
    }
    if hinge == .fullyOpen || h == .regular {
      return .open   // Integrator may alias .flat — D-SHELL-01
    }
    return .unknown  // keep last stable UI at call site
  }
}
```

**Illegal hinge patterns (Integrator nack · TC-S02/S03 fail):**

```text
// Angle threshold → layout
.onHingeChange { _, ctx in
  if let d = ctx.hinge?.angle.degrees, d > 100 { showTabletop = true }
}

// π equality → flat
if abs(radians - .pi) < 0.01 { layout = .flat }

// Invented notification
NotificationCenter.default.addObserver(… UIDeviceHingeDidChangeNotification)

// Stuck effect — forgetting reset on non-partial
// UIKit radians used as degrees without conversion
```

---

## 8.15D Reserved regions — placement recipes (expanded)

**Path:** `DuoApp/Duo/ArrangementRegions.swift` · symbols from §05 §3

```text
FILE: DuoApp/Duo/ArrangementRegions.swift
IMPORTS: import SwiftUI
LANE: LANE-SHELL

PSEUDO:
enum ArrangementRegions {
  struct Snapshot: Equatable, Sendable {
    var hasActiveDivision: Bool
    var divisionAxisGuess: Axis?          // HEURISTIC for PoseMode — ArrangementView still lays out
    var activeDivisionFrames: [CGRect]    // frame ALREADY includes margins
    var activeOcclusionFrames: [CGRect]
    var inactiveDivisionFrames: [CGRect]  // even-column / planning
  }

  static func snapshot(proxy: GeometryProxy) -> Snapshot {
    // PRACTICAL RULE (§05): always includeInactive then filter —
    // runtime default filtering is UNKNOWN (Tech Talk vs doc prose)
    let divisions = proxy.reservedRegions(
      kind: .division,
      options: .includeInactive,
      layoutDirectionBehavior: .mirrors
    )
    let active = divisions.filter(\.isActive)
    let inactive = divisions.filter { !$0.isActive }
    let occlusions = proxy.reservedRegions(
      kind: .occlusion,
      options: .includeInactive
    ).filter(\.isActive)

    let axis: Axis? = {
      guard let f = (active.first ?? inactive.first)?.frame else { return nil }
      // width-dominant reserved rect → vertical divider (book)
      // height-dominant → horizontal divider (tabletop)
      return f.width >= f.height ? .vertical : .horizontal
    }()

    return Snapshot(
      hasActiveDivision: !active.isEmpty,
      divisionAxisGuess: axis,
      activeDivisionFrames: active.map(\.frame),
      activeOcclusionFrames: occlusions.map(\.frame),
      inactiveDivisionFrames: inactive.map(\.frame)
    )
  }
}
```

**Publish loop (do not cache once — SIM-OBS late arrival):**

```text
PSEUDO in RootArrangementView:
GeometryReader { proxy in
  let snap = ArrangementRegions.snapshot(proxy: proxy)
  content
    .onAppear { pose.regionHints = snap; pose.reclassify() }
    .onChange(of: proxy.size) { _, _ in
      pose.regionHints = ArrangementRegions.snapshot(proxy: proxy)
      pose.reclassify()
    }
}
```

**Displacement → Film Tool:**

| Situation | Move | Don’t move | Path |
|-----------|------|------------|------|
| Book partial | Toasts/alerts → trailing | Continuous preview scroll | Root + Capture |
| Tabletop | Preview ↑ · controls ↓ | Features (no reduced mode) | ArrangementView polish |
| Occlusion | Tip / Pro CTA clear of frame | Blind center chrome | Pass frames into tip plate |
| Outer closed | Expect empty regions | Invent fake crease | PoseMode.closed |

---

## 8.15E Failure modes catalog (FM-*)

Symptom → cause → fix → path. Shell owns recovery unless noted.

### Layout / ArrangementView

| ID | Symptom | Cause | Fix | Path |
|----|---------|-------|-----|------|
| **FM-A01** | Secondary controls vanish on fold/rotate | Axis restrict hid secondary | Allow both axes **or** embed shutter in primary | `RootArrangementView.swift` |
| **FM-A02** | Blank gutter on flat open | Drawing inactive division as a hole | Don’t paint empty stripe; let ArrangementView/system work | `ArrangementRegions.swift` |
| **FM-A03** | Layout loop / broken scroll | ArrangementView inside List/ScrollView | Nest under NavigationStack only | Root |
| **FM-A04** | Broken back stack | NavigationStack inside arrangement | Move NavigationStack outside | Root |
| **FM-A05** | `overlayArrangementZIndex` always 0 | Read on arrangement root | Read from **subview** | Pane child |
| **FM-A06** | Looks like Samsung Flex clone | Custom hinge-keyed panes | ArrangementView + regions only | Review vs §05 |
| **FM-A07** | Paywall on outer | Wrong presentation host | SCR-OL-D sheet from **inner** | Paywall call site |

### Pose / hinge

| ID | Symptom | Cause | Fix | Path |
|----|---------|-------|-----|------|
| **FM-H01** | Effect stuck after open | Forgot reset | Reset on nil/closed/fullyOpen | `PoseRouter.swift` |
| **FM-H02** | Pose flips every frame | Classifying from noisy degrees | Status + regions + size class | PoseClassifier |
| **FM-H03** | Works on iPhone, fails on Duo | Missing 27.1 guard / fallback | `#available` + single-column fallback | Duo/* |
| **FM-H04** | Hinge never fires | Observer not attached | Modifier on App/Root | `DuoAppApp.swift` |
| **FM-H05** | Angle 57× wrong | Radians as degrees | SwiftUI `Angle.degrees` | PoseRouter |
| **FM-H06** | Layout jumps at 90° | Illegal threshold | Delete angle→layout (**TC-S02**) | Integrator nack |

### Reserved regions

| ID | Symptom | Cause | Fix | Path |
|----|---------|-------|-----|------|
| **FM-R01** | Empty always | Cached before first layout; or outer display | Re-query each pass; expect empty on outer | ArrangementRegions |
| **FM-R02** | Double inset | Added margins on top of frame | Use `frame` only | ArrangementRegions |
| **FM-R03** | Tip under camera bump | Ignored occlusion | Pass occlusion frames | CoachOverlay |
| **FM-R04** | RTL wrong side | Mixed mirrors/fixed | Keep `.mirrors` default | ArrangementRegions |
| **FM-R05** | Column on crease when flat | Unused inactive division | `includeInactive` for planning | ArrangementRegions |

### Dual-display / CCA boundary (shell side)

| ID | Symptom | Cause | Fix | Path |
|----|---------|-------|-----|------|
| **FM-C01** | ArrangementView “outer tip pane” | Confused CCA with arrangement | Tip = CCA host only | Host + Root |
| **FM-C02** | ActivationAction for outer coach | Outer windows disallowed | Use CCA | Never |
| **FM-C03** | Shutter dies when accessory unavailable | Essential controls on accessory path | Inner always shoots (**TC-C03**) | InnerCaptureView |
| **FM-C04** | Shell polish past 12:10 | Ignoring gate clock | Freeze shell; Orchestrator decides | GATE |
| **FM-C05** | Frost + Outer Lens both visible | Non-exclusive root | Single `if cutover` branch | Root |

### Continuity / state

| ID | Symptom | Cause | Fix | Path |
|----|---------|-------|-----|------|
| **FM-S01** | Session restarts every fold | View identity churn | `@State` router at App; stable stack | DuoAppApp |
| **FM-S02** | Pro tip doesn’t bloom | Coach model recreated | EntitlementState outside swap | Shared |
| **FM-S03** | Permission primer loops | PoseMode remounts SCR-OL-A | Drive from perm state machine | Capture + Types |
| **FM-S04** | Cutover doesn’t swap | Flag written, reader stale | `refreshFromDisk()` on active | CutoverFlag |

### Failure → Saturday decision tree

```text
IF FM-A01/A03/A04 → fix nesting/axis ≤10 min; else force single-column
IF FM-H06 → delete angle→layout immediately; TC-S02 red until gone
IF FM-C01/C02 → rip ArrangementView-as-outer; wire CCA host
IF FM-C04 → stop polish; run GATE-CCA
IF CCA red at 12:15 → CUTOVER.flag frost; frostDualPaneShell(); stop CCA
IF only FM-R03 → inset tip; do not block climax glass
```

---

## 8.16 Do / Don’t (Apple-native vs Android-fold clone)

### Do

1. Design for **two size classes**; freely resizable.  
2. Use system navigation/toolbars for vertical bars + fold avoidance.  
3. Displace interactive chrome around the fold; leave scrolling alone.  
4. Book: alerts/menus trailing. Tabletop: media top, controls bottom — **same** controls.  
5. Prefer ArrangementView `.split` for main/detail.  
6. Query reserved regions; use inactive for even grids / planning.  
7. `onHingeChange` for effects only.  
8. Keep hierarchy identical closed↔open.  
9. Demo: physical pose change → system layout responds in ≤30s.  
10. One climax API path (CCA **or** frost).

### Don’t

1. Layout per marketing pose (StandBy/seated/standing as separate apps).  
2. Compute layout from hinge angle.  
3. Put ArrangementView inside List/ScrollView or navigation inside arrangements.  
4. Custom UIKit bars if you want vertical adoption.  
5. Primary taps in the crease.  
6. Strip features in tabletop.  
7. Stretch single-column phone UI across open inner without reflow **or** honest split.  
8. Assume symmetric safe areas.  
9. Create new windows on the outer display.  
10. Ship Accorduon/hinge-Flappy as the shell product.

---

## 8.17 Example repos — pattern fuel only (do not fork)

| Repo | Steal for shell | Don’t |
|------|-----------------|-------|
| [artemnovichkov/iPhone-Duo-by-Examples](https://github.com/artemnovichkov/iPhone-Duo-by-Examples) | Hour-1 catalog: hinge, regions, split/overlay | Ship as product |
| [artemnovichkov/ClawKit](https://github.com/artemnovichkov/ClawKit) | Tabletop region choreography | Game scope |
| [ScaleWithEzra/cosign-ios](https://github.com/ScaleWithEzra/cosign-ios) | `ArrangementView` `.split.axes(.horizontal)` | Simulated agents product |
| [Lazynius1/Moments](https://github.com/Lazynius1/Moments) | CCA host pattern (feature lane) | Fork social app |
| [po-miyasaka/DuoInspector](https://github.com/po-miyasaka/DuoInspector) | Measurement / debugging | Enter as inspector app |
| [marpies/iphone-duo-sample](https://github.com/marpies/iphone-duo-sample) | UIKit counterparts | — |

---

## 8.18 DECISION log — Integrator fills Saturday morning

Mark each when decided; leave blank = use default in this chapter.

| ID | Decision | Default if blank | Filled value |
|----|----------|------------------|--------------|
| **DECISION: D-SHELL-01** | Collapse `.flat` vs `.open` in `PoseMode`? | **FROZEN: keep both** (Codex P0). Same climax layout; PoseRouter may distinguish polish only. | Codex review 2026-09-26 |
| **DECISION: D-SHELL-02** | Outer Lens hour-1 uses ArrangementView or single column? | **Single column** until CCA green | |
| **DECISION: D-SHELL-03** | Frost outer decoy = closed-outer migration vs arrangement secondary? | Prefer **system closed-outer** | |
| **DECISION: D-SHELL-04** | Where to attach `onHingeChange` — App root vs RootArrangementView? | RootArrangementView modifier | |
| **DECISION: D-SHELL-05** | Tabletop polish before or after RC wire? | **After** CCA green + RC stub; never steal M4–M5 | |
| **DECISION: D-SHELL-06** | `splitArrangementLayoutRatio` for Frost primary? | `0.6` | |
| **DECISION: D-SHELL-07** | Allow `.overlay` arrangement anywhere in win slice? | **No** — solid tip plate / frost materials are not Arrangement overlay | |
| **DECISION: D-SHELL-08** | Navigation title string Outer Lens vs wordmark asset? | Title string + Shared asset mark | |

---

## 8.19 Lane prompt stub (paste with PDF)

```text
You are LANE-SHELL for Outer Lens / Duo Sat Sep 26.
Read bible §00, then §08 + §05 + §06 + §07 PoseMode/CutoverFlag.
Own ONLY: App/DuoAppApp.swift, App/RootArrangementView.swift,
Duo/PoseRouter.swift, Duo/ArrangementRegions.swift, Shared/CutoverFlag.swift.
Layout via ArrangementView / reservedRegions; hinge = effects only — never layout.
Do NOT touch Features/Capture, CoachOverlay, Frost, Monetization, or invent RC IDs.
Leave CCA host empty or SHELL-READY for LANE-CCA.
Done when TC-S01–S04 pass and GATE-SHELL.md is written.
If blocked, write BLOCKED: <reason> and stop.
```

---

## 8.20 Cross-links

| Need | Doc |
|------|-----|
| Symbol catalog deep dive | `docs/bible/05-duo-api-inventory.md` |
| Tree + OWNER locks | `docs/bible/06-repo-file-tree.md` |
| `PoseMode` / `CutoverFlag` signatures | `docs/bible/07-types-state-machines.md` |
| CCA product screens | `docs/bible/11-outer-lens-product.md` |
| Frost cutover | `docs/bible/12-frostduo-cutover.md` |
| RC other-pane unlock | `docs/bible/09-revenuecat-monetization.md` |
| Theme lock | `docs/bible-single-theme-contract.md` |
| HIG / poses research | `internal/research-duo-hig-poses.md` |
| API research | `internal/research-duo-apis.md` |

---

## 8.21 Open UNKNOWN list (shell-relevant)

1. Runtime default of `reservedRegions` active filtering — always pass `.includeInactive`.  
2. Numeric hinge angle contract — effects only; prefer status.  
3. Whether Duo sim ever presents CCA usefully — gate at 12:15.  
4. Camera-companion entitlement string — do not invent.  
5. Exact HIG prose verbatim (fetch shells thin) — rely on Tech Talk transcripts.  
6. `splitArrangementAxis` Environment often nil (**SIM-OBS**) — do not gate.  
7. Live Xcode 27.1 release-notes wording for StandBy/extensions — skip those features regardless.

---

## 8.22 Sources

### Apple

- [Get ready for iPhone Duo](https://developer.apple.com/iphone-duo/)  
- [Preparing your app for iPhone Duo](https://developer.apple.com/documentation/technologyoverviews/preparing-your-app-for-iphone-duo)  
- [Designing for iPhone Duo (HIG)](https://developer.apple.com/design/human-interface-guidelines/designing-for-iphone-duo)  
- [ArrangementView](https://developer.apple.com/documentation/swiftui/arrangementview)  
- [onHingeChange](https://developer.apple.com/documentation/swiftui/view/onhingechange(isenabled:_:))  
- [ReservedRegion](https://developer.apple.com/documentation/swiftui/reservedregion)  
- Tech Talks: [111462](https://developer.apple.com/videos/play/tech-talks/111462/) · [111463](https://developer.apple.com/videos/play/tech-talks/111463/) · [111464](https://developer.apple.com/videos/play/tech-talks/111464/) · [111466](https://developer.apple.com/videos/play/tech-talks/111466/)

### Bitrig / secondary

- [Bitrig Now Builds iPhone Duo Apps](https://bitrig.com/blog/bitrig-builds-iphone-duo-apps) (Kyle — laptop ArrangementView)  
- [Get Your App Ready for iPhone Duo](https://bitrig.com/blog/iphone-duo-app-development)  
- Artem iPhone-Duo-by-Examples · ClawKit · DuoInspector · cosign-ios (pattern fuel)

### Prior store

- `internal/research-duo-apis.md`  
- `internal/research-duo-hig-poses.md`  
- `docs/bible-single-theme-contract.md`  
- `docs/multi-ai-build-routing.md`

---

*End of §08. Next owners: LANE-CCA implements CCA host into shell slots (§11); LANE-RC unlocks other pane without editing PoseRouter (§09); Orchestrator flips cutover only via `CUTOVER.flag` (§12).*
