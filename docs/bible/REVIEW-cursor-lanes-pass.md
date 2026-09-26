# REVIEW — Cursor multi-agent lane lens (§18)

**Reviewer:** Cursor lanes overnight pass (`bc-02f45fd3-e05b-5fa1-a1f3-02a3ef70dd38`)  
**Target:** `docs/bible/18-multi-ai-lane-cards.md` (~2933 words at review; patched for P0)  
**Lens:** own / don’t-touch · conflict locks · handoff contracts · ≤3 concurrent writers  
**Compared to:** `docs/multi-ai-build-routing.md` §0–§5, `docs/bible-single-theme-contract.md` (tree/TCs), bible README lane map  
**Verdict:** **PASS with P0 patches applied** — usable Saturday if ORCH enforces serial shell → trio.

---

## Checklist

| Criterion | Pre-patch | Post-patch | Notes |
|-----------|-----------|------------|-------|
| Own / don’t-touch on every coding card | Partial | **Pass** | Cards had YOU OWN / DO NOT TOUCH; master table omitted **DUOCORE** as its own row (SHELL claimed PoseRouter indefinitely) |
| Conflict locks for hot files | **Pass** | **Pass** | §14 matched routing §4; ORCH subsection for gates/RC-IDs |
| Handoff contracts (artifact + next lane) | Partial | **Pass** | SHELL→DUOCORE / DUOCORE→CCA now name `GATE-SCAFFOLD` / `SHELL-READY` and require closing the prior writer |
| ≤3 concurrent writers enforceable | Fail-prone | **Pass** | Max-3 stated often, but no hard “close shell before trio”; added §0 gate + start-order + ORCH refuse-fourth |
| Paste-ready + tool mapping | **Pass** | **Pass** | Claude / Codex / Cursor packs; Block A–I cheat |
| Path mutex / Integrator sole cross-lane | **Pass** | **Pass** | INTEG merge order + “two lanes in one commit” |

---

## P0 (patched into §18 this pass)

1. **Master table missing DUOCORE** — SHELL row listed `PoseRouter` / `RootArrangementView` / `ArrangementRegions` / `CutoverFlag` with no write-window end. Risk: Cursor scaffold stays live and fights Claude on shell files while CCA/RC also run → 4 writers + merge tax.  
   **Fix:** Split **SHELL** (until `GATE-SCAFFOLD`) vs **DUOCORE** (until `SHELL-READY`); rename paste id `LANE-DUOCORE`; update §14 owners.

2. **≤3 rule not session-gated** — Invariant + ORCH said “max 3” but start order did not force closing serial shell writers before the parallel trio.  
   **Fix:** §0 step 3 hard gate; ORCH CONCURRENCY refuse-fourth; Duo-core DONE/HANDOFF “close this writer”; §15 start order spells serial stop → trio only after `SHELL-READY`; ASSETS replaces Frost slot in the budget.

---

## P1 (not patched — integrator / next pass)

| ID | Issue | Why not P0 |
|----|-------|------------|
| P1-a | No named **ENTITLEMENTS-READY** / `GATE-RC.md=PASS` gate before CCA claims TC-C04 / Integrator wire | Cards already say “after RC merge” / Integrator owns wire; soft but workable |
| P1-b | `Shared/CutoverFlag.swift` vs `docs-runtime/CUTOVER.flag` — file API vs ORCH flip — easy to confuse under stress | Distinguable in cards; add one-line callout in §00 later if agents misfire |
| P1-c | Claude pack is serial DUOCORE→CCA in one terminal — good for ≤3, but if Opus session keeps editing shell after CCA starts, path mutex relies on discipline | Mitigated by close-writer language; GUARD should nack |
| P1-d | INTEG “edit two lanes’ files in one commit” can silently become a 4th writer if feature agents keep typing | ORCH should pause one feature lane during merge bursts (stated in §0) |
| P1-e | Optional Gemini **ingest** lane from routing §3 missing as a card | Pre-doors only; non-coding — README covers human prep |

---

## P2 (nits)

- Alias `SHELL-READY.md` / `GATE-SHELL.md` — keep one canonical name in clock chapter.
- Master table **ASSETS** vs Block C Frost standby — budget exclusivity now in §15; still easy to open both + CCA + RC.
- COPY / QA cards thinner than feature cards — OK for human lanes.
- No per-leaf `OWNER:` / `FORBIDDEN_WRITERS:` encoding from routing §4 bible pattern — §14 table is enough for cards chapter; leaf tags belong in §06 if desired.

---

## What already worked (do not regress)

- Shared §00 invariants paste (theme, climax CCA, RC `pro`, Film Tool tokens, hinge≠layout, kill list, RC-IDs human-only, freeze).
- CCA card: verbatim tips, Simulate* fallbacks, observe-only EntitlementState, motions M1–M3.
- RC card: BLOCKED-if-placeholder, other-pane unlock, GATE-RC.md.
- FROST: flag flip ORCH-only; promote checklist; no Capture imports.
- Conflict zone table covers app entry, pose shell, CCA host, entitlements, DesignSystem, assets partition, demo strings.
- Two-AI fallback aligned with routing §6.

---

## Saturday ORCH one-liner

**Serial:** SHELL → DUOCORE → (close) → **Trio:** CCA + RC + (Frost\|ASSETS\|idle) → serial INTEG → QA. Never four coding agents writing.

---

## Files touched this pass

| File | Action |
|------|--------|
| `docs/bible/18-multi-ai-lane-cards.md` | P0 patch (ownership windows, LANE-DUOCORE, ≤3 session gate, start order) |
| `docs/bible/REVIEW-cursor-lanes-pass.md` | **Created** (this review) |

*End review. Path mutex. Three writers. Cards > vibes.*
