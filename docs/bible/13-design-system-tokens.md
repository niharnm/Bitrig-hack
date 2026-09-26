# §13 — Design system tokens & assets

**Bible section:** 13 · Visual system & assets  
**Primary look:** Outer Lens **Film Tool** — charcoal `#050505` · amber `#E8A838`  
**Cutover look:** FrostDuo ice-soft privacy (flag-gated token swap only)  
**Canonical sources:** [`docs/design-direction.md`](../design-direction.md) · [`docs/ios-craft-addendum.md`](../ios-craft-addendum.md) · [`docs/bible-single-theme-contract.md`](../bible-single-theme-contract.md)  
**Research fuel:** [`internal/design-research-liquid-glass.md`](../../internal/design-research-liquid-glass.md) · [`internal/design-research-ios-hover-minimal.md`](../../internal/design-research-ios-hover-minimal.md) · Outer Lens / Frost UI packs  
**Implementation targets:** `DesignSystem/Tokens.swift` · `DesignSystem/Motion.swift` (duration token names; timed curves in §14) · `Resources/Assets.xcassets/**` · LANE-ASSETS  
**Constraint:** Spec / asset filenames only — **no Saturday Swift sources** in this chapter.  
**Word floor:** ≥3500 (builder-dense).

---

## 13.0 Direction lock (read first)

**DECISION:** One theme = Outer Lens Film Tool. FrostDuo = flag-gated token **swap** only — not a second equal design system.

**DECISION:** Liquid Glass only on **inner side pills** (+ system sheets). **Forbidden** on tip text / shutter disc / frost face / outer subject stage.

**DECISION:** Banned AI-slop clusters — purple→indigo · cream+terracotta · broadsheet hairlines · glow stacks · emoji chrome — are Integrator/GUARD nacks.

**Outer Lens** is a **Film Tool**: brand-first charcoal capture craft where the picture is the hero and the outer face is a single readable coach line for the person in front of the camera. Full-bleed preview on both roles (inner capture / outer subject stage). Free outer tip; Pro blooms a guide oval on the **other** pane after RevenueCat. Liquid Glass is an **additive functional layer** on **inner control chrome only**. It does **not** replace charcoal `#050505`, amber `#E8A838`, or the solid outer tip plate.

**FrostDuo** (hour-one cutover behind `docs-runtime/CUTOVER.flag`) swaps to soft paper/ice tokens — not a second Film Tool redesign, not a second brand bible. See §12 for SCR-FD-*; this chapter only documents the token swap and shared asset filenames.

**Brad (Outer Lens, frozen):** Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.

**Brand test:** If the first viewport could belong to another brand after removing nav chrome, branding is too weak. Wordmark **Outer Lens** is a hero-level signal on every primary surface — never nav-only whisper without a visible mark on SCR-OL-B / SCR-OL-C.

**Maps to Saturday paths:** `DesignSystem/Tokens.swift` · demo seconds **0:15–1:20** · SCR-OL-B / SCR-OL-C chrome · paywall SCR-OL-D sheet materials.

---

## 13.1 Hard bans (AI-slop + craft)

These clusters are **Integrator nack** if they appear in Tokens.swift, assets, or screen chrome.

| Banned cluster | Why |
|----------------|-----|
| Purple→indigo / purple-on-white gradients | Default AI SaaS look |
| Cream `#F4F1EA` + terracotta serif | Default AI “warm editorial” look |
| Broadsheet hairlines / zero-radius dense newspaper columns | Default AI layout bias |
| Glow stacks · emoji chrome · pill *clusters* · card soup in the hero minute | Clutter; fails room test |
| Cyber HUD · matrix green · traffic-light threat chrome in Jane’s 90s | Frost anti-creep; Outer Lens is not SOC |
| Liquid Glass over outer tip text / subject face | Muddy at 2–3 m |
| Glass shutter disc · carnival refractive frost · glass-on-glass piles | Contrast collapse |
| Inter / Roboto / Arial / generic system UI as **display** type | Type lock = SF Pro / SF Rounded |
| Decorative serif for outer tips | Room readability + Film Tool craft |
| Paywall on the outer display | Theme contract — inner only |
| Tip lists / icon grids / floating face badges on outer | One tip only |

**Justified craft-dark:** Capture + outer coach stay charcoal because “content is the picture” (Halide / Moments accessory / Shot Caller pattern). This is **not** a generic dark marketing landing page. Do not “lighten the brand” mid-build.

---

## 13.2 Film Tool color tokens (LOCKED)

**Path:** `DesignSystem/Tokens.swift` — default when `Shared/CutoverFlag.swift` reads false.  
**Source of truth:** design-direction §2A.

### 13.2.1 The two non-negotiables

| Token | Hex | Role | Failure if wrong |
|-------|-----|------|------------------|
| **Canvas** | **`#050505`** | Preview letterbox, outer stage, Film Tool atmosphere | App reads as generic iOS dark gray template |
| **Accent** | **`#E8A838`** | Pro guide stroke, Pro CTA, unlock flash, amber glass tint source | Pro beat invisible; Matt sentence fails on glass |

Everything else in the Film Tool palette supports these two. Do not introduce a third “brand accent.” Success green and system red are **semantic**, not brand.

### 13.2.2 Full CSS-like source of truth

```css
:root {
  /* Brand */
  --brand-name: "Outer Lens";
  --brand-mark-size: 15px;          /* whisper; never louder than tip */
  --brand-mark-weight: 500;

  /* Surfaces */
  --canvas: #050505;                /* preview letterbox, outer stage */
  --panel: #1C1C1E;                 /* tip plate solid, sheets */
  --panel-raised: #2C2C2E;          /* toasts / notices */
  --scrim: rgba(0, 0, 0, 0.55);     /* tip plate over preview min */

  /* Ink */
  --ink: #FFFFFF;
  --ink-muted: rgba(255, 255, 255, 0.62);
  --ink-faint: rgba(255, 255, 255, 0.38);

  /* Accent — Amber film (LOCKED) */
  --accent: #E8A838;                /* Pro guide stroke, Pro CTA, unlock flash */
  --accent-soft: rgba(232, 168, 56, 0.22);

  /* Semantic */
  --success: #5CCC8C;               /* purchase check / Pro badge */
  --danger: #FF453A;                /* system red — denied / error */
  --record: #F5453A;                /* only if video ships (default: photo-only OFF) */

  /* Tip styles */
  --tip-primary-size: 28px;         /* outer compact ≥28pt */
  --tip-primary-weight: 600;        /* SF Rounded Semibold */
  --tip-max-words: 8;
  --countdown-size: 140px;          /* 120–180pt band; default 140 */
  --shutter-size: 80px;             /* 72–88pt band */
  --control-hit: 48px;              /* symbol; ~56pt padding */

  /* Spacing (4pt base) */
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-5: 24px;
  --space-6: 32px;
  --safe-tip-bottom: 34px;          /* above home indicator */
  --outer-inset-x: 16px;

  /* Radii — restrained */
  --radius-control: 12px;           /* glass pills */
  --radius-tip: 14px;               /* tip plate */
  --radius-shutter: 9999px;         /* shutter only */

  /* Motion (see §14) */
  --ease-out: cubic-bezier(0.16, 1, 0.3, 1);
  --dur-tip: 220ms;
  --dur-shutter: 120ms;
  --dur-pro-bloom: 360ms;

  /* Liquid Glass + press (additive — ios-craft-addendum) */
  --glass-variant: regular;           /* never clear over faces */
  --glass-tint-pro: rgba(232, 168, 56, 0.35); /* Pro CTA only */
  --press-fill: rgba(255, 255, 255, 0.12);
  --press-scale-shutter: 0.94;
  --press-scale-side: 0.96;
  --dur-press: 120ms;
}
```

### 13.2.3 Swift token map (`Tokens.swift` names)

| Token ID | Value | Consumed by |
|----------|-------|-------------|
| `Brand.name` | `"Outer Lens"` | SCR-OL-B / SCR-OL-C brand whisper |
| `Color.canvas` | `#050505` | `InnerCaptureView` letterbox · outer CCA stage |
| `Color.panel` | `#1C1C1E` | `TipPlateView` solid plate · sheet fills |
| `Color.panelRaised` | `#2C2C2E` | Toasts / notices |
| `Color.scrim` | black @ 55% | Tip over live preview — **floor**, not ceiling |
| `Color.ink` | `#FFFFFF` | Tip text, countdown |
| `Color.inkMuted` | white @ 62% | Brand whisper, secondary labels |
| `Color.inkFaint` | white @ 38% | Disabled / tertiary |
| `Color.accent` | `#E8A838` | Guide oval stroke · Pro CTA · M3 flash |
| `Color.accentSoft` | amber @ 22% | Soft fills under Pro chrome |
| `Color.success` | `#5CCC8C` | Purchase check / Pro badge |
| `Color.danger` | `#FF453A` | Denied / error (system red OK) |
| `Tip.primarySize` | ≥28pt | Outer T1 / T2 |
| `Tip.maxWords` | 8 | COPY + layout enforcement |
| `Tip.countdownSize` | 140pt (band 120–180) | T3 |
| `Control.shutterSize` | 80pt (band 72–88) | SCR-OL-B shutter |
| `Control.minHit` | 48pt | All tappable chrome |
| `Space.s1…s6` | 4…32 | Layout rhythm |
| `Radius.control` | 12 | Glass pills |
| `Radius.tip` | 14 | Tip plate |
| `Radius.shutter` | full | Shutter disc only |
| `Glass.variant` | `.regular` | Inner pills |
| `Glass.tintPro` | amber soft @ 35% | **Only** Pro coaching CTA |
| `Press.scaleShutter` | 0.94 | P1 |
| `Press.scaleSide` | 0.96 | P2 |
| `Press.fill` | white @ 12% | P2 fallback |
| `Press.duration` | 120ms | P1–P3 |

### 13.2.4 Color usage rules (anti-drift)

1. **Canvas `#050505` is full-bleed** under preview and outer stage — not a card inset on light gray.  
2. **Amber `#E8A838` appears only for Pro / unlock moments** — guide oval, Pro pill, success flash. Do not amber-tint the whole rail.  
3. **Panel `#1C1C1E` is the tip plate** — never replace with Liquid Glass for tip text.  
4. **Scrim ≥0.55** under tip over busy faces — if tip fails room test, raise scrim or solidify panel; do **not** switch to glass tip.  
5. **Semantic success/danger** never become brand accents.  
6. **Record red** stays unused while product is photo-only.

---

## 13.3 Film Tool type stack (LOCKED)

| Role | Face | Size / weight | Color token | Where |
|------|------|---------------|-------------|-------|
| Brand whisper | SF Pro Medium | 13–15pt | `--ink-muted` | Top of SCR-OL-B / SCR-OL-C |
| Outer primary tip | **SF Rounded Semibold** | **≥28pt** | `--ink` | SCR-OL-C tip plate |
| Countdown | SF Rounded Bold + `monospacedDigit` | 120–180pt (default 140) | `--ink` | SCR-OL-C T3 |
| Inner control icons | SF Pro Semibold symbols | ~19–22pt | hierarchical / white | SCR-OL-B rails |
| Paywall title | SF Pro Bold | Title2 | system / ink | SCR-OL-D |
| Body / errors | SF Pro Regular | Body | ink / danger | Primer, denied, settings |
| Paywall bullets | SF Pro Regular | Body / Callout | muted | SCR-OL-D |

### Type laws

1. **No Inter / Roboto / Arial / “system UI” as display.** SF Pro / SF Rounded only for product chrome.  
2. **No decorative serif** on tips — room distance kills hairline serifs.  
3. **Outer tip ≥28pt Semibold** is a **demo reliability** number, not a taste preference. Below 28pt fails 2–3 m readability (**TC-C01**).  
4. **Max 8 words** on T1/T2 — COPY owns strings; layout truncates with ellipsis only as last resort (prefer rewrite).  
5. **Brand whisper never louder than tip** — 13–15pt muted vs ≥28pt tip.  
6. **Dynamic Type:** tip plate must still hold ≥28pt without clipping into home indicator; verify `--safe-tip-bottom` 34.  
7. **Bold Text / Increase Contrast:** tip stays white on solid panel; amber CTA needs a higher-contrast Asset Catalog variant if glass tint washes out.

---

## 13.4 Tip styles (hard cap = 3)

Rendered only inside **SCR-OL-C** (`Features/CoachOverlay/SubjectCoachView.swift`, `TipPlateView.swift`, `GuideOvalView.swift`, `CountdownView.swift`). Demo: **0:15–0:45** T1 · **1:05–1:20** T2 after purchase · T3 once if scripted.

| ID | Name | Tier | Spec |
|----|------|------|------|
| **T1** | Line tip | Free | One sentence ≤8 words + optional SF Symbol; solid tip plate bottom-third; SF Rounded Semibold ≥28pt; brand whisper top |
| **T2** | Guide tip | Pro | T1 + faint oval / thirds / shoulder guide in `--accent` `#E8A838` **stroke** (not filled glass) |
| **T3** | Countdown | Any | Huge numeral 120–180pt; tip plate dims during count; ship once in 90s |

### Tip plate construction (LOCKED — solid, not glass)

| Rule | Value | Path |
|------|-------|------|
| Plate fill | Solid `--panel` `#1C1C1E` | `TipPlateView` |
| Scrim floor | `--scrim` ≥ **0.55** over preview | Under plate |
| Radius | `--radius-tip` **14** | |
| Inset X | `--outer-inset-x` **16** | |
| Safe bottom | `--safe-tip-bottom` **34** | Above home indicator |
| Material | **No Liquid Glass** | ios-craft-addendum rule 1 |
| Interaction | None required | Optional tap-to-focus only if hour ≥3 green |
| Fail path | Simulate tip — **same solid plate** | Settings sheet |

### Tip-over-busy-face checklist

1. Tip never sits on raw preview pixels alone.  
2. Plate opacity floor = scrim ≥0.55 or fully solid panel.  
3. Max 8 words; SF Rounded Semibold ≥28pt.  
4. No glass, no vibrancy-only text, no hairline border-only plate.  
5. Vision miss → fall back to T1 on same plate (no empty outer).

**Forbidden on outer:** tip lists, icon grids, floating face badges, paywall, shutter, settings, second tip simultaneous with countdown chrome clutter.

---

## 13.5 Inner Film Tool chrome (structure + materials)

**SCR-OL-B** — `Features/Capture/InnerCaptureView.swift` · canvas `#050505`.

### 13.5.1 Rails (minimal — ios-craft-addendum rules 2–3)

| Rail | Contents | Material |
|------|----------|----------|
| **Top** | close · Subject screen toggle · tip pack menu | Liquid Glass **regular** pills |
| **Bottom** | flip · **◎ shutter ~80pt** · Pro coaching pill (trailing) | Flip + Pro = glass; **shutter = solid** |
| **Canvas** | Full-bleed live preview | Content layer `#050505` — no inset media cards |
| **Overflow** | Simulate tip / Simulate Pro / Simulate countdown · misc | **One Settings sheet** (system glass) |

### 13.5.2 Shutter craft

| Spec | Value |
|------|-------|
| Size | ~**80pt** (band 72–88) |
| Shape | Circle — `--radius-shutter` full |
| Fill | Solid white / near-white ring on charcoal |
| Material | **Not glass**, not clear ring theater |
| Spacing | ≥16pt breathing room from side controls |
| Press | P1 scale 0.94 · 120ms (§14) |

### 13.5.3 Hit targets & density

| Rule | Value | Source |
|------|-------|--------|
| Min hit | ≥48pt | design-direction |
| Contiguous rail | No gaps between flip / shutter / Pro hit regions | hover-minimal research (phone remap of pointer magnetism) |
| Icon size | ~19–22pt SF Symbol inside ≥48pt hit | |
| Glass cluster | One `GlassEffectContainer` for top rail; one for bottom side pills | liquid-glass research |
| Max custom glass nodes | ≤1–2 clusters | Perf over live camera |

---

## 13.6 Liquid Glass — inner chrome only (additive)

**Status:** Additive on locked Film Tool — charcoal `#050505` + amber `#E8A838` + solid outer tip **unchanged** (`docs/ios-craft-addendum.md`).  
**Sources:** design-direction §10 · liquid-glass research · WWDC25-219 / 323 (iOS 26 material).

### 13.6.1 Governing split

| Layer | Duo map | Material |
|-------|---------|----------|
| **Content** | Live camera preview, outer tip stage, guide oval, countdown numerals, Frost decoys | Opaque `#050505` / **solid tip plate** / standard blur for frost |
| **Functional** | Inner shutter-adjacent controls, Pro CTA, system sheets & paywall chrome | **Liquid Glass** |

Liquid Glass blurs, reflects, refracts/lenses at edges, and reacts to touch/pointer. Previous materials mostly scattered light; Liquid Glass bends and concentrates it. That power is **why tip text must stay solid** — refraction over skin midtones = beige sludge at 2–3 m.

### 13.6.2 Allowed vs forbidden (print this for LANE-CCA / ASSETS)

| Surface | Material | Why |
|---------|----------|-----|
| Outer tip plate (T1/T2 text) | **Solid `--panel` + `--scrim` ≥0.55** | Room test over busy faces |
| Outer countdown numeral | Solid / mild scrim only | No glass under T3 |
| Pro guide oval | Amber **stroke** `#E8A838` — not glass fill | M3 proof is the line |
| Inner control pills (flip · tip pack · Subject · close) | Liquid Glass **regular** or `.buttonStyle(.glass)` | Functional over preview |
| Inner Pro CTA | Regular glass + **amber tint** (`--glass-tint-pro`) — **one** prominent | Selective tint rule |
| Sheets / paywall / menus | **System** Liquid Glass sheet | Remove custom visual-effect backgrounds |
| Optional status capsule | Regular glass, small, **no tip text** | Never clear over face without dim |
| Live preview / guide fill | Charcoal content | Picture is hero |
| **Shutter disc** | **Solid** craft circle | Affordances survive luminance swings |
| Frost overlay / outer decoy | Standard blur / wallpaper | Privacy ≠ carnival glass |
| Glass-on-glass / clear+regular mix / purple glass | **Forbidden** | Contrast + AI-slop |

### 13.6.3 Variant policy

| Variant | Behavior | Use when | Avoid when |
|---------|----------|----------|------------|
| **Regular** (default `--glass-variant`) | Blurs + luminosity adjust; adaptive | Inner capture chrome over live faces; text-ish popovers | — |
| **Clear** | More translucent; not adaptive like regular | Rare icon-only over calm media + ~**35%** dark dim | Tip copy; busy faces; mixed with regular in one cluster |

**API preference (spec):** `.buttonStyle(.glass)` / `.glassProminent` · one `GlassEffectContainer` · prefer system styles over stacked custom `.glassEffect`. Exact overloads → confirm in Xcode SDK; mark UNKNOWN extras — do not invent private styles.

**Amber tint recipe (Pro CTA only):**

```text
.glassEffect(.regular.tint(<Color from #E8A838 soft>).interactive())
```

Do **not** tint every icon amber. Chrome stays monochrome hierarchical; **one** tinted primary.

### 13.6.4 Builder one-screen rules (ios-craft-addendum)

1. **Glass = functional layer** — inner rails + sheets. Never glass tip text over the subject’s face.  
2. **Shutter stays solid** (~80pt craft circle). Side chrome can be glass; shutter is not.  
3. **Minimal rails** — flip · shutter · Pro; tip pack / Subject up top; everything else in **one Settings sheet**.  
4. **Phone demo ≠ pointer theater** — ship press morph; skip trackpad hover as a script dependency (§14).  
5. **FrostDuo** — progressive frost/decoy realism; no craft-camera glass HUD on the outer decoy.

### 13.6.5 Muddy glass — how it happens and how we refuse it

Mud appears when: (1) large clear glass over high-frequency faces/clothing; (2) glass-on-glass (tip + controls + sheet); (3) untinted pale glass sampling skin → beige sludge; (4) clear without ~35% dim over bright scenes.

**Fix for Outer Lens:** solid tip plate; regular (not clear) for small inner controls; clear only if localized dim + icon-only; never glass tip text; never unify inner + outer under one glass language (unequal jobs beat visual sameness).

### 13.6.6 Accessibility for glass & color

| Setting | Effect | Outer Lens check |
|---------|--------|------------------|
| **Reduce Transparency** | Glass frostier / more opaque | Inner icons still legible; tip already solid → tip OK |
| **Increase Contrast** | More B/W; borders | Amber CTA high-contrast variant; tip ink white on solid |
| **Reduce Motion** | Damps morph / gel | See §14 — crossfade/instant |
| **Dark Mode** | Adaptive layers | Capture shell already craft-dark `#050505` |
| **Dynamic Type / Bold Text** | Labels scale | Tip ≥28pt locked — verify plate doesn’t clip |

**Contrast targets:** ≤17pt → 4.5:1; ≥18pt or bold → 3:1. Tip at ≥28pt Semibold on solid panel clears easily; glass icons need a Reduce Transparency pass. Custom `.glassEffect` does **not** auto-fix itself.

---

## 13.7 FrostDuo cutover tokens (swap when `CUTOVER.flag`)

**Not a second product redesign.** Same `DesignSystem/Tokens.swift` branches on flag. SCR specs live in §12.

```css
[data-product="frostduo"] {
  --brand-name: "FrostDuo";
  --canvas: #F3F4F6;                /* soft paper/gray — not VaultDemo #0A0A0F */
  --panel: #FFFFFF;
  --ink: #1C1C1E;
  --ink-muted: rgba(28, 28, 30, 0.62);
  --frost-ice: rgba(200, 230, 240, 0.10); /* lock overlay tint 8–12% */
  --frost-ink: rgba(255, 255, 255, 0.70);
  --accent: #4A6B73;                /* quiet teal-slate — not purple, not red alert */
  --blur-cautious: 8px;
  --blur-threatened: 16px;
  --blur-locked: 24px;
  --dur-frost: 280ms;
  --dur-decoy: 400ms;
}
```

| Token ID | Value | Used by |
|----------|-------|---------|
| `Brand.nameFrost` | `"FrostDuo"` | Quiet corner SCR-FD-* |
| `Color.frostCanvas` | `#F3F4F6` | SCR-FD-A |
| `Color.frostAccent` | `#4A6B73` | Protect / Vault CTA |
| `Blur.cautious/threatened/locked` | 8 / 16 / 24 | Ladder |
| `Motion.durFrost` / `durDecoy` | 280ms / 400ms | F1 / F3 |

Frost lock chrome: sparse grain ~**0.25** density or material only; quiet **“Covered”** / **“Private”**. Hide traffic-light threat colors from Jane demo UI. Inner Protect / Simulate may use **regular monochrome glass** — **not** amber film tint, **not** refractive carnival glass on frost overlay or outer decoy.

---

## 13.8 Dual-display visual craft laws

From design-direction §5 — bind every asset and token choice:

1. **Unequal jobs** — Inner = capture / decide / control. Outer = subject coach **or** decoy stage. Never two dashboards glued at the crease.  
2. **Full-bleed thinking** — Preview / tip stage / decoy wallpapers edge-to-edge; chrome is a thin rail, not inset media cards.  
3. **One climax on glass** ≤30s — CCA tip appear **or** frost+decoy snap (not both in one demo path).  
4. ArrangementView / reserved regions for panes; **`onHingeChange` = effects only** (never layout color themes from hinge degrees).  
5. Outer: glanceable, large type, minimal chrome; non-interactive for CCA; designed placeholder for Frost decoy.  
6. Continuity of hierarchy closed↔open; tabletop = media↑ / controls↓.  
7. RC unlock must change the **other** display — amber oval (OL) or vault pack C (FD).  
8. Screenshot/demo must show crease, lit outer, or tabletop split — else it isn’t Duo.

---

## 13.9 Decoy packs & asset filenames (LANE-ASSETS)

**Root:** `DuoApp/Resources/Assets.xcassets/`  
**TCs:** **TC-A01** paths resolve · **TC-A02** decoy+coach on correct screens · **TC-A03** missing-asset → `PlaceholderMissing` (no crash).

### 13.9.1 Coach / Outer Lens (`Assets.xcassets/Coach/`)

| Filename (imageset) | Purpose | Screen |
|---------------------|---------|--------|
| `TipGlyphFrame.imageset` | Optional T1 leading glyph | SCR-OL-C T1 |
| `TipGlyphSmile.imageset` | Optional T1 glyph | SCR-OL-C |
| `TipGlyphLight.imageset` | Optional T1 glyph | SCR-OL-C |
| `GuideOvalMask.imageset` | Optional oval reference (prefer drawn `#E8A838` stroke) | SCR-OL-C T2 |
| `PaywallHeroOuterLens.imageset` | Folded Duo / tip pair | SCR-OL-D |
| `PermissionHeroCamera.imageset` | Primer illustration | SCR-OL-A |

Prefer **SF Symbols** when sufficient (`camera.fill`, `figure.stand`, etc.).

### 13.9.2 Frost (`Assets.xcassets/Frost/`)

| Filename (imageset) | Purpose | Pack / screen |
|---------------------|---------|---------------|
| `DecoyLockLookalike.imageset` | Calm lock wallpaper | **A** · SCR-FD-C |
| `DecoyBusyCover.imageset` | Busy / banal cover | **B** · SCR-FD-C |
| `DecoyVaultCover.imageset` | Editorial vault cover | **C** · SCR-FD-C Pro |
| `DecoyIdleCalm.imageset` | Pre-threat outer idle | SCR-FD-C idle |
| `FrostGrainSparse.imageset` | Optional sparse grain (~0.25) | SCR-FD-A locked |
| `PaywallHeroFrostDecoy.imageset` | frost→decoy pair | SCR-FD-D |
| `VaultPackCommuter.imageset` | Optional Pro skin | C variant |
| `VaultPackCafe.imageset` | Optional Pro skin | C variant |
| `VaultPackFlight.imageset` | Optional Pro skin | C variant |

**Must-ship stills:** Idle + **A** + **C** (B strongly recommended). No live wallpaper engine. Pre-Sat human prep allowed.

### 13.9.3 Shared (`Assets.xcassets/Shared/` + colorsets)

| Filename | Purpose |
|----------|---------|
| `AppIcon.appiconset` | Outer Lens brand |
| `AccentColor.colorset` | Map to `#E8A838` + Increased Contrast variant |
| `FilmCanvas.colorset` | `#050505` |
| `FilmPanel.colorset` | `#1C1C1E` |
| `FilmAccent.colorset` | `#E8A838` |
| `FrostCanvas.colorset` | `#F3F4F6` |
| `FrostAccent.colorset` | `#4A6B73` |
| `FrostIce.colorset` | Ice overlay |
| `PlaceholderMissing.imageset` | TC-A03 |
| `BrandMarkOuterLens.imageset` | Optional — prefer SF wordmark text |
| `BrandMarkFrostDuo.imageset` | Optional cutover |

### 13.9.4 Strings keys (COPY owns values)

**Path:** `Resources/Localizable.strings`

| Key | Mode | Use |
|-----|------|-----|
| `brand.outer_lens` | OL | Brand whisper |
| `brand.frostduo` | FD | Brand whisper |
| `tip.free.1` … `tip.free.3` | OL | T1 pack |
| `tip.countdown` | OL | T3 |
| `frost.status.covered` / `frost.status.private` | FD | Lock badge |
| `frost.cta.simulate` / `protect` / `unlock_vault` | FD | Controls |
| `paywall.matt.outer` / `paywall.matt.frost` | both | Matt lines |
| `perm.camera.outer` / `perm.camera.frost` | both | Info.plist mirror |

---

## 13.10 Paywall visual tokens (SCR-OL-D / SCR-FD-D)

| Element | Film Tool (OL) | Frost (FD) |
|---------|----------------|------------|
| Host | Inner only — `Features/Paywall/PaywallHostView.swift` | Same shared host |
| Sheet material | **System Liquid Glass sheet** — remove custom VE backgrounds | Same |
| Hero | `PaywallHeroOuterLens` — tip / oval story | `PaywallHeroFrostDecoy` — frost→decoy pair |
| Accent | Amber `#E8A838` CTAs | Teal-slate `#4A6B73` |
| After success | Inner check (`--success`) + **outer** T2 bloom | Inner check + **outer** pack C |
| Tone | Calm craft camera | Calm privacy — no matrix |

Paywall is **monetization chrome**, not a second Duo climax. The climax remains outer tip (OL) or frost+decoy (FD).

---

## 13.11 Do / Don’t (visual)

### Do

- Lead every surface with **Outer Lens** (or **FrostDuo** after cutover).  
- Lock canvas `#050505` and accent `#E8A838` for Film Tool.  
- One primary tip · max 8 words · ≥28pt SF Rounded · **solid** tip plate.  
- Liquid Glass **regular** on **inner** pills only; amber glass tint on Pro CTA only.  
- Ship Simulate tip / Pro / countdown (OL) and Simulate Threat (FD).  
- Photo-only shutter; essential controls stay inner.  
- Remix patterns only — cite Moments / PrivacyScreen / Shot Caller / Halide / SnapShield; never fork.

### Don’t

- Purple-on-white, cream+terracotta, broadsheet, cyber HUD.  
- Glass tip text over faces; glass shutter; carnival frost glass.  
- Paywall on the outer. Skeleton HUD on free tier.  
- Layout or theme tokens from hinge angle.  
- Second climax API in one build.  
- Invent Wizard / Prabaljit visuals.

---

## 13.12 Inspiration credit (pattern remix only)

| Credit | Steal | Leave |
|--------|-------|-------|
| Apple CCA / Tech Talks 111463–111466 | Outer subject script; ArrangementView tabletop | Second full outer app |
| Moments | Full-bleed outer preview + status capsule | Social platform |
| Shot Caller | Dark canvas, huge countdown, shutter scale | Multipeer |
| Halide | Clutter-free craft camera | Manual RAW depth |
| PrivacyScreen | Threat ladder, blur radii, Simulate | VaultDemo chrome, dense scatter |
| SnapShield | Believable placeholder → decoy language | Capture-shield as primary sensing |
| Apple Liquid Glass (WWDC25-219/323) | Functional-layer glass on inner rails | Glass tip over faces |
| iOS 26 Camera simplification | Fewer floating plates; content-first | Cloning Apple Camera chrome |

---

## 13.13 LANE-ASSETS acceptance & handoff

| TC | Assertion |
|----|-----------|
| **TC-A01** | §13 paths resolve in asset catalog |
| **TC-A02** | Decoy + coach assets appear on correct SCR |
| **TC-A03** | Missing asset shows `PlaceholderMissing` — no crash |
| Visual win (OL) | Charcoal `#050505` + amber `#E8A838` Pro; brand **Outer Lens** visible |
| Visual win (FD) | Ice-soft frost; quiet Covered/Private; no cyber HUD |

**Handoff OUT:** catalog IDs + token constants for LANE-CCA / LANE-FROST / LANE-RC sheets.  
**Handoff IN:** this chapter + design-direction + ios-craft-addendum.  
**Path mutex:** `DesignSystem/Tokens.swift` and `Assets.xcassets/**` owned by LANE-ASSETS; feature lanes consume — do not fork private hex literals in feature files.

---

## 13.14 UNKNOWN register

| Item | Status | Owner |
|------|--------|-------|
| Exact Asset Catalog recipe for amber glass tint + Increased Contrast | Build-time | ASSETS Sat |
| Whether CCA outer accessory host auto-applies system Liquid Glass | Verify on Duo sim/hardware | SHELL / CCA |
| Full `glassEffect` overload list / availability macros | Confirm in Xcode SDK | CCA |
| Thermal/FPS cost of `GlassEffectContainer` over AVCapture preview | Instruments on device if time | Polish |
| Best shutter under LG era (solid vs glassProminent) | Craft lock = **solid** | — |

---

## 13.15 Saturday checklist (ASSETS + CCA)

1. Paste Film Tool tokens into `Tokens.swift` — `#050505` / `#E8A838` first.  
2. Tip plate solid + scrim ≥0.55 — refuse glass tip PRs.  
3. Inner pills → `.glass` / regular; shutter solid; Pro CTA amber-tint once.  
4. Paywall sheet = system glass; drop custom blur backgrounds.  
5. Catalog: Coach glyphs (or SF) + Frost Idle/A/C (+B) + PlaceholderMissing.  
6. Reduce Transparency + Increase Contrast smoke on tip + Pro CTA.  
7. If `CUTOVER.flag` — swap frost token branch; do not keep amber film on Frost chrome.  
8. Align `--dur-*` / press scales with `DesignSystem/Motion.swift` (§14 M1–M3 / F1–F3 / P1–P3).

---

## 13.16 PLACEHOLDER_RC_* (human — never invent in AI)

**DECISION:** LANE-RC and LANE-ASSETS must not invent RevenueCat dashboard IDs. Human pastes into `docs-runtime/RC-IDs.md` before configure:

```text
PLACEHOLDER_RC_API_KEY=
PLACEHOLDER_RC_ENTITLEMENT_ID  # expect: pro
PLACEHOLDER_RC_OFFERING_ID=
PLACEHOLDER_RC_PACKAGE_ID=
PLACEHOLDER_RC_PRODUCT_ID=
PLACEHOLDER_RC_PAYWALL_PUBLISHED=
```

Empty placeholders → GATE-RC **BLOCKED**. Paywall chrome may use Film Tool / Frost tokens, but unlock proof still requires filled IDs + other-pane M3/F3.

---

*End of §13. Pair with §14 for motion IDs (`DesignSystem/Motion.swift`, `--dur-*`, press scales, hinge effects-only, CCA tip settle, paywall transitions, hover→press remap).*
