---
cursor:
  subagentId: "bc-c9c3fba2-b6dd-5b92-9563-eca042193206"
chapter: "11b"
title: "Outer Lens — user flows, 90s demo mapping, hour budget"
product: "Outer Lens (Film Tool)"
status: "canonical for LANE-DEMO / Orchestrator / LANE-CCA / LANE-COPY"
constraint: "Spec only — no app/Swift sources. Pseudocode OK."
companion: "docs/bible/11-outer-lens-product.md"
inputs:
  - "docs/bible/11-outer-lens-product.md"
  - "docs/bible-single-theme-contract.md"
  - "docs/design-direction.md"
  - "docs/ios-craft-addendum.md"
  - "docs/outer-lens-3h-build-plan.md"
  - "internal/research-outer-lens.md"
compiled: "Sat Sep 26, 2026"
---

# §11b Outer Lens — screen-by-screen flows, demo seconds, hour budget

**Product:** Outer Lens (Coach) · **Visual theme:** Film Tool — charcoal canvas `#050505`, amber accent `#E8A838`, SF Rounded tip ≥28pt, solid outer tip plate.  
**Brad (frozen):** Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.  
**Matt (frozen):** Free: outer preview. Pro: pose overlays on the outer display.  
**Climax (say aloud):** Outer tip appears on the subject face of the Duo via `CameraCaptureAccessory`. Everything else serves that. RevenueCat purchase is the **monetization beat**, not a second Duo climax.  
**Flag:** `docs-runtime/CUTOVER.flag = false`. If RED at 12:15 → abandon these flows; run FrostDuo §12.

**Companion screen specs:** [`11-outer-lens-product.md`](./11-outer-lens-product.md) (SCR-OL-A…E, T1/T2/T3, TC-OL-*, CCA host).  
**Rule:** Every step names a **SCR-ID**, a **Film Tool token or chrome beat**, a **model field**, a **demo second**, or a **milestone M#**.

---

## 11b.0 How to read this chapter

| Section | Use when |
|---------|----------|
| **11b.1** Screen-by-screen SCR-OL-A…E | Implementing or QA’ing one surface |
| **11b.2** Load-bearing chain (CCA tip → RC → other-pane T2) | Demo climax + Matt beat |
| **11b.3** Empty / loading / error / Simulate | Recovery & gate honesty |
| **11b.4** Flow ID catalog F-OL-01…22 | Cross-links & edge cases |
| **11b.5** 90s / 60s demo mapping | Rehearsal |
| **11b.6** Hour budget M0–M8 / Blocks A–H | Saturday clock |
| **11b.7** State machine + DoD | Freeze checklist |

Film Tool visual invariants (from `design-direction.md` + theme contract) apply on **every** SCR below:

| Token | Value | Flow consequence |
|-------|-------|------------------|
| `--canvas` | `#050505` | Inner preview letterbox + outer stage always charcoal — never cream, never purple gradient |
| `--panel` / `--scrim` | `#1C1C1E` / black@0.55 | Outer tip = **solid plate**, not Liquid Glass over faces |
| `--accent` | `#E8A838` Amber film | Pro CTA tint · T2 oval stroke · M3 unlock flash **only** |
| `--ink` | `#FFFFFF` | Tip text · shutter ring |
| `--success` | `#5CCC8C` | Post-purchase check on inner Pro pill |
| Glass | regular, **inner rails only** | Flip / Subject / tip pack / Pro CTA; shutter stays **solid** |
| Motions | M1 tip settle · M2 countdown · M3 Pro bloom · P1–P3 press | Reduce Motion → crossfade/instant |

---

## 11b.1 Screen-by-screen flows (SCR-OL-A…E)

### 11b.1.A — SCR-OL-A Permission primer (inner)

**Path:** `Features/Capture/PermissionPrimerView.swift`  
**Who:** Photographer · **Demo:** 0:00–0:10 (skip if already authorized)  
**Film Tool:** Charcoal full-bleed `#050505` · brand **Outer Lens** hero-level (not nav-only) · no inset hero cards · one CTA group.

#### Entry

| From | Condition |
|------|-----------|
| App launch → capture slot | `CutoverFlag == false` AND `auth == .notDetermined` |
| User returned from Settings still undetermined | Rare |

**Skip:** If `auth == .authorized` → go straight to SCR-OL-B (F-OL-16). If denied/restricted → SCR-OL-E.

#### Step-by-step

| # | Actor | What happens | Model | Visual (Film Tool) |
|--:|-------|--------------|-------|--------------------|
| 1 | App | Present primer | `auth = notDetermined` | Canvas `#050505` |
| 2 | User | Sees wordmark **Outer Lens** + `camera.fill` | — | Brand Medium 13–15pt muted **or** Title-adjacent; brand test: remove chrome, still Outer Lens |
| 3 | User | Reads title `Subject coaching needs the camera` + body (outer coaching, photos on-device) | — | Title2 Bold white · Body `--ink-muted` ≤3 lines |
| 4 | User | Taps `Continue to Camera` | `auth = requesting` | Primary CTA; spinner on button; secondary `Not now` muted |
| 5 | System | Camera permission alert | — | System UI (not styled) |
| 6a | User | Allow | `auth = authorized` | Instant dismiss |
| 6b | User | Don’t Allow | `auth = denied` | Route SCR-OL-E |
| 7 | App | After Allow → SCR-OL-B · `session.starting` | — | No tip theater yet |

#### Exit criteria

- TC-OL-A01: primer never if authorized  
- TC-OL-A02: one system alert per notDetermined  
- TC-OL-A04: **no mic** prompt (photo-only)  
- Info.plist `NSCameraUsageDescription` coach-specific (see §11 string catalog)

#### Copy (spoken optional)

Brad may start over A or B: parents / framing / Duo outer coach / free tip / Pro overlays.

---

### 11b.1.B — SCR-OL-B Capture shell (inner)

**Path:** `Features/Capture/InnerCaptureView.swift` + `CaptureSessionController.swift`  
**Who:** Photographer · **Demo:** 0:10–0:40 (+ flip 0:40–0:55 · Pro CTA 0:50)  
**Film Tool:** Full-bleed live preview on charcoal · top glass pills · solid **◎ shutter ~80pt** · trailing **Pro coaching** amber-tint glass · brand whisper.

#### Entry

| From | Condition |
|------|-----------|
| SCR-OL-A success | `auth.authorized` |
| Cold launch already authorized | Skip A |
| Settings re-enable (F-OL-17) | Was denied, now authorized |

#### Subflow B0 — Loading (`session.starting`)

| # | UI | Rules |
|--:|----|-------|
| 1 | Center spinner on `#050505` | Shutter **disabled** |
| 2 | Caption `Getting ready…` | `--ink-muted` |
| 3 | No tip cards pretending to coach | Outer must not claim live coaching |
| 4 | CCA may be registered but not sold as ready | Wait for `session.live` |

#### Subflow B1 — Live capture (`session.live`)

| # | Actor | Control | Action | Film Tool / motion |
|--:|-------|---------|--------|--------------------|
| 1 | App | Preview layer | Full-bleed (letterbox OK) | Content is the picture |
| 2 | App | Brand whisper | `Outer Lens` top | Never louder than outer tip |
| 3 | App | Install CCA host | `.sceneAccessory { CameraCaptureAccessory(isEnabled:) { SubjectCoachView } }.onAvailabilityChange` | See §11.3.8 |
| 4 | System | Availability | Show/hide **Subject screen** toggle | Hide if unavailable |
| 5 | User | Subject toggle ON | `isAccessoryEnabled = true` | Glass pill · P2 press |
| 6 | User | Tip pack menu | Free live; Kids/Portrait 🔒 → paywall | Lock glyph amber-adjacent, not purple |
| 7 | User | Flip | Front/back | Glass · P2 · tip labels **unmirrored** |
| 8 | User | Shutter | Photo capture | Solid white ring · **P1** scale 0.94 / 120ms · optional haptic |
| 9 | User | Pro coaching | If !isPro → SCR-OL-D | Glass + `--glass-tint-pro` amber · **P3** |
| 10 | User | Settings (gear/ellipsis) | One sheet: Simulate ×3 + tip interval | System glass sheet |

#### Subflow B2 — Capture with countdown handoff

Optional: shutter long-press or Settings → Simulate countdown → outer T3 (see C) → photo → restore tip.

#### Exit / branch table

| Condition | Next |
|-----------|------|
| Accessory presents | SCR-OL-C visible to subject |
| User taps Pro / locked pack | SCR-OL-D |
| `onAvailabilityChange(false)` | Banner on B · stay on B (F-OL-10) |
| Auth denied mid-flight | SCR-OL-E |
| No devices | Black preview + inner tip overlay · Pro still works |
| Close | Unregister CCA · stop session (F-OL-15) |

#### Acceptance hooks

TC-OL-B01…B06 · TC-C02 · brand visible · Subject toggle ↔ availability.

---

### 11b.1.C — SCR-OL-C Subject coach (outer via CCA)

**Path:** `Features/CoachOverlay/SubjectCoachView.swift` (+ TipPlate / GuideOval / Countdown)  
**Host:** `Duo/CameraCaptureAccessoryHost.swift`  
**Who:** Subject (person in front of camera) · **Demo:** 0:15–0:45 T1 · 1:05–1:20 T2  
**Film Tool:** Charcoal stage · brand whisper · **one** tip ≥28pt SF Rounded Semibold on solid plate · Pro amber oval · no shutter / no paywall / no settings on outer.

#### Entry

| Required | Notes |
|----------|-------|
| Capture UI on **inner** | Apple contract |
| Active capture session (or honest tip-only story) | Gate-CCA |
| `isAccessoryEnabled` + system available | Presented is system-owned |
| Same `OuterLensModel` as inner | No frame messaging protocol |

#### Subflow C1 — Free T1 (climax)

| # | Actor | What | Visual | Motion | Demo |
|--:|-------|------|--------|--------|------|
| 1 | System | Presents accessory | Outer lights | — | 0:15 |
| 2 | App | `tipStyle = t1` · `tip.free.1` | Plate `#1C1C1E` + scrim ≥0.55 · white text ≤8 words | **M1** settle 220ms rise 8–12pt | 0:16 |
| 3 | Judge | Reads at 2–3 m | **Zero narration** if readable | — | 0:15–0:30 |
| 4 | Timer/shutter | Cycle free tips | Still one tip | M1 each change | polish |

**Frozen free strings:** `Chin up · eyes to the lens` · `Fill the frame — step closer` · `Soft smile · shoulders square` (+ optional kids oval line).

**Fallback:** If dual preview black → **tip-only fullscreen** (still charcoal + tip plate). Never blank outer.

#### Subflow C2 — Countdown T3

| # | What | Visual | Motion | Demo |
|--:|------|--------|--------|------|
| 1 | `countdownValue = 3` | Tip dims; huge numeral ~140pt | **M2** | 0:30–0:34 once |
| 2 | 2 · 1 | numericText + scale | M2 | |
| 3 | Capture · clear countdown | Restore T1 or T2 | M1 | |

#### Subflow C3 — Pro T2 after entitlement (other-pane proof)

| # | Trigger | Outer visual | Motion | Demo |
|--:|---------|--------------|--------|------|
| 1 | `isPro` rises true (from D) **or** Simulate Pro | Amber `#E8A838` oval stroke fades in · tip accent flash · optional Pro pack string | **M3** 360ms bloom | 1:05–1:20 |
| 2 | Inner already shows check | Outer carries the **value** judges paid for | — | |

**Hard rules:** Exactly one primary tip · tip labels never mirrored · no paywall on outer · skeleton HUD not on free · glass forbidden on tip text.

#### CCA availability choreography

```text
onAvailabilityChange(available):
  model.isAccessoryAvailable = available
  if !available: hide Subject toggle on B; accessory = unavailable; inner still shoots
  else: show toggle reflecting isAccessoryEnabled
```

Sim flake → Simulate tip + spoken `demo.verbal.ccaFlake` (F-OL-14).

#### Acceptance hooks

TC-OL-C01…C08 · TC-C01 · TC-C04 · room test 2–3 m.

---

### 11b.1.D — SCR-OL-D Paywall (inner only)

**Path:** `Features/Paywall/PaywallHostView.swift`  
**Who:** Photographer · **Demo:** 0:50–1:05 (purchase) → triggers C T2 at 1:05–1:20  
**Film Tool:** System Liquid Glass sheet over charcoal capture · benefit one sentence · amber only as product accent in mock if present · **never** purple glow paywall · **never** on outer.

#### Entry

| From | Trigger |
|------|---------|
| SCR-OL-B Pro coaching CTA | `!isPro` |
| Tip pack Kids / Portrait | Locked while `!isPro` |
| Already Pro | Do **not** present; ensure T2 |

#### Step-by-step (load-bearing monetization)

| # | Actor | What | Model | Pane | Demo |
|--:|-------|------|-------|------|------|
| 1 | Outer | Still T1 (climax already shown) | `isPro=false` | C | 0:45 |
| 2 | User | Taps Pro coaching | `showPaywall=true` | B | 0:50 |
| 3 | App | RevenueCatUI sheet | — | **D on inner** | 0:52 |
| 4 | Outer | Keep T1 · optional lock mark | — | C | 0:52 |
| 5 | O | Speaks Matt | — | — | 0:55 |
| 6 | User | Package → Test Store | — | D | 0:58–1:00 |
| 7 | User | **Successful Purchase** | `entitlements["pro"].isActive` | D | 1:02 |
| 8 | App | `EntitlementState.isPro=true` · dismiss | `isPro=true` | B | 1:04 |
| 9 | Inner | CTA → amber check / `Pro` | P3 complete | B | 1:05 |
| 10 | Outer | T1→T2 oval bloom | M3 · `--accent` stroke | **C other pane** | 1:05–1:10 |

**Timing budget (Block E):** tip visible → Pro ≤5s → paywall ≤10s → Successful Purchase ≤10s → oval ≤5s.

#### Cancel / Fail

| Result | Outer | Inner | TC |
|--------|-------|-------|-----|
| Cancel | Stays T1 | CTA unchanged | TC-OL-D04 · TC-R05 |
| Failed Purchase | Stays T1 | CTA unchanged | same |
| Offerings nil | Error copy | Fix `RC-IDs.md` / dashboard — do not invent IDs | Block E fail |

#### Copy

- UI benefit: `Pose overlays on the subject screen`  
- Spoken Matt: `Free: outer preview. Pro: pose overlays on the outer display.`

#### Acceptance hooks

TC-OL-D01…D05 · TC-R02…R05 · TC-C04 · TC-P03.

---

### 11b.1.E — SCR-OL-E Empty / denied / unavailable

**Path:** `Features/Capture/CaptureDeniedView.swift` + banners on B  
**Who:** Photographer · **Demo:** only if forced; rehearse once  
**Film Tool:** Charcoal · danger red for denied icon only · no tip theater · no amber “success” chrome on error.

#### E1 — Camera denied / restricted (full screen)

| # | UI | Action |
|--:|----|--------|
| 1 | `camera.slash` / raised hand · `--danger` | — |
| 2 | Title `Camera access needed` | — |
| 3 | Body mentions outer coaching | Brad alignment |
| 4 | `Open Settings` primary | `UIApplication.openSettingsURLString` |
| 5 | `Not now` | Idle without claiming coach |
| 6 | On return active | Re-check auth → B if allowed (F-OL-17) |

#### E2 — Accessory unavailable (banner on B, not full replace)

| # | UI | Rule |
|--:|----|------|
| 1 | Banner `Subject screen unavailable on this device` | Hide Subject toggle |
| 2 | Shutter + Pro CTA remain | **RC beat must survive** |
| 3 | Optional inner tip overlay | Honest coach story |
| 4 | Spoken flake line if demoing sim | See script cards |

#### E3 — Empty / no session first open

| State | UI |
|-------|-----|
| Before primer | Prefer A, not a fake live shell |
| Idle after Not now | Black stage + optional Start — no coaching tips |

#### E4 — No devices / black preview

| # | UI | RC |
|--:|----|-----|
| 1 | Black frame + banner tips still work | — |
| 2 | Inner static tip cards / Simulate tip | — |
| 3 | Pro CTA opens D | **Must not block** |

#### E5 — Session failed

Banner + `Retry` · shutter off · never show tips as if live.

#### Acceptance hooks

TC-OL-E01…E05 · TC-C03 · TC-C05.

---

## 11b.2 Load-bearing chain — CCA outer tip → RC unlock on other pane

This is the single story judges must feel. Map to SCR + Film Tool beats:

```text
[Inner B live charcoal preview]
        │
        │  Subject toggle / system presents
        ▼
[Outer C · T1 tip plate on charcoal · M1]     ← Duo climax (≤30s, zero narration)
        │
        │  Photographer taps Pro coaching (amber tint)
        ▼
[Inner D · RevenueCatUI sheet]                ← monetization (paywall NEVER on outer)
        │
        │  Test Store Successful Purchase → entitlement pro
        ▼
[Inner B · Pro check --success]  +  [Outer C · T2 amber oval M3]   ← other-pane proof
```

### Why Film Tool matters in this chain

1. **Charcoal continuity** across B and C makes the dual-display read as one craft camera, not two apps.  
2. **Amber appears only at Pro** — free T1 is white-on-panel; paying paints the **other** pane with `#E8A838` geometry. That color shift is the Matt proof.  
3. **Solid outer tip** (not glass) keeps the climax readable at 2–3 m under room light.  
4. **Glass stays on inner controls** so the photographer’s rail feels iOS 26 craft without washing the subject’s face.

### Pseudocode observe bridge (Integrator merge)

```text
on EntitlementState.isPro false → true:
  model.isPro = true
  play P3 on Pro CTA (inner)
  model.tipStyle = .t2Guide
  play M3 on SCR-OL-C (outer oval opacity 0→1, accent flash)
```

If RC fails mid-demo: Simulate Pro (flagged recovery) still shows T2 chrome; speak free-vs-Pro intent honestly.

---

## 11b.3 Empty / loading / error / Simulate matrix

| State ID | Inner (Film Tool) | Outer | User recovery | Blocks RC? |
|----------|-------------------|-------|---------------|------------|
| Empty first open | Primer A or black Start | Not presented | Continue | No |
| Loading `session.starting` | Spinner on `#050505` · shutter off | No coaching claim | Wait / Retry | Soft |
| Live | Preview + glass rails + solid shutter | T1 tip | — | No |
| Denied | SCR-OL-E danger | Hidden | Open Settings | Capture yes |
| Restricted | SCR-OL-E | Hidden | Cannot fix in-app | Capture yes |
| Accessory unavailable | Banner · toggle hidden | N/A | Verbal device line | **No** |
| No devices | Black + tip cards | Tip-only if any | Simulate tip | **No** |
| Session failed | Error + Retry | None | Retry | Soft |
| Vision miss (if any) | Unchanged | T1 fallback string | — | No |
| Simulate tip | Settings | Force tip cycle + M1 | Demo flake | No |
| Simulate Pro | Settings | Force T2 + M3 | Demo flake | No |
| Simulate countdown | Settings | T3 then flash | Demo flake | No |
| Paywall cancel | Back to B | Stay T1 | Re-tap Pro | No |

**Simulate sheet (must ship):** one Settings sheet on B — `Simulate tip` · `Simulate Pro unlock` · `Simulate countdown` · tip cycle interval. Pattern remix from PrivacyScreen Simulate Threat — **not** a fork.

---

## 11b.4 Flow ID catalog (cross-reference)

| Flow ID | Name | Primary SCR | Demo |
|---------|------|-------------|------|
| **F-OL-01** | Cold start → grant → live | A→B | 0:00–0:40 |
| **F-OL-02** | Outer T1 appears | C | 0:15–0:45 |
| **F-OL-03** | Tip cycle | C | polish |
| **F-OL-04** | Countdown T3 → shutter | C→B | 0:30–0:45 |
| **F-OL-05** | Flip · tip stays | B+C | 0:40–0:55 |
| **F-OL-06** | Pro → purchase → T2 bloom | B→D→C | 0:50–1:20 |
| **F-OL-07** | Locked pack → paywall | B→D | alt |
| **F-OL-08** | Cancel/Fail purchase | D | once |
| **F-OL-09** | Subject available/enabled | B | gate |
| **F-OL-10** | Accessory unavailable | B banner | recovery |
| **F-OL-11** | Denied → Settings | E | recovery |
| **F-OL-12** | No devices / black | B | sim |
| **F-OL-13** | Session failed → Retry | B | recovery |
| **F-OL-14** | Simulate tip/Pro/countdown | B Settings→C | flake |
| **F-OL-15** | Leave capture · unregister | B | hygiene |
| **F-OL-16** | Skip primer if authorized | B | fast demo |
| **F-OL-17** | Re-check after Settings | E→B | recovery |
| **F-OL-18** | GATE-CCA GREEN | meta | 12:15 |
| **F-OL-19** | GATE-CCA RED cutover | meta | 12:15 |
| **F-OL-20** | 90s composite | A/B/C/D | rehearsal |
| **F-OL-21** | 60s backup | B/C/D | behind |
| **F-OL-22** | Who-pays close | pitch | 1:15–1:30 |

### F-OL-01 detail (cold start)

1. Launch · Cutover false · capture slot.  
2. Auth branch → A / B / E.  
3. A Continue → system alert → Allow.  
4. B `session.starting` spinner on charcoal.  
5. B `session.live` · preview · CCA host · availability.  
Fail → F-OL-11/12/13.

### F-OL-02 detail (outer tip)

1. B live · Subject ON if available.  
2. System may present C.  
3. T1 `tip.free.1` · M1 · room test.  
4. If never presents → F-OL-14 Simulate tip + flake line.

### F-OL-06 detail (RC other pane) — see §11b.2 table.

### F-OL-18 GREEN gate (12:15)

ALL (or tip-only honest story): inner capture live or black+tips · CCA compiles + availability wired · outer T1 **or** Simulate sells subject coach · toggle reflects availability. Then stay on Outer Lens Blocks C–H.

### F-OL-19 RED cutover

Accessory never + tip-only dishonest · entitlement mystery · no tip by 12:15 · O judges not viable by 3:15 → `CUTOVER.flag=frost` · stop Capture/Coach feature work · Frost §12 · same RC muscle → vault C. **Do not half-build both.**

---

## 11b.5 90s / 60s demo mapping

### F-OL-20 — Canonical 90s (Film Tool visible)

| Sec | Beat | SCR | Film Tool tell | Motion | Spoken |
|----:|------|-----|----------------|--------|--------|
| 0–10 | Brand + Brad | A→B | Charcoal · **Outer Lens** wordmark | — | Brad |
| 10–15 | Inner live | B | Full-bleed preview · solid shutter | — | quiet |
| 15–30 | **Climax** outer tip | C | Solid tip plate ≥28pt white on panel | **M1** | **none** if readable |
| 30–40 | Countdown once | C | Huge numeral on charcoal | **M2** | optional |
| 40–55 | Flip | B+C | Tip unmirrored · still legible | P2 | quiet |
| 55–75 | Pro → purchase → bloom | D→C | Amber appears on **outer** oval | P3→**M3** | **Matt** |
| 75–90 | Who pays / ask | B+C | Hold T2 amber | — | close |

Surfaces: 3–4 (A maybe · B · C · D) — matches win-completeness bar.

### F-OL-21 — 60s backup

0–8 Brad+brand (skip A if authorized) · 8–25 outer T1 M1 (skip flip/countdown) · 25–50 purchase→M3 · 50–60 Matt+ask.

### F-OL-22 — Who-pays close (≤15s)

Who (parents) · pain (can’t see framing) · why Duo (outer faces subject) · money (Matt free/Pro) · ask.

### 90s → TC crosswalk

| Demo sec | SCR | TCs |
|----------|-----|-----|
| 0:00–0:10 | A/B | TC-OL-P01 · TC-P01 |
| 0:10–0:40 | B | TC-OL-B01 · TC-C02 |
| 0:15–0:45 | C | TC-OL-C01 · TC-C01 |
| 0:30–0:40 | C | TC-OL-C06 |
| 0:40–0:55 | B/C | TC-OL-B03 |
| 0:50–1:05 | D | TC-OL-D01 · TC-R02 |
| 1:02–1:05 | D | TC-OL-D02 · TC-R03 |
| 1:05–1:20 | C | TC-OL-D03 · TC-C04 · TC-R04 |
| flake | Settings | TC-OL-E03/E04 |
| once | D cancel | TC-OL-D04 · TC-R05 |

### Spoken script cards

**Brad:** Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.  
**Matt:** Free: outer preview. Pro: pose overlays on the outer display.  
**Flake:** Subject coach is CCA; sim can’t always light outer for camera — on device the outer faces the kid.

---

## 11b.6 Hour budget (flows ↔ clock)

Aligns with theme contract M0–M8 + `outer-lens-3h-build-plan.md` Blocks A–H. Wall **11:30→3:15**.

### Milestone ↔ flow readiness

| M# | Min | Wall | Unlocks flows |
|----|----:|------|---------------|
| M0 Toolchain | 10 | 11:30 | — |
| M1 Scaffold | 15 | 11:40 | launch |
| M2 Duo shell | 25 | 11:45 | arrangement hosts B/C |
| **M3 GATE-CCA** | 5 | **12:15** | F-OL-18 or 19 |
| M4a Vertical slice | 55 | 12:15–1:10 | F-OL-01 · 02 · 10 · 11 · 14 tip |
| M5 RC Test Store | 35 | 1:45–2:20 | F-OL-06 · 07 · 08 |
| M6 Integrate bloom | 15 | 2:15–2:45 | F-OL-06 steps → M3 amber oval |
| M7 Copy/assets | 10 | overlap | Brad/Matt · tip plate tokens |
| M8 Freeze | 10 | 3:00–3:15 | F-OL-20 ×1 |

### Block plan (GREEN)

| Block | Clock | Owner | Flows | Film Tool note |
|-------|-------|-------|-------|----------------|
| A | 11:30–11:45 | O+S | empty ⌘R | stubs only |
| B | 11:45–12:15 | D | shell + CCA + static T1 | charcoal + tip string |
| GATE | 12:15 | O | 18/19 | decide |
| C | 12:15–1:00 | D∥R | 01 · 02 · 10 · 11 · Simulate tip · RC configure | no M3 yet |
| Lunch | ~1:00 | — | compile | no new screens |
| D | 1:00–1:45 | D | tip cycle · denied · T3 | amber reserved for Pro |
| E | 1:45–2:15 | R+O | **F-OL-06** E2E | amber oval ships |
| F | 2:15–2:45 | Integrator | Entitlement→Coach · P3 · M1 · M3 | other-pane proof |
| G | 2:45–3:00 | S | brand whisper · ≥28pt · plate scrim | polish only |
| H | 3:00–3:15 | O+Q | FREEZE · 90s ×1 | no features |

### Creep → flow cuts

| Behind | Cut first | Keep |
|--------|-----------|------|
| 2:00 | T3 polish · P2 · tabletop | Tip + purchase + amber bloom |
| 2:30 | Extra Simulate buttons | One tip Simulate + Successful Purchase |
| Never | Vision to “save” CCA | Tip-only or F-OL-19 |

### Parallelism ≤3 writers

D builds A/B/C/E flows · R builds D/RC · F standby until cutover · COPY/ASSETS soft-land strings/tokens.

---

## 11b.7 Global state machine + DoD

```text
Launch → Cutover frost? yes → §12 Frost flows
         no → authStatus
              notDetermined → SCR-OL-A → alert → authorized? no → SCR-OL-E
                                              yes → SCR-OL-B starting → live
              authorized → SCR-OL-B
              denied/restricted → SCR-OL-E → Settings → recheck → B
SCR-OL-B live → CCA available? no → banner · shoot · Pro OK
                yes → enable → SCR-OL-C (when presented)
SCR-OL-C → t1 free | t3 countdown | t2 if isPro
SCR-OL-B Pro/lock → SCR-OL-D → success → isPro → C M3 amber
                     cancel/fail → stay t1
```

### Vertical-slice DoD ↔ flows

| # | Criterion | Flow proof | Film Tool proof |
|---|-----------|------------|-----------------|
| 1 | Duo climax ≤30s zero narration | F-OL-02/20 | Tip plate readable 2–3 m |
| 2 | Inner capture usable | F-OL-01/05 | Charcoal preview · solid shutter |
| 3 | Countdown once | F-OL-04 or Simulate | M2 on charcoal |
| 4 | RC other pane | F-OL-06 | Amber oval on outer |
| 5 | Cancel once | F-OL-08 | Stay T1 white tip |
| 6 | Failure survivable | F-OL-10/11/12 | No brick |
| 7 | Scope clean | no second climax · paywall inner | no purple/cream |
| 8 | Pitch | F-OL-20/22 | Brad+Matt |

### LANE-DEMO rehearsal ticks (`DEMO-LAST-PASS.md`)

- [ ] F-OL-20 ≤90s · [ ] F-OL-21 known · [ ] Simulate tip · [ ] Simulate Pro labeled · [ ] Cancel once · [ ] Flake line · [ ] Brad/Matt memorized · [ ] TC-OL-* or waivers · [ ] Second 90s 3:15–3:30

### Pose note

Default open = canonical. Tabletop preview↑ controls↓ only if CCA green **and** ≥2:45 — same flows, not new IDs. `onHingeChange` = effects only (TC-S03).

---

## 11b.8 Crosswalk — TC-OL-* → canonical TC-* (SOFT FAIL-3)

Flow chapter uses `TC-OL-*` as **detail pointers** into §11. Demo/QA and `DEMO-LAST-PASS.md` tick **canonical** contract §6 / bible §15 IDs. Full table lives in [`11-outer-lens-product.md`](./11-outer-lens-product.md) §11.8.0; flow-critical subset:

| Flow beat | TC-OL detail | Canonical TC-* | Demo sec |
|-----------|--------------|----------------|----------|
| Primer / perm | TC-OL-A01…A04 | **TC-C05** (+ TC-S01) | 0:00–0:10 |
| Inner capture | TC-OL-B01…B06 | **TC-C02** | 0:10–0:40 |
| Outer tip climax | TC-OL-C01…C08 | **TC-C01** · **TC-C03** · **TC-C04** | 0:15–0:45 · 1:05–1:20 |
| Paywall | TC-OL-D01…D05 | **TC-R02–R05** · **TC-P03** | 0:50–1:20 |
| Errors / Simulate | TC-OL-E01…E05 | **TC-C03** · **TC-C05** | fallback |
| Pitch | TC-OL-P01 | **TC-P01** | 0:00–0:10 |
| Always (both modes) | — | TC-S01–S04 · TC-R01–R05 · TC-D01–D02 · TC-I01 | §15 |

**DECISION:** Do not rename every flow mention mid-overnight; keep `TC-OL-*` locally but report done against canonical IDs only.

---

## 11b.9 Source index

| Doc | Role in §11b |
|-----|----------------|
| `docs/bible/11-outer-lens-product.md` | SCR specs · strings · TC-OL-* · **§11.8.0 crosswalk** · CCA host |
| `docs/bible/15-acceptance-tests.md` | Canonical TC-* suite |
| `docs/bible-single-theme-contract.md` | SCR freeze · M0–M8 · kill list · always TCs |
| `docs/design-direction.md` | Film Tool tokens · M1–M3 · P1–P3 · 90s checklist |
| `docs/ios-craft-addendum.md` | Glass allowed/forbidden |
| `docs/outer-lens-3h-build-plan.md` | Minute blocks · gate · DoD |
| `internal/research-outer-lens.md` | States · cutover · permissions |
| `docs/win-completeness-bar.md` | Demo length · surface count |

---

*End §11b. Screen-by-screen SCR-OL-A…E. CCA tip → RC → amber T2 on the other pane. Empty/loading/error/Simulate covered. Film Tool charcoal `#050505` + amber `#E8A838`. One climax. 12:15 gate. 3:00 freeze. TC-OL → canonical TC crosswalk in §11b.8.*
