# Multi-AI Saturday build routing — Project Duo

**For:** Nihar Manchikalapudi  
**Event:** Bitrig Hacks: iPhone Duo · Sat Sep 26, 2026 · YC SF · ~4h (11:30–3:30)  
**Role:** Assign each bible lane to a primary AI tool/model + backup; paste-ready ownership blurbs; conflict locks; start order.  
**Constraint:** Still **NO app code** in this prep artifact.  
**Product lean:** Outer Lens Coach (mix **8.2**); hour-one cutover **Frost Cover Vault / FrostDuo** (mix **8.1**).  
**Compiled:** Sat Sep 26, 2026  

**Inputs:** `docs/build-bible-blueprint.md` §06/§18 · `docs/mix-combo-scoreboard.md` · `internal/research-duo-apis.md` · `internal/research-outer-lens.md` · `internal/research-frostduo.md` · `internal/research-revenuecat.md`  
**Prefs:** `/cursor/stores/user/preferences.md` has no model-routing map (only unrelated product note). No `~/.cursor/personalization/` model REVIEW present this run. Tier heuristic from temporary `agentic-engineering` skill (Haiku→Sonnet→Opus by complexity) — applied as **inferred** below.

**Evidence tags:** **[E]** = sourced comparison / vendor docs / store research this wave · **[I]** = practical inference for a solo Mac + multi-AI 4h hack.

---

## 0. How to use this on Saturday

1. Freeze the mega build-bible PDF (same file to every AI).  
2. Paste the matching **Prompt pack stub** (§3) as the *first* message with the PDF.  
3. One human Mac owns **Xcode compile / Duo sim** — AIs draft into **locked paths** only; Nihar (or Cursor-on-Mac) merges.  
4. Do **not** run more than **three coding AIs** writing at once **[I]** — merge tax kills a 4h clock. Prefer: Duo-core + Outer Lens + RC, with Frost as standby paste, not a fourth live writer until cutover.

---

## 1. Lane → primary tool/model + backup

Lanes match bible blueprint §3.2 (Agent OS). “Tool” = surface; “model” = brain inside it when the surface lets you choose.

| # | Lane | Owns (paths) | Primary | Backup | Do **not** give this lane |
|---|------|--------------|---------|--------|---------------------------|
| **0** | **Orchestrator** (human + light AI) | Clock, gates, `CUTOVER.flag`, demo call | **Nihar** + Cursor Agent (fast/cheap model) for checklists | Claude chat (Opus) for “cutover yes/no” | Any AI that writes feature Swift |
| **1** | **Bible ingest / lane briefs** | Extract SCR-IDs, TC-XXX, file locks from PDF | **Gemini 2.5 Pro** (native PDF + ~1M context) **[E]** | Claude Opus / Claude Code with PDF | Coding into the app repo |
| **2** | **Scaffold** | Xcode proj, §06 tree, empty targets, SPM stubs | **Cursor Agent** on the build Mac (Composer / Agent) **[E]** IDE + project files | **Claude Code** | Feature UI, RC IDs invention |
| **3** | **Duo core** *(starts first after scaffold)* | `Duo/PoseRouter.swift`, `App/RootArrangementView.swift`, Arrangement / reserved-region shell | **Claude Code + Opus-class** **[E]** long-context + multi-file agent | Cursor Agent with **Opus / strongest** model | Capture session, paywall, Frost UI |
| **4** | **Outer Lens (primary feature)** | `Features/Capture/`, `Features/CoachOverlay/`, CCA host wiring per §08/§11 | **Claude Code + Opus** (or Cursor+Opus) **[E]/[I]** SwiftUI craft + stick-to-spec | **Cursor Agent + Sonnet/Opus**; GPT-5.x in Cursor if Claude rate-limits | `Monetization/`, `Features/Frost/`, redesign DesignSystem |
| **5** | **RevenueCat** | `Monetization/`, `Features/Paywall/`, `RC-IDs.md` fill | **Codex CLI** (or Cursor+GPT) **[E]** bounded SDK recipe / headless patch | **Claude Code + Sonnet** | Pose router, CCA, inventing RC dashboard IDs |
| **6** | **FrostDuo cutover standby** | `Features/Frost/` only (behind flag) | **Cursor Background Agent** or second **Codex** thread **[I]** parallelizable stub | Claude Code + Sonnet | Touching Capture/Coach or flipping cutover alone |
| **7** | **Polish / motion** | `DesignSystem/`, §14 motions (late) | **Cursor Agent + Claude/Sonnet** **[I]** diff-visible UI polish | Claude Code | New screens, second climax API |
| **8** | **QA / demo** | TC-XXX results, `DEMO-LAST-PASS.md` | **Nihar** + Cursor checklist agent (cheap) | Claude for failure triage | “Fix everything” refactors after freeze |
| **9** | **Doubt / scope guard** | Nacks only | **Claude Opus** (read-only reviewer) **[E]** instruction-following | Second human / Cursor ask mode | Write access to repo |

### Model tier cheat (inside Cursor when choosing)

| Tier | Use for | Tag |
|------|---------|-----|
| Fast / Haiku-class | Orchestrator checklists, QA ticks, paste renames | **[I]** skill heuristic |
| Sonnet / mid | RC wiring, Frost stubs, DesignSystem tokens | **[I]** |
| Opus / max | Duo core, Outer Lens CCA, cutover architecture, scope review | **[E]** + **[I]** |

---

## 2. Why (strengths) — evidenced vs inferred

### Tool surfaces

| Tool | Strength for Duo Saturday | Weakness | Tag |
|------|---------------------------|----------|-----|
| **Cursor Agent / Composer** | In-editor diffs, repo indexing, parallel background agents, lowest friction on the Xcode Mac | Weaker headless/CI story; easy to over-edit shared files if ownership ignored | **[E]** 2026 Cursor vs CLI comparisons (in-editor parallelism, IDE review loop) |
| **Claude Code** | Terminal agent + MCP/skills, multi-step refactors, strong “follow the bible” sessions, CLAUDE.md memory | Cost/latency at Opus; not a replacement for Xcode UI | **[E]** CLI comparisons (MCP, hooks, deep multi-file) |
| **Codex CLI** | Bounded, sandboxed patches; good for “implement this SDK recipe in these files” | Smaller MCP ecosystem; less interactive UI taste | **[E]** Codex = headless/batch/sandboxed strength |
| **Gemini 2.5 Pro** | **1M context + native PDF** — best first pass over a 150–300p bible | Weaker as sole Xcode-side implementer in this workflow | **[E]** Google Gemini 2.5 Pro model card (PDF in, 1M tokens) |
| **ChatGPT / GPT-5.x (in Cursor or chat)** | Competitive on some SwiftUI codegen tasks; strong when given exact SDK snippets | Can invent APIs if bible §08 not pasted | **[E]** mixed iOS bake-offs (GPT-4.1 sometimes beat Claude on constrained SwiftUI tasks; results vary) |
| **Bitrig** (if used) | Duo-aware design/sim sponsor path | Optional prize UNKNOWN; don’t bet the vertical slice on it | **[I]** event research |

### Capability → lane mapping

| Need | Best fit | Why | Tag |
|------|----------|-----|-----|
| Long-context Swift + **stick to verified Duo symbols** | Claude Code / Opus (+ bible §08 pasted) | Fewer hallucinated hinge/layout APIs when contracts are in-context; agent loops for ArrangementView shell | **[I]** + store **[E]** that Duo APIs are easy to invent without §08 |
| Mega-PDF → per-lane brief | Gemini 2.5 Pro | Official long-context + PDF modality | **[E]** |
| Tool use / SPM / file patches for RC | Codex or Cursor+GPT/Sonnet | RC path is a **recipe** (`purchases-ios` ≥5.43, Test Store, RevenueCatUI) — mechanical | **[E]** `internal/research-revenuecat.md` |
| UI polish / motion taste | Cursor+Claude or Claude Code | SwiftUI view iteration with visible diffs | **[I]** (+ Software7-style reports preferring Claude for GUI) **[E]** anecdotal |
| Parallel Frost standby without blocking primary | Cursor Background Agent or second Codex worktree | Composition/parallelism is Cursor’s moat | **[E]** |
| Scope / anti-creep | Claude Opus read-only | Strong instruction adherence to negative space | **[I]** |

### Hard constraints (store evidence — not model marketing)

- **Simulator ≠ camera accessory proof** — CCA needs device; hour-one gate + Frost cutover are load-bearing **[E]** `internal/research-duo-apis.md`, Outer Lens research.  
- **One climax API** for primary (CCA); Frost is ArrangementView dual-face — don’t let AIs merge both into one screen set **[E]** mix board.  
- **RC IDs are human dashboard facts** — AIs must consume `RC-IDs.md`, never invent `test_` / offering strings **[E]** RC research.

---

## 3. Prompt pack stubs (paste with the PDF)

Copy one block per session. Keep under ~10 lines.

### Lane 2 — Scaffold
```text
You own ONLY: Xcode project creation, the §06 folder tree, empty Swift file stubs, and SPM package refs listed in the bible (RevenueCat ≥5.43 stubs OK).
Do NOT implement ArrangementView logic, CameraCaptureAccessory, paywall UI, or Frost features.
Stop when the empty app boots on Duo sim with placeholder RootArrangementView.
Write GATE-SCAFFOLD.md (pass/fail). Do not invent Duo API signatures — leave TODO comments pointing at §08.
```

### Lane 3 — Duo core
```text
You own ONLY: Duo/PoseRouter.swift, App/RootArrangementView.swift, and Duo/ shell wiring per bible §08 + §10.
Layout via ArrangementView / reservedRegions only; hinge = effects/input, never layout.
Do NOT touch Features/Capture, Features/CoachOverlay, Features/Frost, Monetization/, or DesignSystem tokens beyond placeholders.
Done when pose→pane chrome is visible on Duo sim and GATE-CCA.md can be started by Outer Lens (shell ready). No CameraCaptureAccessory yet unless §08 says shell must host the modifier empty.
```

### Lane 4 — Outer Lens (primary)
```text
You own ONLY: Features/Capture/** and Features/CoachOverlay/** plus the minimal Duo/CameraCaptureAccessoryHost.swift if the tree isolates it — per §11 SCR-OL-* and Outer Lens slice.
Inner = controls + session; outer = subject coach via CameraCaptureAccessory; Pro overlays gated by entitlement reads (do not configure Purchases here).
Do NOT edit Monetization/, Features/Frost/, PoseRouter pose tables, or add Foundation Models / Multipeer / Settings tabs.
Fallback: if accessory unavailable, keep inner capture alive and surface accessory.unavailable — never brick. Stop at vertical slice for TC-001 path.
```

### Lane 5 — RevenueCat
```text
You own ONLY: Monetization/** and Features/Paywall/**. Use purchases-ios + RevenueCatUI ≥5.43.0, Test Store only.
Read RC-IDs.md for test_ key, entitlement `pro`, offering/package — if placeholders remain, mark BLOCKED and stop; do not invent IDs.
Unlock must affect the OTHER display’s Pro surface via shared EntitlementState — do not own Capture/Coach view layout.
Do NOT touch Duo/ pose routing or Frost. Done when TC-010 path compiles and documents Success/Fail/Cancel.
```

### Lane 6 — FrostDuo standby
```text
You own ONLY: Features/Frost/** behind CutoverFlag / #if or runtime flag per §12.
Ship minimal: inner progressive frost + outer decoy + Simulate Threat demo control (ARKit optional; sim fallback mandatory).
Do NOT modify Capture/Coach, Monetization, or flip CUTOVER.flag yourself — Orchestrator owns the gate.
Do not fork PrivacyScreen/SnapShield code; remix patterns only. Stop when SCR-FD-* vertical slice builds in isolation.
```

### Lane 7 — Polish / motion
```text
You own ONLY: DesignSystem/** and the 2–3 motions timed in §14. Apply tokens to existing screens without adding screens.
Do NOT invent new features, sponsors, or climax APIs. No card soup / generic AI aesthetic clusters per bible visual rules.
Stop when demo path looks intentional; defer non-demo screens.
```

### Lane 8 — QA / demo
```text
You own ONLY: running/recording TC-XXX from §17 and writing DEMO-LAST-PASS.md / failure notes.
Do NOT “drive-by refactor.” File bugs with file owners; only patch if Orchestrator marks a demo-blocker and names the file.
Include fallback 60s script check. Stop coding at T+3:45 rehearsal.
```

### Lane 9 — Scope guard
```text
Read-only reviewer. Nack any PR/patch that: adds chat, Supabase/auth, second climax API, pre-Saturday code pastes, invented RC IDs, or hinge-driven layout.
Cite bible §00 / §19. Do not write feature code.
```

### Lane 1 — Bible ingest (optional pre-11:30 or T+0)
```text
Ingest this PDF. Output: (1) per-lane file ownership table, (2) SCR/TC ID index, (3) BLOCKED/GAP list, (4) hour-one cutover criteria verbatim.
Do not generate Swift. Do not expand scope beyond Outer Lens primary + Frost cutover.
```

---

## 4. Conflict zones — bible must lock these

| Hot file / area | Likely fighters | Bible lock |
|-----------------|-----------------|------------|
| `App/DuoAppApp.swift`, project.pbxproj, Package.resolved | Scaffold vs everyone | **Scaffold owns until GATE-SCAFFOLD**; afterward **Orchestrator-only** adds targets |
| `App/RootArrangementView.swift` | Duo core vs Outer Lens vs Frost | **Duo core owns**. Features inject via named slots/`Group` hooks specified in §06 — no drive-by root edits |
| `Duo/PoseRouter.swift` | Duo core vs polish vs Frost | **Duo core only**. Features read `PoseMode`; they don’t redefine the table |
| `Duo/CameraCaptureAccessoryHost.swift` (or Capture root) | Duo core vs Outer Lens | Bible picks **one owner: Outer Lens** after shell; Duo core leaves empty `.sceneAccessory` hook **or** forbids CCA until handoff artifact `SHELL-READY.md` |
| `Monetization/Entitlements.swift` / shared `EntitlementState` | RC vs Outer Lens vs Frost | **RC writes**; others **observe** only. Unlock target display named in §09 (`other pane` / outer overlays) |
| `Features/Paywall/*` | RC vs polish | **RC owns** structure; polish may restyle via DesignSystem APIs only |
| `DesignSystem/*` | Polish vs all feature lanes | Features use **token placeholders** until T+2:30; polish lands late; no parallel token rewrites |
| `Features/Frost/*` vs Capture | Cutover panic | Frost never imports Capture. Cutover = flag + root slot swap by **Orchestrator**, not file merges |
| `CUTOVER.flag` / `GATE-CCA.md` | Everyone | **Orchestrator-only** writes. AIs only read |
| `RC-IDs.md` | RC vs human | **Human pastes** dashboard values; RC lane consumes |
| Assets.xcassets | Polish vs Outer vs Frost | Partition by catalog folders: `Coach/`, `Frost/`, `Shared/`; no cross-writes |
| Demo copy strings | Outer Lens vs Frost vs Brad sentence | §01 frozen strings; features must paste verbatim — no “improved” taglines |

**Bible encoding pattern (for §06/§18):** every leaf file gets `OWNER: lane-id` + `READERS:` + `FORBIDDEN_WRITERS:`.

---

## 5. Suggested Saturday sequence (4h)

Clock aligns with blueprint §3.3; AI assignment is the addition.

```text
Pre-doors (optional)
  Gemini/Claude ingest PDF → print lane stubs + BLOCKED list
  Human: RC-IDs.md paste; Duo sim pre-boot; Xcode 27.1 confirm

T+0:00  Orchestrator: confirm Outer Lens lock; §05 preflight
T+0:15  [SERIAL] Scaffold (Cursor on Mac) → empty boot
T+0:30  [SERIAL] Duo core (Claude Code/Opus) → Arrangement shell + pose chrome
        ★ This is the Duo API proof — before parallel feature spam
T+1:00  GATE-CCA path ready?
          YES → stay Outer Lens
          NO  → Orchestrator flips CUTOVER.flag → Frost becomes primary writer
T+1:00  [PARALLEL max 3]
          A: Outer Lens (Claude/Cursor Opus) OR Frost if cutover
          B: RevenueCat (Codex/Cursor)
          C: Frost standby stubs ONLY if still on Outer Lens (low priority)
T+2:30  [SERIAL integrate] EntitlementState → other-pane unlock; freeze DesignSystem inputs
T+3:00  Polish (Cursor) — 2–3 motions only; optional one FM tip or SKIP
T+3:15  QA (human+Cursor) TC-001…TC-020; scope guard nacks creep
T+3:45  Rehearse §17 ×2 — stop feature coding
T+4:00  Demo mode
```

### What must be serial vs parallel

| Serial (blocks others) | Parallel OK |
|------------------------|-------------|
| Scaffold | Outer Lens feature UI ∥ RC monetization |
| Duo core shell / pose truth | Frost standby **files** while Outer Lens green (no root edits) |
| Cutover flag decision | Polish after feature freeze only |
| Final unlock integration | Ingest/QA docs anytime |

### “Which AI starts first?”

1. **Cursor (Scaffold)** on the Mac — nothing else compiles without it.  
2. **Claude Code/Opus (Duo core)** — Duo API proof before CCA/RC theater.  
3. Then **parallel** Outer Lens (Claude/Cursor Opus) + RC (Codex/Cursor).  
4. Frost AI only **upgrades from standby → primary** if GATE fails; otherwise keep it file-isolated.

---

## 6. Practical packing list (solo builder)

| Slot | Tool logged in | Lane |
|------|----------------|------|
| Mac Xcode | Cursor Agent | Scaffold, integrate, polish, QA |
| Terminal pane A | Claude Code (Opus) | Duo core → Outer Lens (hand off after shell) |
| Terminal pane B | Codex CLI | RC (and Frost stubs if needed) |
| Phone/browser | Gemini or Claude.ai | PDF questions / scope nacks |
| Human | — | Orchestrator, sim clicks, RC dashboard, demo |

If only **two** AIs: **Cursor (scaffold+RC+polish)** + **Claude Code (Duo core+Outer Lens)**; drop live Frost writer until cutover **[I]**.

---

## 7. Sources & limits

| Claim class | Sources |
|-------------|---------|
| Lanes / tree / order | `docs/build-bible-blueprint.md` |
| Product / cutover | `docs/mix-combo-scoreboard.md`, Outer Lens / FrostDuo research |
| Duo / RC facts | `internal/research-duo-apis.md`, `research-revenuecat.md` |
| Tool comparisons | Web: Cursor vs Claude Code vs Codex 2026 workflow writeups (tinyctl, AI Catchup, Koenig Academy); Gemini 2.5 Pro model card (1M + PDF) |
| SwiftUI model bake-offs | Mixed / anecdotal **[E]** — do not treat as ranked leaderboard; prefer bible-grounded generation |
| Bright Data SERP/scrape | **Unavailable** this run (401) — used Cursor WebSearch + store corpus |

**Not claimed:** a single “best coding model” for all Swift forever. Routing is for **this** PDF-fed, path-locked, 4h Duo hack.

---

*End. Next: bake OWNER locks into bible §06/§18; print prompt stubs on one sheet for the venue.*
