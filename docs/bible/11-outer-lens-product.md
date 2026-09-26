---
cursor:
  subagentId: "bc-c9c3fba2-b6dd-5b92-9563-eca042193206"
chapter: "11"
title: "Outer Lens — primary product screen specs (SCR-OL-A…E)"
product: "Outer Lens (Film Tool)"
status: "canonical for Saturday LANE-CCA / LANE-COPY / LANE-ASSETS / LANE-RC"
constraint: "Spec only — no app/Swift sources. Pseudocode OK."
inputs:
  - "internal/research-outer-lens.md"
  - "internal/design-research-outer-lens-ui.md"
  - "docs/design-direction.md"
  - "docs/ios-craft-addendum.md"
  - "docs/bible-single-theme-contract.md"
  - "docs/outer-lens-3h-build-plan.md"
companion: "docs/bible/11b-outer-lens-flows.md"
compiled: "Sat Sep 26, 2026"
---

# §11 Outer Lens — primary product screen specs

**Product noun:** Outer Lens (Coach) · **Visual theme:** Film Tool  
**Brad (frozen):** Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.  
**Matt (frozen):** Free: outer preview. Pro: pose overlays on the outer display.  
**Climax API:** `CameraCaptureAccessory` via `.sceneAccessory` on the capture root (`Duo/CameraCaptureAccessoryHost.swift`).  
**Lane owners:** LANE-CCA (Capture + CoachOverlay + CCA host) · LANE-RC (Paywall + EntitlementState) · LANE-COPY (strings) · LANE-ASSETS (tokens / glyphs).  
**Cutover note:** FrostDuo SCR-FD-* live only when `docs-runtime/CUTOVER.flag = frost`. This chapter assumes flag **false**.

**Every paragraph below maps to a SCR-ID, a Saturday path, a tip/motion ID, a demo second, or a TC-OL-* assertion.** Delete anything that does not.

---

## 11.0 Chapter contract

### 11.0.1 Screen inventory (frozen)

| SCR-ID | Screen | Who | Path anchor | Demo seconds |
|--------|--------|-----|-------------|--------------|
| **SCR-OL-A** | Permission primer | Photographer (inner) | `Features/Capture/PermissionPrimerView.swift` | **0:00–0:10** |
| **SCR-OL-B** | Capture shell | Photographer (inner) | `Features/Capture/InnerCaptureView.swift` | **0:10–0:40** |
| **SCR-OL-C** | Subject coach | Subject (outer via CCA) | `Features/CoachOverlay/SubjectCoachView.swift` | **0:15–0:45** T1 · **1:05–1:20** T2 |
| **SCR-OL-D** | Paywall | Photographer (inner only) | `Features/Paywall/PaywallHostView.swift` | **0:50–1:05** |
| **SCR-OL-E** | Empty / denied / unavailable | Photographer | `Features/Capture/CaptureDeniedView.swift` (+ banners on B) | Fallback; never bricks inner |

**Tip styles (only):** T1 Line · T2 Guide (Pro) · T3 Countdown — all render inside SCR-OL-C.  
**Motions (only):** M1 Tip settle · M2 Countdown punch · M3 Pro unlock bloom · P1–P3 press micros on SCR-OL-B.  
**Hard kills:** paywall on outer · tip lists on outer · skeleton HUD free · video/mic · Vision as load-bearing · Multipeer · hinge-driven layout · second climax API.

### 11.0.2 Shared model (Integrator types — consume, don’t reinvent)

Pseudocode contracts for `Shared/Types.swift` (Integrator owns after scaffold):

```text
enum CaptureAuthState { notDetermined, requesting, authorized, denied, restricted }
enum SessionPhase { idle, starting, live, failed(String) }
enum TipStyle { t1Line, t2Guide, t3Countdown }
enum TipPack { free, kidsPro, portraitPro }   // kids/portrait locked until isPro
enum AccessoryPhase { unknown, unavailable, availableDisabled, availableEnabled, presented }

struct CoachTip: Identifiable, Equatable {
  id: String
  pack: TipPack
  text: String          // ≤8 words
  symbolName: String?   // SF Symbol optional
  requiresPro: Bool
}

@Observable final class OuterLensModel {   // shared by inner + CCA content
  auth: CaptureAuthState
  session: SessionPhase
  accessory: AccessoryPhase
  isAccessoryEnabled: Bool          // binding for CameraCaptureAccessory(isEnabled:)
  isAccessoryAvailable: Bool        // from onAvailabilityChange
  selectedPack: TipPack
  currentTip: CoachTip
  tipStyle: TipStyle                // derived: isPro? + countdownActive?
  countdownValue: Int?              // 3,2,1 or nil
  isPro: Bool                       // mirrors EntitlementState.isPro
  showPaywall: Bool
  simulateFlags: SimulateFlags
  lastError: CaptureError?
}

struct SimulateFlags {
  forceTipCycle: Bool
  forceProChrome: Bool              // demo recovery ONLY — hide when RC path works
  forceCountdown: Bool
}

enum CaptureError {
  cameraDenied, noDevices, sessionFailed(String), accessoryUnavailable
}
```

**Rule:** Persist tip / Pro / pack in the model — **not** in the accessory view. CCA content is a render of the same observable model (Apple + Moments pattern).

### 11.0.3 Film Tool tokens (consume from DesignSystem/Tokens.swift)

| Token | Value | Where |
|-------|-------|-------|
| `--canvas` | `#050505` | Inner preview letterbox · outer stage |
| `--panel` | `#1C1C1E` | Tip plate solid · sheets |
| `--panel-raised` | `#2C2C2E` | Toasts |
| `--scrim` | `rgba(0,0,0,0.55)` | Tip plate over preview min |
| `--ink` | `#FFFFFF` | Primary tip / shutter |
| `--ink-muted` | white @ 62% | Brand whisper · secondary |
| `--accent` | `#E8A838` Amber film **LOCKED** | Pro oval stroke · Pro CTA · M3 flash |
| `--success` | `#5CCC8C` | Purchase check · Pro badge |
| `--danger` | `#FF453A` | Denied / error |
| `--tip-primary-size` | ≥28pt SF Rounded Semibold | Outer T1/T2 |
| `--countdown-size` | 140pt (120–180) | T3 |
| `--shutter-size` | 80pt (72–88) | Inner shutter |
| `--glass-variant` | regular | Inner pills only |
| `--dur-tip` | 220ms | M1 |
| `--dur-pro-bloom` | 360ms | M3 |
| `--dur-press` | 120ms | P1–P3 |

**Glass law (ios-craft-addendum):** Liquid Glass = functional layer on **inner** rails + system sheets. Outer tip = **solid** `--panel` + `--scrim`. Shutter = **solid** craft circle. Never glass tip text over a face.

### 11.0.4 Brand signal (hero-level)

On SCR-OL-B and SCR-OL-C, wordmark **Outer Lens** must be visible without relying on a nav bar alone. Spec: SF Pro Medium 13–15pt · `--ink-muted` · top safe area · never louder than tip. If nav removed, brand whisper still identifies the product (brand test).

---

## 11.1 SCR-OL-A — Permission primer (inner)

**Path:** `Features/Capture/PermissionPrimerView.swift`  
**Owner:** LANE-CCA · strings LANE-COPY  
**Job:** Explain why camera is needed **before** system alert. Photo-only. No mic.  
**Demo:** 0:00–0:10 (often auto-skipped if already authorized).

### 11.1.1 Text wireframe

```text
┌─ INNER · SCR-OL-A · PermissionPrimer ──────────────────────────┐
│  [safe top]                                                     │
│                                                                 │
│              Outer Lens                    ← brand ≥ tip chrome │
│                                                                 │
│         ┌─────────────────────────┐                             │
│         │   SF Symbol camera.fill │  ~56pt monochrome           │
│         └─────────────────────────┘                             │
│                                                                 │
│         Subject coaching needs                                  │
│         the camera                                              │
│         (Title2 / SF Pro Bold)                                  │
│                                                                 │
│         Outer Lens shows framing tips on the                    │
│         outer display while you shoot from                      │
│         the inner. Photos stay on this device.                  │
│         (Body · --ink-muted · ≤3 lines)                         │
│                                                                 │
│                                                                 │
│         ┌─────────────────────────────────┐                     │
│         │      Continue to Camera         │  ← primary CTA      │
│         └─────────────────────────────────┘                     │
│         Not now  (text button)                                  │
│  [safe bottom]                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 11.1.2 Layout specs

| Element | Spec |
|---------|------|
| Canvas | `--canvas` full-bleed; no hero photo inset card |
| Brand | Centered or top-leading “Outer Lens” |
| Icon | `camera.fill` · white · no purple glow |
| Title | SF Pro Bold Title2 · `--ink` |
| Body | SF Pro Regular Body · `--ink-muted` · max 3 lines |
| Primary CTA | Full-width or prominent glass/solid fill · amber optional soft · label `Continue to Camera` |
| Secondary | Text `Not now` → dismiss to idle shell without requesting auth |
| Cards | **None** — composition is brand + one headline + one body + one CTA group |

### 11.1.3 States

| State ID | Trigger | UI | Next |
|----------|---------|-----|------|
| `A.empty` | First open · `auth == .notDetermined` | Primer as wireframe | User taps Continue |
| `A.requesting` | After Continue · `requestAccess` in flight | Disable CTA · small spinner on button | System alert |
| `A.authorized` | System Allow | Instant dismiss → SCR-OL-B `session.starting` | — |
| `A.denied-from-system` | System Don’t Allow | Transition → SCR-OL-E denied | — |
| `A.skip` | `auth == .authorized` already | **Do not show primer** — enter B | — |
| `A.restricted` | Parental / MDM | SCR-OL-E restricted copy | — |

### 11.1.4 Copy strings (LANE-COPY keys)

| Key | EN string | Notes |
|-----|-----------|-------|
| `perm.brand` | `Outer Lens` | |
| `perm.title` | `Subject coaching needs the camera` | |
| `perm.body` | `Outer Lens shows framing tips on the outer display while you shoot from the inner. Photos stay on this device.` | |
| `perm.cta` | `Continue to Camera` | |
| `perm.notNow` | `Not now` | |
| `perm.plist.camera` | `Outer Lens uses the camera so you can shoot from the inner display while coaching the subject on the outer.` | Info.plist `NSCameraUsageDescription` |
| `perm.plist.photoAdd` | `Outer Lens saves photos you capture to your library.` | Only if save ships; prefer add-only |

**Do not** request mic. **Do not** request photo library read. Request at camera entry, not cold launch (Apple guidance).

### 11.1.5 Behavior / pseudocode

```text
func onAppear_SCR_OL_A():
  switch AVCaptureDevice.authorizationStatus(for: .video):
    case .authorized: route(SCR-OL-B); startSession()
    case .notDetermined: show primer
    case .denied, .restricted: route(SCR-OL-E)

func onContinue():
  model.auth = .requesting
  AVCaptureDevice.requestAccess(for: .video) { granted in
    if granted: model.auth = .authorized; route(B); startSession()
    else: model.auth = .denied; route(E)
  }
```

### 11.1.6 Acceptance (screen-local)

| TC | Assertion |
|----|-----------|
| **TC-OL-A01** | Primer never appears if already authorized |
| **TC-OL-A02** | Continue triggers system alert exactly once per notDetermined |
| **TC-OL-A03** | Body copy mentions outer coaching (Brad alignment) |
| **TC-OL-A04** | No mic permission dialog in photo-only build |

---

## 11.2 SCR-OL-B — Capture shell (inner)

**Path:** `Features/Capture/InnerCaptureView.swift` (+ `CaptureSessionController.swift`)  
**Owner:** LANE-CCA · glass/press LANE-ASSETS tokens · Pro CTA opens LANE-RC host  
**Job:** Photographer capture — live preview, shutter, flip, tip pack, Subject toggle, Pro CTA, Settings entry.  
**Demo:** 0:10–0:40 (live preview + flip + Pro CTA visible).

### 11.2.1 Text wireframe — live

```text
┌─ INNER · SCR-OL-B · CaptureShell · session.live ───────────────┐
│ [Close]  [Subject screen ○/●]              [Free ▾ tip pack]   │
│  glass pill                         glass pill · lock on Pro   │
│                                                                 │
│  Outer Lens                          ← brand whisper top-center│
│                                                                 │
│                                                                 │
│                                                                 │
│                    LIVE PREVIEW (full-bleed)                    │
│                    AVCaptureVideoPreviewLayer                   │
│                    black letterbox OK                           │
│                                                                 │
│                                                                 │
│                                                                 │
│                                                                 │
│  [Flip]          ◎ SHUTTER ~80pt           [Pro coaching]       │
│  glass 48pt      solid white ring           glass+amber tint    │
│                  press scale 0.94                               │
└─────────────────────────────────────────────────────────────────┘
```

### 11.2.2 Text wireframe — session.starting

```text
┌─ INNER · SCR-OL-B · starting ──────────────────────────────────┐
│ [Close]  [Subject · hidden if !available]     [tip pack]        │
│                                                                 │
│                    ● spinner (center)                           │
│                    Getting ready…                               │
│                    shutter DISABLED                             │
│                    NO tip theater as if coaching                │
└─────────────────────────────────────────────────────────────────┘
```

### 11.2.3 Chrome inventory

#### Top rail (whisper)

| Control | Visibility | Spec | Action |
|---------|------------|------|--------|
| Close / Done | Always | Glass pill · `xmark` | Leave capture · unregister CCA when leaving feature |
| Subject screen | **Only if** `isAccessoryAvailable == true` | Toggle · label `Subject screen` | Sets `isAccessoryEnabled` |
| Tip pack | Always | Menu: Free · Kids (lock) · Portrait (lock) | Free selects pack; locked → `showPaywall = true` |
| Brand | Always | `Outer Lens` 13–15pt muted | Non-interactive |

#### Bottom rail (craft)

| Control | Spec | Action |
|---------|------|--------|
| Flip | Glass · `camera.rotate` · hit ≥48pt · P2 | Toggle front/back; tip labels stay upright / unmirrored |
| Shutter | Solid · ~80pt · P1 scale 0.94 / 120ms | Capture photo; optional dual-pane flash; may fire T3 first |
| Pro coaching | Glass regular + amber tint · trailing pill | If !isPro → SCR-OL-D; if isPro → show check / label `Pro` |

**Minimal chrome law:** No mode carousel. No second settings strip. Everything else → one Settings sheet (Simulate tip / Simulate Pro / Simulate countdown / tip cycle interval).

### 11.2.4 States

| State ID | Trigger | Inner UI | Outer implication |
|----------|---------|----------|-------------------|
| `B.starting` | After auth · session configuring | Spinner · shutter off | Accessory not claimed as coaching |
| `B.live` | Session running | Preview + controls | CCA eligible |
| `B.denied` | Auth denied mid-flow | Embed or push SCR-OL-E | Hide accessory |
| `B.noDevices` | Discovery empty (sim) | Black frame + inner static tip cards overlay | Tip-only outer if presented; **do not block RC** |
| `B.sessionFailed` | Config error | Error banner + Retry | No fake coaching |
| `B.accessoryUnavailable` | `onAvailabilityChange(false)` | Hide Subject toggle; optional one-line banner | N/A |
| `B.proLockedCTA` | !isPro | Pill `Pro coaching` | Outer stays T1 |
| `B.proActive` | isPro | Pill → check / `Pro` | Outer may be T2 |
| `B.capturing` | Shutter down | Brief flash; shutter disabled ~200ms | Optional flash / T3 |

### 11.2.5 Copy strings

| Key | EN string |
|-----|-----------|
| `capture.brand` | `Outer Lens` |
| `capture.subjectToggle` | `Subject screen` |
| `capture.tipPack.free` | `Free` |
| `capture.tipPack.kids` | `Kids` |
| `capture.tipPack.portrait` | `Portrait` |
| `capture.proCTA` | `Pro coaching` |
| `capture.proActive` | `Pro` |
| `capture.starting` | `Getting ready…` |
| `capture.banner.accessoryUnavailable` | `Subject screen unavailable on this device` |
| `capture.banner.noDevices` | `Camera preview unavailable — tips still work` |
| `capture.settings.title` | `Settings` |
| `capture.settings.simulateTip` | `Simulate tip` |
| `capture.settings.simulatePro` | `Simulate Pro unlock` |
| `capture.settings.simulateCountdown` | `Simulate countdown` |
| `capture.settings.tipInterval` | `Tip cycle` |

### 11.2.6 Session controller checklist (pseudocode)

```text
// CaptureSessionController.swift — dedicated session queue
class CaptureSessionController {
  let session = AVCaptureSession()
  let queue = DispatchQueue(label: "outerlens.capture")

  func start() {
    queue.async {
      guard auth == .authorized else { return }
      configureInputsOutputs()          // prefer virtual / discovery first
      attachRotationCoordinator()
      session.startRunning()
      MainActor.set phase = .live
    }
  }

  func stop() { queue.async { session.stopRunning(); phase = .idle } }
  func flipCamera() { /* reconfigure input; do not mirror tip labels */ }
  func capturePhoto() { /* photo-only output; optional save add-only */ }
}
```

**Info.plist minimum:** `NSCameraUsageDescription` (coach-specific). Photo add only if save ships. No mic key in photo-only build.

**UNKNOWN (do not invent):** camera-companion entitlement key mentioned in Group Lab notes — confirm Sat AM; if refused, tip-only outer or cutover.

### 11.2.7 Liquid Glass + press (SCR-OL-B only)

| ID | Where | Spec |
|----|-------|------|
| **P1** | Shutter | Scale 0.94 · 120ms · optional light haptic |
| **P2** | Flip / tip pack / Subject / Close | `.interactive()` glass or `--press-fill` 120ms |
| **P3** | Pro CTA | Press → paywall → on success amber check; outer M3 is separate |

Reduce Motion → instant / crossfade. No idle shimmer. No pointer-hover dependency for 90s.

### 11.2.8 Acceptance (screen-local)

| TC | Assertion |
|----|-----------|
| **TC-OL-B01** | Full-bleed preview or honest black + shutter (never blank brick) |
| **TC-OL-B02** | Shutter solid ~72–88pt; side pills glass regular |
| **TC-OL-B03** | Subject toggle hidden when unavailable |
| **TC-OL-B04** | Tip pack Kids/Portrait show lock and open paywall when !isPro |
| **TC-OL-B05** | Settings sheet contains all three Simulate controls |
| **TC-OL-B06** | Flip once leaves tip still legible on outer (demo 0:40–0:55) |

---

## 11.3 SCR-OL-C — Subject coach (outer via CCA)

**Path:** `Features/CoachOverlay/SubjectCoachView.swift` (+ `TipPlateView` · `GuideOvalView` · `CountdownView`)  
**Host:** `Duo/CameraCaptureAccessoryHost.swift`  
**Owner:** LANE-CCA · tip strings LANE-COPY · oval assets LANE-ASSETS  
**Job:** Person in front of camera sees framing + **exactly one** instruction. Not a control surface.  
**Demo:** 0:15–0:45 T1 · 1:05–1:20 T2 bloom.

### 11.3.1 Text wireframe — T1 free

```text
┌─ OUTER · SCR-OL-C · T1 Line tip ───────────────────────────────┐
│ [safe]  Outer Lens                          (optional timer)   │
│         brand whisper 13–15pt muted                            │
│                                                                 │
│                                                                 │
│              (live preview OR tip-only black stage)             │
│              visual center = subject face region                │
│              NO floating badges on face                         │
│                                                                 │
│                                                                 │
│         ┌──────────────────────────────────────────┐            │
│         │  💡  Chin up · eyes to the lens          │  tip plate │
│         │      SF Rounded Semibold ≥28pt · ≤8 words│  bottom ⅓  │
│         └──────────────────────────────────────────┘            │
│         [safe ≥34pt above home indicator]                       │
└─────────────────────────────────────────────────────────────────┘
```

### 11.3.2 Text wireframe — T2 Pro

```text
┌─ OUTER · SCR-OL-C · T2 Guide tip ──────────────────────────────┐
│ [safe]  Outer Lens                              ✓ Pro          │
│                                                                 │
│              ╭──────────────────────────╮                       │
│              │     amber oval stroke    │  GuideOvalView        │
│              │   (--accent #E8A838)     │  faint; not fill HUD  │
│              │    preview / stage       │                       │
│              ╰──────────────────────────╯                       │
│                                                                 │
│         ┌──────────────────────────────────────────┐            │
│         │  Kneel to their eye line                 │  Pro pack  │
│         │  (+ optional lock→unlocked chrome)       │            │
│         └──────────────────────────────────────────┘            │
└─────────────────────────────────────────────────────────────────┘
```

### 11.3.3 Text wireframe — T3 countdown

```text
┌─ OUTER · SCR-OL-C · T3 Countdown ──────────────────────────────┐
│                                                                 │
│                                                                 │
│                         3                                       │
│                    SF Rounded Bold                              │
│                    ~140pt monospacedDigit                       │
│                    M2 numericText + scale                       │
│                                                                 │
│         tip plate DIMMED or hidden during count                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 11.3.4 Layout rules (hard)

| Rule | Spec | Why |
|------|------|-----|
| One primary tip | Exactly one T1/T2 line visible | Arm’s-length; Apple script/countdown examples |
| Tip placement | Bottom third · above home-indicator ≥34pt · inset `--outer-inset-x` 16pt | Moments pad cue; face stays center |
| Readability | White on solid plate or scrim ≥0.55 · never bare white on skin | Busy clothing / skin tones |
| Interaction | **None required** | Essential controls stay inner |
| Preview fallback | Tip-only fullscreen if dual preview flakes | Reliability > mirror vanity |
| Mirror | Preview may mirror front cam; **tip labels never mirrored** | Craft |
| Brand | Whisper only — never louder than tip | Brand test vs tip hierarchy |
| Forbidden | Tip lists · icon grids · pill clusters · face stickers · paywall · shutter · settings | Contract kill list |

### 11.3.5 Tip styles T1 / T2 / T3 (hard cap = 3)

| ID | Name | Visual | Gate | Copy length | Motion |
|----|------|--------|------|-------------|--------|
| **T1** | Line tip | One sentence + optional SF Symbol on dark plate | Free default | ≤8 words | **M1** settle 220ms rise 8–12pt |
| **T2** | Guide tip | T1 + faint oval / thirds / shoulder guide in `--accent` | `EntitlementState.isPro` **or** Simulate Pro | ≤8 words + silent geometry | **M3** bloom from T1 |
| **T3** | Countdown | Huge numeral; tip dims | Any (demo once) | Numeral only | **M2** punch |

**No fourth style.** Vision miss → stay T1 with fallback string. Skeleton HUD = Pro-only amp **after** climax and only if time remains — default **cut** for 3h plan.

### 11.3.6 Frozen tip string table

#### Free pack (`TipPack.free`) — cycle 3 strings

| ID | String | Words |
|----|--------|------:|
| `tip.free.1` | `Chin up · eyes to the lens` | 6 |
| `tip.free.2` | `Fill the frame — step closer` | 5 |
| `tip.free.3` | `Soft smile · shoulders square` | 4 |

Optional 4th if needed: `Kids: both faces in the oval` — still free, still ≤8 words.

#### Pro Kids (`TipPack.kidsPro`) — requires isPro

| ID | String |
|----|--------|
| `tip.kids.1` | `Kneel to their eye line` |
| `tip.kids.2` | `Catch the laugh — wait` |
| `tip.kids.3` | `Two kids: squeeze in` |

#### Pro Portrait (`TipPack.portraitPro`) — requires isPro

| ID | String |
|----|--------|
| `tip.portrait.1` | `Drop the near shoulder` |
| `tip.portrait.2` | `Chin over toes` |
| `tip.portrait.3` | `Leave headroom` |

**Cycle policy:** Advance on timer (default 6s) **or** after shutter. Simulate tip advances immediately. Never blank outer — if pack empty, fall back to `tip.free.1`.

### 11.3.7 Outer chrome copy

| Key | EN string |
|-----|-----------|
| `outer.brand` | `Outer Lens` |
| `outer.proBadge` | `Pro` |
| `outer.ready` | *(omit status theater — tip is the status)* |
| `outer.gettingReady` | `Getting ready…` | Only if outer forced during `session.starting` |
| `outer.lockMark` | *(SF `lock.fill` only — no “LOCKED” shout)* |

### 11.3.8 CCA host contract

**Path:** `Duo/CameraCaptureAccessoryHost.swift`  
**Register on capture view root — not globally.**

```text
// VERIFIED pattern (research-duo-apis + Apple + Moments)
InnerCaptureView(...)
  .sceneAccessory {
    CameraCaptureAccessory(isEnabled: $model.isAccessoryEnabled) {
      SubjectCoachView(model: model)   // SAME observable model
    }
    .onAvailabilityChange { available in
      model.isAccessoryAvailable = available
      if !available {
        model.accessory = .unavailable
        // hide Subject toggle on SCR-OL-B
      } else if model.isAccessoryEnabled {
        model.accessory = .availableEnabled
      } else {
        model.accessory = .availableDisabled
      }
    }
  }
```

**Availability vs enabled vs presented (Apple):**

| Concept | Owner | UI consequence |
|---------|-------|----------------|
| Available | System (`onAvailabilityChange`) | Show/hide Subject toggle |
| Enabled | App/user binding | Accessory may present when system allows |
| Presented | System lifecycle | App cannot force; design tip-only story if never presented |

**Presentation conditions (Apple):** app foreground · active capture session · capture UI on **inner** · device open. System may withdraw anytime → all essential controls stay on inner.

**Sim reality:** Duo sim hinge OK; **camera-dependent accessory may not light both displays**. Bible default: tips-first outer + Simulate tip. Verbal line ready: “On device, the outer faces the kid.”

### 11.3.9 Preview strategy (Q5 freeze for Saturday)

| Priority | Strategy | When |
|:--------:|----------|------|
| 1 | **Tip-only fullscreen** outer | Default if dual preview unverified by gate |
| 2 | Shared-session second `AVCaptureVideoPreviewLayer` (Moments) | Only if green in probe and stable |
| 3 | Inner-only tips + verbal Duo story | Gate yellow — still try RC beat |

**Do not** make dual preview a requirement for GATE-CCA green if tip-only still sells subject coach.

### 11.3.10 Motion specs on outer

| ID | Trigger | Behavior | Reduce Motion |
|----|---------|----------|---------------|
| **M1** | Tip appear / tip change | Fade + rise 8–12pt · 220ms `--ease-out` | Crossfade or instant |
| **M2** | Countdown tick | `contentTransition(.numericText)` + snappy scale · 3→2→1 | Instant numeral swap |
| **M3** | `isPro` false→true | Accent oval strokes in · tip accent flash · 360ms | Instant oval + tip swap |

Optional micro: capture flash both panes — drop if late.

### 11.3.11 Acceptance (screen-local)

| TC | Assertion |
|----|-----------|
| **TC-OL-C01** | Exactly one primary tip visible (never tip stack) |
| **TC-OL-C02** | Tip ≥28pt · ≤8 words · solid plate/scrim |
| **TC-OL-C03** | Tip readable at 2–3 m (room test) or Simulate tip rehearsed |
| **TC-OL-C04** | T2 oval only when `isPro` or Simulate Pro |
| **TC-OL-C05** | Tip labels never mirrored |
| **TC-OL-C06** | No shutter / paywall / settings on outer |
| **TC-OL-C07** | Vision miss (if any) falls back to T1 string — never blank |
| **TC-OL-C08** | M1 plays on tip change; M3 plays on Pro unlock |

---

## 11.4 SCR-OL-D — Paywall (inner only)

**Path:** `Features/Paywall/PaywallHostView.swift`  
**Owner:** LANE-RC · CTA trigger from SCR-OL-B  
**Job:** RevenueCatUI Test Store → entitlement `pro` → other-pane T2.  
**Demo:** 0:50–1:05 purchase · 1:05–1:20 outer bloom.

### 11.4.1 Text wireframe

```text
┌─ INNER · SCR-OL-D · PaywallHost (sheet over B) ────────────────┐
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  RevenueCatUI Paywall (system Liquid Glass sheet)       │   │
│  │                                                         │   │
│  │  Benefit line (if custom header allowed):               │   │
│  │  “Pose overlays on the subject screen”                  │   │
│  │                                                         │   │
│  │  Optional static mock of outer T2 (amber oval)          │   │
│  │                                                         │   │
│  │  [Packages from Current offering]                       │   │
│  │                                                         │   │
│  │  Test Store modal → Successful Purchase / Fail / Cancel │   │
│  └─────────────────────────────────────────────────────────┘   │
│  OUTER (behind): keep T1 · optional lock glyph · NO paywall    │
└────────────────────────────────────────────────────────────────┘
```

### 11.4.2 Rules

| Do | Don’t |
|----|-------|
| Present on **inner** only | Put paywall on outer |
| One benefit sentence | Feature laundry list |
| Test Store Successful Purchase as demo path | ASC / Apple sandbox theater in 4h |
| Gate overlays with entitlement id **`pro`** (exact) | Invent alternate entitlement ids |
| System glass sheet | Custom purple glow sheet |
| On success: `EntitlementState.isPro = true` → outer M3 | Fake Pro button as primary path |

### 11.4.3 States

| State ID | Trigger | UI |
|----------|---------|-----|
| `D.locked` | User taps Pro / locked pack | Sheet presents |
| `D.purchasing` | Test Store in flight | Wait |
| `D.success` | `entitlements["pro"].isActive` | Dismiss · inner P3 check · outer M3 |
| `D.cancel` | Cancel | Dismiss · gate stays locked · outer T1 |
| `D.fail` | Failed Purchase | Dismiss/error · gate locked |
| `D.alreadyPro` | isPro on tap | Do not present; ensure T2 |

### 11.4.4 Copy strings

| Key | EN string |
|-----|-----------|
| `paywall.benefit` | `Pose overlays on the subject screen` |
| `paywall.mattSpoken` | `Free: outer preview. Pro: pose overlays on the outer display.` |
| `paywall.error.offerings` | `Offerings unavailable — check RC-IDs` |

### 11.4.5 RC integration pseudocode

```text
// Monetization/PurchasesConfig.swift — DEBUG test_ key from docs-runtime/RC-IDs.md
#if DEBUG
Purchases.configure(withAPIKey: rcIDs.testAPIKey)  // must start with test_
#endif

// Features/Paywall/PaywallHostView.swift
PaywallView()   // or presentPaywallIfNeeded
  .onPurchaseCompleted { customerInfo in
    entitlementState.isPro = customerInfo.entitlements["pro"]?.isActive == true
  }

// CoachOverlay observes entitlementState.isPro → tipStyle = .t2Guide → M3
```

**SPM:** `RevenueCat` + `RevenueCatUI` from `purchases-ios-spm` ≥ **5.43.0**.  
**Human prep:** `docs-runtime/RC-IDs.md` filled pre-doors — agents must not invent IDs.

### 11.4.6 Acceptance (screen-local)

| TC | Assertion |
|----|-----------|
| **TC-OL-D01** | Paywall never appears on outer |
| **TC-OL-D02** | Successful Purchase sets `pro` active |
| **TC-OL-D03** | Within ≤5s of success, outer shows T2 oval (other pane) |
| **TC-OL-D04** | Cancel leaves outer on T1 |
| **TC-OL-D05** | Matt sentence speakable during beat |

---

## 11.5 SCR-OL-E — Empty / denied / unavailable

**Path:** `Features/Capture/CaptureDeniedView.swift` (+ banners on B)  
**Owner:** LANE-CCA  
**Job:** Recover without bricking capture or RC story.  
**Demo:** Only if needed; rehearse once.

### 11.5.1 Text wireframes

**Denied:**

```text
┌─ INNER · SCR-OL-E · Camera denied ─────────────────────────────┐
│                                                                 │
│              ⛔  (SF hand.raised / camera.slash)                 │
│                                                                 │
│              Camera access needed                               │
│                                                                 │
│              Enable camera in Settings to shoot                 │
│              and coach on the outer display.                    │
│                                                                 │
│              [ Open Settings ]                                  │
│              [ Not now ]                                        │
└─────────────────────────────────────────────────────────────────┘
```

**Accessory unavailable (banner on B, not full replace):**

```text
┌─ INNER · SCR-OL-B with banner ─────────────────────────────────┐
│  ℹ️ Subject screen unavailable on this device                   │
│  … capture chrome still fully usable …                          │
└─────────────────────────────────────────────────────────────────┘
```

**No devices / black preview:**

```text
┌─ INNER · black preview + overlay tip cards ────────────────────┐
│  Camera preview unavailable — tips still work                   │
│  [tip.free.1 card]  [Simulate tip]                              │
│  Pro CTA still opens paywall                                    │
└─────────────────────────────────────────────────────────────────┘
```

### 11.5.2 States & recovery

| State | Detection | Recovery | Blocks RC? |
|-------|-----------|----------|------------|
| Camera denied/restricted | Auth status | Open Settings (`UIApplication.openSettingsURLString`); re-check on `didBecomeActive` | Capture yes · RC no if you can still show static tip + paywall |
| Accessory unavailable | `onAvailabilityChange(false)` | Hide toggle; inner shoots; verbal device line | No |
| No cameras discovered | Empty discovery | Black + inner tip cards; Simulate tip | No |
| Session failed | Start error | Retry · error copy · don’t claim coaching | Soft |
| Dual preview black | Outer layer fail | Outer tip-only | No |
| Vision miss | No observations | T1 fallback | No |
| Entitlement mystery | Runtime refusal | Tip-only; ask organizers; cutover if blocked | May force cutover |

### 11.5.3 Copy strings

| Key | EN string |
|-----|-----------|
| `error.denied.title` | `Camera access needed` |
| `error.denied.body` | `Enable camera in Settings to shoot and coach on the outer display.` |
| `error.denied.openSettings` | `Open Settings` |
| `error.denied.notNow` | `Not now` |
| `error.restricted.title` | `Camera unavailable` |
| `error.restricted.body` | `Camera is restricted on this device.` |
| `error.accessoryUnavailable` | `Subject screen unavailable on this device` |
| `error.noDevices` | `Camera preview unavailable — tips still work` |
| `error.sessionFailed` | `Couldn’t start the camera. Try again.` |
| `error.retry` | `Retry` |
| `demo.verbal.ccaFlake` | `Subject coach is CCA; sim can’t always light outer for camera — on device the outer faces the kid.` |

### 11.5.4 Simulate controls (must ship)

Mirror PrivacyScreen Simulate Threat pattern — **judge-safe recovery**:

| Control | Effect | Path |
|---------|--------|------|
| **Simulate tip** | Advance free tip strings · force M1 | Settings sheet on B |
| **Simulate Pro unlock** | Apply T2 chrome without purchase (demo flag) | Settings · hide when real RC works in rehearsal |
| **Simulate countdown** | Fire T3 `3·2·1` then soft shutter flash | Settings |

Optional `-demo` scripted captions — cut first if time dies.

### 11.5.5 Acceptance (screen-local)

| TC | Assertion |
|----|-----------|
| **TC-OL-E01** | Denied shows Open Settings |
| **TC-OL-E02** | `accessory.unavailable` → inner still shoots |
| **TC-OL-E03** | Simulate tip changes outer (or inner overlay) without Vision |
| **TC-OL-E04** | Simulate Pro shows T2 without requiring purchase (flagged) |
| **TC-OL-E05** | No-devices path does not block Pro CTA |

---

## 11.6 Cross-cutting — tip engine

**Paths:** `Features/CoachOverlay/TipPlateView.swift` · model tip fields  
**Owner:** LANE-CCA + LANE-COPY

### 11.6.1 Selection algorithm (pseudocode)

```text
func resolvedTipStyle(model) -> TipStyle:
  if model.countdownValue != nil: return .t3Countdown
  if model.isPro || model.simulateFlags.forceProChrome: return .t2Guide
  return .t1Line

func resolvedTip(model) -> CoachTip:
  let pack = model.selectedPack
  if pack.requiresPro && !(model.isPro || forcePro): 
    // show free tip underneath; lock mark on plate corner
    return next(in: .free)
  return next(in: pack) ?? tip.free.1   // never nil
```

### 11.6.2 Pro unlock bloom (M3) — detailed

**Trigger:** `EntitlementState.isPro` rises true (or Simulate Pro).  
**Inner:** Pro CTA → amber check (P3).  
**Outer:**

1. Tip plate brief accent flash (`--accent` border or scrim pulse ≤120ms).  
2. `GuideOvalView` opacity 0→1 · stroke `--accent` · 360ms.  
3. Tip text crossfades to Pro pack string if pack selected, else keep free string with oval.  
4. Optional success check on brand row (`--success`).  

**Not:** confetti · skeleton dance · paywall migration to outer.

---

## 11.7 Component → file map (Saturday tree)

| Component | File | Lane |
|-----------|------|------|
| App entry | `App/DuoAppApp.swift` | SHELL |
| Arrangement host | `App/RootArrangementView.swift` | SHELL |
| CCA host modifier | `Duo/CameraCaptureAccessoryHost.swift` | CCA |
| Session | `Features/Capture/CaptureSessionController.swift` | CCA |
| SCR-OL-B | `Features/Capture/InnerCaptureView.swift` | CCA |
| SCR-OL-A | `Features/Capture/PermissionPrimerView.swift` | CCA |
| SCR-OL-E | `Features/Capture/CaptureDeniedView.swift` | CCA |
| SCR-OL-C root | `Features/CoachOverlay/SubjectCoachView.swift` | CCA |
| Tip plate | `Features/CoachOverlay/TipPlateView.swift` | CCA |
| Oval | `Features/CoachOverlay/GuideOvalView.swift` | CCA |
| Countdown | `Features/CoachOverlay/CountdownView.swift` | CCA |
| SCR-OL-D | `Features/Paywall/PaywallHostView.swift` | RC |
| Purchases | `Monetization/PurchasesConfig.swift` | RC |
| Entitlements | `Monetization/Entitlements.swift` | RC |
| Tokens / motion | `DesignSystem/Tokens.swift` · `Motion.swift` | ASSETS |
| Strings | `Resources/Localizable.strings` | COPY |
| Cutover flag | `Shared/CutoverFlag.swift` | SHELL |

Forbidden new folders: `Agents/`, `Chat/`, `Interview/`, `HingeBeat/`, `PoseAgent/`, `Backend/`, `Marketing/`.

---

## 11.8 Acceptance suite — TC-OL-* (primary Outer Lens)

**DECISION (Claude review P0):** Integrate / DoD / `DEMO-LAST-PASS.md` tick **§15** IDs (`TC-C*`, `TC-R*`, `TC-P*`, Always suite). `TC-OL-*` below are **product-local expansions** for the CCA lane — useful checklists, **not** a substitute Always suite. Prefer the “Maps” column when reporting gate status.

Win slice requires **all Always (TC-S / TC-R / TC-D / TC-I from §15)** plus the following **TC-OL-*** rows when `CUTOVER.flag` is absent/empty/`false`. Map to §15 TC-C0x / TC-R0x where noted.

### 11.8.0 Crosswalk — TC-OL-* → canonical TC-* (contract §6 / §15)

**SOFT FAIL-3 fix** (COMPLETENESS-AUDIT): `TC-OL-*` are product-local checklists only. Gate / DoD / `DEMO-LAST-PASS.md` tick **canonical** contract §6 IDs — never `TC-OL-*` as substitutes. **Do not invent** TC-C06+ / TC-P04+ — those IDs are not in the contract.

**Always suite (both modes):** TC-S01–S04 · TC-R01–R05 · TC-D01–D02 · TC-I01.  
**Primary Outer Lens also:** TC-C01–C05 · TC-P01 · TC-P03 (+ Win visual / Win motion from contract §6B).

| TC-OL (local) | Canonical TC-* (contract §6 only) | Notes |
|---------------|-----------------------------------|-------|
| **TC-OL-A01** | *(local)* → supports **TC-C05** | Primer skip if authorized |
| **TC-OL-A02** | **TC-C05** | Continue → one system alert |
| **TC-OL-A03** | *(local)* → supports **TC-C05** | Coach-specific plist string |
| **TC-OL-A04** | *(local / scope)* | No mic · photo-only — non-goal guard |
| **TC-OL-B01** | **TC-C02** | Inner shutter + preview / honest black |
| **TC-OL-B02** | *(local)* → supports **TC-C03** | Subject toggle ↔ availability |
| **TC-OL-B03** | *(local)* → supports **TC-C01** | Flip once; tip still legible |
| **TC-OL-B04** | *(local)* → supports **TC-D01** | Settings Simulate ×3 |
| **TC-OL-B05** | Win visual | Brand Outer Lens on B |
| **TC-OL-C01** | **TC-C01** | Outer tip readable ≤30s · zero narration |
| **TC-OL-C02** | *(local)* → **TC-C01** detail | One tip · ≥28pt · ≤8 words |
| **TC-OL-C03** | **TC-C03** / GATE-CCA | CCA host + availability wired |
| **TC-OL-C04** | **TC-C01** (tip-only OK) | Tip-only if preview black |
| **TC-OL-C05** | Win motion **M1** | Tip settle |
| **TC-OL-C06** | Win motion **M2** (if scripted) | T3 countdown once / Simulate |
| **TC-OL-C07** | **TC-C01** | Vision miss → static T1 |
| **TC-OL-C08** | Win motion **M1** + **M3** | M3 on Pro unlock |
| **TC-OL-D01** | **TC-R02** (inner-only) | Paywall never on outer |
| **TC-OL-D02** | **TC-R03** | Successful Purchase → `pro` |
| **TC-OL-D03** | **TC-C04** · **TC-R04** | Outer T2 oval after purchase |
| **TC-OL-D04** | **TC-R05** | Cancel keeps T1 |
| **TC-OL-D05** | **TC-P03** | Matt line spoken |
| **TC-OL-E01** | **TC-C05** | Denied → Open Settings |
| **TC-OL-E02** | **TC-C03** | Unavailable → inner still shoots |
| **TC-OL-E03** | *(local)* → **TC-C01** recovery | Simulate tip |
| **TC-OL-E04** | *(local)* → **TC-C04** recovery | Simulate Pro (labeled) |
| **TC-OL-E05** | *(local)* → **TC-D02** support | Verbal CCA flake line |
| **TC-OL-P01** | **TC-P01** | Brad spoken 0:00–0:10 |
| **TC-OL-P02** | Win visual | Film Tool charcoal + amber Pro |
| **TC-OL-P03** | Contract §2 kill list | No banned nouns / AI-slop |

**DECISION:** Keep `TC-OL-*` rows below as CCA lane detail. Report gate status with the Canonical column only.

### 11.8.1 Primer & permissions

| TC | Assertion | Evidence | Maps |
|----|-----------|----------|------|
| **TC-OL-A01** | Primer skipped if authorized | Manual | — |
| **TC-OL-A02** | Continue → one system alert | Manual | TC-C05 |
| **TC-OL-A03** | Plist camera string coach-specific | Info.plist review | — |
| **TC-OL-A04** | No mic prompt in photo-only | Manual | — |

### 11.8.2 Capture shell

| TC | Assertion | Evidence | Maps |
|----|-----------|----------|------|
| **TC-OL-B01** | Inner shutter + preview or honest black | Demo 0:10–0:40 | TC-C02 |
| **TC-OL-B02** | Subject toggle ↔ availability | Sim toggle | — |
| **TC-OL-B03** | Flip once; tip legible | Demo 0:40–0:55 | — |
| **TC-OL-B04** | Settings has Simulate ×3 | Settings sheet | — |
| **TC-OL-B05** | Brand Outer Lens visible on B | Screenshot | Win visual |

### 11.8.3 Subject coach / CCA

| TC | Assertion | Evidence | Maps |
|----|-----------|----------|------|
| **TC-OL-C01** | Outer tip readable ≤30s zero narration | Demo 0:15–0:45 | TC-C01 |
| **TC-OL-C02** | One tip only · ≥28pt · ≤8 words | Visual QA | — |
| **TC-OL-C03** | CCA host compiles; availability wired | GATE-CCA | — |
| **TC-OL-C04** | Tip-only fallback works if preview black | Rehearsal | — |
| **TC-OL-C05** | M1 on tip change | Visual | Win motion |
| **TC-OL-C06** | T3 countdown once (or Simulate) | Demo | — |

### 11.8.4 Paywall / Pro

| TC | Assertion | Evidence | Maps |
|----|-----------|----------|------|
| **TC-OL-D01** | Paywall inner only | Code + demo | — |
| **TC-OL-D02** | Successful Purchase → `pro` | Test Store | TC-R03 |
| **TC-OL-D03** | Outer T2 oval after purchase | Demo 1:05–1:20 | TC-C04 · TC-R04 |
| **TC-OL-D04** | Cancel keeps T1 | Once | TC-R05 |
| **TC-OL-D05** | Matt line spoken | DEMO-SCRIPT | TC-P03 |

### 11.8.5 Errors / Simulate

| TC | Assertion | Evidence | Maps |
|----|-----------|----------|------|
| **TC-OL-E01** | Denied → Settings | Manual | TC-C05 |
| **TC-OL-E02** | Unavailable → inner shoots | Manual | TC-C03 |
| **TC-OL-E03** | Simulate tip recovery | Rehearsal | — |
| **TC-OL-E04** | Simulate Pro recovery | Rehearsal | — |
| **TC-OL-E05** | Verbal CCA flake line memorized | O | — |

### 11.8.6 Pitch / brand

| TC | Assertion | Evidence | Maps |
|----|-----------|----------|------|
| **TC-OL-P01** | Brad spoken 0:00–0:10 | DEMO-SCRIPT | TC-P01 |
| **TC-OL-P02** | Film Tool charcoal + amber Pro | Tokens | Win visual |
| **TC-OL-P03** | No banned AI-slop / kill-list nouns | Scope guard | Contract §2 |

### 11.8.7 Explicit non-goals (do not block done)

Vision/pose ML accuracy · real second-face without Simulate · ASC restore · multiple tip packs beyond T1–T3 chrome · tabletop Arrangement polish · Perfect Liquid Glass on every control · gallery picker · video REC.

---

## 11.9 Hour-one / GATE-CCA (product implications)

At **12:15** Orchestrator writes `docs-runtime/GATE-CCA.md`.

**GREEN** if: capture UI on inner · session live **or** black+tips · CCA compiles with availability wired · **either** outer T1 presents **or** tip-only/Simulate still sells subject coach.

**RED** → `CUTOVER.flag = frost` · stop Capture/CoachOverlay feature work · this chapter’s SCR-OL-* leave as stubs · build SCR-FD-* per §12. **Do not** half-build both.

---

## 11.10 Source index

| Source | Use in this chapter |
|--------|---------------------|
| `internal/research-outer-lens.md` | Slice, states, CCA, permissions, tips, cutover |
| `internal/design-research-outer-lens-ui.md` | Wireframes, T1–T3, paywall beat, Film Tool |
| `docs/design-direction.md` | Tokens, SCR map, M1–M3, P1–P3, glass |
| `docs/ios-craft-addendum.md` | Glass allowed/forbidden |
| `docs/bible-single-theme-contract.md` | IDs, tree, TCs, kill list |
| `docs/outer-lens-3h-build-plan.md` | Scope ON/OFF, gate, DoD |
| Apple CCA + CameraCaptureAccessory docs | Host contract |
| Moments / Shot Caller / PrivacyScreen / Halide | Pattern remix only — never fork |

**Companion flows:** [`docs/bible/11b-outer-lens-flows.md`](./11b-outer-lens-flows.md)

---

*End §11. Ship SCR-OL-A→E + T1/T2/T3 + TC-OL-*. One climax. Film Tool only.*


---

## 11.11 Appendix — per-control hit targets & accessibility

### 11.11.1 Hit targets (inner SCR-OL-B)

| Control | Min visual | Min hit | Spacing |
|---------|-----------:|--------:|---------|
| Close | 24pt symbol | 48×48 | ≥8pt from edge |
| Subject toggle | 44pt wide pill | 48pt tall | Contiguous top rail |
| Tip pack | 44pt+ | 48pt | Contiguous |
| Flip | 48pt | 56pt pad | ≥16pt from shutter |
| Shutter | 80pt | 80pt | Center bottom |
| Pro CTA | hug text + 16pt pad | 44pt tall | Trailing · ≥16pt from shutter |

VoiceOver labels (COPY): match string keys; Pro CTA becomes `Pro coaching, button` → after unlock `Pro, unlocked`.

### 11.11.2 Dynamic Type

| Role | Behavior |
|------|----------|
| Outer tip | Prefer fixed ≥28pt for room test; if Dynamic Type huge, still one line truncate with `…` — never wrap to 3 lines on outer |
| Inner captions | Allow Body scaling |
| Countdown | Fixed large band 120–180pt |

### 11.11.3 Reduce Motion

| Motion | Fallback |
|--------|----------|
| M1 | Opacity crossfade 120ms or instant |
| M2 | Instant numeral replace |
| M3 | Instant oval opacity 1 + tip swap |
| P1–P3 | Instant scale 1 |

### 11.11.4 Color contrast

| Pair | Rule |
|------|------|
| Tip `--ink` on `--panel` / scrim ≥0.55 | WCAG-ish large text OK at distance |
| Brand muted 62% on black | Whisper — not primary reading |
| Accent oval on skin/preview | Stroke only · 2–3pt · not fill |

---

## 11.12 Appendix — string catalog (complete dump for Localizable.strings)

```text
/* Brand */
"brand.name" = "Outer Lens";

/* SCR-OL-A */
"perm.title" = "Subject coaching needs the camera";
"perm.body" = "Outer Lens shows framing tips on the outer display while you shoot from the inner. Photos stay on this device.";
"perm.cta" = "Continue to Camera";
"perm.notNow" = "Not now";

/* SCR-OL-B */
"capture.subjectToggle" = "Subject screen";
"capture.tipPack.free" = "Free";
"capture.tipPack.kids" = "Kids";
"capture.tipPack.portrait" = "Portrait";
"capture.proCTA" = "Pro coaching";
"capture.proActive" = "Pro";
"capture.starting" = "Getting ready…";
"capture.banner.accessoryUnavailable" = "Subject screen unavailable on this device";
"capture.banner.noDevices" = "Camera preview unavailable — tips still work";
"capture.settings.title" = "Settings";
"capture.settings.simulateTip" = "Simulate tip";
"capture.settings.simulatePro" = "Simulate Pro unlock";
"capture.settings.simulateCountdown" = "Simulate countdown";
"capture.settings.tipInterval" = "Tip cycle";

/* Tips free */
"tip.free.1" = "Chin up · eyes to the lens";
"tip.free.2" = "Fill the frame — step closer";
"tip.free.3" = "Soft smile · shoulders square";
"tip.free.4" = "Kids: both faces in the oval";

/* Tips Pro Kids */
"tip.kids.1" = "Kneel to their eye line";
"tip.kids.2" = "Catch the laugh — wait";
"tip.kids.3" = "Two kids: squeeze in";

/* Tips Pro Portrait */
"tip.portrait.1" = "Drop the near shoulder";
"tip.portrait.2" = "Chin over toes";
"tip.portrait.3" = "Leave headroom";

/* SCR-OL-D */
"paywall.benefit" = "Pose overlays on the subject screen";

/* SCR-OL-E */
"error.denied.title" = "Camera access needed";
"error.denied.body" = "Enable camera in Settings to shoot and coach on the outer display.";
"error.denied.openSettings" = "Open Settings";
"error.denied.notNow" = "Not now";
"error.restricted.title" = "Camera unavailable";
"error.restricted.body" = "Camera is restricted on this device.";
"error.sessionFailed" = "Couldn’t start the camera. Try again.";
"error.retry" = "Retry";

/* Spoken (not necessarily UI) */
"spoken.brad" = "Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.";
"spoken.matt" = "Free: outer preview. Pro: pose overlays on the outer display.";
"spoken.ccaFlake" = "Subject coach is CCA; sim can’t always light outer for camera — on device the outer faces the kid.";
```

Info.plist (not Localizable):

```text
NSCameraUsageDescription = "Outer Lens uses the camera so you can shoot from the inner display while coaching the subject on the outer.";
NSPhotoLibraryAddUsageDescription = "Outer Lens saves photos you capture to your library."; /* only if save ships */
```

---

## 11.13 Appendix — GuideOvalView geometry (Pro T2)

```text
GuideOvalView:
  aspect ≈ 3:4 portrait oval centered on outer content bounds
  inset from horizontal safe ≈ 18% width each side
  vertical center biased slightly above geometric mid (face region)
  stroke: --accent #E8A838 · lineWidth 2.5pt · opacity 0.85
  fill: none (never solid HUD)
  optional thirds: hairline white @ 18% opacity — cut first if noisy
  appear: opacity 0→1 over --dur-pro-bloom 360ms with M3
```

Shoulder guide (alt Pro chrome if oval crowded): two short accent ticks at shoulder line — still silent geometry · no labels.

---

## 11.14 Appendix — CaptureSessionController detailed pseudocode

```text
final class CaptureSessionController {
  private let session = AVCaptureSession()
  private let queue = DispatchQueue(label: "outerlens.capture.session")
  private var videoDevice: AVCaptureDevice?
  private var videoInput: AVCaptureDeviceInput?
  private var photoOutput = AVCapturePhotoOutput()
  private var previewLayer: AVCaptureVideoPreviewLayer?
  private var rotationCoordinator: Any? // AVCaptureDevice.RotationCoordinator when available

  func attachPreview(to view: UIView) {
    let layer = AVCaptureVideoPreviewLayer(session: session)
    layer.videoGravity = .resizeAspectFill
    view.layer.addSublayer(layer)
    previewLayer = layer
  }

  func start() {
    queue.async { [weak self] in
      guard let self else { return }
      MainActor.setSession(.starting)
      do {
        try self.configure()
        self.session.startRunning()
        MainActor.setSession(.live)
      } catch {
        MainActor.setSession(.failed(error.localizedDescription))
      }
    }
  }

  private func configure() throws {
    session.beginConfiguration()
    defer { session.commitConfiguration() }
    session.sessionPreset = .photo

    // Prefer default video device / front virtual discovery — escalate direction coordinator only if framing wrong
    let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
      ?? AVCaptureDevice.default(for: .video)
    guard let device else { throw CaptureError.noDevices }
    videoDevice = device

    let input = try AVCaptureDeviceInput(device: device)
    guard session.canAddInput(input) else { throw CaptureError.sessionFailed("input") }
    session.addInput(input)
    videoInput = input

    guard session.canAddOutput(photoOutput) else { throw CaptureError.sessionFailed("output") }
    session.addOutput(photoOutput)

    // RotationCoordinator for upright preview — bible checklist item
    // Mirroring: if position == .front { previewLayer?.connection?.isVideoMirrored = true }
  }

  func flip() {
    queue.async { /* remove input; add opposite position; remirror preview; tip labels untouched */ }
  }

  func capturePhoto(delegate: AVCapturePhotoCaptureDelegate) {
    queue.async {
      let settings = AVCapturePhotoSettings()
      self.photoOutput.capturePhoto(with: settings, delegate: delegate)
    }
  }

  func stop() {
    queue.async { self.session.stopRunning(); MainActor.setSession(.idle) }
  }
}
```

**Photo-only:** no audio input · no movie output · no REC pill unless video later (default cut).

---

## 11.15 Appendix — Entitlement observe → tipStyle

```text
// Integrator merge concern — CoachOverlay observes Monetization.EntitlementState
func syncTipStyle(model: OuterLensModel, entitlement: EntitlementState) {
  model.isPro = entitlement.isPro
  if model.countdownValue != nil {
    model.tipStyle = .t3Countdown
  } else if model.isPro || model.simulateFlags.forceProChrome {
    if model.tipStyle != .t2Guide {
      model.tipStyle = .t2Guide
      playM3()
    }
  } else {
    model.tipStyle = .t1Line
  }
}
```

---

## 11.16 Appendix — Settings sheet wireframe

```text
┌─ Settings (system glass sheet) ───────────────────────────────┐
│  Settings                                                      │
│                                                                │
│  Tip cycle                    [ 6s ▾ ]                         │
│                                                                │
│  DEMO RECOVERY                                                 │
│  [ Simulate tip          ]                                     │
│  [ Simulate Pro unlock   ]                                     │
│  [ Simulate countdown    ]                                     │
│                                                                │
│  Subject screen     (mirror of toggle if available)            │
│                                                                │
│  Done                                                          │
└────────────────────────────────────────────────────────────────┘
```

No analytics toggles · no account · no cloud · no FM tip generator.

---

## 11.17 Appendix — Paywall editor / RC dashboard expectations (human)

Pre-doors checklist for `docs-runtime/RC-IDs.md`:

| Field | Example / rule |
|-------|----------------|
| Test Store API key | starts with `test_` |
| Entitlement | `pro` exact |
| Product | e.g. `pro_monthly` Test Store |
| Offering | Current / Default with package |
| Paywall | Published on that offering |
| Screenshot | offering → packages → `pro` attachment |

Saturday agents read IDs only — never invent.

---

## 11.18 Appendix — Anti-patterns checklist (scope guard)

Before merge, nack if any present:

- [ ] Paywall UI on outer  
- [ ] More than one primary tip on outer  
- [ ] Skeleton HUD on free  
- [ ] Purple/indigo or cream+terracotta theme  
- [ ] Glass tip text over face  
- [ ] Glass shutter  
- [ ] Video/mic permission  
- [ ] Multipeer / Watch  
- [ ] Hinge-driven layout  
- [ ] PoseAgent / HingeBeat / interview nouns  
- [ ] Second climax API in one demo path  
- [ ] Forked Moments/PrivacyScreen/Shot Caller sources  

---

## 11.19 Appendix — Lane prompt paste (CCA)

```text
You are LANE-CCA for Duo Sat Outer Lens.
Read bible §00 invariants + docs/bible/11-outer-lens-product.md + 11b flows.
Owned: Duo/CameraCaptureAccessoryHost.swift, Features/Capture/**, Features/CoachOverlay/**
Forbidden: Monetization/**, Features/Frost/**, App/** (except host hook via Integrator)
Done when: TC-OL-A* B* C* E02/E03 and contract TC-C01–C05.
Do not expand scope. Tips-first outer. Photo-only. Film Tool tokens.
```

---

## 11.20 Appendix — Unknowns (do not invent)

| ID | Unknown | Saturday action |
|----|---------|-----------------|
| U1 | Exact event SDK entitlement for camera companion | Ask organizers AM · tip-only if blocked |
| U2 | Does Duo sim present CCA usefully? | Probe Block B · write both scripts |
| U3 | Dual preview stability | Default tip-only |
| U4 | Judges physical Duo vs sim | Ask AM · adjust proof bar |
| U5 | RC placeholder vs real IDs | Human confirms · BLOCKED if empty at 1:45 |

---

*End of §11 appendices. Combined with §11b = primary feature bible density target.*
