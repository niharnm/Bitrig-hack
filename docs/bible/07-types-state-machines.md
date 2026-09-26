# §07 — Data model & state machines

**Bible ID:** §07  
**Canonical file Saturday:** `DuoApp/Shared/Types.swift` (INTEGRATOR owns)  
**Obeys:** contract §4–§6 · blueprint §07 · Outer Lens / Frost / RC research packs · design-direction tip styles  
**Constraint:** Signatures + machines only. Agents implement; do not invent parallel type names.  
**Required machines (this chapter):** `AppState` · `EntitlementState` · `TipKind` · `CutoverFlag` · `CaptureSessionPhase`  
**Supporting types (locked names):** `PoseMode` · `ThreatLevel` · `DecoyPack` · `DemoPhase`

---

## 07.0 Cross-lane contract rules

1. **One source of truth.** All lanes import `Shared/Types.swift`. Lane-local copies of enums are allowed only as temporary stubs that **must** rename to §07 names before Integrator merge (`TC-I02`).  
2. **Observe vs write.** Only the owning lane mutates a machine’s authoritative store (see §07.1). Downstream lanes observe published values.  
3. **No stringly states.** Tips, threats, phases, and cutover are enums / structs — not free-form strings in view code.  
4. **Demo continuity.** Every terminal / failure state must name a recovery that keeps the 90s script alive (Simulate controls, Settings, tip-only outer).  
5. **Map to path or demo second.** Each transition below cites a file or timestamp.

---

## 07.1 Ownership of stores

| Type / machine | Authoritative writer | Observers | Persistence |
|----------------|---------------------|-----------|-------------|
| `CutoverFlag` | Orchestrator via `docs-runtime/CUTOVER.flag`; SHELL exposes reader | all | File on disk (runtime) |
| `AppState` | SHELL / root coordinator | all | In-memory |
| `CaptureSessionPhase` | LANE-CCA (`CaptureSessionController`) | CoachOverlay, Root slots | In-memory |
| `TipKind` (+ active tip id) | LANE-CCA tip model | SubjectCoachView | In-memory |
| `EntitlementState` | LANE-RC (`Entitlements.swift`) | CCA, FROST, PaywallHost | RC `CustomerInfo` |
| `ThreatLevel` | LANE-FROST | Frost views, outer decoy | In-memory (+ Simulate) |
| `PoseMode` | LANE-SHELL (`PoseRouter`) | RootArrangementView | In-memory from Duo pose |
| `DemoPhase` | LANE-DEMO / human clock | optional UI badges | Script only |

---

## 07.2 Signature freeze (Swift shapes)

Bible signatures — Saturday agents fill bodies. Mark unknown SDK symbols `UNKNOWN` / `BLOCKED`, never invent.

```swift
// Shared/Types.swift — INTEGRATOR

enum CutoverFlag: String, Codable, Sendable {
    case outerLens   // default / flag absent / false
    case frost       // CUTOVER.flag contents "frost" / true
}

enum AppState: Equatable, Sendable {
    case launching
    case shellReady
    case outerLens(OuterLensPhase)
    case frostDuo(FrostDuoPhase)
    case blocked(BlockReason)
    case frozenForDemo
}

enum OuterLensPhase: Equatable, Sendable {
    case permission(PermissionSubstate)
    case capture(CaptureSessionPhase)
    case paywall
    case recovery(RecoveryKind)
}

enum FrostDuoPhase: Equatable, Sendable {
    case clear
    case frostActive(ThreatLevel)
    case paywall
    case vaultUnlock
}

enum PermissionSubstate: Equatable, Sendable {
    case notDetermined
    case requesting
    case authorized
    case denied
    case restricted
}

enum CaptureSessionPhase: Equatable, Sendable {
    case idle
    case permissionRequired
    case starting
    case live
    case accessoryUnavailable
    case accessoryReady(enabled: Bool)
    case interrupted
    case failed(CaptureFailure)
    case shutterFlash
}

enum CaptureFailure: Equatable, Sendable {
    case configuration
    case runtime
    case unknown
}

enum TipKind: Equatable, Sendable {
    case line          // T1 free
    case guide         // T2 Pro
    case countdown     // T3
}

struct CoachTip: Equatable, Identifiable, Sendable {
    var id: String
    var kind: TipKind
    var text: String          // ≤8 words for T1/T2
    var symbolName: String?   // SF Symbol optional
    var requiresPro: Bool
}

struct EntitlementState: Equatable, Sendable {
    var status: EntitlementStatus
    var entitlementID: String   // always "pro"
    var isPro: Bool { status == .active }
    var lastError: String?
}

enum EntitlementStatus: Equatable, Sendable {
    case unknown
    case loading
    case inactive
    case active
    case error
}

enum PoseMode: Equatable, Sendable {
    case flat
    case open
    case tabletop
    case book
    case closed
    case unknown
}

enum ThreatLevel: Int, Comparable, Equatable, Sendable {
    case clear = 0
    case cautious = 1
    case threatened = 2
    case locked = 3
}

enum DecoyPack: String, Equatable, Sendable {
    case aLockLookalike   // free
    case bBusyCover       // free teaser
    case cVaultCover      // Pro
}

enum DemoPhase: Equatable, Sendable {
    case coldOpen          // 0:00–0:10
    case climax            // 0:10–0:45
    case monetize          // 0:50–1:05
    case unlockProof       // 1:05–1:20
    case close             // 1:20–1:30
}

enum BlockReason: Equatable, Sendable {
    case toolchain
    case missingRCIDs
    case cutoverPending
    case scopeNack(String)
}

enum RecoveryKind: Equatable, Sendable {
    case openSettings
    case simulateTip
    case simulatePro
    case simulateCountdown
    case tipOnlyOuter
}
```

**Entitlement id lock:** string literal **`pro`** (lowercase). Typo `Pro` = permanent lock (RC research).

---

## 07.3 CutoverFlag — machine

### 07.3A Purpose

Selects which product vertical is live. Single source: `docs-runtime/CUTOVER.flag`. Orchestrator writes; `Shared/CutoverFlag.swift` reads.

### 07.3B States

| State | Disk / value | Live SCR set | Live lanes |
|-------|--------------|--------------|------------|
| `outerLens` | absent, empty, `false`, `outer`, `outerLens` | SCR-OL-* | SHELL, CCA, RC, COPY, ASSETS, DEMO, INTEGRATOR |
| `frost` | `true`, `frost`, `frostDuo` | SCR-FD-* | SHELL, FROST, RC, COPY, ASSETS, DEMO, INTEGRATOR |

### 07.3C Transitions

```text
                  [Orchestrator 12:15]
                         │
         ┌───────────────┴───────────────┐
         ▼                               ▼
   GATE-CCA GREEN                  GATE-CCA RED
   CutoverFlag.outerLens           write CUTOVER.flag = frost
   keep CCA primary                CutoverFlag.frost
   FROST standby files only        stop CCA feature work
                                   promote FROST primary
```

| From | Event | To | Owner | Artifact |
|------|-------|----|-------|----------|
| `outerLens` | Gate green | `outerLens` (stay) | O | `GATE-CCA.md=GREEN` |
| `outerLens` | Gate red ≤12:15 | `frost` | O | `CUTOVER.flag` + `GATE-CCA.md=RED` |
| `frost` | Accidental flip back | **forbidden** after 12:15 | — | Do not half-build both |
| any | Agent writes flag | **nack** | Scope guard | routing §4 |

### 07.3D Effects on AppState

| CutoverFlag | `AppState` branch allowed |
|-------------|---------------------------|
| `outerLens` | `.outerLens(*)`, not `.frostDuo` on demo path |
| `frost` | `.frostDuo(*)`, CCA phases may remain as dead stubs |

### 07.3E Demo seconds

- Flag decision itself is **not** a demo beat — it is a **build-clock** event at **12:15**.  
- After frost: use cutover DEMO-SCRIPT appendix **0:00–1:30**.

### 07.3F Invariants

- Exactly one climax API per demo path: CCA **or** frost dual-face — never both.  
- RC `EntitlementState` and entitlement id `pro` survive cutover unchanged.  
- RootArrangementView swaps slots; does not merge Capture into Frost files.

---

## 07.4 AppState — machine

### 07.4A Purpose

Top-level product coordinator state for shell + mode. Views bind to nested phases; `AppState` answers “what is the app doing?” for gates and demo.

### 07.4B State diagram

```text
                    ┌────────────┐
                    │ launching  │
                    └─────┬──────┘
                          │ SHELL TC-S01 boot
                          ▼
                    ┌────────────┐
              ┌─────│ shellReady │─────┐
              │     └────────────┘     │
              │ CUTOVER outerLens      │ CUTOVER frost
              ▼                        ▼
     ┌─────────────────┐      ┌─────────────────┐
     │ outerLens(...)  │      │ frostDuo(...)   │
     └────────┬────────┘      └────────┬────────┘
              │                        │
              │  Integrator freeze     │
              └───────────┬────────────┘
                          ▼
                  ┌───────────────┐
                  │ frozenForDemo │
                  └───────────────┘

Any phase ──BLOCKED──► blocked(reason) ──human unblock──► prior / shellReady
```

### 07.4C Nested OuterLensPhase

| Substate | Maps SCR | Entry | Exit |
|----------|----------|-------|------|
| `permission(.notDetermined/.requesting)` | SCR-OL-A | Cold open | authorized → capture; denied → recovery |
| `capture(CaptureSessionPhase)` | SCR-OL-B/C | Session path | paywall sheet overlays; does not destroy capture |
| `paywall` (**inner overlay only**) | SCR-OL-D | Pro CTA | dismiss → capture; success → capture + TipKind.guide — **never** mounts on outer/accessory region |
| `recovery(*)` | SCR-OL-E / Simulate | Failures | back to capture or permission |

### 07.4D Nested FrostDuoPhase

| Substate | Maps SCR | Entry | Exit |
|----------|----------|-------|------|
| `clear` | SCR-FD-A | Cutover live | Simulate / threat → frostActive |
| `frostActive(level)` | SCR-FD-A/B/C | Threat ladder | paywall / clear |
| `paywall` | SCR-FD-D | Pro vault CTA | success → vaultUnlock |
| `vaultUnlock` | SCR-FD-C pack C | `isPro` | stays for demo close |

### 07.4E Transitions (authoritative table)

| ID | From | Event | To | Path / demo |
|----|------|-------|----|-------------|
| A1 | `launching` | App `@main` finished shell chrome | `shellReady` | `DuoAppApp.swift` · TC-S01 |
| A2 | `shellReady` | Flag outerLens + user opens capture | `outerLens(.permission…)` | SCR-OL-A · 0:00 |
| A3 | `shellReady` | Flag frost | `frostDuo(.clear)` | SCR-FD-A · cutover 0:00 |
| A4 | `outerLens(.permission)` | Camera authorized | `outerLens(.capture(.starting→.live))` | SCR-OL-B · 0:10 |
| A5 | `outerLens(.capture)` | Pro CTA | `outerLens(.paywall)` **inner sheet** overlay | SCR-OL-D · 0:50 |
| A6 | `outerLens(.paywall)` (inner) | Purchase success + `isPro` | `outerLens(.capture)` + tip→guide on **outer** | 1:05–1:20 |
| A7 | `outerLens(*)` | Denied / accessory fail | `outerLens(.recovery)` | SCR-OL-E |
| A8 | `frostDuo(.clear)` | Simulate Threat | `frostDuo(.frostActive(.locked))` | 0:15–0:35 |
| A9 | `frostDuo(.frostActive)` | Pro CTA | `frostDuo(.paywall)` | 0:50 |
| A10 | `frostDuo(.paywall)` | Purchase success | `frostDuo(.vaultUnlock)` | 1:05–1:20 |
| A11 | any live | Integrator freeze | `frozenForDemo` | ≤3:00 |
| A12 | any | Missing RC IDs / toolchain | `blocked` | GATE artifacts |

### 07.4F Illegal transitions (nack)

- `outerLens` ↔ `frostDuo` mid-demo without Orchestrator rebuild decision.  
- `paywall` on outer region / accessory surface. (**DECISION / Claude P0:** `OuterLensPhase.paywall` means inner SCR-OL-D sheet during Outer Lens mode — naming ≠ outer placement.)  
- `frozenForDemo` → new feature screens.  
- Entering `outerLens` while `CutoverFlag.frost`.

---

## 07.5 CaptureSessionPhase — machine

### 07.5A Purpose

Authoritative camera pipeline for Outer Lens. Owned by `Features/Capture/CaptureSessionController.swift`. CoachOverlay **renders** from this + tip model; it does not start the session.

### 07.5B States (detail)

| Phase | Meaning | Inner UX | Outer / CCA | Demo |
|-------|---------|----------|-------------|------|
| `idle` | No session | Landing / primer entry | none | pre-0:00 |
| `permissionRequired` | Need auth before start | SCR-OL-A | none | 0:00–0:10 |
| `starting` | Configuring session | Black / spinner; **no fake coaching claim** | not eligible | brief |
| `live` | `AVCaptureSession` running | Preview + shutter | CCA eligible | 0:10–0:40 |
| `accessoryUnavailable` | System will not present | Subject toggle hidden; **inner still shoots** | tip-only / Simulate tip | TC-C03 |
| `accessoryReady(enabled:)` | Available; user/app enabled binding | Subject toggle reflects state | tip stage when presented | 0:15–0:45 |
| `interrupted` | System interrupt | Resume affordance | withdraw accessory | recovery |
| `failed` | Config/runtime error | Error + retry; no coaching claim | none | TC survivable |
| `shutterFlash` | Momentary after shutter | Flash/check | optional mirror flash | shutter beat |

### 07.5C Diagram

```text
 idle ──open capture──► permissionRequired ──authorized──► starting ──ok──► live
         │                     │ denied/restricted              │ fail
         │                     ▼                                ▼
         │              (AppState recovery                      failed
         │               Open Settings)                           │
         │                                                      retry──► starting
         │
 live ──availability false──► accessoryUnavailable ──still live shutter──► (stay)
 live ──availability true───► accessoryReady(enabled)
 accessoryReady ──toggle───► accessoryReady(enabled: !)
 live ──interrupt──► interrupted ──resume──► live|starting
 live ──shutter──► shutterFlash ──► live
 any non-terminal ──cutover RED──► (park machine; do not drive UI)
```

### 07.5D Transition table

| ID | From | Event | Guard | To | Owner path |
|----|------|-------|-------|----|------------|
| C0 | `idle` | User enters capture | Flag=outerLens | `permissionRequired` | InnerCapture / Primer |
| C1 | `permissionRequired` | System `.authorized` | — | `starting` | CaptureSessionController |
| C2 | `permissionRequired` | `.denied`/`.restricted` | — | stay + AppState.recovery | CaptureDeniedView |
| C3 | `starting` | Session running | — | `live` | controller |
| C4 | `starting` | Config error | — | `failed(.configuration)` | controller |
| C5 | `live` | `onAvailabilityChange(false)` | — | `accessoryUnavailable` | CCA host |
| C6 | `live`/`accessoryUnavailable` | `onAvailabilityChange(true)` | — | `accessoryReady(enabled: current)` | CCA host |
| C7 | `accessoryReady` | User Subject toggle | available | flip `enabled` | InnerCaptureView |
| C8 | `live`* | Shutter | session live | `shutterFlash` → `live` | InnerCaptureView |
| C9 | `live`* | Interrupt | — | `interrupted` | controller |
| C10 | `interrupted` | Resume OK | — | `live` or `starting` | controller |
| C11 | `failed` | Retry | — | `starting` | denied/error UI |
| C12 | any | Cutover frost | Orchestrator | park (ignore) | CutoverFlag |

\* including `accessoryUnavailable` / `accessoryReady` as live-session siblings.

### 07.5E Coupling to TipKind

| CaptureSessionPhase | Allowed TipKind on outer |
|---------------------|--------------------------|
| `live` + accessory presented | `line`, `guide` (if Pro), `countdown` |
| `accessoryUnavailable` | Tip-only stage **or** Simulate tip (`RecoveryKind.simulateTip`) — still TipKind.line |
| `starting` / `failed` | **No** tip that claims live coaching |
| parked (cutover) | N/A |

### 07.5F Invariants

1. Essential controls remain on **inner** if accessory withdrawn (Apple CCA contract).  
2. Never start session before permission check.  
3. Photo-only for win slice — no mic-required path.  
4. `accessory.unavailable` must not brick shutter (**TC-C03**).  
5. Persist tip/Pro in model, not only in accessory view (Outer Lens research checklist).

### 07.5G Mapping from research aliases

Research pack names → canonical:

| Research alias | Canonical |
|----------------|-----------|
| `perm.notDetermined` | AppState permission + phase `permissionRequired` |
| `perm.denied` | PermissionSubstate.denied + recovery |
| `session.starting` | `starting` |
| `session.live` | `live` |
| `accessory.unavailable` | `accessoryUnavailable` |
| `accessory.enabled/disabled` | `accessoryReady(enabled:)` |

---

## 07.6 TipKind — machine

### 07.6A Purpose

Which tip style Outer Lens renders on SCR-OL-C. Visual tokens: design-direction T1/T2/T3.

### 07.6B Kinds

| TipKind | Style ID | Tier | Visual | Gate |
|---------|----------|------|--------|------|
| `.line` | **T1** | Free | One sentence + optional SF Symbol; solid tip plate; ≥28pt SF Rounded | Always when outer coaching |
| `.guide` | **T2** | Pro | T1 + amber guide oval (`GuideOvalView`) | `EntitlementState.isPro == true` |
| `.countdown` | **T3** | Any | Huge numeral; tip dims during count | Script once; Simulate countdown OK |

### 07.6C Diagram

```text
                    ┌──────────────┐
                    │  .line (T1)  │◄── default free tip
                    └──────┬───────┘
           ┌───────────────┼────────────────┐
           │ Pro unlock    │ countdown beat │ vision miss / flake
           ▼               ▼                │
    ┌──────────────┐ ┌─────────────┐        │
    │ .guide (T2)  │ │.countdown   │        │
    │  + oval M3   │ │   (T3) M2   │        │
    └──────┬───────┘ └──────┬──────┘        │
           │ end count /    │               │
           │ stay guide     └───────► .line │
           │                                │
           └──── Cancel/Fail purchase ──────┘ (remain .line)
```

### 07.6D Transitions

| ID | From | Event | Guard | To | Demo / path |
|----|------|-------|-------|----|-------------|
| T1 | — | Outer coach appears | capture live or tip-only recovery | `.line` | **0:15–0:45** · M1 |
| T2 | `.line` | `EntitlementState` → active | `isPro` | `.guide` | **1:05–1:20** · M3 |
| T3 | `.guide` | Entitlement inactive / restore fail | — | `.line` | Cancel path TC-R05 |
| T4 | `.line`/`.guide` | Countdown start | script / Simulate | `.countdown` | optional M2 |
| T5 | `.countdown` | Reaches 0 / cancel | — | prior kind | — |
| T6 | any | Vision miss (optional AI) | — | `.line` static | never blank |
| T7 | `.line` | User taps Pro while locked | `!isPro` | stay `.line`; open paywall | 0:50 — tip kind unchanged until purchase |

### 07.6E Illegal

- Rendering `.guide` when `!isPro`.  
- Tip lists / icon grids / floating face badges on outer.  
- Liquid Glass over tip text.  
- TipKind changes owned by RC lane (RC only flips entitlement; CCA maps to TipKind).

### 07.6F Free tip inventory (COPY owns strings)

Ship ≤3 free strings + countdown. Examples (freeze in Localizable / DEMO-SCRIPT):

1. “Chin up · eyes to the lens”  
2. “Fill the frame — step closer”  
3. “Shoulders square · soft smile”  

Pro differentiation = **guide oval / pose overlay**, not a novel climax API.

---

## 07.7 EntitlementState — machine

### 07.7A Purpose

RevenueCat Test Store truth for free vs Pro. Writer: `Monetization/Entitlements.swift`. Unlock must be visible on the **other** display (outer tip→guide or frost vault C).

### 07.7B Fields

| Field | Rule |
|-------|------|
| `entitlementID` | `"pro"` only |
| `status` | see below |
| `isPro` | `status == .active` |
| `lastError` | optional; never invent dashboard IDs into this |

### 07.7C Status diagram

```text
 unknown ──configure/fetch──► loading ──entitlements["pro"].isActive──► active
                                │
                                ├── not active ──► inactive
                                └── fetch fail ──► error ──retry──► loading

 inactive ──Successful Purchase──► loading/active
 active   ──Cancel does nothing──► active
 inactive ──Cancel/Fail──────────► inactive (gate holds)
```

### 07.7D Transitions

| ID | From | Event | To | Path / demo |
|----|------|-------|----|-------------|
| E0 | `unknown` | `Purchases.configure(test_)` DEBUG | `loading` | PurchasesConfig · TC-R01 |
| E1 | `loading` | `pro` active | `active` | Entitlements observer |
| E2 | `loading` | `pro` inactive | `inactive` | free path |
| E3 | `loading` | SDK/network error | `error` | show retry; don’t invent |
| E4 | `inactive` | Present paywall | stay inactive | SCR-OL-D / FD-D · 0:50 |
| E5 | `inactive` | Test Store **Successful Purchase** | `active` | TC-R03 · ≤10s in beat |
| E6 | `inactive` | Cancel / Fail | `inactive` | TC-R05 · gate holds |
| E7 | `active` | App relaunch same sim session | `active` (if CustomerInfo says so) | optional |
| E8 | any | Missing `RC-IDs.md` | stay / AppState.blocked | Human paste |

### 07.7E Downstream effects

| `isPro` | Outer Lens | FrostDuo |
|---------|------------|----------|
| `false` | TipKind `.line` only; Pro CTA visible inner | Decoy A/B; vault C locked |
| `true` | TipKind `.guide` + GuideOvalView (M3) | DecoyPack `.cVaultCover` (F3) |

**Other-pane proof (load-bearing):** after E5, change must appear on the **non-paywall** display within ~5s (3h plan Block E timing).

### 07.7F Invariants

1. Configure `test_` **only** under `#if DEBUG`.  
2. Do not invent API keys / offering IDs — read `docs-runtime/RC-IDs.md`.  
3. Prefer `requiredEntitlementIdentifier: "pro"` over inverted custom-logic samples (RC research footgun).  
4. Gate differentiated Duo surface (overlays / vault), not chrome alone.  
5. CCA and FROST **observe**; they never call `Purchases.configure`.

---

## 07.8 Supporting machines (brief but normative)

### 07.8A PoseMode (SHELL)

| Mode | Layout via ArrangementView | Hinge use |
|------|----------------------------|-----------|
| flat / open / tabletop / book / closed / unknown | Regions remap | Effects / input **only** — never layout math from degrees |

**FROZEN:** Keep **both** `.flat` and `.open` (do not collapse). Win-path Outer Lens climax layout is identical for both; PoseRouter may distinguish polish only. See §08.4 Codex P0 freeze.

Transitions: system pose updates → `PoseRouter` → `PoseMode`. Features read; do not write. **TC-S02/S03.**

### 07.8B ThreatLevel (FROST)

```text
 clear ──presence/motion──► cautious ──► threatened ──► locked
 any ──Simulate Threat──► locked (~3s) ──timeout──► clear|prior
 locked + isPro ──vault──► DecoyPack.c (outer)
 locked + !isPro ──► DecoyPack.a (and optional b teaser)
```

Motions: F1 frost settle · F2 decoy snap · F3 vault crossfade. Quiet copy: “Covered” / “Private” — no cyber HUD.

### 07.8C DemoPhase (script clock)

Aligns spoken Brad/Matt to machines without owning UI:

| DemoPhase | Sec | Expected machines |
|-----------|-----|-------------------|
| coldOpen | 0:00–0:10 | AppState permission or frost clear; Brad |
| climax | 0:10–0:45 | Capture live+tip **or** frost+decoy |
| monetize | 0:50–1:05 | Entitlement inactive → paywall |
| unlockProof | 1:05–1:20 | Entitlement active → TipKind.guide / decoy C |
| close | 1:20–1:30 | Matt + ask |

---

## 07.9 Cross-machine sequence — Outer Lens happy path

```text
0:00  CutoverFlag.outerLens
      AppState.launching → shellReady → outerLens(.permission)
0:08  Permission authorized
      CaptureSessionPhase.starting → live
0:15  accessoryReady(true) · TipKind.line (M1)     ← climax glass
0:35  optional TipKind.countdown (M2) → line
0:50  AppState paywall overlay · EntitlementState.inactive
1:00  Successful Purchase · EntitlementState.active
1:05  TipKind.guide + oval (M3) on OUTER            ← other-pane proof
1:20  Matt line · freeze soon
```

### Frost cutover happy path

```text
0:00  CutoverFlag.frost · AppState.frostDuo(.clear)
0:20  Simulate Threat · ThreatLevel.locked · F1+F2 · decoy A
0:50  paywall · EntitlementState.inactive
1:05  isPro · DecoyPack.c · F3 on OUTER
```

---

## 07.10 Test hooks (for §15)

| Machine | Minimum TCs |
|---------|-------------|
| CutoverFlag | TC-S04 readable; cutover path uses SCR-FD |
| AppState | Implicit in TC-S01 + mode TCs |
| CaptureSessionPhase | TC-C02, TC-C03, TC-C05 |
| TipKind | TC-C01 (line), TC-C04 (guide) |
| EntitlementState | TC-R01…R05 |
| ThreatLevel | TC-F01…F04 |

---

## 07.11 Integrator merge rules for types

1. Reject PRs that introduce `CaptureSessionState`, `CoachTipKind`, `ProState`, `isPremium`, etc. — rename to §07.  
2. `ThreatLevel` may live temporarily under `Features/Frost/ThreatLevel.swift` but must match cases.  
3. After B3 merge, `EntitlementState` exists before CCA Pro overlays land.  
4. Changelog type renames in bible §20 when human edits names (none expected Saturday).

---

## 07.12 Pointers

| Need | Doc |
|------|-----|
| File owners for each store | `docs/bible/06-repo-file-tree.md` |
| Acceptance steps | `docs/bible/15-acceptance-tests.md` |
| CCA / tip research | `internal/research-outer-lens.md` |
| Frost threat ladder | `internal/research-frostduo.md` |
| RC CustomerInfo gate | `internal/research-revenuecat.md` |
| Visual T1–T3 | `docs/design-direction.md` |

---



## 07.13 Reducer sketches (normative behavior, not shipped code)

Agents may implement with Observable / `@Observable` / Combine — behavior must match.

### CutoverFlag reader

```text
readDisk(CUTOVER.flag):
  missing|empty|"false"|"outer"|"outerLens" → .outerLens
  "true"|"frost"|"frostDuo" → .frost
  other → BLOCKED log + default .outerLens until Orchestrator fixes
```

### EntitlementState from CustomerInfo

```text
on CustomerInfo:
  if entitlements[entitlementID].isActive → status=.active
  else → status=.inactive
on configure start → status=.loading (from unknown)
on SDK error → status=.error (keep last known isPro if previously active — prefer inactive on first launch error)
```

### TipKind from entitlement + script

```text
base = .line
if DemoPhase wants countdown && not finished → .countdown
else if isPro → .guide
else → .line
visionMiss → force .line text fallback (never empty string)
```

### CaptureSessionPhase on availability

```text
if phase in liveFamily && available == false → .accessoryUnavailable
if phase in liveFamily && available == true → .accessoryReady(enabled: storedBinding)
```

---

## 07.14 Invalid state catalog (must be unreachable)

| Invalid combo | Why | Guard |
|---------------|-----|-------|
| `TipKind.guide` && `!isPro` | Free Pro cheat | CCA observe only |
| `AppState.outerLens` && `CutoverFlag.frost` | Split brain | Root switch on flag first |
| `CaptureSessionPhase.live` claiming tip while `starting` | Lying UI | Tip gate on phase |
| Paywall presented in outer slot | Design lock | Slot table |
| `ThreatLevel.clear` showing decoy C | Vault leak | DecoyPack gate on isPro+locked |
| `EntitlementState.active` with id `"Pro"` | Case typo | entitlementID == "pro" |
| Dual climax: CCA tip + frost decoy same demo path | One climax | Mode mutex |

---

## 07.15 Observable placement

| Store | Suggested host | Injection |
|-------|----------------|-----------|
| `AppState` | `DuoAppApp` / root model | Environment |
| `CaptureSessionPhase` | `CaptureSessionController` | Environment to Capture+Coach |
| `EntitlementState` | `Entitlements` | Environment app-wide |
| `TipKind` + `CoachTip` | Coach tip model owned by CCA | Environment to SubjectCoach |
| `ThreatLevel` | Frost model | Environment to Frost views |
| `CutoverFlag` | SHELL reader singleton | Read at root switch |

Do not message-pass camera frames as a protocol between panes (Apple CCA guidance / Outer Lens research).

---

## 07.16 String & asset IDs bound to types

| Type field | Resource | Owner |
|------------|----------|-------|
| `CoachTip.text` | `Localizable.strings` keys `tip.free.1`… | COPY |
| `CoachTip.symbolName` | SF Symbol names only unless catalog glyph | ASSETS |
| `DecoyPack.a/b/c` | `Assets.xcassets/Frost/DecoyA`… | ASSETS |
| Brand marks | `Assets.xcassets/Shared/WordmarkOuterLens` | ASSETS |

---

## 07.17 PermissionSubstate × CaptureSessionPhase matrix

| Permission \ Phase | idle | permissionRequired | starting | live* | failed |
|--------------------|------|--------------------|----------|-------|--------|
| notDetermined | OK | OK | illegal | illegal | OK |
| requesting | — | OK | illegal | illegal | — |
| authorized | OK | →starting | OK | OK | OK |
| denied/restricted | OK | recovery | illegal | illegal | recovery |

\* live family = live / accessoryUnavailable / accessoryReady / shutterFlash / interrupted

---

## 07.18 Entitlement × TipKind × Decoy matrix

| isPro | Outer Lens tip | Frost outer |
|-------|----------------|-------------|
| false | `.line` only | Pack A (B teaser OK) |
| true | `.guide` (+ oval) | Pack C vault |
| loading | keep last / treat as false for gating UI | keep last / false |
| error | treat as false; show retry on paywall entry | same |

Countdown `.countdown` allowed in both free/Pro; does not itself prove Pro.

---

## 07.19 Logging & demo debug flags (non-product)

Allowed DEBUG-only controls (inner Settings sheet), mapping to RecoveryKind:

| Control | Sets | TC |
|---------|------|----|
| Simulate tip | force tip-only outer / TipKind.line visible | TC-C01 recovery |
| Simulate Pro | local override **forbidden for win evidence** unless Orchestrator marks rehearse-only; prefer real TC-R03 | rehearse only |
| Simulate countdown | TipKind.countdown | DoD #3 |
| Simulate Threat | ThreatLevel.locked | TC-F03 |

**Win evidence** for Pro unlock must be real Test Store Successful Purchase (`TC-R03`), not Simulate Pro, unless clock emergency waiver.

---

## 07.20 Type changelog

| Rev | Date | Change |
|-----|------|--------|
| 0 | 2026-09-26 | Initial freeze: AppState, EntitlementState, TipKind, CutoverFlag, CaptureSessionPhase + supports |
| 1 | 2026-09-26 | Codex P0: PoseMode keep both `.flat` and `.open`; EntitlementState status machine is sole shape for §09 |




## 07.21 Sequence: permission deny recovery

```text
User opens capture
  → AppState.outerLens(.permission(.notDetermined))
  → system alert DENY
  → PermissionSubstate.denied
  → AppState.outerLens(.recovery(.openSettings))
  → SCR-OL-E CaptureDeniedView
  → user returns from Settings AUTHORIZED
  → CaptureSessionPhase.starting → live
```

Maps: TC-C05 · demo fallback (not happy path).

---

## 07.22 Sequence: RC cancel then success

```text
TipKind.line visible (climax already shown)
  → Pro CTA → AppState paywall overlay
  → EntitlementState.inactive
  → user Cancel → TC-R05 still inactive; TipKind.line
  → Pro CTA again → Successful Purchase
  → EntitlementState.active
  → TipKind.guide + GuideOvalView (M3) on outer
```

Maps: TC-R05 then R03/R04/C04 · demo **0:50–1:20**.

---

## 07.23 PoseMode effects whitelist

Allowed hinge/pose *effects* (not layout):

| Effect | OK? | Notes |
|--------|-----|-------|
| Tip plate opacity nudge | OK | effects-only |
| Frost intensity ease | OK | F1 |
| Remap regions via PoseRouter table | OK | layout via Arrangement, not degrees |
| `offset` from hinge degrees | **FORBIDDEN** | TC-S03 |
| Font size from hinge degrees | **FORBIDDEN** | — |

---

## 07.24 Codable / persistence policy

| Type | Persist? | Why |
|------|----------|-----|
| CutoverFlag | Disk file Orchestrator | Build-mode lock |
| EntitlementState | Via RC CustomerInfo only | Source of truth = SDK |
| TipKind | No | Ephemeral demo |
| CaptureSessionPhase | No | Session lifecycle |
| AppState | No | Restart → launching |
| ThreatLevel | No (Simulate ephemeral) | Demo control |


*End §07. Five machines + supports. If a state isn’t here, it isn’t Saturday.*
