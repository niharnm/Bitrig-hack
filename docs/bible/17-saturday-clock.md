# §17 — Saturday clock (11:30–3:30) — Outer Lens Film Tool

**For:** Nihar · Bitrig Hacks iPhone Duo · Sat Sep 26, 2026 · YC SF  
**Window:** **11:30 → 3:30** (build + polish + freeze + rehearsal); demos **3:30–5:00**  
**Product default:** Outer Lens · **Cutover:** FrostDuo if GATE-CCA RED at **12:15 sharp**  
**Role:** Wall-clock blocks, gates, freeze rules, creep protocol — Orchestrator runbook  
**Maps to:** milestone M0–M8 · `GATE-*.md` · `CUTOVER.flag` · FREEZE at 3:00  
**Inputs:** `docs/outer-lens-3h-build-plan.md` · `docs/multi-ai-build-routing.md` · `docs/bible-single-theme-contract.md` · `docs/win-completeness-bar.md` · `docs/design-direction.md`  
**Constraint:** Spec / runbook only — **no app code**  
**Compiled:** Sat Sep 26, 2026

---

## 0. Clock thesis (say aloud at 11:30)

> Outer tip on the subject face is the climax. Prove CCA by 12:15 or flip Frost. Purchase beat 1:45–2:15. Freeze 3:00. Rehearse. Demo.

**Hard facts**

| Fact | Value |
|------|-------|
| Doors / check-in | 10:30 |
| Opening | 11:00 |
| Hacking | **11:30–3:30** |
| Lunch | **1:00** (eat while compile runs — no new features) |
| Demos / judging | 3:30–5:00 |
| Awards | 5:00–6:00 |
| Coding writers max | **3** live |
| Freeze | **3:00** — no new features |
| First 90s rehearsal done by | **3:15** |
| Second 90s / walk to queue | **3:15–3:30** |

---

## 1. Pre-doors (before 11:30) — human only

These are **not** Saturday app code. Failures here burn Block A.

| # | Check | Done when | Owner |
|---|-------|-----------|-------|
| P1 | macOS **26.6+** | About This Mac shows ≥26.6 | O |
| P2 | Xcode **27.1** selected | `xcode-select -p` → 27.1; empty Duo app ⌘R earlier today | O |
| P3 | Duo sim **first boot finished** | Device Hub fold reacts; cold boot not mid-hack | O |
| P4 | `RC-IDs.md` filled | `test_` key · entitlement `pro` · offering · paywall published | O |
| P5 | Tip strings on paper | 3 free + countdown | O |
| P6 | Frost decoy stills on disk | Wallpaper A/B/C for cutover insurance | O |
| P7 | Lane cards printed / Notes | From `18-multi-ai-lane-cards.md` | O |
| P8 | Demo script pocket card | From `16-demo-script-90s.md` §11 | O |
| P9 | Claude / Codex / Cursor logged in | Tokens not expired | O |
| P10 | Theme lock confirmed | Outer Lens only; Frost = flag path | O |

**If P2/P3 fail at doors:** Block A becomes toolchain triage — do not start feature lanes.

---

## 2. Block map (wall clock)

```text
10:30–11:30  PRE   Human prep / seats / Wi‑Fi / paste §00
11:30–11:45  A     Scaffold + toolchain          GATE-SCAFFOLD
11:45–12:15  B     Duo shell + CCA proof         ★ GATE-CCA / CUTOVER
12:15–1:00   C     Vertical slice (GREEN path)   D∥R (∥F standby)
1:00–1:45    D     Capture harden + tip craft    lunch absorbed
1:45–2:15    E     RC purchase beat              ★ GATE-RC
2:15–2:45    F     Integrate + other-pane proof
2:45–3:00    G     Polish only
3:00–3:15    H     FREEZE + 90s ×1
3:15–3:30    I     90s ×2 · stop coding · queue
3:30+        DEMO  Live path only
```

---

## 3. Block A — 11:30–11:45 · Toolchain + scaffold (15)

| | |
|--|--|
| **Owners** | O + **S** (Cursor Agent on Mac) |
| **AI paste** | Lane card **LANE-SHELL / Scaffold** |
| **ON** | New Duo app target; §06 folder stubs; SPM RevenueCat ≥5.43 refs (no configure yet) |
| **OFF** | CCA, paywall UI, Frost UI, DesignSystem taste, tip craft |
| **Done** | Empty app ⌘R on Duo sim; Device Hub fold reacts; `docs-runtime/GATE-SCAFFOLD.md = PASS` |
| **Fail** | Wrong Xcode / sim missing → **stop all feature work**; fix toolchain |

### Minute ticks

| Clock | Action |
|-------|--------|
| 11:30 | Say climax aloud; confirm Outer Lens lock; paste §00 to all AIs |
| 11:32 | Cursor scaffold starts; O fills any missing RC-IDs note |
| 11:40 | First ⌘R attempt |
| 11:45 | Write GATE-SCAFFOLD pass/fail |

### GATE-SCAFFOLD.md schema

```text
time: 11:45
pass: true|false
xcode: 27.1
sim: Duo booted y/n
notes:
blocker:
```

---

## 4. Block B — 11:45–12:15 · Duo shell + CCA proof (30) ★ GATE

| | |
|--|--|
| **Owners** | **D** (Claude Code/Opus) serial; O probes; S watches compile |
| **AI paste** | Duo core → then Outer Lens CCA proof (same session OK) |
| **ON** | `RootArrangementView` + pose chrome; CCA host; inner black preview shell; outer T1 static tip (**Chin up · eyes to the lens**); Subject availability hook |
| **OFF** | RC purchase UI; Pro oval; Vision; polish motion; tip packs beyond one string |
| **12:10** | **Stop adding code** — probe only |
| **12:15** | **O writes GATE-CCA + CUTOVER decision** |

### Sub-beats

| Clock | Action | TC |
|-------|--------|-----|
| 11:45–12:00 | Arrangement / pose shell visible | TC-S01/S02 |
| 12:00–12:10 | `.sceneAccessory { CameraCaptureAccessory }` + tip view compile; try availability | toward TC-C01 |
| 12:10–12:15 | Gate decision only | GATE-CCA |

### GATE-CCA decision rubric

**GREEN — stay Outer Lens** if ALL (or tip-only story still sells):

1. Capture UI on **inner**; session `live` **or** black preview + static tip without bricking shutter.  
2. CCA / `.sceneAccessory` compiles on iOS 27.1; `onAvailabilityChange` wired.  
3. **Either** accessory presents with T1 readable, **or** rehearsed tip-only / Simulate tip still sells subject coach.  
4. Subject toggle reflects available vs enabled (hide if unavailable).

**RED — cutover FrostDuo** if ANY:

- Accessory never available **and** tip-only story cannot be rehearsed honestly.  
- Entitlement / provisioning mystery blocks CCA with no organizer answer by 12:15.  
- Still fighting dual-preview / invented APIs with **no** tip on glass.  
- O judges CCA not demo-viable by 3:15 even with Simulate.

### RED actions (≤5 min — 12:15–12:20)

1. O writes `CUTOVER.flag = frost` and `GATE-CCA.md = RED`.  
2. Stop all `Features/Capture` / `CoachOverlay` **feature** work (leave compile stubs).  
3. Promote **F** to primary writer; D helps Frost shell if needed.  
4. COPY switches to Frost Brad/Matt (`16-demo-script-90s.md` §8).  
5. **Do not** skin Outer Lens as frost — full concept switch.  
6. Discard Outer Lens blocks below; run Frost vertical slice on **same** clock discipline (C–I).

### GATE-CCA.md schema

```text
time: 12:15
result: GREEN|RED
tip_path: live-cca|tip-only|simulate-rehearsed|none
notes:
cutover: false|frost
decided_by: O
```

---

## 5. Block C — 12:15–1:00 · Vertical slice core (45) · assume GREEN

| | |
|--|--|
| **Owners (≤3)** | **D** Outer Lens · **R** RevenueCat · **F** Frost stubs only if spare (lowest) |
| **ON (D)** | AV session + permission primer; shutter + flip; outer T1 settle; tip-only fallback; `accessory.unavailable`; Simulate tip |
| **ON (R)** | `Purchases.configure(test_)` under `#if DEBUG`; `EntitlementState`; PaywallHost present stub; **no inventing IDs** |
| **OFF** | Pro oval bloom; countdown polish; Liquid Glass taste pass; FM; tabletop feature |
| **Done** | Inner shoots; outer tip or Simulate; RC configures without crash; paywall can present |
| **1:00** | Lunch — leave compile / package resolve running |

### Parallel rules

- D owns `Features/Capture/**`, `Features/CoachOverlay/**`, CCA host.  
- R owns `Monetization/**`, `Features/Paywall/**`.  
- F may write `Features/Frost/**` only — **no root edits**.  
- Never four writers.

### If RED (Frost substitute Block C)

| Owner | ON |
|-------|-----|
| F (+D help) | Sensitive surface + Simulate Threat + outer decoy A |
| R | Same RC configure + paywall stub |
| OFF | CCA thrash; Film Tool tip packs |

---

## 6. Block D — 1:00–1:45 · Capture harden + tip craft (45)

| | |
|--|--|
| **Owners** | **D** primary; **R** finishes offerings if blocked; O eats / organizers |
| **ON** | Free tip set (3 strings); denied → Settings; countdown T3 once; Simulate countdown; Film Tool tokens light (charcoal `#050505`, amber reserved for Pro) |
| **OFF** | Pro oval until EntitlementState merges; DesignSystem rewrite; second tip style beyond T1/T3 |
| **Done** | 90s beats 1–3 possible without purchase: open → grant → tip → countdown once |

**Lunch creep rule:** no new screens; merge/compile OK; Slack/Luma browsing ≠ coding.

---

## 7. Block E — 1:45–2:15 · RC purchase beat (30) ★ MONETIZATION

| | |
|--|--|
| **Owners** | **R** + **O** (Integrator merge); **D** observes `isPro` only |
| **AI** | Codex / Cursor RC lane |
| **ON** | Inner Pro CTA → RevenueCatUI → Test Store → **Successful Purchase** → `entitlements["pro"].isActive` → outer **T2** amber oval (**M3**) |
| **OFF** | Restore-across-reinstall demo; Failed path polish beyond one Cancel; hard paywall; ASC |
| **Timing budget inside block** | Tip visible → Pro ≤5s → paywall ≤10s → Successful Purchase ≤10s → other-pane oval ≤5s |
| **Done** | `GATE-RC.md = PASS` when TC-R02/R03/R04 true; Cancel once proves gate |
| **Fail** | Offering nil / wrong entitlement → **fix dashboard**, not Swift invention |

**Spoken during beat:** Matt line from `16-demo-script-90s.md` §1B.

### GATE-RC.md schema

```text
time: ~2:15
pass: true|false
configure: ok|fail
paywall_presents: y/n
successful_purchase: y/n
other_pane_unlock: y/n
cancel_once: y/n
blocker:
```

**BLOCKED rule:** If `RC-IDs.md` still has placeholders at 1:45 → R marks BLOCKED and stops inventing; O pastes real IDs or accepts Simulate Pro as demo recovery (document waiver).

---

## 8. Block F — 2:15–2:45 · Integrate + other-pane proof (30)

| | |
|--|--|
| **Owners** | **O/S** Integrator; D+R patch **named files only** |
| **ON** | Merge EntitlementState → CoachOverlay; Pro CTA → check (P3); tip settle M1 + unlock bloom M3; shutter press P1 if free; paywall **never** on outer |
| **OFF** | New screens; Vision; tabletop as new feature; Frost primary (unless already cutover) |
| **Done** | Single path: tip → Pro → purchase → oval on outer **without restart** |

### Integrator merge order (GREEN)

1. Shell / pose truth already green.  
2. Capture + Coach compile.  
3. Monetization EntitlementState.  
4. Wire `isPro` → GuideOvalView.  
5. Smoke TC-C01 + TC-R04.  
6. Only then DesignSystem token pass (Block G).

---

## 9. Block G — 2:45–3:00 · Polish only (15)

| | |
|--|--|
| **Owners** | **S** polish (Cursor+Sonnet); scope guard **G** nacks |
| **ON** | Brand whisper **Outer Lens**; tip plate scrim; SF Rounded tip ≥28pt; amber `#E8A838` on Pro only; Reduce Motion → crossfade; optional **one** tabletop Arrangement tweak **iff** CCA green |
| **OFF** | New motions beyond M1/M2/M3 + P1–P3; glass on outer tip; glow; card soup; Sentry/OpenAI/Supabase; tip packs theater |
| **Done** | Demo path looks intentional; non-demo screens ignored |

**Scope guard nacks cite:** `bible-single-theme-contract.md` §2 kill list.

---

## 10. Block H — 3:00–3:15 · FREEZE + rehearsal start (15)

| | |
|--|--|
| **Owners** | **O** + **Q** |
| **3:00** | **FREEZE** — tag / verbal lock |
| **ON** | DoD checklist (§12); write `DEMO-LAST-PASS.md`; rehearse 90s ×1 |
| **OFF** | Quick tip packs, FM, decoy experiments, refactor, “one more motion” |
| **Done at 3:15** | Code frozen; first full 90s timed; Simulate tip / Pro ready; Brad+Matt memorized |

### Freeze rules

1. No new features after 3:00.  
2. Hotfixes only if O names file + demo-blocker (`sat/hotfix/*` mental tag).  
3. AI writers switch to **read-only / QA notes** unless O assigns a named hotfix.  
4. Scope guard auto-nacks anything not on DoD fail list.

---

## 11. Block I — 3:15–3:30 · Second rehearsal + queue (15)

| Clock | Action |
|-------|--------|
| 3:15–3:22 | 90s pass 2 **or** 60s backup if pass 1 failed a beat |
| 3:22–3:25 | Force **one** fallback once (Simulate tip or Simulate Pro) |
| 3:25–3:28 | Battery, silent mode off, volume, Brad breath |
| 3:28–3:30 | Close laptop coding tabs; walk toward demo area |

**Stop coding** means stop. Notes only.

---

## 12. Definition of done at freeze (GREEN Outer Lens)

| # | Criterion | Evidence |
|---|-----------|----------|
| 1 | Duo climax ≤30s, zero narration | Outer T1 readable 2–3 m **or** Simulate tip + §1E |
| 2 | Inner capture usable | Preview or black+shutter; flip once; tip legible |
| 3 | Countdown once | T3 or Simulate countdown (**drop if late**) |
| 4 | RC critical path | Pro → Successful Purchase → outer T2 oval |
| 5 | Cancel/Fail once | Gate still holds |
| 6 | Failure survivable | Denied → Settings; unavailable → inner shoots |
| 7 | Scope clean | No second climax; no paywall on outer; Film Tool tokens |
| 8 | Pitch | Brad + Matt without notes |

### Frost DoD substitute (RED)

Clear mail/notes → Simulate Threat → frost + decoy A/B → Pro vault purchase → outer pack C. Same freeze clock.

---

## 13. Behind / ahead protocols

### Behind at 2:00

Drop: T3 polish, P2 glass brighten, tabletop.  
Keep: tip + purchase + bloom.

### Behind at 2:30

Drop: Simulate variety beyond **one** tip button.  
Keep: Successful Purchase path.

### Behind at 2:45

Drop: all polish Block G except brand whisper + tip legibility.  
Keep: integrate proof.

### Ahead at 2:45 (M8 early)

Allowed only: one tabletop tweak **or** one extra tip string cycle — **never** Vision as savior, never second climax API.

### Never

Burn clock inventing Vision to “save” CCA — tip-only or cutover.

---

## 14. Gate artifact index (write live)

| File | When | Writer | Blocks |
|------|------|--------|--------|
| `GATE-SCAFFOLD.md` | ~11:45 | S | Feature lanes wait |
| `GATE-CCA.md` | **12:15** | O | Theme path |
| `CUTOVER.flag` | 12:15 if RED | O | Frost promote |
| `GATE-RC.md` | ~2:15 | R | Integrate bloom |
| `DEMO-LAST-PASS.md` | 3:00–3:15 | Q | Demo confidence |
| `RC-IDs.md` | Pre-doors | Human | RC lane |
| `DEMO-SCRIPT.md` | ≤3:00 | O/Q paste from §16 | Rehearsal |

**Orchestrator-only writes:** `CUTOVER.flag`, `GATE-CCA.md` decision line.

---

## 15. Lane ↔ clock ownership matrix

| Block | O | S Cursor | D Claude | R Codex | F standby | G guard | Q |
|-------|---|----------|----------|---------|-----------|---------|---|
| A 11:30 | clock | **scaffold** | idle | idle | idle | — | — |
| B 11:45 | probe | compile watch | **shell+CCA** | idle | idle | — | — |
| C 12:15 | merge light | idle/hotfix | **capture** | **RC stub** | frost files? | nack | — |
| D 1:00 | lunch/org | — | **tips** | offerings | low | nack | — |
| E 1:45 | integrate | — | observe isPro | **purchase** | — | nack | — |
| F 2:15 | **merge** | **integrate** | named patches | named patches | — | nack | — |
| G 2:45 | clock | **polish** | stop features | stop | stop | **nack** | — |
| H 3:00 | **freeze** | hotfix only | stop | stop | stop | nack | **rehearse** |
| I 3:15 | queue | stop | stop | stop | stop | — | **pass 2** |

---

## 16. Creep protocol (say no scripts)

| Request | Response |
|---------|----------|
| “Add chat / agents” | Nack — kill list |
| “Add Vision pose” | Nack unless DoD green early — still optional amp only |
| “Paywall on outer” | Nack — design lock |
| “Second product” | Nack — one climax |
| “Quick Supabase” | Nack |
| “Just one more tip pack” | After freeze: nack; before freeze: only if Block D/G spare |
| “ASC sandbox” | Nack — Test Store only |

---

## 17. Venue minute cheat sheet (print)

```text
11:30 scaffold          11:45 shell+CCA
12:10 stop code         12:15 GATE GREEN/RED
12:15–1:00 slice D∥R    1:00 lunch/compile
1:00–1:45 tips          1:45–2:15 RC purchase
2:15–2:45 integrate     2:45–3:00 polish
3:00 FREEZE             3:15 90s#1 done
3:15–3:30 90s#2         3:30 DEMO
```

---

## 18. Milestone ↔ wall-clock bridge (M0–M8)

From `bible-single-theme-contract.md` §3 — mapped onto venue time.

### 18.0 Contract minute budgets (verbatim — SOFT FAIL-4)

Coding slice **180 minutes**. Print this column so agents do not rely only on the external contract file.

| # | Milestone | **Minutes** | Done when | Primary paths / demo secs |
|---|-----------|------------:|-----------|---------------------------|
| **M0** | Toolchain + §00 paste | **10** | Xcode 27.1 · Duo sim booted · every agent has §00 + theme contract | Human · no feature files yet |
| **M1** | Scaffold tree | **15** | Empty app ⌘R on Duo sim; §06 tree stubs exist | `App/**` · project · SPM RevenueCat stubs |
| **M2** | Duo shell green | **25** | Arrangement chrome + pose remaps regions; hinge effects-only | `Duo/PoseRouter.swift` · `App/RootArrangementView.swift` · `Shared/CutoverFlag.swift` |
| **M3** | **GATE-CCA** (~T+50 / ~12:15) | **5** | Outer path green **or** `CUTOVER.flag` → Frost primary | `docs-runtime/GATE-CCA.md` · `docs-runtime/CUTOVER.flag` |
| **M4a** | Outer Lens vertical slice *(if gate green)* | **55** | SCR-OL-A→C live: perm → inner capture → outer T1 tip | `Duo/CameraCaptureAccessoryHost.swift` · `Features/Capture/**` · `Features/CoachOverlay/**` · demo **0:00–0:45** |
| **M4b** | FrostDuo cutover slice *(if gate red)* | **55** | SCR-FD-A→C: clear → Simulate Threat → frost + decoy A | `Features/Frost/**` · demo cutover appendix **0:00–0:45** |
| **M5** | RevenueCat Test Store | **35** | Configure `PLACEHOLDER_RC_*`→human IDs · paywall · Successful Purchase · **other pane** unlock | `Monetization/**` · `Features/Paywall/**` · `docs-runtime/RC-IDs.md` · demo **0:50–1:20** |
| **M6** | Integrate + Pro bloom / vault | **15** | `EntitlementState.isPro` drives T2 (OL) or decoy C (FD) | Shared observe · Integrator merge · demo **1:05–1:20** |
| **M7** | Copy / assets soft land | **10** | Brad/Matt strings + tip glyphs / decoy stills resolve | `Resources/**` · `DesignSystem/Tokens.swift` · `docs-runtime/DEMO-SCRIPT.md` |
| **M8** | Freeze + acceptance | **10** | Tag freeze · TC suite or waivers · 90s ×1 dry | `docs-runtime/DEMO-LAST-PASS.md` · §15 tests |

**Minute column checksum:** 10+15+25+5+55+35+15+10+10 = **180**. (M4a **or** M4b — not both.)

### 18.1 Venue wall-clock map

| Milestone | Wall clock | Block | Owner | Contract min |
|-----------|------------|-------|-------|-------------:|
| M0 Toolchain paste | ≤11:30–11:40 | A | O | 10 |
| M1 Scaffold tree | 11:30–11:45 | A | S | 15 |
| M2 Duo shell green | 11:45–12:10 | B | D | 25 |
| M3 GATE-CCA | **12:15** | B end | O | 5 |
| M4a OL slice / M4b Frost | 12:15–1:45 | C–D | D or F | 55 |
| M5 RC Test Store | 1:45–2:15 | E | R | 35 |
| M6 Integrate bloom | 2:15–2:45 | F | INTEG | 15 |
| M7 Copy/assets soft | 2:45–3:00 | G | S/COPY | 10 |
| M8 Freeze + accept | 3:00–3:15 | H | O/Q | 10 |

---

## 19. Orchestrator run-loop (every 15 minutes)

1. Count live writers (must be ≤3).  
2. Ask each lane: blocked / done / next file.  
3. Check clock vs block table — if behind, apply §13 cut list.  
4. Refuse any request not on ON list.  
5. Log one line in Notes: `HH:MM status`.

**Sample log lines**

```text
11:45 GATE-SCAFFOLD pass
12:15 GATE-CCA GREEN tip-only rehearsed
13:10 CCA shutter live; RC configure ok
14:05 GATE-RC pass other-pane oval
15:00 FREEZE
15:12 90s#1 1:28 tip live purchase live
15:25 90s#2 0:58 backup path
```

---

## 20. Cross-links

| Need | Doc |
|------|-----|
| Second-by-second demo | `docs/bible/16-demo-script-90s.md` |
| Paste-ready AI cards | `docs/bible/18-multi-ai-lane-cards.md` |
| Tonight/tomorrow prep | `docs/bible/19-human-prep-tomorrow.md` |
| 3h plan source | `docs/outer-lens-3h-build-plan.md` |
| Routing | `docs/multi-ai-build-routing.md` |
| Theme / tree / TCs | `docs/bible-single-theme-contract.md` |

---

*End §17. 12:15 gate. 1:45 purchase. 3:00 freeze. Clock > ego.*
