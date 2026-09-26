# REVIEW — Claude-style rigorous overnight pass

**Reviewer:** Claude overnight pass (`bc-ca323a64-fe32-5249-839a-51a15baf9093`)  
**Store:** `/cursor/stores/bc-efb3d903-44d1-4e0a-b492-044c558277f9/docs/bible/`  
**Corpus:** chapters `00`–`19` + `11b` + README/STATUS (~85k words)  
**Lens:** Theme lock Outer Lens Film Tool · FrostDuo cutover-only · CCA climax · no banned nouns as product · concrete file paths · demo seconds · RC placeholder protocol · Saturday coding readiness  
**Compared to:** `docs/bible-single-theme-contract.md` · `docs/outer-lens-3h-build-plan.md` · `docs/win-completeness-bar.md` · sibling `REVIEW-cursor-lanes-pass.md`  
**Verdict:** **CONDITIONAL PASS** — usable Saturday after P0 patches below. Theme/kill-list/demo spine are strong; identity collisions (RC placeholders, TC namespaces, CUTOVER.flag values, stale index) would block coding if unfixed.

**Compiled:** Sat Sep 26, 2026

---

## 0. Executive checklist

| Criterion | Pre-patch | Post-P0 target | Notes |
|-----------|-----------|----------------|-------|
| Theme = Outer Lens Film Tool only | **Pass** | Pass | Charcoal `#050505` · amber `#E8A838` consistent across §§00–03, 11–14, 16–18 |
| FrostDuo = cutover-only (not second product) | Pass w/ ambiguity | **Pass** | Flag value still said `frost` **or** `true` in §02/§12; §15 said `outerLens`/`true` |
| CCA climax ≤30s on outer | **Pass** | Pass | Demo 0:15–0:45 / room silence 0:15–0:40; paths to `CameraCaptureAccessoryHost.swift` |
| No banned nouns as live product | **Pass** | Pass | PoseAgent/HingeBeat/etc. appear only as kill-list / pattern-fuel cites |
| Concrete file paths | Mostly pass | Pass | Tree freeze in §06 solid; §09 `DuoApp/docs-runtime` vs shorthand `docs-runtime` needs one lock line |
| Demo seconds mapped | **Pass** | Pass | §16 second-by-second table is authoritative; minor 0:40 vs 0:45 climax hold drift = P1 |
| RC placeholder protocol | **Fail** | **Pass** | Dual token vocabularies (§00 `PLACEHOLDER_RC_*` vs §09/§19 legacy aliases; §18 `PLACEHOLDER_RC_ENTITLEMENT=pro`) |
| TC / SCR inventory | Partial fail | **Pass** | SCR-OL/FD A–E complete; TC-RC-* vs TC-R0x dual suite; TC-OL-* third namespace in §11 |
| Cutover clarity | Ambiguous | **Pass** | Must freeze file token = `frost` only |
| Index (README/STATUS) | **Stale** | **Pass** | Still said “pending fill / MISSING” after all chapters landed |

---

## 1. P0 — blocks Saturday coding (must fix / patched this pass)

### P0-1 — RC placeholder vocabulary collision

**Problem:** Agents reading different chapters will BLOCK or invent under different token names.

| Source | Tokens |
|--------|--------|
| §00 §5.2 (canonical) | `PLACEHOLDER_RC_API_KEY`, `PLACEHOLDER_RC_ENTITLEMENT_ID`, `PLACEHOLDER_RC_PRODUCT_ID`, `PLACEHOLDER_RC_OFFERING_ID`, `PLACEHOLDER_RC_PACKAGE_ID`, `PLACEHOLDER_RC_PAYWALL_ATTACHED`, `PLACEHOLDER_RC_APP_USER_ID_STRATEGY` |
| §09 (was) | `PLACEHOLDER_ENTITLEMENT_PRO`, `PLACEHOLDER_OFFERING_ID`, `PLACEHOLDER_PACKAGE_ID` (no PRODUCT / PAYWALL_ATTACHED) |
| §19 | Mixed §09 aliases + `PLACEHOLDER_PRODUCT_ID`; template showed `api_key: test_XXXXXXXX` (shape that invites invention) |
| §18 / §14 | `PLACEHOLDER_RC_ENTITLEMENT=pro` (assignment form, not §00 token) |
| §01 / §02 D3 | `PLACEHOLDER_RC_ENTITLEMENT_ID` (aligned) vs lingering alias refs |

**Fix authority:** §00 §5.2 is canonical. All other chapters must use only `PLACEHOLDER_RC_*`.  
**Patch targets:** `09`, `19`, `18`, `14`, `01` (alias callouts), README human-prep line.  
**Why P0:** LANE-RC BLOCKED prompt and grep gates fail if half the bible greps the wrong string; risk of inventing `test_XXXXXXXX`.

### P0-2 — TC-RC-* vs TC-R01–R05 dual win-suite

**Problem:** §09 defines granular `TC-RC-01`…`TC-RC-18` and says GATE-RC passes on TC-RC-01…12. §15 Always suite (and lane cards / demo) tick `TC-R01`–`TC-R05`. Crosswalk in §9.16.3 existed but understated authority — agents can invent a third list into `DEMO-LAST-PASS.md`.

**Mapping (locked):**

| §15 Always (gate) | Fed by §09 granular |
|-------------------|---------------------|
| TC-R01 | TC-RC-01 (+ TC-RC-12) |
| TC-R02 | TC-RC-07 (+ TC-RC-02/08) |
| TC-R03 | TC-RC-03 (+ TC-RC-06) |
| TC-R04 | TC-RC-09 (+ TC-RC-05) |
| TC-R05 | TC-RC-04 |

**Fix:** §09 §9.16.3 DECISION — §15 IDs are DoD/GATE; TC-RC-* are lane diagnostics only. GATE-RC template must list TC-R01–R05 as status rows.  
**Patch targets:** `09-revenuecat-monetization.md` (crosswalk + GATE template language), `18` if it cites TC-RC as Always.

### P0-3 — TC-OL-* third namespace in §11

**Problem:** §11.8 invents `TC-OL-A01`…`TC-OL-P03` while mapping some to TC-C/R/P. Scope guard / DEMO agents may tick TC-OL and skip §15.

**Fix:** Header DECISION in §11.8 — §15 `TC-C*` / `TC-R*` / `TC-P*` are integrate suite; TC-OL-* are product-local expansions that do not replace Always.  
**Patch target:** `11-outer-lens-product.md` §11.8 intro.

### P0-4 — CUTOVER.flag value not frozen

**Problem:** Multiple legal write values → RootArrangementView / CutoverFlag readers diverge under three agents.

| Chapter | Primary | Cutover |
|---------|---------|---------|
| §02 §13 | absent / empty / `false` | `frost` / `true` (“Integrator chooses Sat AM”) |
| §12.1.1 | false | `frost` (or `true` / product token — freeze Sat AM) |
| §15 mode table | `outerLens` / absent | `frost` |
| §15 suite headers | `false` | `true` |
| §05 | `false` | `true` |

**DECISION (this review):**

| File content of `docs-runtime/CUTOVER.flag` | Meaning |
|--------------------------------------------|---------|
| absent · empty · `false` | Outer Lens primary |
| **`frost`** (exact) | FrostDuo cutover |
| **Forbidden writes** | `true`, `outerLens`, invent tokens |

Swift reader may expose enum `.outerLens` / `.frost`; disk token for cutover is **only** `frost`.  
**Patch targets:** `02`, `12`, `15`, `05`, `00` (one lock line if missing).

### P0-5 — Stale README + STATUS block orientation

**Problem:** README reading-order still marks most chapters “pending fill”; STATUS claims 12 MISSING and ~93 page-equiv while all 19 chapters + 11b exist (~85k words / ≥200 page-equiv). Saturday paste instructions point humans at a broken index.

**Fix:** Mark all chapters **ready**; recount words/pages; point reviews at this file + lanes pass.  
**Patch targets:** `README.md`, `STATUS.md`.

### P0-6 — `outerLens(.paywall)` reads as paywall-on-outer

**Problem:** §07 transitions A5/A6 use `outerLens(.paywall)` while illegal list says “paywall on outer region.” Agents can wire SCR-OL-D onto the accessory surface.

**Fix:** Clarify `OuterLensPhase.paywall` = **inner sheet overlay** during Outer Lens product mode; outer region stays tip/coach. Rename comment to `paywallInner` in prose if types stay nested.  
**Patch target:** `07-types-state-machines.md` §07.4C–F.

### P0-7 — GATE artifact name drift (SHELL)

**Problem:** §06 / §00 / §18 disagree among `GATE-SCAFFOLD`, `GATE-SHELL`, `SHELL-READY`. Cursor lanes pass already patched §18; §06 still says `GATE-SHELL` in places.

**DECISION:** Scaffold done → `docs-runtime/GATE-SCAFFOLD.md=PASS`; Duo shell done → `docs-runtime/SHELL-READY.md` (alias note: former `GATE-SHELL`).  
**Patch target:** `06-repo-file-tree.md` conflict table; `00` if needed.

---

## 2. P1 — should fix before doors / first coding hour

| ID | Issue | Why not P0 | Suggested fix |
|----|-------|------------|---------------|
| P1-a | Climax window drift: contract/demo map **0:15–0:45** vs room-test silence **0:10–0:40** / judge beats **0:15–0:40** | All overlap; tip still ≤30s | One line in §16: silence climax 0:15–0:40; optional hold to 0:45 |
| P1-b | Purchase beat: §16 table 0:55–1:20 vs contract **0:50–1:20** | Within Matt window | Prefer §16 live table; contract stays budget envelope |
| P1-c | `Entitlements.swift` vs `EntitlementState` / `RCIdentifiers` naming across §07/§09 | Integrator owns Types | Freeze one public type name in §07 + §09 consume list |
| P1-d | Chapters **04** and **10** intentionally skipped — README should say so | Not missing content | README footnote “no §04/§10” |
| P1-e | §11 product chapter ~7.3k words duplicates §11b flows — merge risk for agents | Both useful | Lane cards: CCA reads 11+11b; Integrator owns conflicts |
| P1-f | Pattern-fuel cites (Moments/PrivacyScreen/ClawKit) dense in §05/§08 — DQ optics if pasted into pitch | Kill-list frames them | §03 already bans forks in pitch; keep |
| P1-g | `PlaceHOLDER_RC_PAYWALL_ATTACHED` optional vs required for BLOCKED | Soft | Treat missing paywall attach as BLOCKED for TC-R02 |
| P1-h | No `ENTITLEMENTS-READY` / soft GATE-RC before CCA claims TC-C04 | Lanes pass P1 | ORCH: don’t claim C04 until R03 green |
| P1-i | Demo Frost appendix timing 0:25–0:45 vs Outer 0:15–0:45 | Cutover-only path | OK if §16 appendix is sole Frost script |
| P1-j | Integrator STATUS still says fill writers in flight | Process stale | Update STATUS decisions log |

---

## 3. P2 — nits

- Alias `SHELL-READY.md` / `GATE-SHELL.md` — keep one canonical (see P0-7).
- §14 motion chapter thinner (~2.2k) but above thin threshold after expand.
- COPY/QA cards thinner than feature cards — acceptable.
- Brad/Matt frozen lines consistent across §01/§16/§12 — do not paraphrase.
- Banned visual tokens (purple/cream/broadsheet/glow/emoji) correctly appear only as BAN-* rows.

---

## 4. Ambiguities that would block Saturday coding (summary)

1. **Which PLACEHOLDER_* string does LANE-RC grep?** → §00 only (`PLACEHOLDER_RC_*`).  
2. **Which TC IDs go in DEMO-LAST-PASS?** → §15 Always (`TC-S/R/C/F/D/I/P/A`); not TC-RC / TC-OL as substitutes.  
3. **What exact bytes in CUTOVER.flag on RED?** → `frost`.  
4. **Is paywall an outer AppMode?** → No; inner overlay only.  
5. **Are chapters still “pending fill”?** → No; all ready (index was wrong).

---

## 5. Contradictions across chapters

| Topic | Chapter A | Chapter B | Resolution |
|-------|-----------|-----------|------------|
| RC tokens | §00 `PLACEHOLDER_RC_ENTITLEMENT_ID` | §09/§19 legacy aliases | **§00 wins** |
| RC Always TCs | §15 TC-R01–R05 | §09 TC-RC-01–12 as GATE | **§15 wins**; TC-RC feeds |
| Product TCs | §15 TC-C* | §11 TC-OL-* | **§15 wins**; TC-OL local |
| Cutover write | §12 allows `true` | §02 prefers `frost` | **`frost` only** |
| Primary flag read | §15 `outerLens` | §02 absent/false | File = absent/false; enum may say outerLens |
| Climax seconds | §03 0:15–0:40 | §16 map 0:15–0:45 | Silence to 0:40; map envelope to 0:45 |
| docs-runtime path | §09 `DuoApp/docs-runtime/…` | Most chapters `docs-runtime/…` | Same file under DuoApp root |
| Gate shell name | §18 SHELL-READY | §06 GATE-SHELL | SHELL-READY + GATE-SCAFFOLD |

---

## 6. Missing TC / SCR / file paths

### SCR — complete

`SCR-OL-A`…`E`, `SCR-FD-A`…`E` appear and map to Capture/Coach/Paywall/Frost leaves in §06/§11/§12.

### TC — present in §15 Always

TC-S01–S04 · TC-R01–R05 · TC-C01–C05 · TC-F01–F05 · TC-P01–P04 · TC-A01–A03 · TC-I01–I04 · TC-D01–D03.

### Gaps / risks

- **TC-RC-*** not in §15 — OK if demoted to extended (P0-2).  
- **TC-OL-*** not in §15 — OK if demoted (P0-3).  
- **TC-S05/S06**, **TC-R06+** marked extended in §15 — do not promote to Always without Integrator.  
- File paths: §06 tree matches theme contract §4 (`DuoApp/App|Duo|Features|Monetization|DesignSystem|Resources|Shared|docs-runtime`). No PoseAgent/HingeBeat folders. CCA host path consistent.

### RC protocol gaps (pre-patch)

- Dual token names (P0-1).  
- `test_XXXXXXXX` example in §19 template (invention bait).  
- Incomplete BLOCKED trigger lists missing PRODUCT / PAYWALL_ATTACHED.  
- GATE-RC claiming TC-RC-01…12 without TC-R rows.

---

## 7. Cutover clarity (required mental model)

1. Build Outer Lens until **12:15**.  
2. Orchestrator writes `GATE-CCA.md` GREEN or RED.  
3. If RED: write `CUTOVER.flag` = **`frost`**; stop Capture/Coach feature work; promote Frost; same RC unlock → decoy C.  
4. Never CCA + frost live in one 90s path.  
5. Frost is **not** a Film Tool reskin and **not** a second brand bible.

---

## 8. Must-fix list (prioritized)

### P0 (this pass — patch in place)

1. Unify `PLACEHOLDER_RC_*` per §00 across §09/§19/§18/§14.  
2. Lock §09 TC crosswalk: §15 TC-R* = gate.  
3. Lock §11.8: TC-OL local only.  
4. Freeze CUTOVER.flag write = `frost` in §02/§12/§15/§05.  
5. Refresh README + STATUS to all-ready + true word counts.  
6. Clarify §07 paywall = inner overlay.  
7. Align GATE-SCAFFOLD / SHELL-READY naming in §06.

### P1 (before doors or first hour)

1. §16 climax silence vs hold note.  
2. README note: no chapters 04/10.  
3. ORCH: C04 after R03.  
4. §19 template: no `test_XXXXXXXX` literal.  
5. Single public entitlement type name.

### P2

- Thin-card polish; alias cleanup; STATUS decision log.

---

## 9. What already works (do not regress)

- Theme lock + Brad/Matt frozen lines (Outer + Frost cutover).  
- Kill list enforcement language in §00/§02/§06/§18.  
- §16 second-by-second demo with fallbacks F1–F3 and Simulate tips.  
- §17 Saturday clock with 12:15 GATE-CCA.  
- §06 file tree freeze with lane owners.  
- Paywall-never-on-outer repeated correctly in most chapters (except §07 naming trap).  
- RC human-only dashboard gate spirit (§09 §9.1 / §19).  
- Cursor lanes pass already fixed ≤3 writers + DUOCORE ownership windows.

---

## 10. Patches applied this pass (verified)

| File | Action |
|------|--------|
| `00-front-matter-agent-contract.md` | P0-4 cutover mode row = `frost` only |
| `docs/bible/REVIEW-claude-pass.md` | **Created** (this review, ≥2k words) |
| `09-revenuecat-monetization.md` | P0-2 crosswalk DECISION · path lock · GATE-RC Always rows TC-R01–R05 |
| `19-human-prep-tomorrow.md` | P0-1 template without `test_XXXXXXXX` · §00 token table |
| `18-multi-ai-lane-cards.md` | P0-1 `PLACEHOLDER_RC_ENTITLEMENT=` forms → §00 tokens |
| `13-design-system-tokens.md` | P0-1 same entitlement token form |
| `02-concept-lock-cutover.md` | P0-4 `frost` only · D2 locked |
| `12-frostduo-cutover.md` | P0-4 12:15 write · lane matrix · decision note |
| `15-acceptance-tests.md` | P0-4 cutover = `frost` · gate TC authority |
| `05-duo-api-inventory.md` | P0-4 flag branch `frost` not `true` |
| `11-outer-lens-product.md` | P0-3 TC-OL local-only authority |
| `07-types-state-machines.md` | P0-6 paywall = inner overlay |
| `06-repo-file-tree.md` | P0-7 `GATE-SHELL` → `SHELL-READY` |
| `README.md` | P0-5 review links · frost / TC locks |
| `STATUS.md` | P0-5 all-ready recount |

Note: Integrator had already marked README chapters ready and §09 tokens toward §00; this pass still applied authority DECISIONS and remaining collisions (§13/§18/§19/cutover).

---

## 11. Saturday ORCH one-liner

**Paste §00 → lane card → §15 Always IDs only. Human fills `PLACEHOLDER_RC_*` into `docs-runtime/RC-IDs.md`. At 12:15 write GREEN or `CUTOVER.flag=frost`. One climax glass. Three writers. No invented keys.**

---

## 12. Verification

- [x] This file exists at `docs/bible/REVIEW-claude-pass.md`  
- [x] ≥800 words (**2234+**)  
- [x] P0 chapter patches landed (see §10)  
- [x] `test -f` + `wc -w` confirm  

*End review. Theme locked. IDs frozen. Cutover = frost. Placeholders = PLACEHOLDER_RC_*.*
