# §01 — Win condition & YC one-liners

**Bible chapter:** `docs/bible/01-win-condition.md`  
**For:** Orchestrator · LANE-COPY · LANE-DEMO · every coding lane (pitch hygiene)  
**Event:** Bitrig Hacks: iPhone Duo · Sat Sep 26, 2026 · YC SF  
**Product:** Outer Lens (Film Tool) primary · FrostDuo cutover appendix  
**Maps to:** Demo seconds in `docs-runtime/DEMO-SCRIPT.md` · TCs in theme contract §6 · paths under `DuoApp/`  
**Upstream:** `docs/win-completeness-bar.md` · `docs/outer-lens-3h-build-plan.md` §5 · `docs/duo-research-briefing.md`  
**Compiled:** Sat Sep 26, 2026 · **no Swift in this chapter**

---

## 0. Verdict (one paragraph → one demo)

Winning means a **polished live vertical slice**, not an App Store–ready product ([Luma Duo](https://luma.com/yc-meetup-4378); [Bitrig WWDC framing](https://bitrig.com/blog/join-us-at-wwdc26)). For Outer Lens that slice is: **inner live capture → outer subject tip via `CameraCaptureAccessory` ≤30s → RevenueCat Test Store Successful Purchase → Pro guide on the other pane** — spoken with frozen Brad + Matt lines — in about **90 seconds**, across **~4 surfaces** (SCR-OL-A/B/C/D), with SCR-OL-E ready so flakes do not brick. If CCA is red at 12:15, the same completeness bar applies to FrostDuo (frost + decoy + same RC other-pane unlock). Paths: `Duo/CameraCaptureAccessoryHost.swift` · `Features/Capture/**` · `Features/CoachOverlay/**` · `Monetization/**` · `Features/Paywall/**` · demo **0:00–1:30**.

---

## 1. Frozen spoken sentences

### 1.1 Brad — Outer Lens (primary, frozen)

**Spoken (0:00–0:10 of `docs-runtime/DEMO-SCRIPT.md`):**

> Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.

| Field | Value | Maps to |
|-------|-------|---------|
| Who | Parents photographing kids | Pitch · Localizable pitch string |
| Acute pain | Can’t see framing/pose while shooting | SCR-OL-B problem beat |
| Why Duo | Outer face = subject coach | SCR-OL-C · CCA |
| Free | Outer preview + tip | T1 on SCR-OL-C · **0:15–0:45** |
| Pro | Pose overlays on outer | T2 after TC-R03 · **1:05–1:20** |
| Owner lane | LANE-COPY · TC-P01 | `Resources/Localizable.strings` · DEMO-SCRIPT |

**Do not “improve” this line mid-merge.** Features paste verbatim. Scope Guard nacks tagline rewrites during integrate.

### 1.2 Matt — Outer Lens (monetization, frozen)

**Spoken during purchase beat (~0:55–1:05 / closing ~1:20):**

> Free: outer preview. Pro: pose overlays on the outer display.

| Field | Value | Maps to |
|-------|-------|---------|
| Free surface | Outer preview + T1 tip | SCR-OL-C tips.free |
| Paid surface | Pose overlays / guide oval T2 | `GuideOvalView.swift` · `EntitlementState.isPro` |
| Other-pane proof | Unlock visible on outer, not toast on inner | TC-R04 · M3 · **1:05–1:20** |
| Owner | LANE-COPY · TC-P03 | DEMO-SCRIPT Matt cue |

### 1.3 Brad — FrostDuo (cutover appendix only)

**Spoken only if `docs-runtime/CUTOVER.flag` = frost:**

> Shoulder-surfers ruin private screens — Duo frosts the inner face and shows a decoy on the outer; Pro unlocks vault decoys.

| Field | Maps to |
|-------|---------|
| Who / pain | Shoulder-surfers / private screens | SCR-FD-A |
| Duo wedge | Inner frost + outer decoy | SCR-FD-C · F1+F2 · **0:25–0:45** |
| Pro | Vault decoys pack C | SCR-FD-C after TC-R03 · F3 · **1:05–1:20** |
| Owner | LANE-COPY · TC-P02 | DEMO-SCRIPT cutover appendix |

### 1.4 Matt — FrostDuo (cutover)

> Free: frost + lock decoy. Pro: vault cover packs on the outer display.

Maps to decoy **A** free · decoy **C** Pro · same TC-R04 other-pane rule · `Features/Frost/OuterDecoyStageView.swift`.

### 1.5 Anti-kabuki (Brad Flora filter)

| Say | Don’t say | Why |
|-----|-----------|-----|
| Parents / kids / framing | “We’re reimagining the future of capture” | Flora concise · briefing §2 |
| Outer is the subject coach | “Multi-agent multimodal platform” | DQ-adjacent agents product |
| Free outer tip / Pro overlays | “Freemium AI SaaS” | Matt needs concrete surfaces |
| One sentence then show glass | Stack dump of sponsors | Logo salad loses |

**YC skeleton (fill only with frozen nouns):**  
“[Parents] can’t [see framing while shooting] on a normal phone. On Duo, [`CameraCaptureAccessory`] makes [the subject see coach tips].”

---

## 2. Win bar — what “done enough” means

Source of truth for philosophy: `docs/win-completeness-bar.md`. This chapter binds that bar to Outer Lens paths and demo seconds.

### 2.1 Host bar (not App Store)

| Source | Exact bar | Implication for Saturday |
|--------|-----------|--------------------------|
| Luma Duo | Polished demo enough; not complete E2E app | Ship SCR-OL-A→D path, not gallery/settings platform |
| Kyle / Bitrig WWDC blog | Newly possible + real enough to demo | CCA tip readable at 2–3 m |
| Hsu (Browser Use winner essay) | Proof of concept; don’t mock the **core** path | Real AV session + real RC purchase |
| Browser Use @ YC proxy rubric | Impact 40 · Creativity 20 · Technical 20 · Demo 20 | Reliability of climax > feature count |
| June Bitrig hosts | Novelty + thoughtfulness + ~3h polish | One noun, one climax |

**UNKNOWN (do not invent):** Official Duo weighted scorecard; exact per-team demo minutes; separate RC trophy.

### 2.2 Must ship (hard checklist)

Tick in `docs-runtime/DEMO-LAST-PASS.md` at freeze (~3:00).

| # | Must | Evidence path / demo sec | TC |
|---|------|--------------------------|----|
| 1 | Duo API climax visible | SCR-OL-C via `CameraCaptureAccessoryHost.swift` · **0:15–0:45** | TC-C01 |
| 2 | On-site code only | No pre-Sat shipping sources (§00 §3) | DQ |
| 3 | Live demo path | Duo sim/device — not video-only | TC-D02 |
| 4 | Vertical slice frozen hour-one | GATE-CCA green **or** cutover by 12:15 | GATE-CCA |
| 5 | Brad sentence | Spoken **0:00–0:10** | TC-P01 |
| 6 | Empty/denied/unavailable recoveries | SCR-OL-E · `CaptureDeniedView.swift` | TC-C03 · TC-C05 |
| 7 | Rehearsal buffer | 3:00–3:30 · DEMO-LAST-PASS | TC-D01–D02 |

### 2.3 Strongly required (Matt Berry / RC signal)

| # | Must | Path / sec | TC |
|---|------|------------|----|
| 1 | `purchases-ios` ≥ 5.43.0 SPM | Package.resolved | TC-R01 |
| 2 | RevenueCatUI paywall | `Features/Paywall/PaywallHostView.swift` · **0:50–1:05** | TC-R02 |
| 3 | Test Store Successful Purchase → `pro` | Live modal · `Entitlements.swift` | TC-R03 |
| 4 | Unlock on **other** display | Outer T2 / M3 · **1:05–1:20** | TC-R04 |
| 5 | Matt free-vs-Pro sentence | DEMO-SCRIPT | TC-P03 |
| 6 | Cancel/Fail once keeps gate | Rehearsed | TC-R05 |

### 2.4 Optional / skip unless load-bearing

| Item | Default | Steal clock from? |
|------|---------|-------------------|
| Foundation Models tip | **Skip** (or one string after climax) | Never from M4–M5 |
| OpenAI second-surface call | Skip | — |
| Sentry breadcrumbs | Skip if time dies | — |
| Supabase | Skip | — |
| Bitrig-primary build | Only if prize confirmed Sat AM (**UNKNOWN**) | — |
| Tabletop Arrangement polish | Only if CCA green **and** ≥2:45 | Polish block G |
| Vision/pose ML | Static T1 is the bar | — |
| SCR-FD-E closed-cover | Cut first | — |

### 2.5 Explicitly out of win bar

App Store submission · ASC/Apple sandbox IAP · multi-user accounts · backend-as-product · five sponsor logos · architecture tour · pre-hack Swift · Multipeer/Watch · multicam · hinge-as-product · paywall on outer · tip lists on outer.

---

## 3. Real vs stubbed (Hsu rule applied)

| Layer | Must be **real live** | OK to stub / fake / skip | Path |
|-------|----------------------|--------------------------|------|
| Duo climax | CCA tip or frost+decoy judges can see | Hinge-driven layout (wrong) | `CameraCaptureAccessoryHost.swift` / `Features/Frost/**` |
| Camera session | Real `AVCaptureSession` + perm path | Fake coaching before session | `CaptureSessionController.swift` |
| Outer tip | Readable T1 (or honest Simulate tip + device line) | Vision ML accuracy | `SubjectCoachView.swift` · tip plate |
| RevenueCat | SDK + paywall + Test Store → `CustomerInfo` / `pro` | Fake “Pro unlocked” button | `PurchasesConfig.swift` · Paywall |
| Pro unlock UX | Other pane actually changes | Extra Pro packs beyond one bloom | `GuideOvalView.swift` / decoy C |
| Decoy stills | Believable wallpapers | Live second-face ARKit in sim | `Assets.xcassets/Frost/` |
| Onboarding | Minimal primer | Full settings app | SCR-OL-A |
| Pitch slides | Prefer live UI | Short aid only if needed | DEMO-SCRIPT |

**Non-negotiable Outer Lens chain (do not fake):**  
SCR-OL-A grant → SCR-OL-B live preview → SCR-OL-C T1 → SCR-OL-D purchase → SCR-OL-C T2 bloom.

---

## 4. Definition of done — demos

### 4.1 Vertical-slice DoD (Outer Lens GREEN) — all true at freeze

| # | Criterion | Evidence | Demo sec |
|---|-----------|----------|----------|
| 1 | Duo climax ≤30s, zero narration | Outer T1 readable at 2–3 m **or** Simulate tip + honest device line | **0:15–0:45** |
| 2 | Inner capture usable | Preview or black+shutter; flip once; tip still legible | **0:10–0:40** · **0:40–0:55** |
| 3 | Countdown once | T3 or Simulate countdown | inside climax window |
| 4 | RC critical path | Pro CTA → Test Store Successful Purchase → outer T2 oval | **0:50–1:20** |
| 5 | Cancel/Fail once | Gate still holds | rehearsal note in DEMO-LAST-PASS |
| 6 | Failure survivable | Denied→Settings; `accessory.unavailable`→inner still shoots | SCR-OL-E |
| 7 | Scope clean | No second climax API; no paywall on outer; Film Tool tokens | Tokens.swift |
| 8 | Pitch | Brad + Matt without notes | TC-P01 · TC-P03 |

### 4.2 FrostDuo DoD (CUTOVER RED) — replaces 4.1 feature rows

| # | Criterion | Evidence | Demo sec |
|---|-----------|----------|----------|
| 1 | Clear → Simulate Threat → frost | SCR-FD-A/B · F1 | **0:00–0:35** |
| 2 | Outer decoy A/B at lock | SCR-FD-C · F2 | **0:25–0:45** |
| 3 | Simulate Threat works in sim | TC-F03 | SCR-FD-B |
| 4 | Pro → vault C other pane | TC-F04 · F3 · TC-R03/R04 | **0:50–1:20** |
| 5 | Brad/Matt frost lines | TC-P02 | DEMO-SCRIPT appendix |
| 6 | Same freeze clock / RC muscle | GATE-RC · DEMO-LAST-PASS | 3:00 |

### 4.3 Always (both modes)

| TC | Assertion | Evidence |
|----|-----------|----------|
| TC-S01 | Launch on Duo sim | GATE-SHELL / scaffold |
| TC-S02 | Pose remaps regions; no hinge layout | `PoseRouter.swift` |
| TC-S03 | `onHingeChange` effects only | code review |
| TC-S04 | `CutoverFlag` readable | `Shared/CutoverFlag.swift` |
| TC-R01–R05 | RC configure → paywall → purchase → other pane → cancel | Monetization + Paywall |
| TC-D01 | Suite or waivers recorded | DEMO-LAST-PASS |
| TC-D02 | 90s ×2 rehearsal | DEMO-SCRIPT |
| TC-I01 | Release/Debug compile | Integrator |

---

## 5. 90-second demo script (completeness = these seconds work)

Owner: Orchestrator + LANE-DEMO. Copy into `docs-runtime/DEMO-SCRIPT.md` Saturday. LANE-COPY freezes strings.

### 5.1 Outer Lens GREEN — master

| Sec | Beat | Glass / path | Spoken | Judge hit |
|----:|------|--------------|--------|-----------|
| **0–10** | Brad + brand | SCR-OL-B chrome shows **Outer Lens** | Brad frozen line | Brad Flora |
| **10–15** | Grant camera | SCR-OL-A → system alert → SCR-OL-B live | Minimal | Reliability |
| **15–40** | **Climax** | SCR-OL-C T1 tip lands (M1); optional T3 (M2) | Silence or “watch the outer” | Kyle · Justin · Jane |
| **40–55** | Flip once | SCR-OL-B flip · tip stays | — | Craft |
| **55–75** | Pro → paywall → purchase → bloom | SCR-OL-D inner · outer T2 M3 | Matt line | Matt Berry |
| **75–90** | Who pays / why Duo / ask | Brand still visible | Close Brad wedge | Brad · room |

**Backup 60s:** Skip flip; tip → purchase → bloom only.  
**CCA flake line (rehearse):** Hit Simulate tip / Simulate Pro; say: “Subject coach is `CameraCaptureAccessory`; sim can’t always light outer for camera — on device the outer faces the kid.” Paths: Settings sheet Simulate controls · SCR-OL-C tip-only stage.

### 5.2 FrostDuo cutover appendix

| Sec | Beat | Path | Spoken |
|----:|------|------|--------|
| 0–15 | Clear mail/notes · calm outer | SCR-FD-A · SCR-FD-C idle | Frost Brad |
| 15–35 | Simulate Threat | SCR-FD-B | — |
| 25–45 | Frost + decoy A/B | SCR-FD-C · F1+F2 | Quiet “Covered” |
| 50–75 | Paywall → vault C | SCR-FD-D · F3 | Matt frost |
| 75–90 | Privacy / on-device line | — | Jane beat |

### 5.3 Visual checklist (Film Tool)

From `docs/design-direction.md` §8 — tick during rehearsal:

1. Brand **Outer Lens** visible · inner charcoal → grant → preview.  
2. Outer T1 ≥28pt · ≤8 words · solid tip plate · readable 2–3 m (M1).  
3. Countdown once (M2) if in script.  
4. Pro coaching → paywall **inner** → purchase → outer T2 amber `#E8A838` bloom (M3).  
5. Flip once; tip still legible.  
6. Simulate tip ready.

Tokens path: `DesignSystem/Tokens.swift` · motions: `DesignSystem/Motion.swift`.

---

## 6. Surfaces count (winning shape)

| Mode | Core surfaces | Demo-visible beats | Error surface |
|------|---------------|--------------------|---------------|
| Outer Lens | OL-A · OL-B · OL-C · OL-D | Usually 3–4: grant → tip → purchase → upgrade | OL-E |
| FrostDuo | FD-A · FD-B · FD-C · FD-D | Same ~4-surface shape | FD-E optional cut |

Not a 12-screen app. June Wizard precedent = one product noun, multimodal intake — **do not copy Wizard UI** (UNKNOWN public visuals).

---

## 7. Hour budget discipline (maps to win, not a second plan)

| Block | Minutes | Win contribution | Paths |
|-------|--------:|------------------|-------|
| M0–M2 shell | ~50 | Duo chrome proof | `App/**` · `Duo/PoseRouter.swift` |
| M3 gate | 5 | Green Outer **or** cutover | `GATE-CCA.md` · `CUTOVER.flag` |
| M4 feature | 55 | Climax glass | Capture / Coach **or** Frost |
| M5 RC | 35 | Matt beat | Monetization · Paywall |
| M6 integrate | 15 | Other-pane unlock | Entitlement observe |
| M7 copy/assets | 10 | Brad/Matt + glyphs | Resources · Tokens |
| M8 freeze | 10 | DoD + rehearsal | DEMO-LAST-PASS |

**Hard stop:** After M3 red → stop CCA feature work. After M8 → no new screens.

---

## 8. Proxy scoring rehearsal (optional, not official)

Use Browser Use 40/20/20/20 **only** as self-check before freeze (`internal/yc-hackathon-criteria.md`):

| Axis | Weight | Outer Lens self-check question | Fail if… |
|------|-------:|--------------------------------|----------|
| Impact | 40% | Would a parent feel the outer tip change the shot? | Tip unread / same as single iPhone |
| Creativity | 20% | Is CCA subject coach non-obvious vs selfie recorder? | Looks like Dhaval “better recording” |
| Technical | 20% | Arrangement + CCA + RC wired without invented APIs? | Hinge layout / fake Pro |
| Demo | 20% | 90s path survives one flake? | No Simulate · bricks on deny |

---

## 9. COPY lane deliverables for win condition

| Deliverable | Path | TC |
|-------------|------|----|
| Brad Outer frozen | `Localizable.strings` + DEMO-SCRIPT 0:00–0:10 | TC-P01 |
| Brad Frost appendix | DEMO-SCRIPT cutover | TC-P02 |
| Matt free-vs-Pro | DEMO-SCRIPT ~1:20 | TC-P03 |
| Full 0:00–1:30 + Simulate lines | DEMO-SCRIPT | TC-P04 |
| Tip strings (≤8 words, 3 free) | Localizable / tip pack | used by SCR-OL-C |
| Quiet Frost chrome (“Covered”/“Private”) | Frost strings | no THREAT banners |

---

## 10. DEMO lane freeze checklist (paste into DEMO-LAST-PASS.md)

```text
## DEMO-LAST-PASS
Date/time:
Mode: Outer Lens GREEN / FrostDuo CUTOVER
TC-S01..S04:
TC-R01..R05:
TC-C01..C05: (or TC-F01..F04)
TC-P01..P03:
90s #1 time:
90s #2 time:
Simulate tip/Pro/Threat ready: Y/N
Waivers:
Go / No-go: Orchestrator signature
```

---

## 11. Failure → still win?

| Failure | Recovery that still meets win bar | Path |
|---------|-------------------------------------|------|
| Outer preview black | Tip-only fullscreen T1 + honest line | SCR-OL-C tip-only |
| CCA unavailable | Inner still shoots + Simulate tip | TC-C03 · Settings Simulate |
| Vision miss | Stay on T2/T1 static | visionMiss→T1 |
| RC offering nil | Fix dashboard — not Swift invention | RC-IDs.md · human |
| Purchase UI flake | Rehearse Successful Purchase path; Cancel once | TC-R03/R05 |
| CCA still red 12:15 | Full FrostDuo cutover | CUTOVER.flag |
| Behind at 2:30 | Drop polish; keep tip + purchase + bloom | plan §7 |

---

## 12. Saturday minute→win map (Orchestrator wall clock)

Bind `docs/outer-lens-3h-build-plan.md` blocks to win-bar outcomes. If a block finishes without its win contribution, the next block **cannot** invent a substitute feature — only recover or cutover.

| Wall | Block | Win contribution that must exist | Artifact / path | Fail → |
|------|-------|----------------------------------|-----------------|--------|
| 11:30–11:45 | A scaffold | Empty Duo app ⌘R; tree stubs | `GATE-SCAFFOLD.md` · `App/**` | Fix toolchain; no features |
| 11:45–12:15 | B shell+CCA probe | Arrangement remaps · CCA host compiles · T1 tip view exists | `PoseRouter.swift` · `CameraCaptureAccessoryHost.swift` · tip plate | Gate decision only |
| **12:15** | Gate | GREEN Outer **or** RED Frost | `GATE-CCA.md` · `CUTOVER.flag` | Orchestrator only |
| 12:15–1:00 | C vertical | Inner shoots · outer tip **or** Simulate · RC configure no crash | Capture/** · Coach/** · `PurchasesConfig.swift` | Do not open Vision |
| 1:00–1:45 | D harden | Denied→Settings · 3 free tip strings · T3 once | SCR-OL-E · Localizable · CountdownView | Lunch = merge only |
| 1:45–2:15 | E purchase | Successful Purchase → other pane | Paywall · Entitlements · GuideOval | Dashboard fix, not Swift IDs |
| 2:15–2:45 | F integrate | Single path tip→Pro→bloom without restart | Integrator merge · Motion M1/M3 | No new screens |
| 2:45–3:00 | G polish | Brand whisper · tip ≥28pt · amber Pro only | Tokens.swift · chrome | Scope Guard nacks |
| 3:00–3:15 | H freeze | DoD §4 all true · 90s #1 timed | DEMO-LAST-PASS · `sat/freeze` | Hotfix demo-blockers only |
| 3:15–3:30 | Rehearse | 90s #2 · walk to queue | DEMO-SCRIPT | **Stop coding** |

**Integrator fills (Saturday morning, not AI invention):**

- **DECISION:** Exact `docs-runtime/RC-IDs.md` paste time (pre-doors vs Block E start).  
- **DECISION:** Whether tip-only outer counts as GREEN without live accessory present (Orchestrator call at 12:15 per §02).  
- **DECISION:** Whether Bitrig-built prize sentence is live Sat AM — if yes, optional Bitrig iterate as amp only after M4 green.

---

## 13. Scorecard → Saturday close-the-gap checklist

From `docs/winning-project-scorecard.md` Outer Lens **8.2 / 10** (unbuilt ceiling ≤8.5). Closing gaps is **rehearsal work**, not new nouns.

| Gap | Saturday action | Path / demo sec | Owner |
|-----|-----------------|-----------------|-------|
| Climax −1 → 18 | Outer tip readable ≤30s zero narration | SCR-OL-C · **0:15–0:45** · TC-C01 | LANE-CCA · DEMO |
| Reliability −4 → 14 | Timed 90s + Simulate tip/Pro proven | DEMO-LAST-PASS · Settings Simulate | DEMO · O |
| Narrative −2 → 12 | Speak frozen Brad (parents/kids) — no improvise | DEMO-SCRIPT 0:00–0:10 · TC-P01 | COPY |
| RC −1 → 12 | Human pastes `PLACEHOLDER_RC_*` only from dashboard | `RC-IDs.md` · TC-R01–R04 · **0:50–1:20** | Human · LANE-RC |
| Ship −4 → 10 | Hour-one green **or** cutover; freeze one slice | GATE-CCA · no FM/pack theater | O |
| Panel −2 → 10 | Optional tabletop = controls↓ tips↑ **only if** ≥2:45 + CCA green | Arrangement regions · polish G | SHELL late |
| Novelty −1 → 8 | Pitch **coach product**, never “outer preview with tips” | Brad line · DEMO | COPY |
| Anti-pattern −1 → 5 | Scope Guard nacks banned nouns (§02 kill list) | lane prompts | SCOPE-GUARD |
| AI −1 → 4 | Optional one on-device tip string **after** climax — or cut | never load-bearing | O cut call |
| Bitrig −1 → 2 | Confirm prize Sat AM; Xcode Duo sim remains ground truth | UNKNOWN until doors | Human |

**Do not** chase PoseAgent / HingeBeat / interview lanes to “close panel gaps” — those are kill-list nouns (`docs/bible/02-concept-lock-cutover.md` §4).

---

## 14. RC placeholders (win path — never invent keys)

Agents may create skeleton only. Real values = **human paste**.

| Placeholder | Consumed by | Demo sec | Rule |
|-------------|-------------|----------|------|
| `PLACEHOLDER_RC_API_KEY` | `Monetization/PurchasesConfig.swift` | configure before **0:50** | Must be `test_` prefix in DEBUG |
| `PLACEHOLDER_RC_ENTITLEMENT_ID` | `Monetization/Entitlements.swift` | TC-R03 | Expected literal story: `pro` — **DECISION:** confirm dashboard id matches |
| `PLACEHOLDER_RC_OFFERING_ID` | Paywall present / offering fetch | TC-R02 | Human pastes; nil offering = dashboard fix |
| `PLACEHOLDER_RC_PACKAGE_ID` | Optional package pin | purchase modal | Prefer default offering package if unsure |

File: `docs-runtime/RC-IDs.md` (human-owned). If empty at Block E → **BLOCKED** — stop inventing; Orchestrator escalates to human. Fake “Pro unlocked” buttons fail the win bar (`docs/win-completeness-bar.md` §3).

---

## 15. Kill list (win-chapter excerpt — full table in §02)

Any of these appearing in DEMO-SCRIPT, SCR map, or lane prompts = Scope Guard nack and win-bar failure:

| Banned | Why it kills the win | Replace with |
|--------|----------------------|--------------|
| PoseAgent / agents / interview coach | Wrong product · over-scope | Outer Lens Film Tool only |
| HingeBeat / Accorduon-as-product | Crowded lane · DQ-adjacent | Hinge effects only · TC-S03 |
| Paywall on outer | Breaks Matt other-pane story | SCR-OL-D / SCR-FD-D **inner** |
| Fake Pro button | Hsu core-path mock | Real Test Store |
| Second climax (CCA + frost live) | Confuses 90s | One mode via `CUTOVER.flag` |
| ASC / App Store ship | Wrong completeness bar | Test Store only |
| Multipeer / Watch / Vision load-bearing | Clock + flake | Static T1 · Simulate |

---

## 16. Per-lane “done for the win” (not feature completeness)

| Lane | Win-done when | Paths | Must not “improve” into |
|------|---------------|-------|-------------------------|
| SHELL | TC-S01–S04 green | `App/**` · `Duo/PoseRouter.swift` · `CutoverFlag.swift` | Hinge layout · Accorduon toys |
| CCA | TC-C01–C05 (GREEN mode) | Capture/** · CoachOverlay/** · CCA host | Vision ML · tip packs theater |
| FROST | TC-F01–F04 if cutover | Features/Frost/** | Skin Outer Lens as frost · malware HUD |
| RC | TC-R01–R05 | Monetization/** · Paywall/** | Invented IDs · ASC |
| COPY | TC-P01–P03 | Localizable · DEMO-SCRIPT | Kabuki rewrites of Brad/Matt |
| ASSETS | Brand + tip plate + amber Pro | Tokens · Motion · xcassets | Purple/glow/emoji chrome |
| DEMO | TC-D01–D02 · DoD §4 | DEMO-LAST-PASS | New features after freeze |
| INTEGRATOR | TC-I01 · freeze tag | Types · pbxproj · merges | Silent cross-lane redesigns |

---

## 17. Spoken close + ask (75–90s)

After Matt free-vs-Pro line lands and outer T2 (or vault C) is visible:

1. Point at **other pane** unlock (silent 2s — glass proves it).  
2. One who-pays close: parents / Pro overlays worth paying.  
3. Optional ask: “Questions on the accessory or the paywall?” — stop.  

Do **not** open architecture, sponsor logo list, or roadmap. Paths: DEMO-SCRIPT closing beat · brand still on SCR-OL-B/C.

---

## 18. Cross-links

| Need | Doc |
|------|-----|
| Agent invariants | `docs/bible/00-front-matter-agent-contract.md` |
| Cutover / kill / Luma | `docs/bible/02-concept-lock-cutover.md` |
| Judges → seconds | `docs/bible/03-judge-sponsor-beats.md` |
| Completeness philosophy | `docs/win-completeness-bar.md` |
| 3h DoD + script table | `docs/outer-lens-3h-build-plan.md` §5 |
| Design tokens / 90s visual | `docs/design-direction.md` |
| Theme TC suite | `docs/bible-single-theme-contract.md` §6 |
| Scorecard gaps | `docs/winning-project-scorecard.md` |
| Mix board lock | `docs/mix-combo-scoreboard.md` |

---

*End §01. If the 90s path fails, you did not win the bar — features elsewhere do not compensate.*
