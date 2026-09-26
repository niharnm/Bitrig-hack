# Outer Lens — 3-hour Saturday build plan (Film Tool only)

**Routing update, 2026-09-26:** Bitrig owns visual QA and Duo demo captures now, then replaces Cursor for ASSETS polish after the current owner hands off. Cursor retains scaffold, integration, and Frost standby. Use the Codex provider in Bitrig. See [Bitrig task assignment](bitrig-task-plan.md) for evidence, exact file locks, handoff conditions, and the first task prompt. This update takes precedence over older tool assignments below; lane boundaries and the three-writer limit still apply.

**For:** Nihar · Bitrig Hacks iPhone Duo · Sat Sep 26, 2026 · YC SF  
**Product:** **Outer Lens** (Film Tool) — one climax: `CameraCaptureAccessory` subject coach on the outer  
**Window this plan covers:** **11:30 → 3:15** (build + polish → freeze start); demos 3:30+  
**Cutover:** If CCA gate is **RED** at **12:15 sharp**, abandon Outer Lens feature work and flip to **FrostDuo** (see §3). Do not half-build both.  
**Constraint:** Spec / runbook only — **no app code in this doc**  
**Inputs:** `docs/design-direction.md` · `internal/research-outer-lens.md` · `internal/research-duo-apis.md` · `internal/research-revenuecat.md` · `docs/multi-ai-build-routing.md` · handoff §7 Saturday game plan  
**Compiled:** Sat Sep 26, 2026  

---

## 0. One paragraph — what you are shipping

By **3:15**, Outer Lens is a **photo-only Film Tool** on Duo sim: inner charcoal capture (preview + shutter + flip + Pro CTA); outer shows **one tip** (≥28pt, ≤8 words) via CCA (or tip-only stage if dual preview flakes). Free = outer tip T1. Pro = amber guide oval T2 after RevenueCat Test Store **Successful Purchase**, visible on the **other** pane. **One climax.** No Vision, no FM, no video, no Multipeer, no second product. If CCA is red at 12:15 → full cutover to FrostDuo; RC muscle memory carries.

**Brad (spoken, frozen):** Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.  
**Matt (spoken, frozen):** Free: outer preview. Pro: pose overlays on the outer display.

---

## 1. Ruthless scope lock

### ON (must ship)

| ID | Feature | Pane | Notes |
|----|---------|------|-------|
| **OL-A** | Camera permission primer → system alert | Inner | Photo only; no mic |
| **OL-B** | Capture shell: full-bleed preview, flip, **◎ shutter ~80pt**, Subject toggle, tip-pack menu stub | Inner | Liquid Glass on side pills only; shutter solid |
| **OL-C** | Subject coach: **T1** one tip (+ brand whisper) | Outer via CCA | Tips-first; tip-only fullscreen OK if preview black |
| **T3** | One countdown `3·2·1` | Outer | Demo once; Simulate countdown if live flaky |
| **OL-D** | RevenueCatUI paywall → entitlement `pro` | Inner | Test Store; no ASC |
| **M3** | Pro unlock → outer **T2** amber oval bloom | Outer | Other-pane proof — load-bearing RC beat |
| **E** | Denied / `accessory.unavailable` | Inner | Inner still shoots; never brick |
| **Simulate tip / Simulate Pro / Simulate countdown** | Settings sheet | Inner | Judge-safe recovery |

### OFF (hard kill — refuse mid-day)

| Kill | Why |
|------|-----|
| Video / mic / REC theater | Session + perm tax |
| Dual outer preview as requirement | Prefer tip-only if flakes |
| Vision / ARKit / body pose / FM tips | Not load-bearing; sim flakes |
| Tip packs beyond Free (3 strings) + Pro oval | Pack theater |
| Multipeer / Watch / gallery picker / lens rack | Out of slice |
| ArrangementView tabletop polish as a *feature* | Optional only if CCA green **and** clock ≥ 2:45 |
| Hinge-driven layout / Accorduon / chat / Supabase / Sentry-as-product | Scope / DQ adjacent |
| Frost UI while Outer Lens is still GREEN | Standby files only until 12:15 |
| Second climax API in one demo path | One climax |
| Paywall on outer · tip lists · skeleton HUD · purple/cream AI-slop | Design lock |

### One climax (say it aloud at 11:30)

> **Outer tip appears on the subject face of the Duo (CCA). Everything else serves that.**

RC purchase is the **monetization beat**, not a second Duo climax.

---

## 2. Who owns what (AI lanes — max 3 coding writers)

Aligned with `docs/multi-ai-build-routing.md`. Paste lane stubs from that doc.

| Slot | Human / AI | Lane | Owns |
|------|------------|------|------|
| **O** | **Nihar** (+ cheap Cursor checklist) | Orchestrator | Clock, gates, `CUTOVER.flag`, `GATE-CCA.md`, merge, sim clicks, demo |
| **S** | **Cursor Agent** on Xcode Mac | Scaffold → integrate | Project tree, SPM stubs, integration |
| **D** | **Claude Code + Opus** | Duo core → then Outer Lens | `PoseRouter`, `RootArrangementView`, then `Capture/` + `CoachOverlay/` + CCA host |
| **R** | **Codex CLI** (or Cursor+GPT) | RevenueCat | `Monetization/`, `Paywall/`, consumes `RC-IDs.md` only |
| **F** | Cursor BG / 2nd Codex | Frost standby | `Features/Frost/**` behind flag — **upgrade to primary only if cutover** |
| **B** | Bitrig with Codex | Visual QA → ASSETS after handoff | `BITRIG-REVIEW.md` now; tokens, motion, assets after handoff |
| **Q** | Nihar + Bitrig evidence | QA / demo | TC ticks, `DEMO-LAST-PASS.md`; timed rehearsal and approval by Nihar |
| **G** | Claude Opus read-only | Scope guard | Nacks creep; no write |

**Concurrency rule:** ≤3 writers. Preferred live set: **D + R + (F standby OR polish)**. Never four feature writers.

---

## 3. CCA green / red gate → Frost cutover

### Gate clock

| Time | Artifact | Owner |
|------|----------|-------|
| **12:10** | Start gate probe (stop new CCA thrash) | O |
| **12:15 sharp** | Write `docs-runtime/GATE-CCA.md` + decide | O **only** |

### GREEN (stay Outer Lens)

ALL of the following, or the written tip-only story still reads as subject coach:

1. Capture UI on **inner**; session reaches `session.live` **or** black preview + static tip cards without bricking shutter.  
2. `.sceneAccessory { CameraCaptureAccessory… }` compiles on iOS 27.1; `onAvailabilityChange` wired.  
3. **Either** accessory presents with T1 tip readable, **or** rehearsed **tip-only outer / Simulate tip** still sells “subject coach on the outer” in the Duo story (verbal if sim never lights outer for camera).  
4. Subject toggle reflects available vs enabled (hide if unavailable).

**GREEN →** keep LANE-CCA primary; F stays file-isolated standby (low priority). Do **not** flip cutover for polish debt.

### RED (cutover FrostDuo immediately)

ANY of:

- Accessory never available after live/fake session **and** tip-only coach story cannot be rehearsed honestly.  
- Entitlement / provisioning mystery blocks CCA path with no organizer answer by 12:15.  
- Team still fighting dual-preview / invented APIs with **no** tip on glass by 12:15.  
- Orchestrator judges CCA will not be demo-viable by 3:15 even with Simulate.

**RED actions (≤5 min):**

1. O writes `CUTOVER.flag = frost` and `GATE-CCA.md = RED`.  
2. Stop all `Features/Capture` / `CoachOverlay` feature work (leave compile stubs).  
3. Promote **F** to primary writer; D moves to Frost shell help if needed.  
4. COPY switches to Frost Brad; same RC `pro` / Test Store / other-pane unlock → vault decoy C.  
5. **Do not** skin Outer Lens as frost. Full concept switch.

**This plan’s minute table after 12:15 assumes GREEN.** If RED, discard Outer Lens blocks 12:15→3:15 and run Frost vertical slice (inner frost ladder + outer decoy A/B + Simulate Threat + RC → vault C) on the same clock discipline.

---

## 4. Minute plan — 11:30 → 3:15

Times are **wall clock** (venue). Lunch ~1:00 is **eat while RC/compile runs** — do not open a new feature.

### Pre-doors (before 11:30) — human only, no app code

| Check | Done when |
|-------|-----------|
| Xcode **27.1**, Duo sim **first boot already finished** | ⌘R empty app earlier today |
| `RC-IDs.md` filled: `test_` key, entitlement `pro`, offering, paywall published | Paste ready |
| Tip strings frozen (3 free + countdown) | On paper / Notes |
| Frost decoy stills on disk (cutover insurance) | Wallpaper A/B/C |
| Lane prompt stubs printed / one sheet | From routing doc |

---

### Block A — 11:30–11:45 · Toolchain + scaffold (15)

| | |
|--|--|
| **Owner** | O + **S** (Cursor scaffold) |
| **AI** | Cursor Agent on Mac — Scaffold stub |
| **ON** | New Duo app target; §06 folder stubs; SPM refs for RevenueCat ≥5.43 (no configure yet) |
| **OFF** | CCA, paywall UI, Frost UI, DesignSystem taste pass |
| **Done** | Empty app ⌘R on Duo sim; Device Hub fold reacts; `GATE-SCAFFOLD.md = PASS` |
| **Fail** | Wrong Xcode → stop; fix toolchain before any feature |

---

### Block B — 11:45–12:15 · Duo shell + CCA proof (30) ★ GATE

| | |
|--|--|
| **Owner** | **D** (Claude Code/Opus) serial; O probes sim; S idle / watches compile |
| **AI** | Duo core → hand to Outer Lens CCA proof in same session |
| **ON** | `RootArrangementView` + pose chrome; CCA host on capture root; inner black preview shell; outer T1 **static** tip (“Chin up · eyes to the lens”); Subject availability hook |
| **OFF** | RC purchase UI; Pro oval; Vision; polish motion; tip packs |
| **12:10** | Stop adding code; probe gate criteria (§3) |
| **12:15** | **O writes GATE-CCA green/red** |

**Sub-beats (use if helpful):**

| Clock | Action |
|-------|--------|
| 11:45–12:00 | Arrangement / pose shell visible on Duo sim (TC-S01/S02) |
| 12:00–12:10 | Wire `.sceneAccessory { CameraCaptureAccessory }`; tip view compiles; try availability |
| 12:10–12:15 | Gate decision only |

---

### Block C — 12:15–1:00 · Vertical slice core (45) · assume GREEN

| | |
|--|--|
| **Owners (parallel ≤3)** | **D** Outer Lens · **R** RevenueCat · **F** Frost stubs *only if spare* (lowest priority) |
| **ON (D)** | AV session + permission primer; shutter + flip; outer T1 settle; tip-only fallback; `accessory.unavailable` path; Simulate tip |
| **ON (R)** | `Purchases.configure(test_)` under `#if DEBUG`; `EntitlementState`; PaywallView / present sheet stub; **no inventing IDs** |
| **OFF** | Pro oval bloom (wait for integrate); countdown polish; Liquid Glass taste; FM; tabletop |
| **Done** | Inner shoots; outer shows tip (or Simulate); RC configures without crash; paywall can present even if purchase not rehearsed yet |
| **1:00** | Lunch — leave a compile / package resolve running if needed |

---

### Block D — 1:00–1:45 · Capture harden + tip craft (45)

| | |
|--|--|
| **Owner** | **D** primary; **R** finishes offerings fetch if blocked; O eats / answers organizers |
| **ON** | Free tip set (3 strings cycle or pack menu with 1 live tip); denied → Settings; countdown **T3** wired once; Simulate countdown; Film Tool tokens applied lightly (charcoal `#050505`, amber reserved for Pro) |
| **OFF** | Pro oval until EntitlementState merges; DesignSystem rewrite; second tip style beyond T1/T3 |
| **Done** | 90s path beats 1–3 possible without purchase: open → grant → tip visible → countdown once |

---

### Block E — 1:45–2:15 · RC purchase beat (30) ★ MONETIZATION

| | |
|--|--|
| **Owner** | **R** + **O** (Integrator merge); **D** observes `isPro` only |
| **AI** | Codex/Cursor RC lane; human pastes `RC-IDs.md` if still placeholder → else **BLOCKED** stop inventing |
| **ON** | Inner Pro coaching CTA → RevenueCatUI → Test Store → **Successful Purchase** → `entitlements["pro"].isActive` → outer **T2** amber guide oval (**M3**) |
| **OFF** | Restore-across-reinstall demo; Failed path polish beyond one Cancel; hard paywall; ASC |
| **Timing (rehearse inside this block)** | Climax tip already visible → tap Pro ≤5s → paywall ≤10s → Successful Purchase ≤10s → **other pane** oval ≤5s |
| **Done** | `GATE-RC.md = PASS` when TC-R02/R03/R04 true; Cancel once proves gate still holds |
| **Fail** | Offering nil / wrong entitlement id → fix dashboard, not Swift invention |

**Spoken Matt line during purchase beat:** “Free outer preview. Pro pose overlays on the outer display.”

---

### Block F — 2:15–2:45 · Integrate + other-pane proof (30)

| | |
|--|--|
| **Owner** | **O/S** Integrator; D+R patch only named files |
| **ON** | Merge EntitlementState → CoachOverlay; Pro CTA → check (P3); tip settle M1 + unlock bloom M3; shutter press P1 if free; Ensure paywall **never** on outer |
| **OFF** | New screens; Vision; tabletop as new feature; Frost primary |
| **Done** | Single build path: tip → Pro → purchase → oval on outer without restart |

---

### Block G — 2:45–3:00 · Polish only (15)

| | |
|--|--|
| **Owner** | **S** polish (Cursor+Sonnet); scope guard **G** nacks |
| **ON** | Brand whisper **Outer Lens**; tip plate scrim; SF Rounded tip ≥28pt; amber `#E8A838` on Pro only; Reduce Motion → crossfade; optional **one** tabletop Arrangement tweak **iff** CCA green |
| **OFF** | New motions beyond M1/M2/M3 + P1–P3; glass on outer tip; glow; card soup; Sentry/OpenAI/Supabase |
| **Done** | Demo path looks intentional; non-demo screens ignored |

---

### Block H — 3:00–3:15 · FREEZE + rehearsal start (15)

| | |
|--|--|
| **Owner** | **O** + **Q** |
| **3:00** | **FREEZE** — tag / verbal lock: no new features; only `sat/hotfix/*` demo-blockers named by O |
| **ON** | Run DoD checklist (§5); write `DEMO-LAST-PASS.md`; rehearse **90s script ×1** (second pass 3:15–3:30 per handoff) |
| **OFF** | “Quick” tip packs, FM, decoy experiments, refactor |
| **Done at 3:15** | Code frozen; first full 90s timed; Simulate tip / Simulate Pro ready; Brad+Matt memorized |

**3:15–3:30 (handoff, outside this file’s title window but mandatory):** second 90s; stop coding; walk to demo queue.

---

## 5. Definition of done — demos

### Vertical-slice DoD (must all be true at freeze)

| # | Criterion | Evidence |
|---|-----------|----------|
| 1 | Duo climax ≤30s, zero narration | Outer T1 tip readable at 2–3 m (or Simulate tip + honest “on device…” line) |
| 2 | Inner capture usable | Preview or black+shutter; flip once; tip still legible |
| 3 | Countdown once | T3 or Simulate countdown |
| 4 | RC critical path | Pro CTA → Test Store **Successful Purchase** → outer T2 oval (other pane) |
| 5 | Cancel/Fail once | Gate still holds |
| 6 | Failure survivable | Denied → Settings; `accessory.unavailable` → inner still shoots |
| 7 | Scope clean | No second climax API; no paywall on outer; Film Tool tokens |
| 8 | Pitch | Brad + Matt spoken without notes |

### 90s demo script (Outer Lens GREEN)

| Sec | Beat | Owner cue |
|----:|------|-----------|
| 0–10 | Brad sentence; show brand **Outer Lens** | O |
| 10–40 | **Climax:** unfold / outer tip lands (M1); optional countdown (M2) | O + sim |
| 40–55 | Flip once; tip stays | — |
| 55–75 | Pro CTA → paywall → Successful Purchase → outer T2 bloom (M3) | Matt line |
| 75–90 | Who pays / why Duo / ask | Brad close |

**Backup 60s:** Skip flip; tip → purchase → bloom only.  
**CCA flake line:** Hit Simulate tip / Simulate Pro; “Subject coach is CCA; sim can’t always light outer for camera — on device the outer faces the kid.”

### If cutover RED — Frost DoD (replace Outer Lens DoD)

Clear mail/notes → Simulate Threat → frost + decoy A/B → Pro vault purchase → outer pack C. Same freeze clock. Brad switches to shoulder-surfer sentence.

---

## 6. Gate artifacts (write these live)

| File | When | Writer |
|------|------|--------|
| `GATE-SCAFFOLD.md` | ~11:45 | S |
| `GATE-CCA.md` | **12:15** | O |
| `CUTOVER.flag` | 12:15 if RED | O |
| `GATE-RC.md` | ~2:15 | R |
| `DEMO-LAST-PASS.md` | 3:00–3:15 | Q |
| `RC-IDs.md` | Pre-doors | Human |

---

## 7. Lunch / creep protocol

- **1:00 lunch:** no new screens; merge/compile OK.  
- Any request not in §1 ON list → **G nacks** or O defers to post-demo.  
- If behind at **2:00:** drop T3 polish, drop P2 glass brighten, drop tabletop; keep tip + purchase + bloom.  
- If behind at **2:30:** drop Simulate variety beyond one tip button; keep Successful Purchase path.  
- **Never** burn remaining clock inventing Vision to “save” CCA — tip-only or cutover.

---

## 8. Cross-links

| Doc | Use |
|-----|-----|
| `docs/design-direction.md` | Tokens, SCR-OL-*, M1–M3, P1–P3 |
| `docs/multi-ai-build-routing.md` | Lane prompt stubs + conflict locks |
| `docs/build-bible-blueprint.md` | §18 merge order / lane IDs |
| `internal/research-outer-lens.md` | CCA contract, states, hour-one cutover |
| `internal/research-duo-apis.md` | VERIFIED APIs + sim quirks |
| `internal/research-revenuecat.md` | Test Store recipe + pitfalls |
| `internal/bitrig-duo-cursor-handoff.md` §7 | Venue clock / 90s template |

---

*End. One climax. 12:15 gate. 1:45–2:15 purchase. 3:00 freeze. Ship the Film Tool tip, not a platform.*
