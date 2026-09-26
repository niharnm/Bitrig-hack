# §05 — Duo API inventory (Outer Lens Film Tool)

**Product:** Outer Lens · Film Tool (FrostDuo = cutover only)  
**Event:** Bitrig Hacks: iPhone Duo · Sat Sep 26, 2026  
**Role:** Every Duo / related symbol Saturday agents may touch — usage recipes, VERIFIED vs UNKNOWN, imports, pitfalls — mapped to theme-contract paths.  
**Constraint:** Spec / pseudocode only — **no app sources** in this chapter. Agents emit implementations Saturday.  
**Obeys:** [`docs/bible-single-theme-contract.md`](../bible-single-theme-contract.md) §4 tree · [`docs/design-direction.md`](../design-direction.md)  
**Ingest:** [`internal/research-duo-apis.md`](../../internal/research-duo-apis.md) · [`internal/research-duo-hig-poses.md`](../../internal/research-duo-hig-poses.md) · [`internal/design-research-duo-craft.md`](../../internal/design-research-duo-craft.md) · [`internal/research-outer-lens.md`](../../internal/research-outer-lens.md)  
**Toolchain:** Xcode **27.1** / iOS **27.1** SDK (Duo APIs).  
**Lane:** LANE-SHELL owns layout/hinge wiring; LANE-CCA owns CCA + capture; LANE-FROST reads CutoverFlag only.

---

## 0. How to use this chapter

| If you are… | Read | Then implement in |
|-------------|------|-------------------|
| LANE-SHELL | §§1–4, §6, §9 | `DuoApp/Duo/PoseRouter.swift` · `DuoApp/Duo/ArrangementRegions.swift` · `DuoApp/App/RootArrangementView.swift` · `DuoApp/Shared/CutoverFlag.swift` |
| LANE-CCA | §§1.5, §5, §7 | `DuoApp/Duo/CameraCaptureAccessoryHost.swift` · `DuoApp/Features/Capture/**` · `DuoApp/Features/CoachOverlay/**` |
| LANE-FROST | §1 hard rules + §8 | `DuoApp/Features/Frost/**` (behind `docs-runtime/CUTOVER.flag`) |
| LANE-RC | §1.6 scenes note only | Do **not** invent Duo APIs; unlock other pane via `EntitlementState` |
| Integrator / QA | §9–§11 + TC map | `docs-runtime/GATE-SHELL.md` · `GATE-CCA.md` |

**Every recipe paragraph names a file path or a demo second.** If it cannot, delete it (theme contract §7).

### Verification tiers (copy into every agent prompt)

| Tag | Meaning | Saturday action |
|-----|---------|-----------------|
| **VERIFIED** | Symbol/signature confirmed via Apple docs + SDK typecheck snapshot (bunn/iphone-duo-skill · 19 Sep 2026 · Xcode 27.1 build 27A9269) and/or matching secondary sources | Use as written; reconfirm compile on live 27.1 |
| **SIM-OBS** | Observed in Duo simulator / Artem Examples / DuoInspector — not Apple contract | Use for demos; do not assert as App Store guarantee |
| **UNVERIFIED** | Named in blogs/examples; signature not re-checked this wave | Prefer VERIFIED twin; probe SDK before shipping |
| **UNKNOWN** | Conflicting sources or no public contract | Do **not** invent; mark `BLOCKED:` or cut |

---

## 1. Hard rules (non-negotiable)

Map each rule to Saturday code ownership:

| # | Rule | Owner path | Demo / TC |
|---|------|------------|-----------|
| R1 | **Layout ≠ hinge.** Drive panes with size classes, `ArrangementView`, `reservedRegions`. Use `onHingeChange` / `UIHingeInteraction` for **effects only**. | `Duo/PoseRouter.swift` · `Duo/ArrangementRegions.swift` · `App/RootArrangementView.swift` | **TC-S02** · **TC-S03** |
| R2 | **Idiom stays `.phone`.** Wide Duo scenes are still phone — never branch on pad. | All layout code | Integrator review |
| R3 | **Guard `iOS 27.1`.** Duo-specific APIs introduce at 27.1; ship older-OS fallbacks (single-column / no accessory). | Every Duo API call site | Compile check |
| R4 | **Camera accessory ≠ closed-outer chrome.** Outer subject UI during capture = `CameraCaptureAccessory` via `sceneAccessory`. Closed-outer app chrome = system scene migration. | `Duo/CameraCaptureAccessoryHost.swift` vs Frost outer decoy | Demo **0:15–0:45** |
| R5 | **Simulator ≠ camera hardware.** Pose/layout/hinge OK in sim; real capture + accessory presentation need hardware (entitlement **UNKNOWN**). | `docs-runtime/GATE-CCA.md` | Gate **12:15** |
| R6 | **One climax API per demo path.** CCA **or** frost — never both live. | `Shared/CutoverFlag.swift` · `CUTOVER.flag` | Theme contract §2B |
| R7 | **Hierarchy identical closed↔open.** Open shows more of the same structure. | `RootArrangementView.swift` | Vince / Tech Talk 111466 |

**Banned inventions (kill list → Integrator nack):**

- `UIDeviceHingeDidChangeNotification` (fabricated — Dodecaidr)  
- Layout keyed off hinge degrees / π equality  
- Invented camera-companion entitlement string  
- `UIScreen.main.bounds` / device-name branches  
- New windows on the **outer** display (`UIWindowScene.ActivationAction` = **inner only**)  
- Accorduon / HingeBeat / PoseAgent product surfaces (theme contract §2A)

---

## 2. Symbol catalog — Hinge

### 2.1 SwiftUI hinge

| Symbol | Framework | Intro | Tier | What it does |
|--------|-----------|-------|------|--------------|
| `View.onHingeChange(isEnabled:_:)` | SwiftUI | 27.1 | **VERIFIED** | Delivers old+new `DeviceHingeContext` on attach and change; pause with `isEnabled: false` |
| `DeviceHingeContext` | SwiftUI | 27.1 | **VERIFIED** | Context wrapper; `.hinge` optional |
| `DeviceHinge` | SwiftUI | 27.1 | **VERIFIED** | `.angle: Angle`, `.status` |
| `DeviceHinge.Status` | SwiftUI | 27.1 | **VERIFIED** | Struct constants: `.closed`, `.partiallyOpen`, `.fullyOpen` |

**Imports:** `import SwiftUI`

**Saturday owner:** `DuoApp/Duo/PoseRouter.swift` — **effects only** (never pane frames). Optional polish: tip flash / frost settle amp. **Do not** drive `ArrangementView` style from angle.

**VERIFIED signature recipe (pseudocode for Saturday):**

```text
FILE: DuoApp/Duo/PoseRouter.swift
LANE: LANE-SHELL
AVAILABILITY: @available(iOS 27.1, *)

PSEUDO:
  @Observable final class PoseRouter {
    var hingeStatus: HingeStatusKind = .unavailable   // app enum — see Shared/Types.swift
    var hingeDegrees: Double? = nil                   // effect fuel only
    var effectBend: Double = 0                        // reset when non-partial

    func attachHingeObserver(to view: some View) -> some View {
      view.onHingeChange { old, new in
        // hinge == nil → no hinge in this context (normal iPhone, hierarchy exit)
        guard let hinge = new.hinge else {
          hingeStatus = .unavailable
          hingeDegrees = nil
          effectBend = 0                              // RESET — never leave stuck effect
          return
        }
        switch hinge.status {
        case .closed:
          hingeStatus = .closed
          hingeDegrees = hinge.angle.degrees
          effectBend = 0
        case .partiallyOpen:
          hingeStatus = .partiallyOpen
          hingeDegrees = hinge.angle.degrees
          effectBend = /* optional visual amp — NOT layout */
        case .fullyOpen:
          hingeStatus = .fullyOpen
          hingeDegrees = hinge.angle.degrees
          effectBend = 0                              // RESET partial effects
        default:
          hingeStatus = .unavailable
          effectBend = 0
        }
      }
    }
  }
```

**Usage patterns (steal behavior, not product):**

| Pattern | Source | Outer Lens use |
|---------|--------|----------------|
| Continuous angle → effect while `.partiallyOpen` | Accorduon, Apple guitar | **Optional** only — never layout; never Accorduon clone |
| Held reading survives close | HingeMaster | Frost closed-cover nice-to-have only |
| Closed → outer shelf via effect + scene | ClawKit | Frost decoy continuity, not Outer Lens CCA |

**UNKNOWN:** Guaranteed numeric angle range, zero convention, update rate (Apple: system policy). Artem README **180° when flat** = **SIM-OBS** only. Whether SwiftUI `DeviceHinge.Status` exposes `.unknown` (UIKit does; Moments uses **app-level** `.unknown` when `hinge == nil`) = **UNKNOWN**.

---

### 2.2 UIKit hinge

| Symbol | Framework | Intro | Tier |
|--------|-----------|-------|------|
| `UIHingeInteraction` | UIKit | 27.1 | **VERIFIED** |
| `UIHingeInteraction.Update` | UIKit | 27.1 | **VERIFIED** |
| `UIHinge` | UIKit | 27.1 | **VERIFIED** — `.angle: CGFloat` **radians** |
| `UIHinge.Status` | UIKit | 27.1 | **VERIFIED** — includes `.unknown` |

**Imports:** `import UIKit`

**Saturday policy:** Prefer SwiftUI `onHingeChange` in `PoseRouter.swift`. UIKit only if a UIKit capture bridge appears — still **effects only**. Handler escapes → `[weak self]`.

**Pitfall:** Mixing SwiftUI `Angle.degrees` with UIKit radians without conversion → wrong effects (**SIM-OBS** DuoInspector).

---

## 3. Symbol catalog — Reserved regions

| Symbol | Framework | Intro | Tier | Role |
|--------|-----------|-------|------|------|
| `ReservedRegion` | SwiftUI | 27.1 | **VERIFIED** | `id`, `kind`, `frame`, `margins`, `isActive` |
| `ReservedRegion.Kind.division` | SwiftUI | 27.1 | **VERIFIED** | Fold / content-splitting region |
| `ReservedRegion.Kind.occlusion` | SwiftUI | 27.1 | **VERIFIED** | Camera / obstruction |
| `ReservedRegion.QueryOptions.includeInactive` | SwiftUI / UIKit | 27.1 | **VERIFIED** | Also return inactive regions |
| `GeometryProxy.reservedRegions(kind:options:layoutDirectionBehavior:)` | SwiftUI | 27.1 | **VERIFIED** | Query in local coords; default `layoutDirectionBehavior: .mirrors` |
| `UIView.ReservedRegion` + `reservedRegions(kind:options:)` | UIKit | 27.1 | **VERIFIED** | `@MainActor` |

**Imports:** `import SwiftUI` (shell); UIKit only if needed.

**Saturday owner:** `DuoApp/Duo/ArrangementRegions.swift` — consumed by `App/RootArrangementView.swift`.

**VERIFIED query recipe:**

```text
FILE: DuoApp/Duo/ArrangementRegions.swift
LANE: LANE-SHELL

PSEUDO:
  struct DivisionSnapshot {
    var activeFrames: [CGRect]      // layout panes around these
    var inactiveFrames: [CGRect]    // even-column / planning
    var anyActive: Bool
  }

  func snapshotDivisions(proxy: GeometryProxy) -> DivisionSnapshot {
    // PRACTICAL RULE (research-duo-apis): always includeInactive then filter
    // Discrepancy UNKNOWN: Tech Talk says default=active-only; some doc prose says all
    let all = proxy.reservedRegions(kind: .division, options: .includeInactive)
    let active = all.filter(\.isActive)
    return DivisionSnapshot(
      activeFrames: active.map(\.frame),   // frame ALREADY includes margins — do not add twice
      inactiveFrames: all.filter { !$0.isActive }.map(\.frame),
      anyActive: !active.isEmpty
    )
  }

  func snapshotOcclusions(proxy: GeometryProxy) -> [CGRect] {
    proxy.reservedRegions(kind: .occlusion, options: .includeInactive)
      .filter(\.isActive)
      .map(\.frame)
  }
```

**SIM-OBS (Artem “Good to Know” — label in code comments as SIM-OBS):**

| Observation | Saturday implication |
|-------------|----------------------|
| Division active **only** when partially folded; flat → inactive; frame still ~**40 pt** wide with **20 pt** margins each side of zero-width crease | Prefer inactive for tabletop planning; never hardcode 40 |
| Regions may arrive **after first layout** | Read in `GeometryReader` body; **don’t cache once** |
| **Outer display:** no reserved regions at all | Closed outer = compact chrome only; CCA is separate API |
| Status-bar area of vertical bar can be **active occlusion** | Keep tip copy clear of trailing camera bump (**SIM-OBS** DuoInspector 84×120) |

**Displacement rules (Maria / Tech Talk 111463) → shell behavior:**

| Pose situation | Move | Don’t move | Path |
|----------------|------|------------|------|
| Book / partial fold | Independent chrome off crease; alerts → **trailing** | Continuous scroll content | `ArrangementRegions` + panes |
| Tabletop | Glanceable → **top**; touch → **bottom** | Features (rearrangement ≠ reduced mode) | `RootArrangementView` tabletop polish |
| Any | Prefer context (search over searched content) | Primary taps in crease | Integrator review |

**Example fuel (patterns only):** ClawKit tabletop/book; Artem Avoid-the-Crease / Tabletop / Even Columns; Cosign CardApart reads division while flat.

---

## 4. Symbol catalog — ArrangementView

| Symbol | Framework | Intro | Tier |
|--------|-----------|-------|------|
| `ArrangementView` | SwiftUI | 27.1 | **VERIFIED** |
| `arrangementViewStyle(_:)` | SwiftUI | 27.1 | **VERIFIED** — `.automatic` → split; `.split`; `.overlay` |
| `SplitArrangementViewStyle.axes(_:)` | SwiftUI | 27.1 | **VERIFIED** — axis restrict can **hide secondary** |
| `splitArrangementLayoutRatio(_:)` (+ min/ideal/max) | SwiftUI | 27.1 | **VERIFIED** — preference, not hard % |
| `splitArrangementLayoutSize(...)` | SwiftUI | 27.1 | **VERIFIED** |
| `splitArrangementFixedLayoutSize(horizontal:vertical:)` | SwiftUI | 27.1 | **VERIFIED** — can still shrink |
| `overlayArrangementEdge(_:)` | SwiftUI | 27.1 | **VERIFIED** — horizontal **and** vertical overloads in SDK |
| `EnvironmentValues.splitArrangementAxis` | SwiftUI | 27.1 | **VERIFIED** API; **SIM-OBS** was `nil` in every Artem sim config |
| `EnvironmentValues.overlayArrangementZIndex` | SwiftUI | 27.1 | **VERIFIED** — read from **subview**, not root (root always 0 — Artem) |
| `ArrangementViewStyle` / `ArrangementViewStyleConfiguration` | SwiftUI | 27.1 | **VERIFIED** — prefer built-ins |
| `UIArrangementViewController` | UIKit | 27.1 | **VERIFIED** |
| `UISplitArrangement` / `UIOverlayArrangement` | UIKit | 27.1 | **VERIFIED** |
| `UIArrangementViewController.ViewState` | UIKit | 27.1 | **VERIFIED** — query only; **no** `arrangementDidChange` |

**Imports:** `import SwiftUI`

**Saturday owner:** `DuoApp/App/RootArrangementView.swift` (LANE-SHELL).

### 4.1 Outer Lens default wiring (hour 1)

```text
FILE: DuoApp/App/RootArrangementView.swift
LANE: LANE-SHELL
CONSUMES: Shared/CutoverFlag.swift · Duo/PoseRouter.swift · Duo/ArrangementRegions.swift
PRESENTS:
  CUTOVER.flag absent/empty/false → Outer Lens SCR-OL-*
  CUTOVER.flag == frost            → FrostDuo SCR-FD-*   # DECISION Claude P0: never write true

PSEUDO (Outer Lens green):
  NavigationStack {
    // Nesting rule VERIFIED: NavigationStack → ArrangementView → content
    // NEVER ArrangementView inside List/ScrollView
    // NEVER navigation containers INSIDE arrangement
    Group {
      if CutoverFlag.isFrost {
        frostRoot()          // Features/Frost/**
      } else {
        outerLensRoot()      // Features/Capture + Coach via CCA host
      }
    }
  }
  .modifier(PoseRouter.hingeEffectsOnly())   // attach onHingeChange here or on App root

  func outerLensRoot() -> some View {
    // Primary product hour-1: single capture column is OK.
    // ArrangementView tabletop polish = OPTIONAL after CCA green AND clock ≥ 2:45
    // (outer-lens-3h-build-plan §1 OFF list)
    InnerCaptureView()                       // SCR-OL-B path Features/Capture/InnerCaptureView.swift
      .modifier(CameraCaptureAccessoryHost()) // Duo/CameraCaptureAccessoryHost.swift
  }

  func tabletopPolishIfGreen() -> some View {
    // OPTIONAL — same hierarchy, media↑ controls↓
    ArrangementView {
      CapturePreviewPane()                   // primary = media / preview
        .splitArrangementLayoutRatio(0.55)
    } secondary: {
      CaptureControlsPane()                  // secondary = shutter rail / Pro CTA
    }
    .arrangementViewStyle(.split.axes([.horizontal, .vertical]))
  }
```

### 4.2 Style chooser (Kyle / Apple aligned)

| Style | When | Outer Lens | FrostDuo |
|-------|------|------------|----------|
| `.split` (default) | Main–detail; neither obscured | Optional tabletop: preview ‖ controls | **Preferred primary demo pose:** content↑ / controls↓ |
| `.overlay` | Clear FG/BG | Rare — tip plate is **solid**, not overlay arrangement | Optional frost chrome over content |
| Reserved-region custom | Games / canvases | Prefer ArrangementView first | ClawKit-class cabinet if ArrangementView insufficient |

**Kyle blog (Bitrig Sep 18, 2026) — laptop:** media upper half · controls lower half via ArrangementView. Maps to optional polish + Frost tabletop.

**Axis hide pitfall:** `.split.axes(.horizontal)` may show **only primary** when vertical split needed — provide inline fallback for secondary controls (Apple Podcasts pattern). For Outer Lens: shutter must remain reachable → keep essential controls **inside primary** if secondary can hide, or allow both axes.

**Nesting caveats (overview vs video disagree on NavigationSplitView direction):** Safe reusable = `NavigationStack → ArrangementView → content`. Avoid either form of NavigationSplitView↔arrangement nesting without validation.

---

## 5. Symbol catalog — Camera capture accessory + direction

| Symbol | Framework | Intro | Tier | Saturday path |
|--------|-----------|-------|------|---------------|
| `CameraCaptureAccessory` | SwiftUI | 27.1 | **VERIFIED** | `Duo/CameraCaptureAccessoryHost.swift` → hosts `Features/CoachOverlay/SubjectCoachView.swift` |
| `sceneAccessory(content:)` | SwiftUI | 27.0 | **VERIFIED** | Attach to **capture** view (`InnerCaptureView`) |
| `SceneAccessoryContent.onAvailabilityChange` | SwiftUI | 27.0 | **VERIFIED** | Drive Subject toggle on SCR-OL-B |
| `UISceneAccessory.cameraCapture(...)` | UIKit | 27.1 | **VERIFIED** | Prefer SwiftUI path |
| `registerSceneAccessory` / `unregisterSceneAccessory` | UIKit | 27.0 | **VERIFIED** | UIKit lifecycle only |
| `UISceneAccessoryRegistration.isAvailable` / `isEnabled` | UIKit | 27.0 | **VERIFIED** | Distinct from presented |
| `UISceneSession.Role.windowCameraCaptureAccessory` | UIKit | 27.1 | **VERIFIED** | System-assigned — **do not** invent Info.plist scene |
| `AVCaptureDeviceDirectionCoordinator` | AVKit | 27.1 | **VERIFIED** | `Features/Capture/CaptureSessionController.swift` |
| `AVCaptureDeviceDirectionMap` / `AVCaptureDeviceDescriptor` | AVKit | 27.1 | **VERIFIED** | Capture actor |
| `.builtInInnerUltraWideCamera` / `.builtInOuterUltraWideCamera` | AVFoundation | 27.1 | **VERIFIED** | DiscoverySession — photo-only slice |
| Virtual front camera | AVFoundation | 27.1 | **VERIFIED** | Auto-switches; capability intersection ~1080p/60 |
| `AVCaptureDevice.RotationCoordinator` | AVFoundation | 17.0+ | **VERIFIED** | Still essential on Duo |

**Imports (CCA host):** `import SwiftUI`  
**Imports (session):** `import AVFoundation` · `import AVKit` (direction coordinator)

### 5.1 VERIFIED accessory recipe → Outer Lens files

```text
FILE: DuoApp/Duo/CameraCaptureAccessoryHost.swift
LANE: LANE-CCA
DEMO: 0:15–0:45 (T1) · 1:05–1:20 (T2 bloom)
SCR: SCR-OL-C via Features/CoachOverlay/SubjectCoachView.swift

PSEUDO:
  struct CameraCaptureAccessoryHost: ViewModifier {
    @Binding var subjectDisplayEnabled: Bool
    @Binding var subjectDisplayAvailable: Bool
    @Environment(EntitlementState.self) var entitlements   // Monetization/Entitlements.swift
    @Environment(CoachModel.self) var coach                // Shared/Types + CoachOverlay

    func body(content: Content) -> some View {
      content
        .sceneAccessory {
          CameraCaptureAccessory(isEnabled: $subjectDisplayEnabled) {
            SubjectCoachView(                    // SCR-OL-C
              tip: coach.currentTip,             // T1 free / T2 Pro / T3 countdown
              isPro: entitlements.isPro,
              brand: "Outer Lens"                // DesignSystem/Tokens — brand whisper
            )
          }
          .onAvailabilityChange { available in
            subjectDisplayAvailable = available
            // Hide Subject toggle when unavailable — InnerCaptureView chrome
            // Essential shutter MUST still work (Apple contract)
          }
        }
    }
  }
```

**States to keep distinct (research-outer-lens):**

| State | Meaning | UI owner |
|-------|---------|----------|
| Available | System can present | `onAvailabilityChange` → SCR-OL-B Subject toggle visibility |
| Enabled | User/app wants it | `$isEnabled` binding |
| Presented | Lifecycle actually showing | Do not invent as separate API — observe UX |

**Moments pattern fuel (do not fork):** `DuoCameraCaptureAccessory.swift` — session ownership stays **inner**; outer = non-interactive preview/status. Outer Lens productizes into tips T1–T3 + Pro oval.

**UNKNOWN:** Camera-companion **entitlement** named in Group Lab 285 — **no public key** in docs/headers. Confirm Apple provisioning before hardware ship; do not invent string. Sim may never present accessory usefully → **GATE-CCA red → Frost**.

---

## 6. Symbol catalog — Vertical toolbar / bars

| Symbol | Framework | Intro | Tier | Notes |
|--------|-----------|-------|------|-------|
| `toolbarVerticalBehavior(_:)` | SwiftUI | 27.1 | **VERIFIED** | Opt out e.g. `.disabled` for player-like UIs |
| `toolbarVerticalCompressionBehavior(_:)` | SwiftUI | 27.1 | **VERIFIED** | Labs may say `toolbarCompressionBehavior` — **wrong spelling** |
| `toolbarVerticalEdge` (Environment) | SwiftUI | 27.1 | **VERIFIED** | Preferred edge — **not** visibility flag |
| `ToolbarContent.axisBehavior(_:)` | SwiftUI | 27.1 | **VERIFIED** | `.horizontalOnly` / `.verticalPreferred` |
| `ToolbarContent.visibilityPriority(_:)` | SwiftUI | 27.1 | **VERIFIED** | Overflow order |
| `ToolbarOverflowMenu` | SwiftUI | 27.0 | **VERIFIED** (not Duo-exclusive) | |
| `.topBarPinnedTrailing` | SwiftUI | 27.0 | **VERIFIED** | Done/pinned |
| `presentationPlacement(_:)` | SwiftUI | 27.0 | **VERIFIED** | Sheets only |
| UIKit vertical bar twins | UIKit | 27.1 | **VERIFIED** | Prefer system SwiftUI bars |

**Imports:** `import SwiftUI`

**Saturday owner:** Attach toolbars on `NavigationStack` in `RootArrangementView` / SCR-OL-B / SCR-OL-D — **not** custom floating bars (custom bars won’t get vertical behavior).

**Outer Lens chrome policy (design-direction §3A / §10):**

| Control | Material | Path |
|---------|----------|------|
| Inner flip / tip pack / Subject / close | Liquid Glass regular pills | `InnerCaptureView.swift` |
| Shutter ~80pt | **Solid** (not glass) | `InnerCaptureView.swift` |
| Outer tip | **Solid** tip plate — never glass over faces | `TipPlateView.swift` |
| Paywall sheet | System glass sheet | `PaywallHostView.swift` |

**Opt out:** Capture-heavy single page may set `toolbarVerticalBehavior(.disabled)` if vertical bar fights Film Tool bottom rail — document in GATE-SHELL if used.

---

## 7. Symbol catalog — Scenes / size classes / geometry (supporting)

| Symbol | Tier | Saturday use |
|--------|------|--------------|
| `horizontalSizeClass` / `verticalSizeClass` | **VERIFIED** (system) | Compact outer / regular inner branching — primary layout signal |
| `UIWindowScene.ActivationAction` | **VERIFIED** | Second window = **inner only**; handle failure |
| `UIApplication.supportsMultipleScenes` | **VERIFIED** | Distinct from resize-beside |
| `UIWindowScene.effectiveGeometry` | **VERIFIED** | Prefer over `UIScreen.main` |
| `backgroundExtensionEffect()` / `UIBackgroundExtensionView` | iOS 26+ | Optional bleed under bars |
| `ConcentricRectangle` / `UICornerConfiguration` | iOS 26+ | Corner geometry polish |
| `contentMargins(for: .container)` | **VERIFIED** | Artem demo — optional |

**Size-class cheat (Apple prepare talk + DuoInspector SIM-OBS):**

| Situation | Typical traits (verify live) | Shell action |
|-----------|------------------------------|--------------|
| Outer portrait | compact / regular | Glance chrome; CCA or Frost decoy |
| Outer landscape | compact / compact | Tent glance — large tip / decoy |
| Inner fully open landscape | regular / regular | More canvas; vertical bar trailing |
| Partial fold | Treat as **active division** | Arrangement / regions — not hinge degrees |

**SIM-OBS geometry (DuoInspector):** Inner ~669×951 pt; outer ~466×678 pt. Trailing safe area **84 pt** landscape can be camera occlusion — asymmetric → never `left * 2`.

---

## 8. FrostDuo cutover — API subset (not a second climax)

When `docs-runtime/CUTOVER.flag` = frost (`Shared/CutoverFlag.swift` reads true):

| Still use | Don’t use as climax |
|-----------|---------------------|
| `ArrangementView` tabletop media↑ / controls↓ | `CameraCaptureAccessory` as primary story |
| `reservedRegions(.division)` for frost panes | Accorduon hinge synth |
| `onHingeChange` effects optional (F1 amp) | Layout from hinge |
| Size classes / vertical bars | Second window on outer |

**Frost paths:** `Features/Frost/SensitiveSurfaceView.swift` (SCR-FD-A) · `FrostControlsView.swift` (SCR-FD-B) · `OuterDecoyStageView.swift` (SCR-FD-C) · shared `PaywallHostView.swift` (SCR-FD-D).

Outer decoy on closed display = **system migration / designed placeholder**, not CCA.

---

## 9. Per-file API ownership matrix

| Path (theme contract §4) | Lane | APIs allowed | APIs forbidden |
|--------------------------|------|--------------|----------------|
| `App/DuoAppApp.swift` | SHELL | App entry; attach PoseRouter env | CCA |
| `App/RootArrangementView.swift` | SHELL | `ArrangementView`, size classes, NavigationStack, CutoverFlag switch | Hinge→frames |
| `Duo/PoseRouter.swift` | SHELL | `onHingeChange`, status→app pose enum | Layout math |
| `Duo/ArrangementRegions.swift` | SHELL | `reservedRegions` division/occlusion | Hinge thresholds |
| `Duo/CameraCaptureAccessoryHost.swift` | CCA | `sceneAccessory`, `CameraCaptureAccessory`, availability | Paywall on outer |
| `Features/Capture/CaptureSessionController.swift` | CCA | AVCaptureSession, direction/rotation coordinators | Outer window creation |
| `Features/Capture/InnerCaptureView.swift` | CCA | Preview, shutter, toolbars, host modifier | Tip lists on outer |
| `Features/Capture/PermissionPrimerView.swift` | CCA | Permission UX only | Duo layout APIs |
| `Features/Capture/CaptureDeniedView.swift` | CCA | Settings deep link | — |
| `Features/CoachOverlay/SubjectCoachView.swift` | CCA | Renders T1–T3; brand whisper | Interactive chrome |
| `Features/CoachOverlay/TipPlateView.swift` | CCA | Solid plate | Liquid Glass over tip |
| `Features/CoachOverlay/GuideOvalView.swift` | CCA | Amber stroke when `isPro` | Free-tier oval |
| `Features/CoachOverlay/CountdownView.swift` | CCA | T3 numeral | — |
| `Features/Paywall/PaywallHostView.swift` | RC | RevenueCatUI | Duo climax APIs |
| `Features/Frost/**` | FROST | Arrangement/regions; Simulate Threat | CCA as product |
| `Monetization/**` | RC | Purchases | Hinge |
| `DesignSystem/Tokens.swift` | ASSETS | Colors/type — no Duo APIs | — |
| `DesignSystem/Motion.swift` | ASSETS | M1–M3 / F1–F3 / P1–P3 specs | — |
| `Shared/CutoverFlag.swift` | SHELL | Flag reader | Feature UI |
| `Shared/Types.swift` | INTEGRATOR | `PoseMode`, session states, tips | — |
| `docs-runtime/GATE-*.md` | Orchestrator | Evidence, not code | — |

---

## 10. Pitfalls catalog (copy into GATE-SHELL)

### 10.1 Official / near-official

| Quirk | Source | Saturday action |
|-------|--------|-----------------|
| Slow **first** Simulator launch | Xcode 27.1 RN (cited) | Boot Duo sim **before** 11:30 |
| StandBy unavailable in Duo runtime | Same | No StandBy widgets |
| Most app extensions can’t run in Duo runtime | Same | Skip widgets path |
| Camera apps launch with **no cameras** | Group Lab 286 | Shell OK; not capture proof |
| Sim **cannot** light both displays for camera / validate accessory | Lab 286 + SwiftLee | Tip-only / Simulate tip / cutover Frost by 12:15 |
| Xcode **27.2** points Duo work back to **27.1** | Skill guide | Stay on 27.1 |
| Need **macOS 26.6+** | Apple requirements | Check laptop AM |
| Settings → Components **Update** for iOS 27.1 runtime | SwiftLee | Don’t assume download alone |

### 10.2 Anti-patterns (everywhere)

| Anti-pattern | Correct path |
|--------------|--------------|
| Layout from hinge angle thresholds | `ArrangementRegions` + `ArrangementView` |
| `UIScreen.main.bounds` | Local geometry / effectiveGeometry |
| Symmetric inset assumptions | Asymmetric safe areas |
| `.front` = “facing user” without direction coordinator | `AVCaptureDeviceDirectionCoordinator` |
| Essential features only via hinge or accessory | Inner shutter always works |
| Invented notifications / entitlements | VERIFIED catalog only |
| ArrangementView inside ScrollView/List | Nest under NavigationStack |
| Navigation inside arrangement | Content panes only |
| Paywall on outer | SCR-OL-D / SCR-FD-D **inner only** |
| Glass over outer tip / face | Solid tip plate (`TipPlateView`) |
| Two climax APIs one demo | CutoverFlag exclusivity |

### 10.3 Product README pitfalls (fuel only)

| Repo | Pitfall | Saturday |
|------|---------|----------|
| Accorduon | Sim hard to hold key + fold | Ship Simulate / Auto fallback — **don’t ship Accorduon** |
| HingeMaster | Partial/flat unverified | Don’t claim precision |
| Moments | Multi-feature social | Steal CCA pattern only |
| Cosign | Agents simulated | Steal ArrangementView book only |
| marpies | APIs unavailable on non-Duo | Guard 27.1 |

---

## 11. First-hour API proof checklist (11:30–12:30)

Maps to milestones **M0–M3** (theme contract §3) and `docs/outer-lens-3h-build-plan.md` Block A–B.

### 11:30–11:45 — Toolchain green → `docs-runtime/GATE-SHELL.md`

- [ ] `xcodebuild -version` → **27.1**; iOS **27.1** runtime installed  
- [ ] iPhone Duo destination; **first boot** finished  
- [ ] Empty SwiftUI app ⌘R → Device Hub fold/unfold reacts (**TC-S01**)  
- [ ] §4 tree stubs exist under `DuoApp/`  

### 11:45–12:15 — Pick ONE climax

**Path A — Outer Lens (preferred):**

- [ ] `CameraCaptureAccessoryHost` on `InnerCaptureView` compiles  
- [ ] `.sceneAccessory { CameraCaptureAccessory { SubjectCoachView } }`  
- [ ] `onAvailabilityChange` toggles visible Subject control on SCR-OL-B  
- [ ] T1 tip string readable (“Chin up · eyes to the lens”) — tip-only OK if preview black  
- [ ] **If** no cameras / accessory never available → **abort Path A** → Path B  

**Path B — FrostDuo cutover:**

- [ ] Orchestrator writes `CUTOVER.flag` + `GATE-CCA.md = RED`  
- [ ] `RootArrangementView` swaps to Frost SCR-FD-*  
- [ ] Simulate Threat → frost + decoy A (**TC-F01–F03**)  

**Path C — Tabletop Arrangement (polish only if A green early):**

- [ ] Media↑ / controls↓ via ArrangementView or regions — **same hierarchy**  
- [ ] Optional `onHingeChange` effect — not layout  

### 12:15–12:30 — Gate + continuity

- [ ] `GATE-CCA.md` written green/red  
- [ ] One RC configure stub path exists (LANE-RC) — not Duo API  
- [ ] Fold mid-nav: selection/state preserved  
- [ ] No StandBy / extension dependency  
- [ ] Lock 90s script around the climax that works  

**Red flags — stop:** fighting entitlement; Accorduon-as-product; hinge-driven layout; two unfinished Duo API surfaces.

---

## 12. Import cheat-sheet (Swift)

```text
// Duo/PoseRouter.swift
import SwiftUI

// Duo/ArrangementRegions.swift
import SwiftUI

// App/RootArrangementView.swift
import SwiftUI

// Duo/CameraCaptureAccessoryHost.swift
import SwiftUI
// (no AVFoundation in host — session stays in CaptureSessionController)

// Features/Capture/CaptureSessionController.swift
import AVFoundation
import AVKit          // DirectionCoordinator
import SwiftUI        // if Observable bridged

// Features/Frost/** (cutover)
import SwiftUI
```

Do **not** import RevenueCat into Duo/* shell files. Do **not** import AVFoundation into PoseRouter.

---

## 13. Example repo → API map (pattern fuel — remix only)

| Repo | APIs | Steal for Outer Lens | Don’t |
|------|------|----------------------|-------|
| artemnovichkov/iPhone-Duo-by-Examples | Full cheat sheet | Hour-1 catalog | Ship as product |
| artemnovichkov/Accorduon | onHingeChange speed | Hinge-as-input + fallback | Accordion product |
| artemnovichkov/ClawKit | reservedRegions; hinge shelf | Tabletop choreography | Claw game entry |
| po-miyasaka/DuoInspector | Overlay inspector | Measurement | Enter as inspector |
| swiftlysingh/HingeMaster | Live hinge; outer hold | Outer continuity | Precision claims |
| ScaleWithEzra/cosign-ios | ArrangementView `.split.axes(.horizontal)` | Book panes / tabletop | Agent theater |
| Lazynius1/Moments | CCA + ArrangementView | Outer Lens CCA wiring | Fork social |
| marpies/iphone-duo-sample | UIKit twins | UIKit counterparts | — |

---

## 14. Open UNKNOWN list (carry forward)

1. Exact camera-accessory **entitlement** string (if any).  
2. Runtime default of `reservedRegions` active filtering.  
3. Whether SwiftUI `DeviceHinge.Status` ever exposes `.unknown`.  
4. Numeric hinge angle contract (range / zero / rate).  
5. Live Xcode 27.1 release-notes wording (JS shell fetches).  
6. Whether Duo sim can ever present `CameraCaptureAccessory` usefully before hardware.  
7. App Store screenshot upload for Duo assets (marketing only — later year).

**Rule:** Saturday agents treat UNKNOWN as **non-blocking cut** or **GATE red**, never as invented API.

---

## 15. Sources (cite in PR / demo notes)

**Apple:** [iPhone Duo hub](https://developer.apple.com/iphone-duo/) · [Preparing](https://developer.apple.com/documentation/technologyoverviews/preparing-your-app-for-iphone-duo) · [HIG Designing for iPhone Duo](https://developer.apple.com/design/human-interface-guidelines/designing-for-iphone-duo) · [onHingeChange](https://developer.apple.com/documentation/swiftui/view/onhingechange(isenabled:_:)) · [ArrangementView](https://developer.apple.com/documentation/swiftui/arrangementview) · [CameraCaptureAccessory](https://developer.apple.com/documentation/swiftui/cameracaptureaccessory) · [ReservedRegion](https://developer.apple.com/documentation/swiftui/reservedregion) · [Registering CCA](https://developer.apple.com/documentation/avfoundation/registering-a-camera-capture-accessory-on-iphone-duo) · [Choosing camera by direction](https://developer.apple.com/documentation/avkit/choosing-a-camera-by-the-direction-it-faces) · Tech Talks 111461–111466  

**Bitrig:** [Builds Duo apps (Kyle)](https://bitrig.com/blog/bitrig-builds-iphone-duo-apps) · [Get ready (Sean Allen)](https://bitrig.com/blog/iphone-duo-app-development)  

**Research packs:** `internal/research-duo-apis.md` · `internal/research-duo-hig-poses.md` · `internal/design-research-duo-craft.md` · `internal/research-outer-lens.md`  

**Skill snapshot (temp):** [bunn/iphone-duo-skill](https://skills.sh/bunn/iphone-duo-skill/iphone-duo) — not a substitute for live Saturday SDK confirm.

---

## 16. Acceptance crosswalk

| TC | Assertion | API / path evidence |
|----|-----------|---------------------|
| TC-S01 | App launches on Duo sim | Toolchain §11 |
| TC-S02 | Pose remaps regions/panes without hinge-driven layout | `PoseRouter` + `ArrangementRegions` + `RootArrangementView` |
| TC-S03 | `onHingeChange` effects only | Code review PoseRouter |
| TC-S04 | CutoverFlag readable | `Shared/CutoverFlag.swift` |
| TC-C01 | Outer tip ≤30s | CCA host + SubjectCoachView · demo **0:15–0:45** |
| TC-C02 | Inner shutter + preview | CaptureSessionController · InnerCaptureView |
| TC-C03 | accessory.unavailable → still shoots | Availability path |
| TC-C04 | T2 follows `isPro` | GuideOvalView + Entitlements |
| TC-F01–F04 | Frost cutover suite | Frost paths when flag true |

---

*End §05. Companion shell chapter: [`08-shell-arrangement-poses.md`](./08-shell-arrangement-poses.md).*
