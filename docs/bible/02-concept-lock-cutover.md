# §02 — Concept lock & cutover matrix

**Bible chapter:** `docs/bible/02-concept-lock-cutover.md`  
**For:** Orchestrator · Scope Guard · all feature lanes · COPY  
**Event:** Bitrig Hacks: iPhone Duo · Sat Sep 26, 2026 · YC SF  
**Lock:** **Outer Lens — Film Tool** is the only primary product theme  
**Cutover:** **FrostDuo** is hour-one flagged module — not a second equal bible  
**Maps to:** `Shared/CutoverFlag.swift` · `docs-runtime/CUTOVER.flag` · `docs-runtime/GATE-CCA.md` · SCR-OL-* / SCR-FD-*  
**Upstream:** `docs/bible-single-theme-contract.md` · `docs/luma-chat-intel.md` · `docs/duo-research-briefing.md` · `docs/design-direction.md` · mix board 8.2 / 8.1  
**Compiled:** Sat Sep 26, 2026 · **no Swift implementations in this chapter**

---

## 0. Lock statement (print large)

**ONE product theme for the mega bible: Outer Lens — Film Tool.**

| Lock field | Value | Path / demo |
|------------|-------|-------------|
| Product noun | **Outer Lens** (Coach) | Brad · DEMO-SCRIPT · string tables · brand whisper on SCR-OL-B/C |
| Visual theme | Film Tool — charcoal `#050505`, amber `#E8A838`, SF Rounded tip ≥28pt, solid outer tip plate | `DesignSystem/Tokens.swift` · design-direction §2A |
| Climax API | **`CameraCaptureAccessory`** via `.sceneAccessory` | `Duo/CameraCaptureAccessoryHost.swift` · demo **0:15–0:45** |
| Free vs Pro | Free outer T1 tip; Pro T2 guide oval on **other** pane after RC Test Store | `Features/Paywall/**` · `Monetization/**` · **0:50–1:20** |
| Brand | Wordmark **Outer Lens** is hero-level on primary surfaces — not nav-only | SCR-OL-B / SCR-OL-C chrome |

**FrostDuo is not a second product to design “insufficiently.”** It is the **hour-one CUTOVER module**:

- Built **behind** `Shared/CutoverFlag.swift` / `docs-runtime/CUTOVER.flag`.  
- Spec lives as SCR-FD-* (+ design-direction §2B tokens) — **not** equal page budget to Outer Lens Film Tool redesign.  
- Active lanes after gate red (~12:15): SHELL · FROST · RC · COPY · ASSETS · DEMO · INTEGRATOR.  
- Cutover = **swap root slot + flip flag + switch DEMO-SCRIPT appendix** — not a second brand system, not a parallel Film Tool skin.

**Rule:** If a bible paragraph cannot point at Outer Lens Film Tool **or** the FrostDuo cutover flag path, **delete it**.

---

## 1. Why Outer Lens is locked (evidence, not vibes)

| Signal | Source | Implication |
|--------|--------|-------------|
| Mix score **8.2** winner | `docs/mix-combo-scoreboard.md` | Highest-EV Saturday concept |
| Scorecard verdict Outer Lens Coach | `docs/winning-project-scorecard.md` | Locked noun |
| Broadest judge panel fit | briefing §8 | Kyle CCA · Justin subject↔coach · Jane dual-face · Matt Pro overlays · Brad wedge |
| Portfolio fit | niharm.me Briff/Posture | Camera-coach DNA |
| FrostDuo **8.1** | mix board | Best cutover, not co-primary |
| PoseAgent **7.3–7.6** | score-off | Demoted — FM/multi-pose 4h trap |
| Accorduon-class | luma + underground | Crowded — demote |

**Spoken lock at 11:30 (Orchestrator):**

> Outer tip appears on the subject face of the Duo (CCA). Everything else serves that. RC is the monetization beat, not a second Duo climax.

---

## 2. Product definitions (one page each)

### 2.1 Outer Lens — Film Tool (primary)

| Axis | Spec | Path |
|------|------|------|
| Job | Photographer shoots on **inner**; **subject** sees coach on **outer** | Unequal jobs · design-direction §5 |
| Inner | Full-bleed preview · shutter ~80pt · flip · Pro CTA · Subject toggle | SCR-OL-B · `InnerCaptureView.swift` |
| Outer | One tip ≥28pt ≤8 words · optional countdown · Pro guide oval | SCR-OL-C · `SubjectCoachView.swift` |
| Climax | CCA presents outer coach ≤30s zero narration | TC-C01 · **0:15–0:45** |
| Monetization | Free T1 · Pro T2 via `EntitlementState.isPro` | TC-C04 · TC-R04 |
| Mood | Craft camera · Halide-quiet · charcoal | Tokens 2A |
| Photo-only | No mic / video / REC theater default | Capture session photo |

**Brad (frozen):** Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.

### 2.2 FrostDuo — Cover Vault (cutover only)

| Axis | Spec | Path |
|------|------|------|
| Job | Inner progressive frost on sensitive surface; outer believable decoy | SCR-FD-A/C |
| Trigger | Threat ladder + **Simulate Threat** (sim mandatory) | `SimulateThreatControl.swift` · TC-F03 |
| Outer packs | A Lock Lookalike · B Busy Cover · C Vault Cover (Pro) | `Assets.xcassets/Frost/` |
| Climax | Simulate → frost + decoy snap (F1+F2) ≤30s | **0:25–0:45** |
| Monetization | Pro vault pack C other pane | F3 · TC-F04 · **1:05–1:20** |
| Mood | Ice-soft privacy · quiet Covered/Private · never malware HUD | Tokens 2B |
| Pose | Tabletop preferred (content↑ controls↓) | Arrangement regions |

**Brad (cutover):** Shoulder-surfers ruin private screens — Duo frosts the inner face and shows a decoy on the outer; Pro unlocks vault decoys.

---

## 3. Cutover matrix (hour-one)

### 3.1 Gate clock

| Wall | Artifact | Owner | Action |
|------|----------|-------|--------|
| **12:10** | Stop new CCA thrash | Orchestrator | Probe only |
| **12:15 sharp** | `docs-runtime/GATE-CCA.md` | Orchestrator **only** | GREEN or RED |
| **12:15 if RED** | `docs-runtime/CUTOVER.flag = frost` | Orchestrator **only** | Promote FROST |

Agents **read** these files; they do **not** flip them (`docs/bible/00-front-matter-agent-contract.md` §0.5).

### 3.2 GREEN criteria (stay Outer Lens)

ALL of the following, **or** the written tip-only story still reads as subject coach:

1. Capture UI on **inner**; session reaches `session.live` **or** black preview + static tip cards without bricking shutter (`Features/Capture/**`).  
2. `.sceneAccessory { CameraCaptureAccessory… }` compiles on iOS 27.1; `onAvailabilityChange` wired (`CameraCaptureAccessoryHost.swift`).  
3. **Either** accessory presents with T1 tip readable, **or** rehearsed **tip-only outer / Simulate tip** still sells “subject coach on the outer” (verbal if sim never lights outer for camera).  
4. Subject toggle reflects available vs enabled (hide if unavailable).

**GREEN →** keep LANE-CCA primary; FROST stays file-isolated standby (low priority). Do **not** flip cutover for polish debt.

### 3.3 RED criteria (cutover FrostDuo immediately)

ANY of:

- Accessory never available after live/fake session **and** tip-only coach story cannot be rehearsed honestly.  
- Entitlement / provisioning mystery blocks CCA with no organizer answer by 12:15.  
- Team still fighting dual-preview / invented APIs with **no** tip on glass by 12:15.  
- Orchestrator judges CCA will not be demo-viable by 3:15 even with Simulate.

### 3.4 RED actions (≤5 minutes)

| Step | Who | Exact action | Path |
|-----:|-----|--------------|------|
| 1 | O | Write `CUTOVER.flag = frost` and `GATE-CCA.md = RED` | `docs-runtime/` |
| 2 | O | Stop all Capture / CoachOverlay **feature** work (leave compile stubs) | `Features/Capture/**` · `CoachOverlay/**` |
| 3 | O | Promote FROST to primary writer; Duo-core helps Frost shell if needed | lane cards |
| 4 | COPY | Switch DEMO-SCRIPT to Frost Brad/Matt appendix | `docs-runtime/DEMO-SCRIPT.md` |
| 5 | RC | Same `pro` / Test Store / other-pane unlock → vault decoy C | `Monetization/**` · SCR-FD-C |
| 6 | Integrator | Root slot swap to Frost hosts — **do not** skin Outer Lens as frost | `RootArrangementView.swift` slots |
| 7 | All | **Do not** half-build both climax paths in one demo | One climax glass |

### 3.5 Mode table after gate

| Mode | Flag | Live SCR set | Live climax | RC unlock target | Parked |
|------|------|--------------|-------------|------------------|--------|
| Primary | false/absent | SCR-OL-A…E | CCA tip T1 | Outer T2 oval | Frost stubs only |
| Cutover | frost/true | SCR-FD-A…D (E optional) | Frost+decoy | Outer pack C | CCA feature work stopped |

### 3.6 `CutoverFlag` contract (spec signature — Integrator/SHELL implement Sat)

Bible-level contract for Saturday (implementations emitted by agents, not this file):

| Symbol | Responsibility | Readers |
|--------|----------------|---------|
| `CutoverFlag.isFrost` (or equivalent) | Reads `docs-runtime/CUTOVER.flag` or compile-time/runtime flag | RootArrangementView · feature lanes |
| Root slot | Hosts either Capture+Coach **or** Frost stack | SHELL |
| Demo script appendix | COPY selects Outer vs Frost lines | DEMO |

**Forbidden:** Feature lane flips flag. Frost imports Capture. “Hybrid” demo that runs CCA tip and frost snap as two climaxes.

---

## 4. Kill list (banned from bible & Saturday app)

### 4A. Rejected product concepts (hard ban)

| Banned noun | Why dead | Do not invent |
|-------------|----------|---------------|
| **PoseAgent** / PoseAgent lite / LocalAssist agent | Lost score-off (7.3–7.6); FM + multi-pose = 4h trap | Agent panes, listen mode, map/plan tools |
| **HingeBeat** / Accorduon-as-product | Crowded hinge-instrument lane (6.7); DQ-adjacent | Reed synth, bellows, hinge→layout |
| **Interview coach** / sales voice coach / Pitchée Flex Voice | Mix #4 — not locked; second climax surface | FoldAware voice packs as product |
| **Generic “agents”** / chat-on-fold / OYI agent thesis | Anti-pattern; cloud-chat wrapper DQ risk | Chat tabs, tool-calling kabuki as climax |
| Cover Stage Lens as **primary** (mix #2) | Pattern fuel only; CCA already owned by Outer Lens | Second CCA product identity |
| Stickless Outer Preview / Flex Tabletop Drill / Pose Shelf / Scrunch Breath / Folio Study / FoldingVideo Media | Lower mixes; dilute Film Tool | Alternate product nouns in §01–§02 |
| SalesCue / SnapDecoy / YogaTable (dark-horse mixes) | Not the lock | Alternate RC stories |
| Tabletop Drill Coach as **primary** | Dark horse; tabletop = **polish pose**, not product | ClawKit game/cabinet as entry |

### 4B. Feature / tech kill list

| Banned | File/demo consequence |
|--------|------------------------|
| Multipeer / Watch / second-phone remote | No transport code paths |
| Multicam grid, lens rack, Watch remote | No SCR for camera matrix |
| Foundation Models / cloud tips as load-bearing | Optional one tip string **after** climax or **cut** |
| PrivacyScreen / SnapShield / Moments / Shot Caller / ClawKit / Cosign **forks** | Remix patterns; cite only |
| Accorduon / Flex video / Flip launcher / Android folio chrome | No screenshots in pitch; no layout clones |
| Paywall on the **outer** | Paywall = SCR-OL-D / SCR-FD-D **inner only** |
| Tip lists, icon grids, floating face badges on outer | Outer = one tip · T1–T3 only |
| Skeleton HUD on free tier; traffic-light threat banners | Frost copy = quiet “Covered” / “Private” |
| Layout from `onHingeChange` degrees | Hinge = effects only · `Duo/PoseRouter.swift` |
| Second climax API in one build | One climax glass ≤30s |
| Auth, Supabase, Sentry, OpenAI, backend, ASC production, marketing site, multi-user sync | Out of §00 |
| Purple→indigo / cream+terracotta / broadsheet / glow stacks / emoji chrome | Banned in tokens |
| Liquid Glass over outer tip text / face; glass shutter; carnival glass frost | ios-craft-addendum |
| Pre-Saturday shipping app sources / secret finished binary | Human prep rule |
| Frost UI while Outer Lens still GREEN as primary demo | Standby files only until 12:15 |
| Video / mic / REC theater | Session + perm tax |
| Dual outer preview as **requirement** | Prefer tip-only if flakes |
| Vision / ARKit body pose as load-bearing | Static T1 / Simulate |

### 4C. Bible author / Scope Guard rule

Any draft that introduces a banned noun, SCR outside SCR-OL-*/SCR-FD-*, or a path outside the frozen tree → **Integrator nack**. Scope Guard cites this chapter + theme contract §2.

---

## 5. Luma collision map (competitive)

Source: `docs/luma-chat-intel.md` (dump `internal/luma-chat-raw.md`). Truncated chat — absence ≠ guarantee Sat AM.

### 5.1 Named idea collisions vs our lanes

| Person | Their idea | Collides with | Threat | Our response |
|--------|------------|---------------|--------|--------------|
| **Dhaval Patel** | Change how people **record themselves** | Outer Lens (camera/self-capture) | **High** | Differentiate: **subject sees tips on outer** + RC Pro overlays — coach, not recorder |
| **Asher Chok** | Foldable-obvious; deep AVFoundation / USB cameras | Outer Lens camera craft | **High** if dual-face camera | Same differentiation; do not join his team |
| **Maide Altas** | AI interview / presentation coach | Coach framing / Pitchée mix | **Med** | Stay camera-subject coach; not interview packs |
| **Tianqin Long (Justin)** | Postures → moments between two people | PoseAgent twin | **High** for PoseAgent | We already killed PoseAgent — do not pivot into his lane |
| **Pushpinder Singh** | Duo-core hinge/posture; authored HingeMaster | PoseAgent + hinge | **High** | Hinge = effects only for us |
| **Kartik Gaurav Kapoor** | Hinge as eyes-free control | HingeBeat / Accorduon-adjacent | **High** in hinge lane | Stay off Accorduon |
| **Aashi Modi** | Hinge as physical input + dual-display diagnostic | Hinge-as-input | **Med–High** | Same |
| **Roansh Desai** | Fold as the interaction | Hinge / fold-as-product | **Med** | Our fold use is CCA/Arrangement, not fold-toy |
| **Denis Ivanov** | AI meditation | Soft wellness | **Low** | Ignore / optional teammate only if pivots to our noun |
| **Harpreet + Ojasva** | Cross-app agentic teammate | Agents / OYI-adjacent | **Low** | Kill agents product |
| **Patrick Liu** | Voyage + Own Your Intelligence | Wrong weekend (Sun OYI) | **Ignore** | Do not build OYI thesis Sat |

### 5.2 Quiet lane (advantage)

**FrostDuo** (privacy / outer decoy / frost) had **no named twin** in the Fri dump. Outer Lens *CameraCaptureAccessory* subject-coach is only weakly echoed (Dhaval = recording; Asher = camera frameworks). Differentiate hard on **outer subject tips + RC Pro overlays**.

### 5.3 High-threat people (watch; don’t stack)

| Who | Why | Action |
|-----|-----|--------|
| **Prabaljit Walia** | Self-claimed last Bitrig solo winner; may team | Compete; don’t join unless he adopts **your** Outer Lens/Frost |
| **Pushpinder Singh** | Hinge fluency + HingeMaster | Don’t team; don’t clone hinge toy |
| **Tianqin Long +2** | Posture→moments | Don’t team if locking camera/privacy |
| **Asher Chok (+)** | AVFoundation depth | Rival in camera lane |
| **Om Chachad** | Craft + full team | Polish threat; don’t ask to join |
| **Mustafa Nomair** / **Krish Golcha** | Pedigree / YC-hack wins | Generalist threat if they lock a Duo climax |
| **Kartik / Aashi / Roansh** | Hinge cluster | Crowds Accorduon lane we already demote |

### 5.4 Teammate policy (default solo)

Solo is OK (Jacob Xiao). Team only if partner **adopts Nihar’s locked concept**. Do **not** DM for team-up: Dhaval, Asher, Justin’s posture team, Pushpinder, Kartik, Aashi, Roansh, Om (full), OYI folks.

### 5.5 Sat AM room scan → cutover lean

| If you see early… | Then |
|-------------------|------|
| Another **outer camera coach** shipping hard | Lean FrostDuo cutover readiness; still try CCA gate honestly |
| **Posture companion** teams | Stay Outer Lens — different climax |
| **Hinge-as-input** cluster | Stay off Accorduon; effects-only hinge |
| **Generic AI agents** | Duo climax ≤30s will outread them |
| **Privacy/frost clone** appears | Stay Outer Lens if CCA green; differentiate Jane beat with outer tip cleverness |

### 5.6 Differentiation cheat-sheet (from luma intel)

| Rival type | Your counter | Demo sec proof |
|------------|--------------|----------------|
| Self-recording / creator capture | Outer **subject coach tips** + Pro overlays | **0:15–0:45** T1 · **1:05–1:20** T2 |
| Posture social companion | You’re **camera accessory** or **privacy frost**, not pose→moments | CCA or CUTOVER |
| Hinge-as-input cluster | Stay off Accorduon; hinge effects only | TC-S03 |
| Generic AI agent teams | Duo climax in ≤30s | TC-C01 / TC-F01 |

---

## 6. ON / OFF scope for Outer Lens (Film Tool)

### 6.1 ON (must ship if GREEN)

| ID | Feature | Pane | Path / notes |
|----|---------|------|--------------|
| OL-A / SCR-OL-A | Camera permission primer | Inner | `PermissionPrimerView.swift` · photo only · no mic |
| OL-B / SCR-OL-B | Capture shell | Inner | preview · flip · ◎ shutter ~80pt · Subject toggle · tip-pack stub |
| OL-C / SCR-OL-C | Subject coach T1 | Outer via CCA | one tip · brand whisper |
| T3 | Countdown 3·2·1 | Outer | once · Simulate if flaky |
| OL-D / SCR-OL-D | RevenueCatUI paywall | Inner | Test Store · entitlement `pro` |
| M3 | Pro unlock → T2 amber oval | Outer | other-pane proof |
| E / SCR-OL-E | Denied / unavailable | Inner | never brick |
| Simulate tip / Pro / countdown | Settings sheet | Inner | judge-safe recovery |

### 6.2 OFF (hard kill mid-day)

See §4B + plan §1 OFF. Orchestrator refuses mid-day adds.

---

## 7. Inspiration remix only (cite, never fork)

| Credit | Steal | Leave | Path consequence |
|--------|-------|-------|------------------|
| Apple CCA docs / Tech Talks | Outer = subject script/countdown | Second full outer app | CCA host |
| Moments | Full-bleed outer preview + status capsule | Social platform | Coach overlay layout |
| Shot Caller | Dark canvas, huge countdown, shutter scale | Multipeer | Motion M2 · shutter |
| Halide | Clutter-free craft taste | Manual RAW | Tokens Film Tool |
| PrivacyScreen | Threat ladder, Simulate / `-demo` | VaultDemo finance chrome | Frost ladder |
| SnapShield | Believable placeholder → decoy language | Capture-shield primary | Decoy packs |
| ClawKit | Dual-role / tabletop idea | Claw game entry | Pose polish only |
| Cosign | Book roles | Gel metaball required climax | — |

---

## 8. Screen ID freeze reminder

Agents implement **only**:

- Primary: **SCR-OL-A…E** (+ T1–T3 · M1–M3 · P1–P3)  
- Cutover: **SCR-FD-A…E** (+ decoys A–C · F1–F3)  

Aliases `OL-A` in design-direction = `SCR-OL-A`. Do not invent `SCR-I-01`, `SCR-01`, or third product prefixes.

---

## 9. Root arrangement cutover (Integrator checklist)

When RED:

1. Confirm `CUTOVER.flag` readable via `Shared/CutoverFlag.swift`.  
2. `RootArrangementView.swift` hosts Frost feature slots (sensitive + decoy), not Capture.  
3. Paywall host remains shared (`Features/Paywall/PaywallHostView.swift`) — inner only.  
4. COPY switches spoken appendix; brand whisper → **FrostDuo** quiet corner.  
5. ASSETS ensures Frost decoy catalogs resolve (`Assets.xcassets/Frost/`).  
6. DEMO rehearses Frost 90s; Outer Lens script archived, not deleted.  
7. Run TC-F01–F04 + Always TCs; waive TC-C* with written note in DEMO-LAST-PASS.

---

## 10. Concept lock checklist (Orchestrator at 11:30)

1. [ ] Speak Outer Lens climax sentence aloud.  
2. [ ] Confirm Brad/Matt Outer lines memorized (COPY).  
3. [ ] Confirm Frost Brad ready in appendix (insurance).  
4. [ ] Confirm decoy stills on disk (cutover insurance).  
5. [ ] Confirm no banned nouns on whiteboard / lane prompts.  
6. [ ] Confirm Luma rivals noted (Dhaval/Asher = camera rivals).  
7. [ ] Confirm gate probe scheduled 12:10–12:15.  
8. [ ] Confirm max 3 coding writers.

---

## 11. Lane behavior at cutover (who stops / who starts)

| Lane | GREEN (Outer Lens) | RED (FrostDuo) | Paths |
|------|--------------------|----------------|-------|
| SHELL | Arrangement + CutoverFlag read | Same; root slot hosts Frost | `RootArrangementView.swift` · `CutoverFlag.swift` |
| CCA | **Primary writer** Capture + Coach | **Stop feature work**; leave compile stubs | `Features/Capture/**` · `CoachOverlay/**` · CCA host |
| FROST | File-isolated standby only | **Promote to primary writer** | `Features/Frost/**` |
| RC | Same `pro` / Test Store / other-pane | Same muscle → vault decoy C | `Monetization/**` · `Paywall/**` |
| COPY | Outer Brad/Matt | Switch DEMO-SCRIPT appendix to Frost Brad/Matt | `DEMO-SCRIPT.md` · Localizable |
| ASSETS | Film Tool tokens + Coach glyphs | Ensure Frost decoy A/B/C resolve | `Tokens.swift` · `Assets.xcassets/Frost/` |
| DEMO | Outer 90s | Frost 90s; waive TC-C* in DEMO-LAST-PASS | DEMO-LAST-PASS |
| INTEGRATOR | Merge Capture/Coach/RC | Root slot swap; **do not** skin OL as frost | Types · pbxproj · slots |
| SCOPE-GUARD | Nack dual-climax / banned nouns | Nack “hybrid CCA+frost demo” | read-only |

**Concurrency after RED:** still ≤3 coding writers — preferred **FROST + RC + SHELL/polish**. Never keep CCA as a fourth live writer.

---

## 12. GATE-CCA.md template (Orchestrator writes at 12:15)

Paste into `docs-runtime/GATE-CCA.md`:

```text
# GATE-CCA
Time: 12:15
Author: Orchestrator (human only)

## Probe results
- Inner capture UI present: Y/N
- session.live OR black+shutter usable: Y/N
- CameraCaptureAccessoryHost compiles: Y/N
- onAvailabilityChange wired: Y/N
- T1 tip readable on outer OR tip-only/Simulate rehearsed honestly: Y/N
- Subject toggle correct: Y/N

## Decision
GREEN / RED

## If RED
CUTOVER.flag written: frost
CCA feature stop acknowledged by: <lane>
FROST promoted: Y/N
COPY switched: Y/N

## Notes
<sim quirks / organizer answers>
```

Agents **read** this file; they do **not** author the GREEN/RED decision (`docs/bible/00-front-matter-agent-contract.md` §0.5).

---

## 13. CUTOVER.flag contract (values)

| File content | Meaning | Root hosts | DEMO appendix |
|--------------|---------|------------|--------------|
| absent / empty / `false` | Outer Lens primary | Capture + Coach slots | Outer Brad/Matt |
| **`frost`** (exact) | FrostDuo cutover | Frost slots | Frost Brad/Matt |

**DECISION (Claude review P0):** Disk write for cutover is **only** the token `frost`. Forbidden writes: `true`, `outerLens`, invent tokens. Swift reader may expose enum `.outerLens` / `.frost`; file bytes for RED = `frost`. Implement in `Shared/CutoverFlag.swift` (SHELL). Feature lanes must not write the flag.

---

## 14. DoD at gate vs DoD at freeze

| Moment | Outer GREEN must prove | Frost RED must prove | Artifact |
|--------|------------------------|----------------------|----------|
| **12:15 gate** | Tip story viable by 3:15 (live or Simulate) | Cutover decision recorded ≤5 min | GATE-CCA · CUTOVER.flag |
| **~2:15 RC** | Purchase path presenting | Same RC host | GATE-RC.md |
| **3:00 freeze** | Full §01 DoD 4.1 + Always TCs | Full §01 DoD 4.2 + Always TCs | DEMO-LAST-PASS · `sat/freeze` |

Gate green ≠ freeze done. Gate red ≠ abandon RC. Paths: theme contract §6 · `docs/bible/01-win-condition.md` §4.

---

## 15. Brad / Matt ownership across modes

| Mode | Brad (frozen) | Matt (frozen) | COPY paths |
|------|---------------|---------------|------------|
| Outer | Parents / framing / outer subject coach / free preview / Pro overlays | Free: outer preview. Pro: pose overlays on the outer display. | DEMO-SCRIPT primary · TC-P01 · TC-P03 |
| Frost | Shoulder-surfers / frost inner / decoy outer / Pro vault | Free: frost + lock decoy. Pro: vault cover packs on the outer display. | DEMO-SCRIPT appendix · TC-P02 |

Do **not** invent third Brad lines for Cover Stage / SalesCue / YogaTable. Kill list §4A.

---

## 16. Integrator decision log (fill Saturday — mark **DECISION:**)

| ID | Question | Default if Nihar asleep | Affects |
|----|----------|-------------------------|---------|
| D1 | Tip-only outer without live accessory = GREEN? | **Yes** if Simulate tip + honest device line rehearsed | GATE-CCA · TC-C01 |
| D2 | Exact `CUTOVER.flag` token | **`frost` only** (never `true`) | CutoverFlag.swift |
| D3 | Entitlement id string | Expect `pro` — paste from dashboard only | `PLACEHOLDER_RC_ENTITLEMENT_ID` |
| D4 | Promote FROST writer machine | Cursor BG / 2nd Codex already on Frost stubs | lane cards |
| D5 | Keep Outer DEMO-SCRIPT file after cutover | Archive, don’t delete | DEMO |
| D6 | Tabletop polish if GREEN late | Only ≥2:45 | Arrangement · never new product |

---

## 17. Cross-links

| Need | Doc |
|------|-----|
| Agent contract / flag ownership | `docs/bible/00-front-matter-agent-contract.md` |
| Win / Brad-Matt / DoD | `docs/bible/01-win-condition.md` |
| Judges / sponsors | `docs/bible/03-judge-sponsor-beats.md` |
| Theme contract | `docs/bible-single-theme-contract.md` |
| 3h gate detail | `docs/outer-lens-3h-build-plan.md` §3 |
| Luma intel | `docs/luma-chat-intel.md` |
| Design tokens both modes | `docs/design-direction.md` |
| Outer research | `internal/research-outer-lens.md` |
| Frost research | `internal/research-frostduo.md` |
| Mix / score lock | `docs/mix-combo-scoreboard.md` · `docs/winning-project-scorecard.md` |

---

*End §02. Outer Lens is the theme. FrostDuo is the parachute. Everything else is a nack.*
