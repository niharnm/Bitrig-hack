# Outer Lens — locked visual direction

**For:** Nihar · Bitrig Hacks iPhone Duo · Sat Sep 26, 2026  
**Product (primary):** **Outer Lens** — subject coach on Duo’s outer while you shoot from the inner  
**Cutover (hour-one):** **FrostDuo** — inner progressive frost + outer decoy vault  
**Role:** Locked look / flow for bible §13–§14 (and SCR maps in §11–§12)  
**Compiled:** Sat Sep 26, 2026 · from four design-research packs + iOS craft wave (Liquid Glass / hover / award) + bible/routing/mix boards  
**Constraint:** Spec only — no Saturday app sources in this doc

---

## 0. Direction lock (one paragraph)

**Outer Lens** is a **Film Tool**: brand-first charcoal capture craft where the picture is the hero and the outer face is a single readable coach line for the person in front of the camera. Full-bleed preview on both roles (inner capture / outer subject stage). Free outer tip; Pro blooms a guide oval on the **other** pane after RevenueCat. If CCA is red by ~12:15, flip to **FrostDuo**: ice-soft frost on the inner secret surface and a calm, believable decoy on the outer — never malware HUD.

**Brad (Outer Lens, frozen):** Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.

**Brad (FrostDuo, cutover):** Shoulder-surfers ruin private screens — Duo frosts the inner face and shows a decoy on the outer; Pro unlocks vault decoys.

---

## 1. Visual thesis

| Axis | Outer Lens (default) | FrostDuo (cutover) |
|------|----------------------|--------------------|
| Mood | Craft camera · Halide-quiet | Soft privacy · ice, not CCTV |
| Hero | Live preview + tip | Inner content → milky; outer becomes someone else’s phone |
| Brand signal | Wordmark **Outer Lens** ≥ tip chrome; never buried in nav alone | Wordmark **FrostDuo** quiet corner; product noun = outer decoy vault |
| Room test | Tip readable at 2–3 m | Frost + decoy mismatch readable at 3–5 m without a meter |

**Banned AI-slop clusters (hard):** purple→indigo / purple-on-white; cream `#F4F1EA` + terracotta serif; broadsheet hairlines / zero-radius dense columns; glow stacks; emoji chrome; pill *clusters*; card soup in the hero minute.

**Justified craft-dark:** Capture + outer coach stay charcoal because “content is the picture” (Shot Caller / Halide / Moments accessory). Not a generic dark landing page.

---

## 2. CSS-like tokens

### 2A. Outer Lens — Film Tool (ship these)

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
  --record: #F5453A;                /* only if video ships (default: photo-only) */

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

  /* Motion */
  --ease-out: cubic-bezier(0.16, 1, 0.3, 1);
  --dur-tip: 220ms;
  --dur-shutter: 120ms;
  --dur-pro-bloom: 360ms;

  /* Liquid Glass + press (additive — §10) */
  --glass-variant: regular;           /* never clear over faces */
  --glass-tint-pro: rgba(232, 168, 56, 0.35); /* Pro CTA only */
  --press-fill: rgba(255, 255, 255, 0.12);
  --press-scale-shutter: 0.94;
  --press-scale-side: 0.96;
  --dur-press: 120ms;
}
```

**Type stack (LOCKED)**

| Role | Face | Size / weight |
|------|------|---------------|
| Brand whisper | SF Pro Medium | 13–15pt · `--ink-muted` |
| Outer primary tip | **SF Rounded Semibold** | ≥28pt · `--ink` |
| Countdown | SF Rounded Bold / monospacedDigit | 120–180pt |
| Inner controls | SF Pro Semibold symbols | ~19pt icons |
| Paywall title | SF Pro Bold | Title2 |
| Body / errors | SF Pro Regular | Body |

No Inter / Roboto / Arial / system UI as display. No decorative serif for tips.

### 2B. FrostDuo cutover tokens (swap when `CUTOVER.flag`)

```css
[data-product="frostduo"] {
  --brand-name: "FrostDuo";
  --canvas: #F3F4F6;                /* soft paper/gray room-readable — not VaultDemo #0A0A0F */
  --panel: #FFFFFF;
  --ink: #1C1C1E;
  --ink-muted: rgba(28, 28, 30, 0.62);
  --frost-ice: rgba(200, 230, 240, 0.10); /* lock overlay tint 8–12% */
  --frost-ink: rgba(255, 255, 255, 0.70);
  --accent: #4A6B73;                /* quiet teal-slate CTA — not purple, not red alert */
  --blur-cautious: 8px;
  --blur-threatened: 16px;
  --blur-locked: 24px;
  --dur-frost: 280ms;               /* easeInOut 0.2–0.3s */
  --dur-decoy: 400ms;               /* Pro vault crossfade */
}
```

Frost lock chrome: sparse frost grain (~0.25 density) or material only; quiet “Covered” / “Private” — **never** “THREAT / INTRUDER.” Hide traffic-light threat colors from Jane demo UI.

---

## 3. Screen map

### 3A. Outer Lens (primary) — SCR-OL-*

| ID | Screen | Who | Job | States |
|----|--------|-----|-----|--------|
| **OL-A** | Permission primer | Photographer (inner) | Why camera → system alert | empty → requesting |
| **OL-B** | Capture shell | Photographer (inner) | Full-bleed preview · shutter · flip · tip pack · Pro CTA · Subject toggle (if available) | starting · live · denied · accessory.unavailable |
| **OL-C** | Subject coach | Subject (outer via CCA) | Preview or tip-only stage · **one** tip · optional countdown · Pro guide oval | tips.free (T1) · tips.pro (T2) · countdown (T3) · visionMiss→T1 |
| **OL-D** | Paywall | Photographer (inner only) | RevenueCatUI Test Store → `pro` | locked · purchasing · success |
| **OL-E** | Empty / error | Photographer | Settings path; accessory unavailable without bricking capture | denied · unavailable |

**Tip styles (hard cap = 3)**

| ID | Name | Tier |
|----|------|------|
| **T1** | Line tip | Free — one sentence + optional SF Symbol |
| **T2** | Guide tip | Pro — T1 + faint oval / thirds / shoulder guide in `--accent` |
| **T3** | Countdown | Any — huge numeral; tip dims during count |

**Inner chrome (Film Tool)**  
Top: close · Subject screen toggle · tip pack menu.  
Bottom: flip · **◎ shutter ~80pt** · Pro coaching pill (trailing).  
Canvas `#050505`. **Liquid Glass regular** (or `.buttonStyle(.glass)`) on **inner control pills only**; shutter stays **solid**; outer tip = solid plate / scrim. Prefer system glass over hand-rolled `ultraThinMaterial`.

**Outer chrome**  
Brand whisper top · tip plate bottom-third · no shutter · no paywall · no settings. Interaction: none required (optional tap-to-focus only if hour ≥3 green).

**Pose polish (optional, after CCA green)**  
Tabletop ArrangementView: preview **up**, controls **down**. Same hierarchy — not a new feature. Hinge never drives layout.

### 3B. FrostDuo (cutover) — SCR-FD-*

| ID | Screen | Job |
|----|--------|-----|
| **FD-A** | Sensitive surface (inner) | One mail/notes surface; progressive frost ladder |
| **FD-B** | Controls / Simulate (inner) | Protect · Simulate Threat · Pro vault CTA — bottom or trailing |
| **FD-C** | Outer decoy stage | Idle → lock decoy → Pro vault pack |
| **FD-D** | Paywall (inner) | Unlock Cover Vault → other-pane decoy upgrade |
| **FD-E** | Closed-cover (nice) | Outer-only vault showcase |

**Threat ladder (visual)**  
`.clear` → `.cautious` (blur 8) → `.threatened` (blur 16 + light wash) → `.locked` (full frost + sparse grain + quiet “Covered”).

**Outer decoys (LOCKED)**

| Pack | Role |
|------|------|
| **A — Lock Lookalike** | Free teaser default — calm lock, large time, banal wallpaper |
| **B — Busy Cover** | Demo climax pack — 2–3 innocuous bubbles / “Busy until 4” (generic names only) |
| **C — Vault Cover** | Pro unlock reveal — editorial frosted cover + quiet glyph + pack name |

Idle outer before threat: **calm wallpaper** (not a second clock app). Free locked: **A**. Pro after purchase: **C** (with B as selectable pack).

**Primary demo pose for Frost:** **tabletop** (content above crease, controls below). Book = backup dual-pane clarity.

---

## 4. Motion (intentional only)

Honor Reduce Motion → crossfade / instant.

### Outer Lens (exactly three)

| # | Name | Where | Spec |
|---|------|-------|------|
| **M1** | Tip settle | Outer T1 | Fade + rise 8–12pt · 220ms `--ease-out` |
| **M2** | Countdown punch | Outer T3 | `numericText` + snappy scale · room climax |
| **M3** | Pro unlock bloom | Outer T1→T2 | Accent oval strokes in + tip flash · inner CTA → check · **other-pane proof** |

Optional micro (drop if late): dual-pane capture flash. Prefer §10 press micros (P1–P3) over inventing new climax motion.

### FrostDuo (cutover three)

| # | Name | Spec |
|---|------|------|
| **F1** | Frost settle | Threat step · easeInOut ~280ms · whole pane goes milky |
| **F2** | Decoy snap | Outer idle → A/B at lock · paired with F1 |
| **F3** | Vault crossfade | Pro unlock · outer → pack C · 400ms calm · no confetti |

**Do not ship:** parallax noise, continuous glow pulse, skeleton dance, confetti, Cosign-level gel theater as primary climax, Accorduon bellows as product.

---

## 5. Dual-display choreography (craft laws)

From Duo-native craft + Outer Lens / Frost packs:

1. **Unequal jobs** — Inner = capture / decide / control. Outer = subject coach **or** decoy stage. Never two dashboards glued at the crease.
2. **Full-bleed thinking** — Preview / tip stage / decoy wallpapers edge-to-edge; chrome is a thin rail, not inset media cards.
3. **One climax on glass** in ≤30s — CCA tip appear **or** frost+decoy snap (not both in one demo path).
4. ArrangementView / reserved regions for panes; **`onHingeChange` = effects only**.
5. Outer: glanceable, large type, minimal chrome; non-interactive for CCA; designed placeholder for Frost decoy (SnapShield idea, not blank black).
6. Continuity of hierarchy closed↔open; tabletop = media↑ / controls↓.
7. RC unlock must change the **other** display.
8. Screenshot/demo must show crease, lit outer, or tabletop split — else it isn’t Duo.

---

## 6. Do / Don’t

### Do

- Lead every surface and pitch with **Outer Lens** (or **FrostDuo** after cutover) as brand-first signal.
- One primary tip · max 8 words · ≥28pt · solid tip plate.
- Amber film `#E8A838` for all Pro / unlock moments.
- Ship Simulate tip / Simulate Pro / Simulate countdown (Outer Lens) and Simulate Threat (FrostDuo).
- Photo-only shutter; essential controls stay inner.
- Remix patterns only — cite, never fork Moments / PrivacyScreen / Shot Caller / ClawKit / etc.

### Don’t

- Purple-on-white, cream+terracotta serif, broadsheet columns, cyber HUD, matrix green.
- Paywall on the outer. Tip lists / icon grids / floating face badges on outer.
- Skeleton HUD on free tier. Traffic-light threat chrome in Jane’s 90s.
- Accorduon / Flex video / Flip launcher / chat-on-fold as the product.
- Layout from hinge angle. Android fold chrome. Second climax API in one build.
- Invent Wizard / Prabaljit visuals (not public).

---

## 7. Inspiration credit list (pattern remix only)

| Credit | Steal | Leave |
|--------|-------|-------|
| Apple CCA + CameraCaptureAccessory docs / Tech Talks 111463–111466 | Outer = subject script/countdown; ArrangementView tabletop | Second full outer app |
| [Moments](https://github.com/Lazynius1/Moments) CCA | Full-bleed outer preview + status capsule | Social platform |
| [Shot Caller](https://github.com/RF-Nelson/open-source-selfie-stick) | Dark canvas, huge countdown, shutter scale | Multipeer / pairing |
| [Halide](https://halide.cam/) | Clutter-free craft camera taste | Manual RAW depth |
| [PrivacyScreen](https://github.com/abhay/PrivacyScreen) | Threat ladder, blur radii, Simulate / `-demo` | VaultDemo finance chrome, dense pixel scatter |
| [SnapShield](https://github.com/EmadBeyrami/SnapShield) | Believable placeholder → outer decoy language | Capture-shield as primary sensing |
| [ClawKit](https://github.com/artemnovichkov/ClawKit) | Dual-role choreography, tabletop cabinet idea, outer shelf continuity | Claw game as entry |
| [Cosign](https://github.com/ScaleWithEzra/cosign-ios) | Book roles; pose moves placement not story | Gel metaball as required climax |
| CapWords (ADA 2025 article) | Tip settle as latency delight | Sticker language game |
| All Climb / Play Melody (SSC) | Tip-over-body; Guide→Practice→Perform | Full sport/music apps |
| Browser Brawl / Phantom (YC hack OSS) | Dual-role live stage; one threshold snap | Arcade / pentest chrome |
| build-your-phone (GStack) | HIG screenshot review mindset | Devtool as product |
| Kyle / Bitrig Duo blogs | Invent interactions Apple might ship; media↑ controls↓ | — |
| Samsung fold scans | Cover-as-stage / subject≠controls *ideas only* | Flex / Flip / WindowArea chrome |

**UNKNOWN / do not invent UI for:** Wizard, Prabaljit June app, Bitrig 3rd-place project (no public OSS this wave).

---

## 8. 90s visual checklist

**Outer Lens**

1. Brand **Outer Lens** visible · inner black → grant → preview live.  
2. Outer T1 tip readable at 2–3 m (M1).  
3. Countdown once (M2).  
4. Pro coaching → paywall **inner** → purchase → outer T2 bloom (M3).  
5. Flip once; tip still legible.  
6. Simulate tip ready if CCA/Vision flakes.

**FrostDuo (cutover)**

1. Clear mail/notes · calm outer.  
2. Tabletop reflow (content↑ controls↓).  
3. Simulate Threat → frost + decoy A/B (F1+F2).  
4. Unlock vault → outer → C (F3).  
5. On-device / faces-never-leave line available for Jane.

---

## 9. Bible handoff

Feed this file into:

- **§13 Visual system & assets** — tokens 2A/2B (+ §10 glass/press), tip styles, decoy packs A–C  
- **§14 Interaction & motion** — M1–M3 / F1–F3 + §10 P1–P3  
- **§11 / §12 Screen specs** — SCR-OL-* / SCR-FD-*  
- **LANE-ASSETS / LANE-COPY / LANE-CCA / LANE-FROST** per `docs/multi-ai-build-routing.md`

Ready signal: `docs/design-research-ready.md`  
iOS craft summary: `docs/ios-craft-addendum.md`

---

## 10. Liquid Glass + iOS 26 craft (additive)

**Does not replace** Film Tool charcoal `#050505` / amber `#E8A838` / solid outer tip. Layers iOS 26 Liquid Glass + phone-first press feel on top. Sources: `internal/design-research-liquid-glass.md`, `internal/design-research-ios-hover-minimal.md`, `internal/design-research-award-ios-ui.md`.

### 10A. Token additions

| Token | Value | Use |
|-------|-------|-----|
| `--glass-variant` | `regular` (default) | Inner control pills; adaptive blur + luminosity |
| `--glass-clear` | clear + ~35% dark dim | **Rare** — icon-only over calm media; never tip copy |
| `--glass-tint-pro` | amber soft on regular glass | **Only** Pro coaching CTA (`.glassEffect(.regular.tint(…).interactive())`) |
| `--press-fill` | white @ 12% | Brief fill under finger on side symbols if glass interactive unavailable |
| `--press-scale-shutter` | `0.94` | Shutter press (P1) |
| `--press-scale-side` | `0.96` | Flip / tip pack / Subject press |
| `--dur-press` | `120ms` · `--ease-out` | All press morphs |
| API preference | `.buttonStyle(.glass)` / `.glassProminent` · one `GlassEffectContainer` | Prefer system styles over stacked custom `.glassEffect` |

Sheets / paywall: **system Liquid Glass sheet** — remove custom visual-effect backgrounds. Fall back to `ultraThinMaterial` only if SDK < 26.

### 10B. Where glass is allowed vs forbidden

| Surface | Material | Why |
|---------|----------|-----|
| **Allowed — tip plate?** | **No — solid `--panel` + `--scrim` ≥0.55** | Outer tip must read at 2–3 m over busy faces; glass over skin = muddy |
| **Allowed — inner control pills** | Liquid Glass **regular** (flip · tip pack · Subject · close) | Functional layer over preview |
| **Allowed — Pro CTA** | Regular glass + **amber tint** (one prominent) | Selective tint; not every icon |
| **Allowed — sheets / paywall / menus** | System glass | Auto-adopt; Settings = one sheet |
| **Allowed — optional status capsule** | Regular glass, small, no tip text | Never clear over a face without dim |
| **Forbidden — outer subject face / tip text** | Solid only | Room test + CCA non-interactive coach |
| **Forbidden — live preview / guide oval fill** | Content layer stays charcoal + accent **stroke** | Picture is the hero (Halide / Darkroom) |
| **Forbidden — shutter disc** | **Solid** white/near-white ring on charcoal | Craft affordance; avoid gel morph as climax |
| **Forbidden — FrostDuo frost / decoys** | Ice-soft **standard blur / materials** on content | Frost is privacy treatment, **not** refractive carnival Liquid Glass; outer decoy = believable wallpaper, no craft-camera glass HUD |
| **Forbidden — glass-on-glass / clear+regular mix / purple glass** | — | Collapsed contrast + banned AI-slop |

**Rule:** Liquid Glass = **functional layer** only. Content = solid canvas / solid tip / frost blur. Unequal panes — do not unify inner + outer under one glass language.

### 10C. Minimal chrome rules for shutter

1. **Bottom rail only:** flip · **◎ shutter ~80pt** · Pro coaching pill (trailing). No mode carousel, no second settings strip.  
2. **Shutter = solid craft circle** (72–88pt) — not glass blob, not clear ring theater. Breathing room ≥16pt from side controls.  
3. **Top rail whisper:** close · Subject · tip pack — glass pills, monochrome / hierarchical SF Symbols (~19–22pt), hit ≥48pt, contiguous (no gaps).  
4. **Everything else → one Settings sheet** (Simulate tip / Pro / countdown). Progressive disclosure like iOS 26 Camera / Final Cut Camera — not permanent HUD.  
5. **Preview full-bleed;** chrome floats as thin rails — no inset media cards, no pill clusters, no icon grids on outer.  
6. **Pointer hover theater skipped** for phone 90s — touch press is the craft story (see P1–P3).

### 10D. Micro-interactions for demo polish (exactly three)

Cap additive press feel; do **not** replace M1–M3 climax story. Reduce Motion → crossfade / instant.

| # | Name | Where | Spec |
|---|------|-------|------|
| **P1** | Shutter press | Inner ◎ | Scale `--press-scale-shutter` (0.94) · `--dur-press` 120ms · `--ease-out` · optional light haptic — Halide / (Not Boring) *feel* without 3D toy chassis |
| **P2** | Glass brighten | Inner side pills | `.interactive()` glass reaction **or** brief `--press-fill` · same 120ms — phone-safe “spotlight”; no idle shimmer |
| **P3** | Pro press → check | Inner Pro CTA | Press scale/tint flash → paywall success → amber check; outer T2 bloom remains **M3** (other-pane proof). Optional late: one tip-pack `GlassEffectContainer` morph into menu — drop if clock tight |

**Do not ship as polish:** pointer-only hover, continuous glass shimmer, nested glass, decorative focus rings, Cosign-level gel as climax.
