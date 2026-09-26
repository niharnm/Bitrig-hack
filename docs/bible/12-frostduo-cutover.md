# §12 — FrostDuo cutover screen specs

**Bible section:** 12 · Screen specs (cutover)  
**Product mode:** FrostDuo / Frost Cover Vault — **hour-one cutover only**  
**Canonical locks:** [`docs/bible-single-theme-contract.md`](../bible-single-theme-contract.md) · [`docs/design-direction.md`](../design-direction.md) §2B / §3B · [`docs/outer-lens-3h-build-plan.md`](../outer-lens-3h-build-plan.md) §3  
**Research fuel:** [`internal/research-frostduo.md`](../../internal/research-frostduo.md) · [`internal/design-research-frostduo-ui.md`](../../internal/design-research-frostduo-ui.md)  
**Constraint:** Spec only — **no Saturday app sources** in this chapter. Agents implement from these SCR-IDs on Saturday behind the flag.  
**Page band:** ~28 of the ~40–50 page §12–§14 block.

---

## 12.0 Non-product notice (read before any SCR)

**FrostDuo is not a second product to design “insufficiently.”**

| Truth | Consequence |
|-------|-------------|
| Primary theme for the mega bible = **Outer Lens — Film Tool** | §11 owns SCR-OL-*; Film Tool tokens in §13 |
| FrostDuo = **CUTOVER module** | Spec lives in **§12 only**; tokens in design-direction §2B / this §13 cutover block |
| Activation = flag flip | `docs-runtime/CUTOVER.flag` + root slot swap + DEMO-SCRIPT appendix — **not** a second brand bible |
| Equal page budget to Outer Lens = defect | Do not invent parallel Film Tool redesign, second amber system, or SCR outside SCR-FD-* |

**Brad (cutover only, frozen):** Shoulder-surfers ruin private screens — Duo frosts the inner face and shows a decoy on the outer; Pro unlocks vault decoys.

**Matt (cutover only, frozen):** Free blurs your secrets on the inner screen; Pro puts believable decoys on the outer.

If a paragraph in this chapter cannot name a **SCR-FD-*** ID, a path under `Features/Frost/**` / shared paywall / `CUTOVER.flag`, or a **demo second** in the cutover appendix — **delete it**.

---

## 12.1 Cutover contract — when lanes switch

### 12.1.1 Gate clock (Orchestrator-only)

| Wall clock | Artifact | Owner | Action |
|------------|----------|-------|--------|
| **12:10** | Stop new CCA thrash | Orchestrator | Probe only — no new Capture/Coach features |
| **12:15 sharp** | `docs-runtime/GATE-CCA.md` | Orchestrator **only** | Write GREEN or RED |
| **12:15 if RED** | `docs-runtime/CUTOVER.flag` | Orchestrator **only** | Write **`frost`** only (**DECISION / Claude P0:** never `true` / invent tokens) |
| **≤12:20** | Lane promotion | Orchestrator | Promote LANE-FROST; park LANE-CCA feature work |

**GREEN (stay Outer Lens):** do **not** flip cutover for polish debt. Frost stays file-isolated standby.

**RED (activate this chapter):** ANY of:

1. `CameraCaptureAccessory` never available after live/fake session **and** tip-only coach story cannot be rehearsed honestly.  
2. Entitlement / provisioning mystery blocks CCA with no organizer answer by 12:15.  
3. Team still fighting dual-preview / invented APIs with **no tip on glass** by 12:15.  
4. Orchestrator judges CCA will not be demo-viable by 3:15 even with Simulate tip.

### 12.1.2 RED actions (≤5 minutes — map to demo 0:00 readiness)

| # | Action | Path / artifact |
|---|--------|-----------------|
| 1 | Write flag | `docs-runtime/CUTOVER.flag` = frost |
| 2 | Write gate | `docs-runtime/GATE-CCA.md` = RED + one-line reason |
| 3 | Stop CCA feature work | Leave `Features/Capture/**` · `Features/CoachOverlay/**` compile stubs; no new commits |
| 4 | Promote Frost | LANE-FROST becomes primary writer; LANE-CCA writers may help Frost shell if Integrator reassigns |
| 5 | Switch copy | LANE-COPY loads Frost Brad/Matt + cutover DEMO-SCRIPT appendix |
| 6 | Retarget RC surface | Same `pro` entitlement / Test Store — unlock target = **outer decoy C**, not T2 oval |
| 7 | Root slot | `App/RootArrangementView.swift` reads `Shared/CutoverFlag.swift` → hosts Frost SCR set |

**Hard stop:** After RED → **do not half-build both.** Do not skin Outer Lens as frost. Full concept switch.

### 12.1.3 Lane matrix after gate

| Mode | Active lanes | Parked |
|------|--------------|--------|
| Primary Outer Lens (`CUTOVER.flag` false) | SHELL · CCA · RC · COPY · ASSETS · DEMO · INTEGRATOR | FROST = stub files only until 12:15 |
| **Cutover FrostDuo (`CUTOVER.flag` = `frost`)** | SHELL · **FROST** · RC · COPY · ASSETS · DEMO · INTEGRATOR | CCA stops feature work; keep fallback notes only |

**Concurrency:** still ≤ **three** coding writers. Preferred live set after RED: **FROST + RC + (SHELL help or ASSETS)**.

### 12.1.4 `CutoverFlag` contract

| Item | Spec |
|------|------|
| Path | `Shared/CutoverFlag.swift` (LANE-SHELL owns; all lanes read) |
| Runtime source | Reads `docs-runtime/CUTOVER.flag` (or bundled equivalent) — Orchestrator write only |
| Consumers | `App/RootArrangementView.swift` · FROST views · COPY script picker · DEMO checklist |
| Forbidden | Feature lanes writing the flag; flipping mid-demo without Orchestrator |

**Acceptance:** **TC-S04** — `CutoverFlag` readable by feature lanes (`docs/bible-single-theme-contract.md` §6A).

**DECISION (Claude review P0):** File token for cutover = exact `frost`. Primary = absent/empty/`false`. Forbidden: `true`, `outerLens` as file contents.

---

## 12.2 File tree freeze (Frost slice)

From theme contract §4 — Frost-owned leaves only. Do not invent new top-level folders.

```text
DuoApp/
  App/
    RootArrangementView.swift            # LANE-SHELL — swaps OL ↔ FD host by flag
  Features/
    Frost/                               # LANE-FROST (behind CutoverFlag)
      SensitiveSurfaceView.swift         # SCR-FD-A
      FrostControlsView.swift            # SCR-FD-B
      FrostOverlayView.swift             # frost layers used by A
      OuterDecoyStageView.swift          # SCR-FD-C
      SimulateThreatControl.swift        # control + force-lock API
      ThreatLevel.swift                  # .clear|.cautious|.threatened|.locked
    Paywall/
      PaywallHostView.swift              # SCR-FD-D (shared RC host)
  Monetization/
    PurchasesConfig.swift                # LANE-RC
    Entitlements.swift                   # EntitlementState.isPro
  DesignSystem/
    Tokens.swift                         # frost tokens when flag true (§13)
    Motion.swift                         # F1–F3 (§14)
  Resources/
    Assets.xcassets/Frost/               # decoy packs A/B/C (§13)
    Localizable.strings                  # Frost strings
  Shared/
    CutoverFlag.swift
    Types.swift                          # ThreatLevel / FrostMode shared if Integrator places here
  docs-runtime/
    CUTOVER.flag                         # Orchestrator write only
    GATE-CCA.md
    GATE-FROST.md
    DEMO-SCRIPT.md                       # cutover appendix
    DEMO-LAST-PASS.md
```

**SPM:** RevenueCat + RevenueCatUI ≥ **5.43.0** only. **No** PrivacyScreen / SnapShield packages — remix patterns only.

---

## 12.3 Screen ID freeze — SCR-FD-* only

| SCR-ID | Screen | Path anchor | Demo seconds (cutover script) |
|--------|--------|-------------|-------------------------------|
| **SCR-FD-A** | Sensitive surface (inner) | `Features/Frost/SensitiveSurfaceView.swift` | **0:00–0:15** |
| **SCR-FD-B** | Controls / Simulate (inner) | `Features/Frost/FrostControlsView.swift` | **0:15–0:35** |
| **SCR-FD-C** | Outer decoy stage | `Features/Frost/OuterDecoyStageView.swift` | **0:25–0:45** A/B · **1:05–1:20** C |
| **SCR-FD-D** | Paywall (inner) | `Features/Paywall/PaywallHostView.swift` | **0:50–1:05** |
| **SCR-FD-E** | Closed-cover vault (nice) | Optional outer-only | **Cut first** — only if M8 early |

**Aliases:** design-direction `FD-A`…`FD-E` map 1:1 to `SCR-FD-A`…`SCR-FD-E`. Do not invent `SCR-I-01`, `SCR-01`, or third-product prefixes.

**Tip styles:** Outer Lens T1–T3 do **not** apply in cutover mode. Frost uses **decoy packs A/B/C** and threat ladder only.

**Motions:** **F1** frost settle · **F2** decoy snap · **F3** vault crossfade — see §14. Press micros P1–P3 are Film Tool (Outer Lens); Frost may reuse quiet button press feel but **must not** ship amber shutter theater.

---

## 12.4 Shared types (signatures for Saturday — Integrator)

Bible ships signatures; agents emit implementations.

```text
enum ThreatLevel {    // Features/Frost/ThreatLevel.swift or Shared/Types.swift
  case clear
  case cautious
  case threatened
  case locked
}

enum DecoyPack {
  case lockLookalike   // A — free teaser
  case busyCover       // B — climax selectable
  case vaultCover      // C — Pro unlock reveal
}

struct FrostMode {
  var threat: ThreatLevel
  var protectEnabled: Bool
  var activeDecoy: DecoyPack   // free locked → .lockLookalike; Pro may select B/C
}

struct EntitlementState {     // Monetization/Entitlements.swift — LANE-RC
  var isPro: Bool             // entitlement id "pro"
}
```

| Rule | Detail |
|------|--------|
| Escalation | Immediate on second-face / Simulate / snatch tilt |
| De-escalation | Smoothing window (~8 frames) if live ARKit path exists — **not** required for Simulate path |
| Outer at locked | Always show a designed decoy — never blank black |
| Pro gate | Pack **C** (and pack picker / vault teaser) requires `EntitlementState.isPro == true` |

---

## 12.5 SCR-FD-A — Sensitive surface (inner)

| Field | Spec |
|-------|------|
| **ID** | SCR-FD-A |
| **Path** | `Features/Frost/SensitiveSurfaceView.swift` |
| **Who** | Owner (inner face) |
| **Job** | One mail **or** notes surface; progressive frost ladder; hero secret blurs first |
| **Demo** | **0:00–0:15** clear → readable; later frost under F1 |
| **Lane** | LANE-FROST |

### 12.5.1 Content freeze (pick one Sat AM — do not ship both)

| Option | Hero secret (blurs first at `.cautious`) | Room-readable rule |
|--------|------------------------------------------|--------------------|
| **Mail thread** | Subject line + one OTP / balance-like number | Body ≥18pt equivalent; sparse list |
| **Notes** | Title + one secret paragraph / code | Same |

**Reject:** VaultDemo finance tabs, multi-account dashboards, dense tables (PrivacyScreen lookalike tax).

### 12.5.2 Threat ladder → visual (maps to `FrostOverlayView.swift`)

| Level | Inner visual | Blur radii | Copy |
|-------|--------------|------------|------|
| `.clear` | Full contrast content | 0 | — |
| `.cautious` | High-sensitivity fields soft-blur | **8** (`--blur-cautious`) | None |
| `.threatened` | Medium fields blur + light material wash; ~6% brightness drop | **16** (`--blur-threatened`) | None |
| `.locked` | Full frost: `.ultraThinMaterial` + **sparse** frost grain (~0.25 density) + small SF Symbol | **24** field max + overlay | Quiet **“Covered”** or **“Private”** — corner badge 12–14pt **or** wordless |

**Overlay path:** `Features/Frost/FrostOverlayView.swift`  
**Hit testing:** overlay `.allowsHitTesting(false)` so controls under/beside remain tappable (PrivacyScreen pattern — remix, don’t fork).  
**Motion:** **F1** — easeInOut ~**280ms** (`--dur-frost`) on each threat step; whole pane goes milky at locked.  
**Tokens:** §13 FrostDuo block (`--frost-ice`, `--frost-ink`, soft canvas — **not** VaultDemo `#0A0A0F`).

### 12.5.3 States

| State | UI | Recovery |
|-------|-----|----------|
| `content.ready` | Clear mail/notes | Default demo open |
| `threat.cautious` / `threatened` / `locked` | Ladder above | Simulate / ARKit / motion |
| `protect.off` | No automatic frost; manual Frost now still OK | Owner toggle on SCR-FD-B |
| `camera.denied` | Content still visible; frost via Simulate / motion / manual | Never dead-end demo |

### 12.5.4 Sensing spine (behavior — not a second product)

| Path | When | Notes |
|------|------|-------|
| **ARKit face tracking** (primary on device) | TrueDepth / supported | `ARFaceTrackingConfiguration`; second face → `.locked`; **not in Simulator** |
| **Motion snatch** | `deviceTiltRate > 120°/s` | Instant `.locked` (pattern) |
| **Simulate Threat** | **Always required for Duo sim** | SCR-FD-B — load-bearing |
| Vision face rectangles | Optional secondary | **Do not build both** in 4h unless ARKit proven dead |

**Bible rule:** Face-detect is the Jane gasp, **not** the only unlock path. Fallback is score-critical.

### 12.5.5 Acceptance

| TC | Assertion |
|----|-----------|
| **TC-F01** | Threat → inner frost (SCR-FD-A · F1) |
| Across-room | From 3–5 m: inner goes milky in &lt;0.5s — not only a tiny field |

---

## 12.6 SCR-FD-B — Controls / Simulate (inner)

| Field | Spec |
|-------|------|
| **ID** | SCR-FD-B |
| **Path** | `Features/Frost/FrostControlsView.swift` + `SimulateThreatControl.swift` |
| **Who** | Owner |
| **Job** | Protect toggle · **Simulate Threat** · Pro / Unlock Cover Vault CTA — always tappable |
| **Demo** | **0:15–0:35** |
| **Lane** | LANE-FROST |

### 12.6.1 Control inventory (hard cap)

| Control | Action | Demo second |
|---------|--------|-------------|
| **Protect** | Enables automatic threat→frost path | Prep before 0:25 |
| **Simulate Threat** | Forces `.locked` ~3s (or until clear) | **0:25** — climax trigger |
| **Frost now** (optional manual) | Force lock without ARKit | Backup if Simulate label confuses |
| **Unlock Cover Vault** | Presents SCR-FD-D | **0:45–0:50** |
| Status flake | Tiny SF Symbol — clear=hidden; locked=flake ~80% opacity | Never LED strip / radar |

**Placement by pose**

| Pose | Controls region |
|------|-----------------|
| Open / flat | Bottom chrome or trailing |
| **Tabletop (primary demo pose)** | **Below crease** — content above, controls below (`Duo/ArrangementRegions.swift`) |
| Book (backup) | Trailing half — content leading |

**Do not** put the primary secret in the controls region.

### 12.6.2 Simulate Threat — load-bearing API behavior

| Item | Spec |
|------|------|
| Path | `Features/Frost/SimulateThreatControl.swift` |
| Behavior | `simulateThreat(duration:)` → force `ThreatLevel.locked` for ~**3s** (tunable) |
| Also OK | Launch args `-demo` / `-screenshots` for scripted walkthrough (PrivacyScreen pattern) |
| TC | **TC-F03** — Simulate Threat works in sim |

**Demo order if face flakes (freeze):** clear inner → tap Simulate → inner frost + outer decoy snap → paywall → Pro unlock — **never wait on a second face**.

### 12.6.3 Jane-facing chrome rules

| Do | Don’t |
|----|-------|
| Quiet teal-slate accent CTA (`--accent` frost tokens) | Red alert / “INTRUDER” / traffic-light threat meter in 90s |
| “On-device. Faces never leave this iPhone.” in Settings / pitch | Surveillance framing, cloud AI vision |
| Camera ask on first Protect | Dead-end alert that blocks demo |
| Debug overlays behind long-press or `-demo` only | Live “2 FACES” counter in Jane’s 90s |

### 12.6.4 Info.plist copy (if ARKit/camera path ships)

| Key | Draft string |
|-----|--------------|
| `NSCameraUsageDescription` | “FrostDuo uses the front camera on-device to notice if someone else is looking at your screen so it can frost private content. Face data never leaves your iPhone.” |

Denied camera → Simulate / motion / manual still work (**TC** path continuity).

---

## 12.7 SCR-FD-C — Outer decoy stage

| Field | Spec |
|-------|------|
| **ID** | SCR-FD-C |
| **Path** | `Features/Frost/OuterDecoyStageView.swift` |
| **Who** | Shoulder-surfer / room (outer face) |
| **Job** | Idle → lock decoy → Pro vault pack; **stage not mirror** |
| **Demo** | **0:25–0:45** packs A/B · **1:05–1:20** pack C |
| **Lane** | LANE-FROST (+ ASSETS for images) |

### 12.7.1 Decoy packs (LOCKED — only these three)

#### Pack A — Lock Lookalike (free teaser default)

| | |
|--|--|
| **What room sees** | Calm iOS-adjacent lock: large time, date, soft abstract wallpaper, empty notification stack or one banal “Weather” |
| **Why** | Instantly legible; story = “just a locked phone” |
| **Asset** | `Resources/Assets.xcassets/Frost/DecoyLockLookalike.imageset` (+ optional SwiftUI time overlay) |
| **Tier** | Free locked default |
| **Risk** | Too static — tick clock minutes OK; no live wallpaper engine |

#### Pack B — Busy Cover (demo climax favorite)

| | |
|--|--|
| **What room sees** | Fake Home / Messages-busy face — **2–3** unread bubbles with innocuous titles (“Mom”, “Team lunch”) **or** calendar “Busy until 4” |
| **Why** | Outer ≠ idle clock; judges read decoy story without narration |
| **Asset** | `Resources/Assets.xcassets/Frost/DecoyBusyCover.imageset` and/or SwiftUI busy sketch |
| **Tier** | Selectable; free may teaser; avoid phishing brands |
| **Risk** | Phishy if bank/Apple branding — **generic names + FrostDuo-neutral icons only** |

#### Pack C — Vault Cover (Pro unlock reveal)

| | |
|--|--|
| **What room sees** | Editorial frosted-glass cover + quiet lock glyph + pack name (“Commuter”, “Café”, “Flight”) |
| **Why** | Matt beat visible on **other** display: free A → purchase → C snaps on outer |
| **Asset** | `Resources/Assets.xcassets/Frost/DecoyVaultCover.imageset` |
| **Tier** | **`pro` only** |
| **Risk** | Steel-door crypto vibes — keep editorial wallpaper + quiet glyph, not 3D vault door |

### 12.7.2 State × tier matrix (freeze)

| State | Outer (free) | Outer (Pro) |
|-------|--------------|-------------|
| Clear / idle | Soft **calm wallpaper** (not a second clock app) | Same + optional Pro idle pack |
| Threatened (optional) | Teaser decoy @ ~40% opacity | Full decoy |
| **Locked** | Pack **A** (or B if preselected free teaser) | Full A/B + unlocked **C** result |
| Closed pose | Outer-only decoy showcase | Vault pack hero (SCR-FD-E nice) |

**Idle freeze:** calm wallpaper before threat (design-direction §3B).  
**Free locked:** **A**.  
**Pro after purchase:** **C** (B selectable pack).

### 12.7.3 Motions on this screen

| Motion | Spec | Demo |
|--------|------|------|
| **F2** Decoy snap | Outer idle → A/B at lock · paired with F1 · ~same 280–400ms window | **0:25–0:35** |
| **F3** Vault crossfade | Outer → pack C · **400ms** calm · no confetti | **1:05–1:20** |

### 12.7.4 Acceptance

| TC | Assertion |
|----|-----------|
| **TC-F02** | Outer decoy at locked — pack A |
| **TC-F04** | Pro vault/decoy C gated by `pro` after TC-R03 · F3 |
| Across-room | Outer clearly different wallpaper/UI — fails if black or mirrors inner |

### 12.7.5 Anti-malware visual rules (outer)

| Avoid | Prefer |
|-------|--------|
| Capture-shield blank black | Designed placeholder (SnapShield *idea*, not package) |
| Phishy fake bank login | Lock lookalike or busy-but-banal |
| Matrix green / terminal fonts | SF Pro; editorial wallpapers |
| Craft-camera Liquid Glass HUD on decoy | Believable wallpaper only (§13 / ios-craft-addendum) |

---

## 12.8 SCR-FD-D — Paywall (inner only)

| Field | Spec |
|-------|------|
| **ID** | SCR-FD-D |
| **Path** | `Features/Paywall/PaywallHostView.swift` *(shared with SCR-OL-D)* |
| **Who** | Owner |
| **Job** | RevenueCatUI Test Store → entitlement `pro` → other-pane unlock |
| **Demo** | **0:50–1:05** |
| **Lane** | LANE-RC |

### 12.8.1 Free vs Pro surface map

| Tier | Inner | Outer |
|------|-------|-------|
| Free | Full progressive frost ladder | One boring decoy (**A**) |
| Pro | Same frost | Packs A/B/C + vault cover; optional tiny secret-notes teaser |

**Vault ≠ password manager.** Vault = outer decoy pack + optional one locked “secret notes” card gated by `pro`.

### 12.8.2 Unlock choreography (must be other-display)

1. Threat → frost + free/teaser decoy (**0:25–0:45**, F1+F2).  
2. Tap **Unlock Cover Vault** on **inner** controls → SCR-FD-D.  
3. Test Store → **Successful Purchase** (**0:50–1:05**).  
4. `EntitlementState.isPro` flips → **outer** swaps to pack **C** with F3 crossfade (**1:05–1:20**).  
5. Optional: inner shows small “Vault unlocked” check once, then clears.

**Matt sentence must be true on glass:** Free blurs secrets on the **inner**; Pro puts believable decoys on the **outer**.

### 12.8.3 Paywall tone

Calm privacy product: one hero (folded Duo frost→decoy pair), three bullets, RCUI default. **No** hacking/matrix aesthetics. System Liquid Glass sheet OK; remove custom VE backgrounds (`docs/ios-craft-addendum.md`).

### 12.8.4 RC acceptance (always + cutover)

| TC | Assertion |
|----|-----------|
| **TC-R01** | `Purchases.configure` with human `test_` key (DEBUG) |
| **TC-R02** | Paywall presents |
| **TC-R03** | Test Store Successful Purchase |
| **TC-R04** | Unlock visible on **other** display |
| **TC-R05** | Cancel / Fail keeps gate locked |

Human prep: `docs-runtime/RC-IDs.md` — never invent IDs; never ship `test_` in Release.

---

## 12.9 SCR-FD-E — Closed-cover vault (nice / cut first)

| Field | Spec |
|-------|------|
| **ID** | SCR-FD-E |
| **Path** | Optional outer-only host in `OuterDecoyStageView` closed branch |
| **Job** | Closed pose → outer decoy-only showcase for Pro vault |
| **Demo** | Only if M8 early — **TC-F05 not required for win** |
| **Cut rule** | Cut before touching M4–M5 minutes |

---

## 12.10 Pose behavior (ArrangementView — not hinge layout)

**Climax API family:** `ArrangementView` + reserved regions (`Duo/PoseRouter.swift`, `Duo/ArrangementRegions.swift`).  
**Forbidden:** layout from `onHingeChange` degrees — hinge = effects only (**TC-S03**).

| Pose | Inner | Outer | Priority |
|------|-------|-------|----------|
| **Open / flat** | Sensitive + frost | Idle / decoy on lock | Baseline |
| **Tabletop (primary)** | Content **above** crease; controls **below** | Decoy when locked | **Ship for 90s** |
| **Book (backup)** | Leading = content; trailing = controls | Decoy when locked/closed | Dual-surface clarity |
| **Closed** | N/A | Decoy wallpaper only | Nice / SCR-FD-E |
| **Tent** | Soft | Soft | Skip unless free |

### Pose demo beat (≤30s, no narration required)

1. Open flat → clear inner + calm outer (**0:00–0:15**).  
2. Fold to tabletop → content rises, controls drop.  
3. Simulate Threat → top frosts, outer decoys (**0:25–0:45**, F1+F2).

Pose change = Yuma/Kyle soft STEM; frost = Jane gasp.

---

## 12.11 Cutover 90s script appendix (seconds → SCR)

Spoken Brad/Matt from COPY; this table is the **glass choreography**.

| Time | Pane | SCR | Beat |
|------|------|-----|------|
| **0:00–0:10** | Inner | SCR-FD-A | Clear mail/notes; say Frost Brad |
| **0:10–0:15** | Both | A+C idle | Calm outer wallpaper; brand whisper FrostDuo |
| **0:15–0:25** | Inner | SCR-FD-B | Tabletop reflow; Protect on; point to Simulate |
| **0:25–0:35** | Both | A+B+C | **Simulate Threat** → F1 frost + F2 decoy **A** (or B) |
| **0:35–0:45** | Outer | SCR-FD-C | Hold decoy — room reads mismatch |
| **0:45–0:50** | Inner | SCR-FD-B | Tap Unlock Cover Vault |
| **0:50–1:05** | Inner | SCR-FD-D | RCUI → Successful Purchase |
| **1:05–1:20** | Outer | SCR-FD-C | F3 → pack **C**; say Matt line |
| **1:20–1:30** | — | — | Jane line: on-device / faces never leave; stop |

**Backup 60s:** Skip tabletop polish; Simulate immediately; still hit F1+F2+RC+F3.

**Simulate fallback lines (COPY):** “Simulator can’t do TrueDepth — we Simulate Threat so the craft still shows.”

---

## 12.12 Milestone map when cutover is live (M0–M8 remapped)

Aligns with theme contract §3 — **M4b** path.

| # | Milestone | Minutes | Done when (Frost) | Paths / demo |
|---|-----------|--------:|-------------------|--------------|
| M0 | Toolchain + §00 | 10 | Duo sim boot | Human |
| M1 | Scaffold | 15 | Tree stubs | App/** |
| M2 | Duo shell | 25 | Pose remaps; CutoverFlag readable | PoseRouter · CutoverFlag |
| **M3** | GATE-CCA | 5 | **RED** → flag frost | CUTOVER.flag |
| **M4b** | Frost vertical slice | **55** | SCR-FD-A→C live | Features/Frost/** · demo **0:00–0:45** |
| M5 | RC Test Store | 35 | Paywall + purchase | Monetization/** · **0:50–1:20** |
| M6 | Pro vault | 15 | `isPro` → decoy C | F3 · **1:05–1:20** |
| M7 | Copy/assets | 10 | Decoy stills + strings | Resources/Frost/** |
| M8 | Freeze | 10 | TC suite or waivers | DEMO-LAST-PASS.md |

**Optional after M8 green early only:** SCR-FD-E closed-cover · ARKit live second-face bonus · book pose polish.

---

## 12.13 Acceptance suite — cutover mode

Pass **all Always** (theme contract §6A) **+ all Cutover** rows:

| TC | Assertion | Evidence |
|----|-----------|----------|
| **TC-F01** | Threat → inner frost | SCR-FD-A · F1 |
| **TC-F02** | Outer decoy at locked | SCR-FD-C · pack A |
| **TC-F03** | Simulate Threat works in sim | SCR-FD-B |
| **TC-F04** | Pro vault/decoy C gated by `pro` | SCR-FD-C after TC-R03 · F3 |
| **TC-F05** | Closed-cover optional — **not** required | SCR-FD-E |
| **TC-P02** | Frost Brad ready | DEMO-SCRIPT cutover appendix |
| **Win visual** | Ice-soft frost; quiet Covered/Private; no cyber HUD | Tokens §13 |
| **Win motion** | F1+F2 on Simulate; F3 on unlock | Motion.swift §14 |

### Explicit non-goals (do not block done)

Real second-face without Simulate · ASC/sandbox restore · multiple decoy engines · PowerThrottler · PrivacyScreen fork · Perfect Liquid Glass on decoys · SCR-FD-E.

---

## 12.14 Gate artifact — `GATE-FROST.md` (LANE-FROST writes)

```text
# GATE-FROST
status: PASS | FAIL
cutover_flag: frost
tc_f01: …
tc_f02: …
tc_f03: …
tc_f04: …
notes: …
```

Integrator merges `sat/frost` → `sat/integrate` only after PASS or written waivers in `DEMO-LAST-PASS.md`.

---

## 12.15 Cut list & kill list (Frost chapter)

| Banned | Why |
|--------|-----|
| Parallel Outer Lens Film Tool redesign for Frost | Not a second product |
| PrivacyScreen / SnapShield SPM | Remix only |
| Traffic-light threat banners / “INTRUDER” | Jane anti-creep |
| Paywall on outer | Inner only SCR-FD-D |
| Hinge-driven layout | Effects only |
| CCA + frost live in one demo path | One climax glass ≤30s |
| PoseAgent / HingeBeat / interview / agents nouns | Theme contract §2 |
| Purple cyber HUD / matrix / dense pixel glitch | Design lock |
| Liquid Glass carnival on frost/decoy | Content blur + wallpaper only |

---

## 12.16 Remix clarity checklist (pitch + UI)

- [ ] Product sentence leads with **Duo outer decoy**, not ARKit blur.  
- [ ] At least one pose changes visibility without narration.  
- [ ] RC unlocks **outer** surface, not chrome.  
- [ ] Fallback demo works with **zero** faces (Simulate).  
- [ ] No PrivacyScreen / SnapShield dependency in Saturday binary.  
- [ ] Never say “we rebuilt PrivacyScreen.”  
- [ ] Noun on chrome: **FrostDuo** (quiet corner) — product class = outer decoy vault.  
- [ ] `CUTOVER.flag` is the only switch — not a second app target.

---

## 12.17 UNKNOWN / BLOCKED register

| Item | Status | Owner |
|------|--------|-------|
| Exact Duo multi-scene / outer display API signatures | Concept-level until Xcode 27.1 confirm | SHELL Sat AM |
| Whether Duo sim exposes any front-camera / Vision path | Assume **Simulate 100% mandatory** | FROST |
| `CUTOVER.flag` exact string token (`frost` vs `true`) | Freeze Sat AM in Integrator note | Orchestrator |
| Noun chrome: FrostDuo vs Frost Cover Vault string | Prefer **FrostDuo** on chrome; Cover Vault in Matt line | COPY |

---

## 12.18 Citation index

| Source | Use in §12 |
|--------|------------|
| `internal/research-frostduo.md` | Sensing, ladder, RC gate, Jane copy, risks |
| `internal/design-research-frostduo-ui.md` | Visual frost, decoys A/B/C, pose layouts, anti-malware |
| `docs/design-direction.md` §2B / §3B / §4 | Tokens, SCR map, F1–F3 |
| `docs/bible-single-theme-contract.md` | Flag, lanes, tree, TCs, non-product rule |
| `docs/outer-lens-3h-build-plan.md` §3 | 12:15 gate RED actions |
| PrivacyScreen / SnapShield GitHub | Pattern remix only — cite, never fork |

---

*End of §12. Agents implementing cutover: read §00 invariants → this chapter → §13 frost tokens → §14 F1–F3 → lane card LANE-FROST.*
