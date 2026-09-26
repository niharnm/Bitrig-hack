# §16 — Demo script (90s) — Outer Lens Film Tool

**For:** Nihar · Bitrig Hacks iPhone Duo · Sat Sep 26, 2026 · YC SF  
**Product:** **Outer Lens** (Film Tool) — climax = `CameraCaptureAccessory` subject coach on the outer  
**Cutover appendix:** FrostDuo 90s if `CUTOVER.flag = frost` at 12:15  
**Role:** Second-by-second spoken + click script; Brad/Matt lines frozen; fallbacks for CCA/RC flake  
**Maps to:** demo seconds · `docs-runtime/DEMO-SCRIPT.md` (paste this verbatim Sat) · TC-P01 / TC-P03 / TC-D02  
**Inputs:** `docs/outer-lens-3h-build-plan.md` · `docs/win-completeness-bar.md` · `docs/bible-single-theme-contract.md` · `docs/design-direction.md` · `docs/multi-ai-build-routing.md`  
**Constraint:** Spec / runbook only — **no app code**  
**Compiled:** Sat Sep 26, 2026

---

## 0. How to use this chapter

1. Memorize **§1 frozen lines** before doors. Do not improvise Brad/Matt.
2. At **3:00 FREEZE**, paste §2 into `docs-runtime/DEMO-SCRIPT.md`.
3. Rehearse **full 90s ×2** (3:00–3:15 first pass; 3:15–3:30 second pass). Time with phone stopwatch.
4. If any beat fails in rehearsal, run the matching **fallback** in §4 — do not invent a third product story on stage.
5. Judges hear **one climax** (outer tip) then **one monetization beat** (RC → other-pane oval). Everything else is chrome.

**Room test (hard):** T1 tip readable at **2–3 m** with zero narration during 0:10–0:40.

---

## 1. Frozen spoken lines (do not paraphrase on stage)

### 1A. Brad Flora / YC one-liner (Outer Lens — PRIMARY)

> Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.

**When:** 0:00–0:10 (open) and optionally restated in close 0:75–0:90 as “who pays.”  
**TC:** TC-P01  
**Path:** `Resources/Localizable.strings` · `docs-runtime/DEMO-SCRIPT.md`

### 1B. Matt Berry / RevenueCat free-vs-Pro (Outer Lens — PRIMARY)

> Free: outer preview. Pro: pose overlays on the outer display.

**When:** during/after purchase beat ~0:55–0:75, before oval blooms or as oval blooms.  
**TC:** TC-P03  
**Alt Matt (same meaning, if you flub):** “Free outer tip; Pro coaching overlays on the subject face.”

### 1C. Brad (FrostDuo — CUTOVER ONLY)

> Shoulder-surfers ruin private screens — Duo frosts the inner face and shows a decoy on the outer; Pro unlocks vault decoys.

### 1D. Matt (FrostDuo — CUTOVER ONLY)

> Free: frost and a lock decoy. Pro: vault covers on the outer display.

### 1E. Honest CCA / sim flake line (approved — use when Simulate is on)

> Subject coach is CameraCaptureAccessory — the sim can’t always light the outer for camera. On device, the outer faces the kid.

### 1F. Who-pays close (Outer Lens)

> Parents pay for the overlays that make the kid look good without turning the phone around. That’s Outer Lens.

**Do not say:** “AI coach,” “Foundation Models,” “we also have Frost,” “vision pose detection,” sponsor logo salad.

---

## 2. Full 90-second path — Outer Lens GREEN

**Precondition checklist (before you walk up):**

| # | Ready | Evidence |
|---|-------|----------|
| 1 | App on Duo sim, book or unfold pose showing crease | TC-S01 |
| 2 | Camera permission already granted **or** primer one-tap | SCR-OL-A |
| 3 | Outer T1 tip string frozen: **Chin up · eyes to the lens** | SCR-OL-C · T1 |
| 4 | Settings: **Simulate tip** / **Simulate Pro** / **Simulate countdown** exist | OL-E recovery |
| 5 | RC Test Store path works once in rehearsal | TC-R02–R04 |
| 6 | Brad + Matt memorized | TC-P01 / TC-P03 |

### Second-by-second table

| Sec | Wall beat | You say | You click / show | Screen / motion | Fail → jump |
|----:|-----------|---------|------------------|-----------------|-------------|
| **0–3** | Open | *(silence 0.5s)* then start Brad | Hold Duo so crease + both panes visible | Brand **Outer Lens** visible on inner | — |
| **3–10** | Brad | **§1A Brad full sentence** | Do not tap yet; let them read brand | SCR-OL-B charcoal preview | Skip brand whisper if missing — still speak Brad |
| **10–15** | Climax setup | *(optional, ≤6 words)* “Watch the outer.” | Ensure Subject toggle On if visible; unfold if closed | SCR-OL-B → SCR-OL-C | If outer dark → **F1 Simulate tip** |
| **15–30** | **CLIMAX** | *(zero narration preferred)* | Outer shows T1 tip ≥28pt: **Chin up · eyes to the lens** | SCR-OL-C · **M1** tip settle | F1; speak §1E once |
| **30–40** | Hold climax | *(silence or)* “That’s the subject coach.” | Keep tip on glass; do not open paywall yet | Tip readable 2–3 m | If tip gone → F1 again |
| **40–48** | Flip proof | “Flip keeps the coach.” | Tap **flip** once on inner | SCR-OL-B P2; tip stays on outer | Skip flip → go 0:48 purchase |
| **48–55** | Countdown (optional) | *(optional)* “One count.” | Fire countdown **or** Settings → **Simulate countdown** | SCR-OL-C · **T3** · **M2** | **Skip entire countdown** if late — go Pro |
| **55–62** | Pro CTA | Start Matt **§1B** | Tap **Pro coaching** pill (inner trailing) | SCR-OL-B · **P3** | If CTA missing → Settings **Simulate Pro** then pretend Matt |
| **62–72** | Paywall | Finish Matt while sheet up | RevenueCatUI → Test Store → tap **Successful Purchase** | SCR-OL-D inner only | **F2 Cancel recovery** then retry once; else **F3 Simulate Pro** |
| **72–80** | Unlock proof | *(point at outer, no jargon)* “Pro on the outer.” | Outer T1 → **T2 amber oval** bloom | SCR-OL-C · **M3** · TC-R04 | F3; say §1E + “Pro overlays gate on device.” |
| **80–90** | Close | **§1F who-pays** + stop | Lower phone slightly; smile; stop talking | Brand still visible | Never start a second feature |

**Total spoken words target:** ≤90 words excluding silence. Prefer less.

### Beat → SCR / path / TC map

| Demo sec | SCR-ID | Path | TC |
|----------|--------|------|----|
| 0:00–0:10 | SCR-OL-A/B | `PermissionPrimerView` / `InnerCaptureView` | TC-P01 |
| 0:15–0:45 | SCR-OL-C · T1 | `SubjectCoachView` / `TipPlateView` | TC-C01 |
| 0:40–0:48 | SCR-OL-B | flip control | TC-C02 |
| 0:48–0:55 | SCR-OL-C · T3 | `CountdownView` | optional |
| 0:55–1:05 | SCR-OL-D | `PaywallHostView` | TC-R02 |
| 1:05–1:20 | SCR-OL-C · T2 | `GuideOvalView` + `EntitlementState` | TC-R03 · TC-R04 · TC-C04 |
| 1:20–1:30 | close | spoken only | TC-P03 · TC-D02 |

---

## 3. Backup 60-second path (skip flip + countdown)

Use when: clock is short, judge queue is moving, or flip/countdown flake in rehearsal.

| Sec | Beat | Say | Do |
|----:|------|-----|----|
| 0–8 | Brad | §1A | Show crease + brand |
| 8–28 | Climax | *(silence)* | Outer T1 tip (or Simulate tip + §1E) |
| 28–50 | Purchase | §1B Matt | Pro → Successful Purchase |
| 50–60 | Bloom + close | “Pro on the outer.” + §1F half-line | T2 oval · stop |

**Rule:** Never cut the climax tip **and** the purchase. Cut chrome first.

---

## 4. Fallbacks (named — rehearse once)

### F1 — CCA / outer tip flake

| Step | Action |
|------|--------|
| 1 | Settings → **Simulate tip** (forces T1 on outer stage or tip-only fullscreen) |
| 2 | Speak **§1E** once, calmly |
| 3 | Continue to Pro beat — do not debug APIs on stage |
| 4 | If Simulate tip missing → hold phone, narrate tip string while pointing at outer pane (last resort; mark DEMO-LAST-PASS waiver) |

### F2 — Paywall / offering nil / Cancel

| Step | Action |
|------|--------|
| 1 | If Cancel/Fail once → say “Gate still holds” only if asked; otherwise silent retry |
| 2 | Retry **Successful Purchase** once (≤10s) |
| 3 | If still fail → Settings → **Simulate Pro** → outer T2 oval |
| 4 | Matt line still spoken; add: “Test Store path is wired; sim flake — entitlement `pro` drives the oval.” |
| 5 | **Never** invent a fake toast-only unlock as the story |

### F3 — Unlock not on other pane

| Step | Action |
|------|--------|
| 1 | Confirm you are looking at **outer**, not inner checkmark alone |
| 2 | Simulate Pro |
| 3 | If oval never appears → point to inner Pro check + say Matt; note as demo-blocker for post-mortem — still finish who-pays |

### F4 — Permission denied mid-demo

| Step | Action |
|------|--------|
| 1 | Show deny → Settings path once (SCR-OL-E) — proves hygiene |
| 2 | Re-grant quickly **or** restart app with prior grant from rehearsal |
| 3 | Do not spend >10s in Settings on stage |

### F5 — Accessory unavailable / inner still shoots

| Step | Action |
|------|--------|
| 1 | Show shutter still works (TC-C03) — one press |
| 2 | Jump to Simulate tip + §1E |
| 3 | Proceed to RC beat |

### F6 — Wrong product / Frost files visible

| Step | Action |
|------|--------|
| 1 | Confirm `CUTOVER.flag` is **false** for Outer Lens demo |
| 2 | If Frost UI is live by mistake → stop; relaunch correct root slot (Integrator) |
| 3 | Never demo both climaxes |

---

## 5. Click choreography (inner chrome only)

Film Tool rails from `docs/design-direction.md`:

**Top rail:** close · Subject · tip pack (glass pills)  
**Bottom rail:** flip · **◎ shutter ~80pt solid** · Pro coaching (amber tint glass)

| Demo need | Control | Notes |
|-----------|---------|-------|
| Climax | Subject On + CCA tip | No shutter required for climax |
| Flip proof | Flip once | Tip must remain legible |
| Countdown | Tip pack / Settings Simulate countdown | Optional |
| Monetization | Pro coaching | Opens SCR-OL-D |
| Recovery | Settings sheet | Simulate tip / Pro / countdown |

**Outer:** no shutter, no paywall, no settings. Tip plate solid `#1C1C1E` + scrim — not Liquid Glass.

---

## 6. Tip strings (frozen for demo)

Ship **three free** strings; demo uses **#1** unless cycling mid-rehearsal.

| # | String (≤8 words) | Use |
|---|-------------------|-----|
| 1 | **Chin up · eyes to the lens** | Default climax T1 |
| 2 | **Fill the frame · step closer** | Alternate if #1 burned in prior take |
| 3 | **Soft smile · both faces in** | Kids beat if asked |

**Pro T2:** same tip + amber guide oval stroke (`#E8A838`) — not a longer sentence.

**Countdown T3:** huge `3 · 2 · 1` then tip dims during count.

---

## 7. Judge-facing beats (who cares when)

| Judge signal | Demo seconds | What they should see/hear |
|--------------|-------------:|---------------------------|
| **Brad Flora** | 0:00–0:10, 0:80–0:90 | Who/pain/why Duo; who pays |
| **Kyle / Justin** | 0:15–0:40 | Real Duo API climax (CCA), craft chrome |
| **Jane** | 0:15–0:40 | Outer does something newly possible |
| **Matt Berry** | 0:55–0:80 | Real Test Store purchase → other pane |
| **Yuma / Thomas / Ari** | optional | Do not bend the slice for them |

---

## 8. Cutover appendix — FrostDuo 90s (only if GATE-CCA RED)

**Precondition:** `docs-runtime/CUTOVER.flag = frost` written by Orchestrator at 12:15. Brad/Matt switch to §1C / §1D.

| Sec | Beat | Say | Do | SCR |
|----:|------|-----|-----|-----|
| 0–10 | Brad | §1C | Show clear mail/notes inner; calm outer | SCR-FD-A |
| 10–25 | Setup | “Tabletop — secrets up.” | Pose tabletop if available | FD-A/B |
| 25–45 | **CLIMAX** | *(silence)* | **Simulate Threat** → frost + decoy A/B | SCR-FD-C · F1+F2 |
| 45–55 | Hold | “Outer looks like someone else’s phone.” | Point at decoy | FD-C |
| 55–75 | Purchase | §1D Matt | Pro → Test Store Successful Purchase | SCR-FD-D |
| 75–85 | Unlock | “Vault on the outer.” | Outer → pack **C** | FD-C · F3 |
| 85–90 | Close | Who pays: people who hate shoulder-surf | Stop | — |

**Frost fallbacks:** Simulate Threat is mandatory in sim (TC-F03). Never rely on live ARKit faces on stage.

---

## 9. Rehearsal protocol (3:00–3:30)

| Pass | Clock | Goal | Record in |
|------|-------|------|-----------|
| Dry 1 | 3:00–3:15 | Full 90s timed; note first fail second | `DEMO-LAST-PASS.md` |
| Dry 2 | 3:15–3:30 | Full 90s **or** backup 60s; force one fallback | `DEMO-LAST-PASS.md` |
| Queue | 3:30+ | No coding; battery + volume; Brad breath | — |

**DEMO-LAST-PASS.md template fields:**

```text
mode: outer-lens | frost
path: 90 | 60
climax: live-cca | simulate-tip
rc: live-purchase | simulate-pro
brad: memorized y/n
matt: memorized y/n
waivers:
blocker-hotfixes:
```

---

## 10. Anti-patterns on stage (instant nacks)

- Narrating through the climax (“so here the CameraCaptureAccessory modifier…”)
- Opening Settings to show architecture
- Second climax (frost + CCA) in one take
- Paywall on outer
- “And if we had more time…” roadmap
- Logo tour (OpenAI / Supabase / Sentry) unless asked
- Apologizing more than once — fix with Simulate, then finish

---

## 11. Print card (one sheet for pocket)

```text
OUTER LENS 90s
0-10  Brad: parents / kids / outer coach / free preview / Pro overlays
10-40 OUTER TIP "Chin up · eyes to the lens"  (Simulate tip + honest CCA line)
40-55 flip optional · countdown optional
55-80 Matt: Free outer preview. Pro pose overlays on the outer.
      Pro → Successful Purchase → amber oval OTHER PANE
80-90 who pays · STOP

60s backup: Brad → tip → purchase → oval → stop
F1 Simulate tip · F2 retry purchase / Simulate Pro · F3 oval miss
```

---

## 12. Full spoken transcript (Outer Lens GREEN — default take)

Use this as the rehearsal master. Bracketed lines are optional; strike them if time is tight.

| Sec | Transcript |
|----:|------------|
| 0:00 | *(show crease; brand Outer Lens visible)* |
| 0:03 | “Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.” |
| 0:10 | *(optional)* “Watch the outer.” |
| 0:15–0:35 | *(silence — tip lands: Chin up · eyes to the lens)* |
| 0:35 | *(optional)* “That’s the subject coach.” |
| 0:40 | “Flip keeps the coach.” *(flip once)* |
| 0:48 | *(optional)* “One count.” *(3·2·1)* |
| 0:55 | “Free: outer preview. Pro: pose overlays on the outer display.” *(tap Pro)* |
| 1:02 | *(paywall up — silence or soft “Test Store.”)* |
| 1:08 | *(Successful Purchase)* |
| 1:12 | “Pro on the outer.” *(amber oval blooms)* |
| 1:20 | “Parents pay for the overlays that make the kid look good without turning the phone around. That’s Outer Lens.” |
| 1:28 | *(stop. smile. lower phone.)* |

**Word count (required lines only):** Brad 36 · Matt 12 · close 24 · optional extras ≤20 → stay under ~90 spoken words.

---

## 13. Q&A pocket answers (≤15s each)

| Likely ask | Answer |
|------------|--------|
| “Does it work on a normal iPhone?” | “The coach needs Duo’s outer face — that’s the point.” |
| “Is the tip AI?” | “Static craft tips for the slice; Pro is the oval overlay. Vision is optional amp we cut.” |
| “Real purchase?” | “RevenueCat Test Store — Successful Purchase flips entitlement `pro` on the other pane.” |
| “Why not Vision body pose?” | “Sim flakes; tip-first is the load-bearing path.” |
| “What about Frost / privacy?” | Only if cutover: give Frost Brad. If GREEN: “We engineered a cutover; today you saw Outer Lens.” |
| “Ship to App Store?” | “Polished demo slice — hosts asked for real enough to demo, not ASC.” |

---

## 14. Stage ops checklist (walk-up)

- [ ] Airplane mode off (RC needs net) **or** known offline waiver → Simulate Pro  
- [ ] Silent switch off; volume mid  
- [ ] Brightness high; True Tone OK  
- [ ] Prior grant camera permission  
- [ ] Settings sheet one gesture away  
- [ ] Know which pane is outer in current pose  
- [ ] Stopwatch app ready for rehearsal only — not on stage  

---

## 15. Cross-links

| Need | Doc |
|------|-----|
| Minute clock / freeze | `docs/bible/17-saturday-clock.md` |
| Lane ownership | `docs/bible/18-multi-ai-lane-cards.md` |
| Human prep / paste packs | `docs/bible/19-human-prep-tomorrow.md` |
| Tokens / M1–M3 | `docs/design-direction.md` |
| Win bar | `docs/win-completeness-bar.md` |
| Theme lock | `docs/bible-single-theme-contract.md` |

---

*End §16. One climax. Brad then silence then Matt. Simulate is honesty, not cheating.*
