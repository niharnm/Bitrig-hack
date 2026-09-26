# §14 — Interaction & motion

**Bible section:** 14 · Interaction & motion  
**Climax motions:** Outer Lens **M1–M3** · FrostDuo **F1–F3** · Film Tool press micros **P1–P3**  
**Also specified here:** hinge (effects-only) · CCA tip choreography · paywall transitions · hover/spotlight → phone press remap  
**Canonical sources:** [`docs/design-direction.md`](../design-direction.md) §4 / §5 / §10D · [`docs/ios-craft-addendum.md`](../ios-craft-addendum.md) · [`docs/bible-single-theme-contract.md`](../bible-single-theme-contract.md) §5–§6  
**Research fuel:** [`internal/design-research-liquid-glass.md`](../../internal/design-research-liquid-glass.md) · [`internal/design-research-ios-hover-minimal.md`](../../internal/design-research-ios-hover-minimal.md)  
**Implementation target:** `DesignSystem/Motion.swift` — consumed by Capture / CoachOverlay / Frost / Paywall  
**Constraint:** Timed interaction specs only — **no** Saturday animation source code in this chapter.  
**Word floor:** ≥2500 (builder-dense).

---

## 14.0 Motion thesis

Ship **intentional** motion only. Motion creates presence and hierarchy — not noise. The Film Tool story on glass is: tip appears for the subject (M1), optional countdown punch (M2), Pro guide blooms on the **other** pane after purchase (M3). Press micros (P1–P3) make the inner camera feel craft-grade without becoming the climax. Frost cutover (when `CUTOVER.flag` is set) replaces that story with frost settle + decoy snap + vault crossfade (F1–F3).

**Hard laws**

1. **One climax on glass per demo path** ≤30s — CCA tip story **or** frost+decoy story — never both live in one 90s.  
2. **Hinge never drives layout** — `onHingeChange` / `DeviceHinge` = **effects only** (**TC-S03**). Pose layout comes from ArrangementView + reserved regions.  
3. **Honor Reduce Motion** everywhere — crossfade / instant; no rise, scale punch, gel morph, or spring overshoot.  
4. **Phone demo ≠ pointer theater** — translate iPadOS hover/spotlight vocabulary into **touch press** (ios-craft-addendum rule 4). Do not script a trackpad beat.  
5. **Do not ship:** parallax wallpaper noise, continuous glow pulse, skeleton dance, confetti, Cosign-level gel as primary climax, Accorduon bellows-as-product, idle glass shimmer.

**Maps to:** `DesignSystem/Motion.swift` · demo **0:15–1:20** · SCR-OL-B/C/D · SCR-FD-A/B/C/D · `Duo/PoseRouter.swift`.

---

## 14.1 Shared motion tokens

Implement as named constants in `DesignSystem/Motion.swift` (LANE-ASSETS / polish owns; feature lanes call — do not duplicate magic numbers).

| Token | Value | Used by |
|-------|-------|---------|
| `easeOut` | `cubic-bezier(0.16, 1, 0.3, 1)` | M1, P1–P3, most UI |
| `easeInOutFrost` | system easeInOut | F1 |
| `durTip` | **220ms** | M1 CCA tip settle |
| `durShutter` / `durPress` | **120ms** | P1–P3 |
| `durProBloom` | **360ms** | M3 |
| `durFrost` | **280ms** (0.2–0.3s band) | F1 |
| `durDecoy` | **400ms** | F3 (F2 pairs with F1) |
| `durPaywallPresent` | system sheet (~350–450ms) | SCR-OL-D / SCR-FD-D |
| `durPaywallSuccess` | **200–280ms** check + handoff to M3/F3 | After TC-R03 |
| `durHingeEffect` | **≤180ms** damp | Optional hinge→effect only |
| `tipRise` | **8–12pt** | M1 translation |
| `pressScaleShutter` | **0.94** | P1 |
| `pressScaleSide` | **0.96** | P2 / side pills |
| `pressFill` | white @ **12%** | P2 fallback “spotlight” |
| `frostLockedScaleIn` | 0.9 → 1.0 opacity | Locked overlay |

**SwiftUI hints (spec):** `withAnimation(.easeOut(duration:))` for M1/P*; `.contentTransition(.numericText())` for M2; single `Transaction` pairing F1+F2 on Simulate; branch every site on Reduce Motion.

---

## 14.2 Hinge interaction (effects only — never layout)

### 14.2.1 Contract

| Item | Spec |
|------|------|
| **API family** | `onHingeChange` / `DeviceHinge` (see Duo API pack — mark VERIFIED on Sat AM) |
| **Owner path** | `Duo/PoseRouter.swift` · effects hooks only |
| **Layout owner** | `Duo/ArrangementRegions.swift` + ArrangementView poses — **not** hinge degrees |
| **TC** | **TC-S03** — hinge used for effects only |
| **Demo** | Optional polish — **never** load-bearing for 90s script |

### 14.2.2 Allowed hinge effects (optional, after shell green)

| Effect ID | Trigger idea | Visual | Cap |
|-----------|--------------|--------|-----|
| **H-FX1** | Fast fold / snatch-like angular rate | Soft brightness dip on inner preview **or** Frost panic nudge toward `.threatened` | ≤180ms; no layout jump |
| **H-FX2** | Settling into tabletop | Brief chrome fade emphasis (controls denser below crease already via regions) | Do not animate frames from angle |
| **H-FX3** | Book pose settle | Trailing controls opacity ease | Regions already placed content vs controls |

### 14.2.3 Forbidden hinge behaviors (Integrator nack)

| Forbidden | Why |
|-----------|-----|
| Drive `frame` / padding / which pane exists from continuous hinge degrees | Breaks ArrangementView craft; Android-fold smell |
| Morph Liquid Glass from hinge angle | Glass = functional press layer, not hinge instrument |
| Accorduon / bellows product motion as climax | Kill list |
| Require hinge animation for tip or decoy to appear | Tip/decoy must work flat-open with Simulate |
| Second climax that is “watch the hinge” | Duo climax = outer coach tip **or** frost+decoy |

### 14.2.4 Pose changes that *look* like motion but are layout

Tabletop polish (preview/content **up**, controls **down**) is an **ArrangementView reserved-region remap**, not a numbered M/F motion. If any transitional animation is added, prefer **instant remap**; if animated, ≤180ms easeOut and **Reduce Motion → instant**. Same hierarchy closed↔open — not a new feature.

**Primary Frost demo pose:** tabletop. **Outer Lens:** tabletop optional after CCA green. Book = backup dual-pane clarity. Tent = skip unless free.

---

## 14.3 CCA tip choreography (Outer Lens climax spine)

**Mode:** `CUTOVER.flag` false.  
**Paths:** `Duo/CameraCaptureAccessoryHost.swift` · `Features/CoachOverlay/SubjectCoachView.swift` · `TipPlateView.swift` · `GuideOvalView.swift` · `CountdownView.swift`.  
**Outer interaction:** **none required** — tip is a stage for the subject (design-direction §3A). Optional tap-to-focus only if hour ≥3 green.

### 14.3.1 Tip lifecycle states → motion

| State | Tip style | Motion | Demo |
|-------|-----------|--------|------|
| Accessory presenting / tip-only stage ready | — | Instant stage; brand whisper visible | 0:10–0:15 |
| Free tip shows | **T1** | **M1** settle | **0:15–0:45** |
| Countdown (once) | **T3** | **M2** punch; T1 dims | Mid-script once |
| Vision / tip miss | Fallback T1 | M1 again or instant swap | Simulate tip path |
| Pro unlocked | **T2** | **M3** oval bloom | **1:05–1:20** |
| `accessory.unavailable` | Tip-only fullscreen OK | Still M1 on solid plate — never brick inner | TC-C03 |

### 14.3.2 M1 — Tip settle (CCA)

| Field | Spec |
|-------|------|
| **ID** | M1 |
| **Name** | Tip settle |
| **Where** | Outer T1 appear/update — SCR-OL-C |
| **Visual** | Tip plate **fade in** + **rise 8–12pt**; opacity 0→1; solid `#1C1C1E` plate + scrim ≥0.55 |
| **Timing** | **220ms** · `easeOut` (`--dur-tip`) |
| **Type** | SF Rounded Semibold ≥28pt · ≤8 words (§13) |
| **Win** | Readable at 2–3 m with **zero narration** (**TC-C01**) |
| **Reduce Motion** | Instant opacity — **no** rise |
| **Do not** | Bounce, shimmer, continuous idle float, glass tip plate |

**Latency delight pattern:** CapWords-style settle — tip arrival *is* the craft beat when CCA is slow. Prefer M1 over apologizing verbally.

### 14.3.3 M2 — Countdown punch (CCA)

| Field | Spec |
|-------|------|
| **ID** | M2 |
| **Name** | Countdown punch |
| **Where** | Outer T3 — SCR-OL-C |
| **Visual** | Huge numeral 120–180pt; `numericText` transition + snappy scale; tip plate dims during count |
| **Timing** | ≤**200ms** per digit; sequence `3·2·1` **once** |
| **Material** | No Liquid Glass under numeral |
| **Simulate** | Settings → Simulate countdown if live flaky |
| **Reduce Motion** | Digit replace without scale; or static hold |
| **Do not** | Particle bursts; full-screen takeover that hides brand whisper forever |

### 14.3.4 M3 — Pro unlock bloom (CCA + other pane)

| Field | Spec |
|-------|------|
| **ID** | M3 |
| **Name** | Pro unlock bloom |
| **Where** | Outer T1→T2 guide oval — SCR-OL-C; inner Pro CTA → check — SCR-OL-B |
| **Visual** | Accent oval **strokes in** with `#E8A838`; tip flash; inner CTA → success check |
| **Timing** | **360ms** `--dur-pro-bloom` · `easeOut` |
| **Demo** | **1:05–1:20** after Test Store Successful Purchase |
| **Depends on** | `EntitlementState.isPro` (**TC-C04** · **TC-R04**) |
| **Proof rule** | Glass brighten on inner CTA is **not** the Pro proof — **outer T2 amber oval** is |
| **Reduce Motion** | Crossfade tip→guide; instant check |
| **Do not** | Confetti, crown explosion, whole-rail amber tint |

### 14.3.5 CCA tip interaction rules

| Rule | Detail |
|------|--------|
| Non-interactive outer | Subject does not need to tap for tip to work |
| One tip at a time | T3 dims T1; never tip list |
| Solid plate always | Even under Simulate tip / tip-only fallback |
| Inner still shoots if accessory unavailable | TC-C03 |
| No paywall / settings / shutter on outer | Theme contract |

---

## 14.4 Paywall interaction & motion (SCR-OL-D / SCR-FD-D)

**Path:** `Features/Paywall/PaywallHostView.swift` (shared) · `Monetization/**` · LANE-RC.  
**Pane:** **Inner only** — never present paywall on outer.  
**Material:** System Liquid Glass sheet — remove custom visual-effect backgrounds (ios-craft-addendum / liquid-glass research).

### 14.4.1 State machine

| State | UI | Motion |
|-------|-----|--------|
| `locked` | Entry from Pro CTA / Unlock Cover Vault | Sheet present — system timing |
| `purchasing` | RevenueCatUI Test Store modal | System; do not add custom spinner theater |
| `success` | Dismiss toward unlock | Check on inner (**P3** / short success) → **M3** or **F3** on **other** pane |
| `cancel` / `fail` | Sheet dismiss; gate stays locked | Instant/ease; rehearse once (**TC-R05**) |

### 14.4.2 Timing relative to demo seconds

| Time | Event | Motion ID |
|------|-------|-----------|
| **0:45–0:50** | Tap Pro coaching / Unlock Vault (inner) | P3 press start |
| **0:50–1:05** | Paywall + Test Store Successful Purchase | System sheet · **TC-R02/R03** |
| **1:05–1:20** | Other-pane unlock | **M3** (OL oval) or **F3** (FD vault) · **TC-R04** |

### 14.4.3 Paywall motion laws

1. **Monetization beat ≠ Duo climax.** Climax remains outer tip (OL) or frost+decoy (FD).  
2. **Success must change the other display** within the M3/F3 window — if only inner chrome changes, Matt fails.  
3. **No custom blur stacks** under RCUI — fight system Liquid Glass and you get muddy double materials.  
4. **Reduce Motion:** sheet may still animate via system; custom check/bloom → instant/crossfade.  
5. **Fallback:** Cancel/Fail keeps Pro locked; tip stays T1 / decoy stays A — rehearse verbally once.  
6. **Frost paywall tone:** calm privacy hero; **Outer Lens paywall tone:** craft camera hero — accent tokens from §13 (`#E8A838` vs `#4A6B73`).

### 14.4.4 Entry points (do not invent more)

| Mode | Entry control | Screen |
|------|---------------|--------|
| Outer Lens | Pro coaching pill (trailing bottom rail) | SCR-OL-B → SCR-OL-D |
| FrostDuo | Unlock Cover Vault | SCR-FD-B → SCR-FD-D |

---

## 14.5 Hover / spotlight — phone-first minimal remap

**Source:** `internal/design-research-ios-hover-minimal.md` · ios-craft-addendum rule 4 · design-direction §10D.  
**Verdict:** For a Duo **phone** 90s, **skip pointer hover theater**; ship **press / highlight morph** that feels premium without a trackpad.

### 14.5.1 Why pointer APIs are not the demo

| Reality | Implication |
|---------|-------------|
| Duo 90s is phone held / tabletop — pointer usually **absent** | Hover-only effects never show |
| Outer CCA is **non-interactive** | No hover, no press morph on tip plate |
| Judges watch **touch** beats | Press morph + tip settle + Pro bloom are the craft story |

### 14.5.2 iPadOS vocabulary → Film Tool touch equivalents

| iPadOS / Catalyst pattern | Phone 90s equivalent | Where |
|---------------------------|----------------------|-------|
| Highlight platter (“spotlight” light source) | Brief **press fill** white@12% **or** glass `.interactive()` brighten | Inner glass pills |
| Lift (scale + shadow + specular) | **Scale 0.94–0.96** on press | Shutter primary; Pro secondary |
| Hover tint (no scale) | Opacity / amber tint flash on press | Pro pill → check |
| Pointer magnetism / custom pointer shapes | **N/A — skip** | — |
| Hover-reveal chrome | **N/A** on capture; tip always visible | — |
| Liquid Glass `.interactive()` | **Yes** — touch *and* pointer if present | Inner control rail only |
| Glass morph (`GlassEffectContainer` + IDs) | Optional: tip-pack → menu **once** if time | Drop if clock tight |
| Button → menu morph | Prefer **system Menu / sheet** for settings | Settings density |

### 14.5.3 “Spotlight” definition for Outer Lens

Treat spotlight as **press illumination under the finger**, not a cursor platter:

- **P2 glass brighten** = spotlight analog on side pills.  
- **P1 shutter scale** = lift analog.  
- **No idle spotlight drift**, no continuous specular crawl, no decorative focus rings.

### 14.5.4 Press micros — P1–P3 (exactly three)

#### P1 — Shutter press

| Field | Spec |
|-------|------|
| **Where** | Inner ◎ — SCR-OL-B |
| **Visual** | Scale **0.94** |
| **Timing** | **120ms** · `easeOut` |
| **Haptic** | Optional light impact |
| **Material** | Shutter stays **solid** — no glass morph as climax |
| **Reduce Motion** | Opacity flash only or none |

#### P2 — Glass brighten (spotlight-on-press)

| Field | Spec |
|-------|------|
| **Where** | Inner side pills (flip · tip pack · Subject · close) |
| **Visual** | `.interactive()` glass reaction **or** brief `--press-fill` white @ 12% |
| **Timing** | **120ms** |
| **Scale** | Optional **0.96** |
| **Reduce Motion** | Skip interactive morph; static highlight OK |
| **Do not** | Idle shimmer / continuous glow / pointer-only path |

#### P3 — Pro press → check

| Field | Spec |
|-------|------|
| **Where** | Inner Pro CTA → paywall success |
| **Visual** | Press scale/tint flash → amber/success **check** |
| **Timing** | Press 120ms; check aligns with M3/F3 window |
| **Pairs with** | **M3** outer T2 bloom (OL) or **F3** vault (FD) |
| **Optional late** | One tip-pack glass morph into menu — drop if tight |
| **Reduce Motion** | Instant check |

### 14.5.5 Chrome density rules that support motion

From hover-minimal + Camera iOS 26 simplification:

1. Bottom rail only for primary actions — flip · shutter · Pro.  
2. No mode carousel, no second settings strip.  
3. Contiguous hit regions — no gaps (phone analog of pointer flicker).  
4. Don’t scale crowded neighbors into each other — tint/fill over multi-control scale.  
5. Everything else → **one Settings sheet**.  
6. Outer tip: **M1 only** — no press morph required.

---

## 14.6 FrostDuo cutover climax — F1–F3

**Mode:** `CUTOVER.flag` true · see §12.  
**Paths:** `Features/Frost/FrostOverlayView.swift` · `OuterDecoyStageView.swift`.

### F1 — Frost settle

| Field | Spec |
|-------|------|
| **Where** | Inner threat step — SCR-FD-A |
| **Visual** | Progressive blur / wash; locked = whole pane **milky**; sparse grain optional; quiet Covered/Private |
| **Timing** | easeInOut ~**280ms** |
| **Demo** | **0:25–0:35** on Simulate |
| **TC** | **TC-F01** |
| **Reduce Motion** | Instant blur/material |
| **Not** | Liquid Glass carnival refraction |

### F2 — Decoy snap

| Field | Spec |
|-------|------|
| **Where** | Outer idle → pack A/B — SCR-FD-C |
| **Visual** | Calm wallpaper → Lock Lookalike or Busy Cover |
| **Timing** | Same window as F1; prefer **one transaction** with F1 |
| **Demo** | **0:25–0:45** |
| **TC** | **TC-F02** |
| **Reduce Motion** | Instant image swap |

### F3 — Vault crossfade

| Field | Spec |
|-------|------|
| **Where** | Outer → pack C after Pro — SCR-FD-C |
| **Visual** | Calm crossfade to Vault Cover |
| **Timing** | **400ms** |
| **Demo** | **1:05–1:20** |
| **TC** | **TC-F04** after TC-R03 |
| **Reduce Motion** | Instant pack swap |
| **Do not** | Confetti, 3D vault spin, matrix rain |

---

## 14.7 Reduce Motion — global contract

| Setting | Required behavior |
|---------|-------------------|
| **Reduce Motion ON** | All M/F/P/H-FX → **crossfade** or **instant**; no rise, scale punch, gel morph, spring overshoot |
| **Reduce Motion OFF** | Full specs above |
| **Reduce Transparency** | Glass frostier — icons remain legible; tip plate already solid |
| **Tests** | ≥1 rehearsal with Reduce Motion on before `DEMO-LAST-PASS.md` |

**Implementation rule:** every animation call site branches on accessibility Reduce Motion. Custom glass morphs are first to damp. System sheets may still move — custom blooms must not.

### Mapping table

| Motion | Full | Reduce Motion |
|--------|------|---------------|
| M1 | Fade + rise 8–12pt · 220ms | Instant opacity |
| M2 | numericText + scale | Digit swap / static |
| M3 | Oval stroke bloom · 360ms | Crossfade tip→guide |
| F1 | easeInOut blur · 280ms | Instant blur/material |
| F2 | Paired decoy snap | Instant image |
| F3 | 400ms crossfade | Instant pack |
| P1 | Scale 0.94 | Skip or opacity |
| P2 | Interactive glass / fill | Skip morph |
| P3 | Press → check | Instant check |
| H-FX* | ≤180ms damp | Instant / omit |
| Paywall success handoff | Check + M3/F3 | Instant other-pane swap |

---

## 14.8 Choreography graphs (demo seconds)

### 14.8.1 Outer Lens 90s (primary)

```text
0:00  SCR-OL-A primer
0:10  SCR-OL-B live preview · P1/P2 available anytime
0:15  SCR-OL-C T1 —— M1 tip settle          ← CCA climax start
0:35  optional T3 —— M2 countdown punch (once)
0:45  Pro pill press —— P3 → SCR-OL-D
0:50  paywall / Test Store
1:05  purchase OK → SCR-OL-C T2 —— M3 bloom (+ P3 check)
1:20  hold · Matt line
```

### 14.8.2 FrostDuo cutover 90s

```text
0:00  SCR-FD-A clear
0:15  SCR-FD-B controls · tabletop region remap (layout, not M/F)
0:25  Simulate —— F1 + F2 together          ← frost climax
0:45  Unlock CTA → SCR-FD-D paywall
0:50  Test Store purchase
1:05  F3 vault crossfade on outer
1:20  Matt frost · Jane on-device line
```

### 14.8.3 Forbidden choreography

| Forbidden | Why |
|-----------|-----|
| M* and F* in same 90s path | One climax |
| Hinge angle drives layout animation | TC-S03 |
| Pointer-hover-only demos | Phone 90s |
| Continuous glass shimmer as “alive” | Noise |
| Confetti on Pro | Matt beat = other pane |
| Paywall on outer | Contract |
| Waiting on second face without Simulate | Sim has no TrueDepth ARKit |

---

## 14.9 Dual-display interaction craft laws

Tied to design-direction §5:

1. **Unequal jobs** — Inner decides; outer coaches or decoys.  
2. **Full-bleed** stages — motion reveals content, not card chrome.  
3. **One climax** ≤30s on glass.  
4. ArrangementView regions for pose; hinge effects-only.  
5. Outer glanceable / largely non-interactive.  
6. RC unlock changes **other** display (M3 or F3).  
7. Continuity of hierarchy across poses.  
8. Demo evidence must show crease / lit outer / tabletop — motion that only works on a single flat phone fails the brief.

---

## 14.10 Acceptance — motion & interaction

| Mode | Required | Evidence |
|------|----------|----------|
| Outer Lens | **M1** once · **M3** on unlock · **M2** if countdown scripted | Win motion · TC-C01/C04 |
| FrostDuo | **F1+F2** on Simulate · **F3** on unlock | TC-F01/F02/F04 |
| Always | Hinge not used for layout | TC-S03 |
| Always | Paywall inner; unlock other pane | TC-R02/R04 |
| Always | Reduce Motion path rehearsed | DEMO-LAST-PASS note |
| Polish | P1–P3 if time — **not** blockers | — |
| Optional | H-FX* — cut first under clock pressure | — |

### Explicit non-goals

Perfect spring physics · Cosign gel · pointer hover theater · parallax decoy · Perfect Liquid Glass morph on every control · hinge-as-instrument product.

---

## 14.11 Lane ownership

| Lane | Owns |
|------|------|
| LANE-ASSETS / polish | `DesignSystem/Motion.swift` constants + shared helpers |
| LANE-SHELL | Hinge effects-only wiring in `PoseRouter`; region remaps |
| LANE-CCA | Apply M1–M3 + P1–P3 on Capture/Coach |
| LANE-FROST | Apply F1–F3 |
| LANE-RC | Paywall present/dismiss; emits `isPro` for M3/F3 consumers |
| LANE-DEMO | Timing vs DEMO-SCRIPT; Reduce Motion rehearsal tick |

**Path mutex:** Motion.swift owned by ASSETS/polish; feature lanes call APIs — do not fork duration constants.

---

## 14.12 Do / Don’t

### Do

- Cap climax at M1–M3 · F1–F3; press at P1–P3.  
- Pair F1+F2 on Simulate; prove Pro on the **other** pane (M3/F3).  
- Keep hinge effects-only; layout via ArrangementView.  
- Remap hover/spotlight → press fill / glass interactive / shutter scale.  
- Branch every animation on Reduce Motion.  
- Use system glass sheet for paywall.

### Don’t

- Invent M4/F4/P4 or hinge-driven layouts.  
- Script trackpad hover as a judge beat.  
- Put Liquid Glass under CCA tip text.  
- Use motion to hide missing tip/decoy contrast.  
- Ship confetti, glow pulses, skeleton HUDs.  
- Make glass morph the climax instead of tip/decoy.

---

## 14.13 Quick reference card (print for Saturday)

| ID | One-liner | ms | SCR / path |
|----|-----------|---:|------------|
| **M1** | CCA tip fade+rise | 220 | OL-C TipPlate |
| **M2** | Countdown punch | ~200/digit | OL-C Countdown |
| **M3** | Pro oval bloom | 360 | OL-C GuideOval (+B) |
| **F1** | Frost milky | 280 | FD-A |
| **F2** | Decoy snap | w/ F1 | FD-C |
| **F3** | Vault crossfade | 400 | FD-C |
| **P1** | Shutter 0.94 | 120 | OL-B |
| **P2** | Spotlight press / glass brighten | 120 | OL-B side pills |
| **P3** | Pro→check | 120+ | OL-B → paywall |
| **Paywall** | System sheet → other-pane M3/F3 | sys+360/400 | OL-D / FD-D |
| **Hinge** | Effects ≤180ms — **never layout** | ≤180 | PoseRouter |
| **RM** | All → instant/crossfade | 0 | all |

---

## 14.14 Saturday builder checklist

1. Wire `Motion.swift` tokens before feature polish.  
2. CCA path: M1 on first tip; M3 only after `isPro`; Simulate tip uses same M1 plate.  
3. Capture chrome: P1 solid shutter; P2 interactive glass or press fill; no idle shimmer.  
4. Paywall: system sheet; success → observe entitlement → M3 or F3 on other pane within 1:05–1:20.  
5. PoseRouter: assert no layout from hinge; optional H-FX only after TC-S02 green.  
6. Rehearse once with **Reduce Motion** on.  
7. If cutover: disable M* path in root; enable F1–F3 only.

---

## 14.15 UNKNOWN register

| Item | Status |
|------|--------|
| Exact `onHingeChange` symbol availability / rate units | Confirm Sat AM in Duo SDK |
| Whether CCA host applies system motion to accessory presentation | Verify on hardware/sim |
| GlassEffectContainer thermal cost over live preview | Instruments if time |
| Optional tip-pack glass morph worth the clock | Default **drop** |

---

*End of §14. Consume §13 tokens for colors/durations; §12 for Frost SCR wiring; §11 for Outer Lens SCR wiring.*
