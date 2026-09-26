# §03 — Judge & sponsor beat map

**Bible chapter:** `docs/bible/03-judge-sponsor-beats.md`  
**For:** Orchestrator · LANE-DEMO · LANE-COPY · feature lanes (what must be visible on glass)  
**Event:** Bitrig Hacks: iPhone Duo · Sat Sep 26, 2026 · YC SF · demos 3:30–5:00  
**Panel:** **Eight** judges (Grokbot’s five-name table is stale)  
**Maps to:** Demo seconds in `docs-runtime/DEMO-SCRIPT.md` · SCR-OL-* / SCR-FD-* · RC unlock · brand chrome  
**Upstream:** `docs/duo-research-briefing.md` §2 · `internal/judges-extras-scout.md` · `internal/sponsors-patterns.md` · `docs/win-completeness-bar.md` · `docs/luma-chat-intel.md`  
**Compiled:** Sat Sep 26, 2026 · **no Swift in this chapter**  
**UNKNOWN:** Whether all eight sit every demo or rotate — design beats for all eight anyway.

---

## 0. How to use this chapter

1. Build the **one** Outer Lens (or Frost cutover) path in §01 — do not build eight apps.  
2. Ensure each judge’s **primary beat** appears at a named demo second.  
3. Sponsor depth follows the priority stack in §10 — Duo + RC critical path; others skip.  
4. If a beat requires Frost-only glass and you are still GREEN on Outer Lens, hit Jane with **clever dual-face tip** instead of forcing frost into the same demo.

---

## 1. Panel roster (live Luma)

| # | Judge | Org / lens | Primary affinity for Outer Lens |
|---|-------|------------|----------------------------------|
| 1 | **Kyle Macomber** | Bitrig CEO; SwiftUI co-creator | Real Duo API + craft delight |
| 2 | **Brad Flora** | YC GP | Anti-kabuki who/pain/why-now |
| 3 | **Justin Santamaria** | Future; early iPhone | Two-display human communication |
| 4 | **Yuma Soerianto** | 5× WWDC SSC; robotics educator | Student craft + phone-as-body seriousness |
| 5 | **Jane Manchun Wong** | RE / security | Clever dual-face + privacy awareness |
| 6 | **Ari Weinstein** | OpenAI; Shortcuts/Sky | Assistant that acts in context — not chat chrome |
| 7 | **Matt Berry** | RevenueCat Partnerships | Real Test Store purchase → other pane |
| 8 | **Thomas Karatzas** | Terse F26; ex–Apple Intelligence | Durable on-device agent feel / pose→tool |

Winner hardware (Luma): **a new iPhone Duo** (not “a new iPhone”).

---

## 2. Master timeline — Outer Lens GREEN (90s)

Every judge beat pins to a second. Paths listed are Saturday targets.

| Sec | Glass / path | Spoken | Judges primarily served |
|----:|--------------|--------|-------------------------|
| **0:00–0:10** | SCR-OL-B brand **Outer Lens** · Brad | Brad frozen line | **Brad** (sentence) · all (noun) |
| **0:10–0:15** | SCR-OL-A → grant → SCR-OL-B live preview | Minimal | Reliability · Hsu “don’t mock core” |
| **0:15–0:40** | SCR-OL-C T1 tip via CCA (`CameraCaptureAccessoryHost.swift`) · M1 | Silence / “watch the outer” | **Kyle** · **Justin** · **Jane** · **Ari** (instrumented tip) · **Thomas** (concrete coach tool) |
| **0:40–0:55** | SCR-OL-B flip once · tip stays | — | **Kyle** (craft) · **Yuma** (serious playful control) |
| **0:50–1:05** | SCR-OL-D RevenueCatUI paywall (inner) | Matt line starts | **Matt** |
| **1:05–1:20** | Outer T2 amber oval bloom M3 · `EntitlementState.isPro` | Matt free-vs-Pro | **Matt** · **Brad** (who pays) · **Kyle** (other-pane proof) |
| **1:20–1:30** | Close · ask | Who pays / why Duo | **Brad** · room |

**Backup 60s map:** 0:00 Brad → 0:10 tip climax → 0:30 purchase → 0:45 bloom → 0:55 close. Still covers Kyle/Justin/Matt/Brad; compress Jane/Yuma into tip+flip.

### 2.1 FrostDuo cutover timeline (if RED)

| Sec | Glass / path | Judges primarily served |
|----:|--------------|-------------------------|
| **0:00–0:15** | SCR-FD-A clear sensitive · calm outer | **Brad** (Frost Brad) · **Justin** (roles) |
| **0:15–0:35** | SCR-FD-B Simulate Threat | **Jane** · reliability |
| **0:25–0:45** | SCR-FD-C frost + decoy A/B · F1+F2 | **Jane** (wow) · **Kyle** (Arrangement dual-face) · **Yuma** |
| **0:50–1:05** | SCR-FD-D paywall | **Matt** |
| **1:05–1:20** | Outer vault C · F3 | **Matt** · **Brad** |
| **1:20–1:30** | On-device / faces-never-leave line | **Jane** · **Ari** (local action) · **Thomas** |

---

## 3. Judge cards — deep beats → demo seconds

### 3.1 Kyle Macomber (Bitrig / SwiftUI)

**Public signal (cite):** SwiftUI co-creator; Bitrig “native SDK”; Duo blog highlights pose adaptation, `onHingeChange`, `ArrangementView`, `CameraCaptureAccessory`; taste for delightful micro-detail ([Bitrig Duo blog](https://bitrig.com/blog/bitrig-builds-iphone-duo-apps); [9to5Mac Sep 21](https://9to5mac.com/2026/09/21/ai-coding-platform-bitrig-adds-iphone-duo-support-with-interactive-3d-simulator/); judges-extras §1.1).

| Beat # | What Kyle should see | Demo sec | Path / TC |
|-------:|----------------------|----------|-----------|
| K1 | Named Duo API in first 30s — not stretched iPhone layout | **0:15–0:40** | `CameraCaptureAccessoryHost.swift` · TC-C01 |
| K2 | Interaction that feels inventable / first-class (subject coach on outer) | **0:15–0:40** | SCR-OL-C |
| K3 | Pose chrome / Arrangement regions behave | pre-demo shell · optional flip **0:40–0:55** | `PoseRouter.swift` · TC-S02 |
| K4 | Film Tool craft — charcoal, solid shutter, tip settle M1 | **0:15–0:40** · polish | `Tokens.swift` · `Motion.swift` |
| K5 | Optional Bitrig-built affinity | Only if prize confirmed Sat AM (**UNKNOWN**) | ask organizers |

**Do not show Kyle:** Accorduon clone · hinge-driven layout · Android fold chrome · five half-features.

**Frost alternate:** Dual-face frost+decoy at **0:25–0:45** still proves Arrangement / two displays (K1/K2 via different API surface).

---

### 3.2 Brad Flora (YC GP)

**Public signal:** Anti-kabuki; concise declarative founders; small learnable wedge; pace of learning ([Mercury/Series Tea](https://mercury.com/blog/brad-flora); Garry Tan concise-founders attribution; judges-extras §1.2).

| Beat # | What Brad should hear/see | Demo sec | Path / TC |
|-------:|---------------------------|----------|-----------|
| B1 | One plain YC sentence (frozen Brad) | **0:00–0:10** | DEMO-SCRIPT · TC-P01 |
| B2 | Small wedge — parents/kids framing — not platform | whole 90s | kill list §02 |
| B3 | Someone who would pay (Matt beat doubles) | **0:55–1:20** | TC-P03 · TC-R04 |
| B4 | Earnest vertical slice — no fake metrics / stack dump | all | DEMO-LAST-PASS |

**Frozen line (do not rewrite):**  
Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.

**Frost alternate Brad at 0:00–0:10:** shoulder-surfers / frost / decoy / Pro vault (TC-P02).

---

### 3.3 Justin Santamaria (Future; early iPhone)

**Public signal:** Phone/Messages/FaceTime-era communication; Future as coaching advocate; care about details ([AppleInsider](https://appleinsider.com/articles/22/04/04/former-lead-apple-engineer-justin-santamaria-talks-imessage-facetime-more-on-the-appleinsider-podcast); judges-extras §1.3).

| Beat # | What Justin should see | Demo sec | Path / TC |
|-------:|------------------------|----------|-----------|
| J1 | Two-display choreography: photographer inner / subject outer | **0:15–0:45** | SCR-OL-B + SCR-OL-C |
| J2 | Human communication metaphor (coach ↔ subject) — not Android gimmick | **0:15–0:45** | CCA tip readable at 2–3 m |
| J3 | One polished flow > many half features | whole script | DoD §01 |
| J4 | Tip stays after flip (continuity) | **0:40–0:55** | SCR-OL-C persistence |

**Do not show Justin:** Second dashboard glued at crease · paywall on outer · chat tabs.

**Frost alternate:** Inner private / outer decoy roles at **0:25–0:45** = two-person deception choreography (still communication-shaped).

---

### 3.4 Yuma Soerianto (SSC / robotics educator)

**Public signal:** 5× WWDC scholar; Ro/Box STEM; teaches coding; June Bitrig judge continuity ([madebyyuma.com](https://www.madebyyuma.com/); judges-extras §1.4).

| Beat # | What Yuma should see | Demo sec | Path / TC |
|-------:|----------------------|----------|-----------|
| Y1 | Real Swift craft on Duo — not wrapper | **0:15–0:55** | Capture + Coach |
| Y2 | Phone-as-body seriousness (subject faces coach stage) without needing a robot | **0:15–0:40** | SCR-OL-C |
| Y3 | Playful but serious learning angle (tips teach pose/framing) | tip copy ≤8 words | Localizable · T1 |
| Y4 | Clean controls (shutter / flip) feel intentional | **0:40–0:55** · P1 | SCR-OL-B |

**Do not:** Overplay age narrative; ship PoseAgent sprawl “for Yuma.”

**Frost alternate:** Tabletop content↑ controls↓ + Simulate Threat = physical/pose seriousness at **0:15–0:45**.

---

### 3.5 Jane Manchun Wong (RE / security)

**Public signal:** Surprise / “how did you notice that?”; lighter more secure transparent apps; privacy-aware ([BBC](https://www.bbc.com/news/technology-47630849); judges-extras §1.5).

| Beat # | What Jane should see | Demo sec | Path / TC |
|-------:|----------------------|----------|-----------|
| N1 | Clever dual-face: tip on **subject** face while shooter controls inner | **0:15–0:40** | SCR-OL-C |
| N2 | On-device / no unnecessary cloud story (static tips OK) | if asked / close | no OpenAI required |
| N3 | Optional wow: Simulate tip when sim flakes — honest about limits | rehearsal | Settings Simulate |
| N4 | **If cutover:** frost + believable decoy mismatch at room distance | **0:25–0:45** | SCR-FD-C · TC-F01/F02 |
| N5 | Quiet privacy chrome — never THREAT/INTRUDER banners | Frost strings | design-direction §2B |

**Outer Lens Jane strategy (GREEN):** Win her with **clever subject-face coach**, not by bolting frost into the same path.  
**Cutover Jane strategy:** Primary Jane demo — Simulate Threat → Covered → decoy.

---

### 3.6 Ari Weinstein (OpenAI; Shortcuts / Sky)

**Public signal:** AI that understands context and **takes action in apps**; Shortcuts lineage; June Bitrig judge ([TechCrunch Sky acquisition coverage](https://techcrunch.com/2025/10/23/openai-buys-sky-an-ai-interface-for-mac/); judges-extras §1.6).

| Beat # | What Ari should see | Demo sec | Path / TC |
|-------:|---------------------|----------|-----------|
| A1 | Coach **instrumented into Duo displays** — tip is an action on the outer face, not a chat box | **0:15–0:40** | SCR-OL-C |
| A2 | Prefer on-device / static tips for climax; OpenAI only if hard multimodal needed (**default skip**) | — | kill FM load-bearing |
| A3 | Assistant-that-acts framing: tip changes what the subject does | spoken if needed | COPY optional line |
| A4 | **Avoid** generic ChatGPT chrome | whole app | theme contract §2A |

**Do not:** Add chat tab “for Ari.” That is DQ-adjacent.

**Frost alternate:** Local threat→frost action without cloud = automation taste at **0:15–0:45**.

---

### 3.7 Matt Berry (RevenueCat Partnerships)

**Public signal:** Partnerships / Shipaton judging; real monetization infrastructure ([RevenueCat author](https://www.revenuecat.com/blog/author/matt-berry); judges-extras §1.7). Organizer email: must use RC SDK for RC prize path; Luma lists Matt + sponsor but **no separate RC prize bullet** → **UNKNOWN** trophy; still ship purchase.

| Beat # | What Matt should see | Demo sec | Path / TC |
|-------:|----------------------|----------|-----------|
| M1 | RevenueCatUI paywall presents | **0:50–1:05** | `PaywallHostView.swift` · TC-R02 |
| M2 | Test Store **Successful Purchase** | inside **0:50–1:15** | TC-R03 |
| M3 | Entitlement `pro` flips `EntitlementState.isPro` | observe | `Entitlements.swift` |
| M4 | Unlock visible on **other** display (outer T2) | **1:05–1:20** | TC-R04 · M3 motion |
| M5 | One free-vs-Pro sentence | ~**0:55** / ~**1:20** | TC-P03 |
| M6 | Cancel/Fail once still locked | rehearsal | TC-R05 |

**Frozen Matt line:** Free: outer preview. Pro: pose overlays on the outer display.

**Config path:** Human `docs-runtime/RC-IDs.md` · `PLACEHOLDER_RC_*` rules in §00 · `PurchasesConfig.swift` · SPM ≥5.43.0.

**Frost alternate:** Same M1–M6 with unlock → decoy pack C (F3).

---

### 3.8 Thomas Karatzas (Terse; ex–Apple Intelligence)

**Public signal:** Durable agent workflows; Apple Intelligence / Siri background; respects real systems ([useterse.ai](https://www.useterse.ai/); judges-extras §1.8).

| Beat # | What Thomas should see | Demo sec | Path / TC |
|-------:|------------------------|----------|-----------|
| T1 | Concrete tool on a pane — tip/guide as actionable coach, not vibes chat | **0:15–0:40** · **1:05–1:20** | T1 then T2 |
| T2 | Pose/display instrumented behavior (Arrangement + CCA) | shell + climax | PoseRouter · CCA |
| T3 | Durable on-device feel — tips local; no brittle cloud climax | whole | skip OpenAI default |
| T4 | **Avoid** PoseAgent over-scope “for Thomas” | kill list | §02 |

**Frost alternate:** Threat ladder as deterministic local state machine (`ThreatLevel.swift`) at **0:15–0:45**.

---

## 4. Judge × second matrix (printable)

### 4.1 Outer Lens GREEN

| Judge | 0:00–0:10 | 0:15–0:40 | 0:40–0:55 | 0:50–1:05 | 1:05–1:20 | 1:20–1:30 |
|-------|:---------:|:---------:|:---------:|:---------:|:---------:|:---------:|
| Kyle | brand | **CCA tip** | flip craft | — | other-pane Pro | — |
| Brad | **sentence** | wedge visible | — | who pays setup | **pay proof** | close |
| Justin | — | **dual-face coach** | continuity | — | — | — |
| Yuma | — | subject stage | **controls** | — | — | — |
| Jane | — | **clever outer** | — | — | — | privacy if asked |
| Ari | — | **instrumented tip** | — | — | — | — |
| Matt | — | free surface shown | — | **paywall** | **unlock** | Matt line |
| Thomas | — | **concrete coach** | — | — | Pro tool upgrade | — |

### 4.2 FrostDuo CUTOVER

| Judge | 0:00–0:15 | 0:15–0:35 | 0:25–0:45 | 0:50–1:05 | 1:05–1:20 | 1:20–1:30 |
|-------|:---------:|:---------:|:---------:|:---------:|:---------:|:---------:|
| Kyle | roles | — | **dual-face** | — | vault craft | — |
| Brad | **Frost Brad** | — | wedge | — | pay proof | close |
| Justin | roles | — | **inner/outer jobs** | — | — | — |
| Yuma | — | Simulate | **tabletop** | — | — | — |
| Jane | — | Simulate | **frost+decoy** | — | — | on-device line |
| Ari | — | local action | state machine | — | — | — |
| Matt | free frost/decoy | — | — | **paywall** | **vault C** | Matt frost |
| Thomas | — | ladder | deterministic | — | Pro pack | — |

---

## 5. Per-judge failure modes (fix while building)

| Judge | If we fail them | Likely cause | Fix before freeze |
|-------|-----------------|--------------|-------------------|
| Kyle | “Could be any iPhone” | Tip not on outer / no CCA | Tip-only stage + honest line **or** cutover |
| Brad | Kabuki / confused noun | Rewritten tagline / platform talk | Restore frozen Brad · cut screens |
| Justin | Android-fold vibe | Equal dashboards / hinge layout | Unequal jobs · TC-S03 |
| Yuma | Toy / unfinished | Broken shutter / no craft | P1 shutter · Film Tool tokens |
| Jane | Boring dual-screen | Tip unread / no cleverness | ≥28pt tip · or Frost cutover |
| Ari | ChatGPT wrapper | Chat UI / cloud tip climax | Delete chat · static tip |
| Matt | Logo-only RC | Fake Pro button / same-pane toast | Real Test Store · other pane |
| Thomas | Vague “AI agent” | PoseAgent sprawl | One tip tool only |

---

## 6. Spoken cues cheat-sheet (COPY/DEMO)

| Cue | When | Exact |
|-----|------|-------|
| Brad Outer | 0:00–0:10 | Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays. |
| Watch outer | 0:15 | “Watch the outer.” (optional; prefer silence) |
| Matt Outer | 0:55–1:20 | Free: outer preview. Pro: pose overlays on the outer display. |
| CCA flake | if needed | Subject coach is CCA; sim can’t always light outer for camera — on device the outer faces the kid. |
| Brad Frost | cutover 0:00 | Shoulder-surfers ruin private screens — Duo frosts the inner face and shows a decoy on the outer; Pro unlocks vault decoys. |
| Matt Frost | cutover purchase | Free: frost + lock decoy. Pro: vault cover packs on the outer display. |
| Jane privacy | cutover close | Faces / content never leave the device. (only if true) |

Store in `docs-runtime/DEMO-SCRIPT.md` · `Resources/Localizable.strings` as needed · TC-P01–P04.

---

## 7. Sponsor priority stack

Depth ≫ stickers (`docs/duo-research-briefing.md` §5 · `internal/sponsors-patterns.md`).

| Rank | Sponsor / force | Critical-path demo | Demo sec | Skip if… | Owner lane |
|-----:|-----------------|-------------------|----------|----------|------------|
| **1** | **Duo APIs** (theme) | CCA tip **or** frost+decoy via Arrangement | **0:15–0:45** | **Never** | SHELL · CCA / FROST |
| **2** | **RevenueCat** (+ Matt) | Test Store purchase → other pane | **0:50–1:20** | Never if Matt/RC matter | LANE-RC · Human RC-IDs |
| **3** | **YC narrative** (Brad; interview prize shape) | One sentence Brad can repeat | **0:00–0:10** | Never | LANE-COPY |
| **4** | **Bitrig** (host) | Optional primary build in Bitrig | n/a | Prize sentence **UNKNOWN** on live Luma Rules — confirm Sat AM | Human ask |
| **5** | **OpenAI** | Hard multimodal on 2nd surface | n/a | On-device/static tips carry — **default skip** | — |
| **6** | **Sentry** | Breadcrumbs on hinge/paywall | n/a | Time dies — **default skip** | — |
| **7** | **Supabase** | Auth/sync | n/a | State on-device — **default skip** | — |

### 7.1 RevenueCat depth recipe (Matt)

| Step | When | Artifact |
|------|------|----------|
| Dashboard Test Store + `pro` + offering + paywall | Pre-doors **human** | `docs-runtime/RC-IDs.md` replaces `PLACEHOLDER_RC_*` |
| SPM RevenueCat + RevenueCatUI ≥5.43.0 | Scaffold Sat | Package.resolved |
| `Purchases.configure(test_)` DEBUG | Block E ~1:45–2:15 | `PurchasesConfig.swift` · TC-R01 |
| Present paywall inner | Demo **0:50–1:05** | `PaywallHostView.swift` · TC-R02 |
| Successful Purchase | Demo | TC-R03 |
| Other-pane unlock | Demo **1:05–1:20** | Coach T2 or Frost C · TC-R04 |
| Cancel once | Rehearsal | TC-R05 |

**Design rule:** Gate the differentiated Duo surface — outer overlays / vault decoy — **not** chrome.

### 7.2 Duo API depth recipe (Kyle / theme)

| Proof | Path | TC / sec |
|-------|------|----------|
| Arrangement / regions | `RootArrangementView.swift` · `ArrangementRegions.swift` | TC-S02 |
| Pose router | `PoseRouter.swift` | TC-S02 |
| Hinge effects only | `onHingeChange` usage | TC-S03 |
| CCA climax | `CameraCaptureAccessoryHost.swift` · SCR-OL-C | TC-C01 · **0:15–0:45** |
| Cutover dual-face | `Features/Frost/**` | TC-F01/F02 |

### 7.3 Logo salad anti-pattern

| Don’t | Why |
|-------|-----|
| Five sponsor stickers on paywall | Track wins go to deep integrations |
| OpenAI call with no Duo climax | Ari/Thomas punish shallow AI |
| Sentry-only demo flex | Not the climax |
| Claim separate RC/Bitrig trophies without confirmation | UNKNOWN — don’t invent |

### 7.4 RevenueCat win patterns (steal depth, not Ship-a-ton length)

Evidence: `docs/win-completeness-bar.md` §5 · `docs/duo-research-briefing.md` §5 · scorecard dim 4 (**11/12** for Outer Lens) · `internal/sponsors-patterns.md`.

| Pattern that wins short hacks | Outer Lens application | Demo sec / path | Anti-pattern |
|------------------------------|------------------------|-----------------|--------------|
| **SDK in critical path** | `purchases-ios` ≥5.43 + RevenueCatUI | Package.resolved · TC-R01 | Logo on README only |
| **Paywall is a demo beat** | Inner SCR-OL-D after climax tip already visible | **0:50–1:05** | Paywall before Duo climax |
| **Gate the value feature** | Pro = outer T2 guide oval / vault C — not chrome | **1:05–1:20** · `GuideOvalView.swift` | Gate a settings toggle |
| **Other-pane unlock** | Outer changes after `pro` | TC-R04 | Same-pane toast “You’re Pro!” |
| **Test Store, not ASC** | `test_` key · Successful Purchase | Human `RC-IDs.md` | Sandbox Apple ID fight |
| **One free-vs-Pro sentence** | Matt frozen line | TC-P03 | Feature-list dump |
| **Cancel proves gate** | Fail once still locked | TC-R05 | Always-unlocked debug |
| **Dashboard frozen pre-doors** | entitlement `pro` + offering + paywall published | scorecard gap→10 row | Invent IDs in Swift |

**Scorecard → 12/12 RC row (what closes the −1):** Dashboard frozen tonight with `pro` + offering + `test_` key; Matt sentence locked; demo order climax → paywall → Successful Purchase → unlock on other pane (`docs/winning-project-scorecard.md` Gap to 10).

**Kindred @ Moss / Ship-a-ton lesson (depth only):** Host product in the critical path → overall + sponsor signal. Do **not** import “ship to App Store” as the Duo bar (`docs/win-completeness-bar.md` §1).

**Spoken Matt block (rehearse verbatim during Block E ~1:45–2:15):**

> Free: outer preview. Pro: pose overlays on the outer display.  
> *(tap Pro → RevenueCatUI → Successful Purchase)*  
> Watch the outer — that’s the entitlement flipping the coach.

Paths: `Features/Paywall/PaywallHostView.swift` · `Monetization/Entitlements.swift` · SCR-OL-C T2 · `docs-runtime/RC-IDs.md`.

### 7.5 Bitrig / YC sponsor-adjacent beats (not APIs)

| Force | What “deep” means in 90s | Say / show | Skip |
|-------|--------------------------|------------|------|
| **YC (Brad)** | Matter-of-fact wedge + who pays | Frozen Brad **0:00–0:10** · close **1:20** | Kabuki deck |
| **Bitrig (Kyle + optional prize)** | Native Duo API inventiveness | CCA tip **0:15–0:40** | Accorduon clone; claim Bitrig trophy if UNKNOWN |
| **OpenAI (Ari present)** | Instrumented action, not chat | Tip on outer as action | OpenAI call unless load-bearing |
| **Sentry / Supabase** | — | — | Default skip |

---

## 7A. Exactly what to say — per judge (90s Outer Lens)

Use these as **optional micro-lines** layered on the frozen Brad/Matt spine. Prefer silence during the CCA tip (Kyle/Justin see glass). Paths: `docs-runtime/DEMO-SCRIPT.md`.

| Judge | Second | Say (≤12 words) | Show |
|-------|--------|-----------------|------|
| **Brad** | 0:00 | Frozen Brad Outer sentence (full) | Brand **Outer Lens** |
| **Brad** | 1:20 | “Parents pay for overlays that work on the kid’s face.” | Outer still showing T2 |
| **Kyle** | 0:15 | “Outer is `CameraCaptureAccessory` — subject coach.” *(optional)* | SCR-OL-C T1 lands |
| **Kyle** | 1:05 | “Pro unlocks on the other pane.” | Amber oval M3 |
| **Justin** | 0:20 | “Photographer inside; subject sees the coach outside.” | Dual panes lit |
| **Yuma** | 0:40 | “Flip — tip stays. Phone as the coach stage.” | Flip · tip persists |
| **Jane** | 0:25 | “Tips stay on-device — nothing cloud-required for the climax.” | Solid tip plate |
| **Ari** | 0:30 | “The assistant is the outer tip — it acts on the subject face.” | T1 change if cycling |
| **Matt** | 0:55 | Frozen Matt line | Paywall presenting |
| **Matt** | 1:10 | “That’s `pro` on the outer coach.” | T2 bloom |
| **Thomas** | 0:35 | “One concrete tool: framing tip on the subject pane.” | T1 ≤8 words |

**Frost cutover spoken swaps (only if `CUTOVER.flag`):**

| Judge | Say | Sec |
|-------|-----|-----|
| Brad | Frost Brad frozen | 0:00 |
| Jane | “Simulate Threat — inner frosts; outer becomes someone else’s phone.” | 0:20–0:40 |
| Matt | Frost Matt free/Pro | 0:55–1:10 |
| Kyle | “Two faces, unequal jobs — Arrangement, not a stretched iPhone.” | 0:25 |

**Luma differentiation lines** (if Dhaval/Asher-class camera rivals asked “how is this different?”) — from `docs/luma-chat-intel.md` §6:

> We’re not a better selfie recorder. The **subject** sees coach tips on Duo’s outer; Pro unlocks pose overlays on that face.

If hinge/posture teams ask: “Hinge is effects only for us — climax is the outer coach accessory.”

---

## 7B. Anti-patterns catalog (judge + sponsor + Luma)

Compile from briefing §3 · scorecard dims 7–8 · win-completeness §2–3 · luma intel §2–5. Any of these in the 90s → Scope Guard nack / cut before freeze.

### 7B.1 Instant trust-killers (DQ-adjacent or Flora/Kyle allergic)

| Anti-pattern | Who punishes | Replace with | Path / sec |
|--------------|--------------|--------------|------------|
| Prewritten shipping app | Rules / DQ | Specs + Sat agents only | §00 |
| Slides/video instead of live | Luma Judging | Live Duo sim path | TC-D02 |
| Generic ChatGPT / cloud chat wrapper | Ari · Thomas · theme | Outer tip instrumented | SCR-OL-C |
| Accorduon / hinge-as-whole-product | Kyle · crowded Luma hinge cluster | CCA tip or Frost | kill list §02 |
| Marketing kabuki / fake metrics | Brad | Frozen Brad sentence | 0:00–0:10 |
| Fork Moments/PrivacyScreen/ClawKit as submission | DQ remix rule | Pattern cite only | design-direction §7 |
| Sponsor logo salad | Matt · tracks | Deep Duo + RC only | §7 |
| Fake “Pro unlocked” without purchase | Matt · Hsu core-path rule | Real Test Store | TC-R03 |
| Same-pane unlock toast | Matt | Other-pane T2/C | TC-R04 |
| Paywall on outer | Justin choreography | SCR-OL-D inner only | 0:50–1:05 |

### 7B.2 Soft losers (still shipable but panel cold)

| Anti-pattern | Risk | Fix |
|--------------|------|-----|
| “Outer camera preview with tips” pitch | Novelty −1 (scorecard) | Pitch **coach product** + paid overlays |
| Tip unread at 2–3 m | Kyle/Justin miss climax | ≥28pt · ≤8 words · solid plate · M1 |
| Five half-features | Demo axis dies | Freeze SCR-OL-A→D only |
| FM/Vision as load-bearing | Shipability · flake | Static T1; FM after climax or cut |
| PoseAgent sprawl “for Yuma/Thomas” | Over-scope | One tip tool; optional tabletop polish late |
| Interview-coach framing (Maide lane) | Collision / wrong noun | Subject coach on outer — not sales voice |
| OYI / agents thesis | Wrong weekend | Ignore Sun event |
| Claiming June ranks / separate trophies | Truthfulness | Mark UNKNOWN |
| Traffic-light frost HUD | Jane taste | Quiet Covered/Private |
| Explaining APIs instead of showing glass | All | Silence 0:15–0:40 |

### 7B.3 Competitive anti-joins (Luma)

Do **not** team-stack with Dhaval (self-record), Asher (AV lead), Justin Tianqin posture team, Pushpinder hinge, Kartik/Aashi/Roansh hinge cluster — same climax, split credit (`docs/luma-chat-intel.md` §5). Solo OK.

### 7B.4 Completeness anti-bar (not the win)

From `docs/win-completeness-bar.md`: App Store Connect, ASO, onboarding funnels, account systems, production analytics, multi-week Ship-a-ton completeness — **out**. Polished live slice in; store ship out.

---

## 7C. Scorecard panel-fit → what the 90s must prove

Outer Lens scored **8/10 panel fit** (`docs/winning-project-scorecard.md`): strong Kyle/Justin/Matt/Brad/Jane; Yuma/Thomas softer than PoseAgent. Closing the −2 without new products:

| Soft judge | Cheap beat already in GREEN path | Sec |
|------------|----------------------------------|-----|
| Yuma | Flip once + shutter craft P1 — phone-as-stage seriousness | 0:40–0:55 |
| Thomas | One ≤8-word concrete tip (tool, not chat) + optional T2 upgrade | 0:15–0:40 · 1:05 |
| Yuma/Thomas optional amp | Tabletop Arrangement polish **only if** CCA green ≥2:45 | late polish — not a feature |

FrostDuo peaks Jane (8.1 reliability/ship) — keep as cutover, not co-primary, so the 90s still maximizes eight-judge coverage when GREEN.

---

## 8. Proxy rubric rehearsal (not official Duo sheet)

Browser Use @ YC weights (HackHQ) as rehearsal only:

| Axis | Weight | Outer Lens mapping | Demo sec checkpoint |
|------|-------:|--------------------|---------------------|
| Impact | 40% | Parent/kid framing pain solved by outer tip | 0:15–0:40 tip readable? |
| Creativity | 20% | Subject coach ≠ selfie recorder (vs Dhaval) | Differentiation line ready? |
| Technical | 20% | CCA + Arrangement + RC wired | TC-C01 + TC-R04 green? |
| Demo | 20% | 90s survives flake | Simulate + 2 rehearsals? |

---

## 9. Sat AM organizer questions (human)

Ask once; record answers in DEMO-LAST-PASS notes:

1. Is there a **Bitrig-built** prize track today? (Luma Rules conflict / UNKNOWN)  
2. Is there a **separate RevenueCat trophy**, or is Matt’s judging the RC signal?  
3. Demo slot length per team? (only 3:30–5:00 block public)  
4. Any CCA entitlement / provisioning gotchas for Duo sim vs device?

Do **not** invent answers in the pitch.

---

## 10. Lane ownership for judge/sponsor beats

| Beat family | Lane | Must produce |
|-------------|------|--------------|
| Brad/Matt lines | COPY | DEMO-SCRIPT · TC-P* |
| CCA tip glass | CCA | SCR-OL-C · TC-C01 |
| Shell / pose | SHELL | TC-S* |
| RC purchase | RC + Human IDs | TC-R* |
| Frost Jane path | FROST (if cutover) | TC-F* |
| Tokens craft | ASSETS | Film Tool / Frost tokens |
| Rehearsal matrix | DEMO | DEMO-LAST-PASS ticks per judge |

---

## 11. One-page “show this” card (print for venue)

```text
OUTER LENS — 90s SHOW THIS
0:00  Brad sentence + Outer Lens brand          → Brad
0:15  Outer tip via CameraCaptureAccessory      → Kyle Justin Jane Ari Thomas
0:40  Flip once                                 → Kyle Yuma
0:50  Paywall (inner) → Test Store Success      → Matt
1:05  Outer Pro oval blooms                     → Matt Brad Kyle
1:20  Who pays — stop talking                   → Brad

IF CUTOVER FROST
0:00  Frost Brad
0:15  Simulate Threat → frost + decoy           → Jane Kyle
0:50  Paywall → vault C other pane              → Matt
```

Paths: `docs-runtime/DEMO-SCRIPT.md` · SCR-OL-* / SCR-FD-* · `Monetization/**`.

---

## 12. Cross-links

| Need | Doc |
|------|-----|
| Agent contract | `docs/bible/00-front-matter-agent-contract.md` |
| Win / DoD / script | `docs/bible/01-win-condition.md` |
| Cutover / Luma rivals | `docs/bible/02-concept-lock-cutover.md` |
| Briefing judges table | `docs/duo-research-briefing.md` |
| Deep judge profiles | `internal/judges-extras-scout.md` |
| Logistics research | `internal/bitrig-duo-judges-api-logistics-research.md` |
| Sponsor patterns | `internal/sponsors-patterns.md` |
| RC recipe | `internal/research-revenuecat.md` |
| Win completeness | `docs/win-completeness-bar.md` |
| Concept scorecard (8.2 + panel gaps) | `docs/winning-project-scorecard.md` |
| Luma collisions / differentiation | `docs/luma-chat-intel.md` |

---

*End §03. Eight judges, one path. Every second on the clock should make at least one named person nod — without building eight products.*
