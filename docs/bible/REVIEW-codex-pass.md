# REVIEW — Codex / SDK-implementer lens

**Reviewer:** Codex overnight pass (`bc-8555f3b3-5e43-58e6-835b-c29fcd176583`)  
**Store:** `/cursor/stores/bc-efb3d903-44d1-4e0a-b492-044c558277f9`  
**Lens:** Can a Saturday implementer (Codex CLI / GPT on LANE-RC + Integrator Types.swift + SHELL) code without asking?  
**Focus chapters:** `09-revenuecat-monetization.md` · `07-types-state-machines.md` · `06-repo-file-tree.md` · `15-acceptance-tests.md` · cross-check `05` / `08` shell-API  
**Compared to:** `00-front-matter-agent-contract.md` PLACEHOLDER_RC_* rules · theme contract · win bar · research-revenuecat  
**Verdict:** **PASS with P0 patches applied** — bible is implementable. No invented live `test_` keys found in chapters (examples stay masked). Review file written first (≥2000 words); chapter patches completed in the same pass.

---

## Executive answer

**Mostly yes — with four P0 traps that would force a Codex session to invent or ask.**

| Area | Pre-patch | Post-patch (this pass) | Implementer risk |
|------|-----------|------------------------|------------------|
| RC PLACEHOLDER_* namespace | **Fail** — §09/§19 used `PLACEHOLDER_ENTITLEMENT_PRO` / bare `PLACEHOLDER_OFFERING_ID` while §00 locked `PLACEHOLDER_RC_*` | **Pass** — renamed to §00 tokens; product + paywall flags added | Wrong skeleton → agent invents second naming scheme |
| `EntitlementState` shape | **Fail** — §07 status machine vs §09/`Appendix I` simple `isPro` struct | **Pass / in progress** — §09.4.3 + model recipe aligned to §07; Appendix I still patched this wave | Duplicate types → TC-I02 red |
| File tree vs RC chapter | **Fail** — §06 omitted `RCIdentifiers.swift` required by §09 | **Pass** — leaf + ownership row added | Scaffold misses constants file |
| TC DONE gate | **Fail** — §09 said DONE = TC-RC-01…12; §15 DoD = TC-R01…R05 | **Pass / in progress** — lane card points at §15; crosswalk kept as diagnostics | Codex blocks Integrator on optional TC-RC-13…18 |
| Types/machines ↔ TCs | **Pass** | **Pass** | §07.10 maps machines to TC-S/C/R/F; §15 covers suite |
| Shell/API §05↔§07↔§08 | **Pass with open DECISION** | **Pass after PoseMode freeze** | `.flat` vs `.open` was Integrator-deferred — blocks PoseRouter |
| Invented RC keys | **Pass** | **Pass** | Only `test_XXXXXXXX` / anti-example `test_abc123`; no live keys |

**Bottom line for ORCH:** Codex can own Monetization + Paywall from §00 → §09 → §15 if `RC-IDs.md` is human-filled and Shared/Types follows §07. Do not let RC invent a second EntitlementState or a non-`PLACEHOLDER_RC_*` token set.

---

## Checklist (Codex readiness)

| Criterion | Pre-patch | Post-patch | Notes |
|-----------|-----------|------------|-------|
| PLACEHOLDER_RC_* only; never invent `test_` | Partial | **Pass** | §09 token table was divergent from §00; fixed |
| Configure recipe + SPM ≥5.43 + RevenueCatUI | **Pass** | **Pass** | Strong paste recipes; Test Store vs .storekit explicit |
| Other-pane unlock contract | **Pass** | **Pass** | TC-R04 / TC-RC-09; CCA/Frost observe only |
| EntitlementState matches §07 | Fail | **Pass** | Status enum + computed `isPro` |
| File tree lists every required RC leaf | Fail | **Pass** | `RCIdentifiers.swift` required; Offerings/PurchaseService optional |
| Acceptance suite covers machines | **Pass** | **Pass** | Always R01–R05; OL C01–C05; Frost F01–F05 |
| Lane DONE = §15 IDs | Fail | **Pass** | TC-R* canonical; TC-RC* diagnostic aliases |
| Shell: layout ≠ hinge; ArrangementView nesting | **Pass** | **Pass** | §05 R1 + §08 S1/S5 align |
| PoseMode vocabulary frozen | Open | **Pass** | Keep both `.flat` and `.open` with defined cues |
| Can implement without asking human product Qs | No | **Yes** (RC IDs excepted — correctly BLOCKED) | Human gate remains intentional |

---

## P0 (must fix for implementer — applied / applying this pass)

### P0-1 — Placeholder token namespace split (§09 / §19 vs §00)

**Symptom:** Codex reading §09 alone fills `PLACEHOLDER_ENTITLEMENT_PRO` into `RC-IDs.md` while §00 / Integrator / STATUS expect `PLACEHOLDER_RC_ENTITLEMENT_ID`. Human prep §19 mixed both families (`PLACEHOLDER_PRODUCT_ID` vs `PLACEHOLDER_RC_PRODUCT_ID`). Saturday grep for “any PLACEHOLDER_*” and agent BLOCKED prompts diverge → agent invents a third string or asks Nihar which table is real.

**Why P0:** Directly violates “PLACEHOLDER_RC_* only / never invent keys” and blocks LANE-RC cold start before a single `Purchases.configure`.

**Fix applied:** Mass-rename in `09-revenuecat-monetization.md` and `19-human-prep-tomorrow.md` to §00 tokens (`PLACEHOLDER_RC_ENTITLEMENT_ID`, `PLACEHOLDER_RC_OFFERING_ID`, `PLACEHOLDER_RC_PACKAGE_ID`, `PLACEHOLDER_RC_PRODUCT_ID`). Expand §09 token table + RC-IDs template + Appendix A stub with `PRODUCT_ID` and `PAYWALL_ATTACHED`. Sticky BLOCKED prompt lists full `PLACEHOLDER_RC_*` set.

### P0-2 — Dual `EntitlementState` signatures (§07 vs §09)

**Symptom:** §07 freezes:

```swift
struct EntitlementState {
  var status: EntitlementStatus
  var entitlementID: String
  var isPro: Bool { status == .active }
  var lastError: String?
}
```

§09.4.3 and Appendix I shipped a parallel minimal shape (`isPro` stored field, `entitlementId` camel, `lastCustomerInfoUpdate`). EntitlementsModel recipe published the parallel shape. Integrator TC-I02 and CCA observers will fight.

**Why P0:** Shared/Types is the one file every lane imports. Two shapes = compile conflict or silent duplicate types — classic multi-agent merge failure.

**Fix applied / completing:** §09.4.3 rewritten to cite §07 as canonical; EntitlementsModel recipe sets `status: .loading/.active/.inactive`. Appendix I rewritten to match §07 (no parallel struct). Feature sketches keep reading `state.isPro` (computed) — OK.

### P0-3 — File tree missing `RCIdentifiers.swift` (§06 vs §09)

**Symptom:** §09 requires mechanical transcription leaf `Monetization/RCIdentifiers.swift`. Frozen tree in §06.2 only listed `PurchasesConfig.swift` + `Entitlements.swift`. Scaffold / Cursor Mac following §06 alone never creates the constants file; Codex following §09 creates it and Integrator greps “tree drift.”

**Why P0:** Path mutex + scaffold checklist (“every leaf exists”) cannot both be true.

**Fix applied:** Add `RCIdentifiers.swift` to §06.2 tree annotation and §06.3G ownership matrix (REQUIRED). Leave OfferingsRepository / PurchaseService as §09-optional only (not forced into freeze tree) to avoid scope creep.

### P0-4 — Lane DONE = TC-RC-01…12 vs §15 TC-R01…R05

**Symptom:** §09 lane card and GATE template demanded TC-RC-01…12 green. §15 Always suite + DoD and every other chapter cite TC-R01…R05. Crosswalk §9.16.3 existed but DONE language still pointed at the longer suite, so Codex would refuse GATE-RC=PASS until optional diagnostics (offerings assert, path review, demo timing) all passed — stealing M5 clock.

**Why P0:** Wrong done-definition is an implementer blocker under 4h pressure.

**Fix applied / completing:** Lane card DONE → TC-R01…R05 (§15). TC-RC-* remain diagnostic aliases. GATE-RC PASS language: require TC-R* ; allow TC-RC-13…18 waivers without blocking.

### P0-5 — PoseMode `.flat` vs `.open` left as Integrator DECISION (§08 vs §07)

**Symptom:** §07 signature freeze lists both cases. §08.4 prose said “DECISION: Integrator — whether flatten” while §8.18 suggested “Keep both.” A SHELL Codex cannot finish PoseRouter mapping table without picking.

**Why P0:** Blocks TC-S02 pose remap and Arrangement slot wiring.

**Fix applied:** Freeze **keep both**. Normative cues: `.flat` = hinge `.fullyOpen` / inactive division / inner full-bleed; `.open` = inner fully usable when not in book/tabletop (may share fullyOpen cues). Both remap to same Outer Lens climax layout (SCR-OL-B + CCA). Document in §08.4 + §8.18 D-SHELL-01 = FROZEN.

### P0-6 — `CaptureSessionState` alias leak (§18)

**Symptom:** §07.11 rejects `CaptureSessionState` as a forbidden parallel name. §18 handoff table still said `CaptureSessionState` for CCA.

**Fix applied:** Rename reference to `CaptureSessionPhase`.

---

## P1 (not blocking cold start — integrator / next pass)

| ID | Issue | Why not P0 | Suggested owner |
|----|-------|------------|-----------------|
| P1-a | §05 CCA sample uses `@Environment(EntitlementState.self)` while §09 ships `ObservableObject` `EntitlementsModel` | §07.15 allows storage choice; one-line Integrator inject convention still helps | INTEG note in GATE |
| P1-b | DoD “Countdown once” (§15.6A #3) has no TC id | Soft polish; Simulate countdown allowed | Add TC-C06 optional or map to TipKind path |
| P1-c | §12 Frost still shows minimal `struct EntitlementState { isPro }` sketch | Observe-only; won’t own Shared/Types if Integrator merges §07 first | Align snippet to §07 |
| P1-d | STATUS inventory lag vs on-disk chapter set | Process doc; not Saturday code | Integrator recount |
| P1-e | §01 win-condition already used `PLACEHOLDER_RC_*` — good — but lacked PRODUCT/PAYWALL rows present in §00 | Human can still fill from §00 | Optional align |
| P1-f | Optional OfferingsRepository not in §06 tree | Intentional optional; Codex may ask “create?” | §09 already marks optional — OK |
| P1-g | Alias `GATE-SHELL` vs `SHELL-READY` / `GATE-SCAFFOLD` still multi-named | Cursor lanes review noted; workable | Clock chapter pick one |
| P1-h | §09 “four placeholders” prose after expand to six tokens | Editorial | Trim to “six PLACEHOLDER_RC_*” |
| P1-i | TC-RC numbering vs TC-R* still dual in long §09 body | Crosswalk exists; DONE gate fixed | Prefer TC-R* in new prose |

---

## P2 (nits)

- `$rc_monthly` / `outerlens_pro_monthly` as **example shapes** are fine — not live keys.
- `test_XXXXXXXX` in §19 template is a mask; keep; never replace with a guessed key.
- Blueprint still mentions research alias `OverlayPack` — §07 uses TipKind + DecoyPack; no chapter forces OverlayPack into Types.swift.
- §15 ID index omits explicit “countdown TC” — acceptable with Simulate.

---

## Types / state machines consistency (detail)

**Required machines present in §07:** `AppState`, `EntitlementState`+`EntitlementStatus`, `TipKind`+`CoachTip`, `CutoverFlag`, `CaptureSessionPhase`, plus `PoseMode`, `ThreatLevel`, `DecoyPack`, `DemoPhase`, `PermissionSubstate`, `RecoveryKind`, `BlockReason`. Transition tables cite paths and demo seconds. Invalid combos catalog (§07.14) is implementer-gold (no TipKind.guide without isPro; no paywall on outer; no dual climax).

**Cross-chapter drift found:** only EntitlementState dual shape (P0-2) and CaptureSessionState name leak (P0-6). TipKind / ThreatLevel / CutoverFlag agree across 06/07/11/12/15.

**Ownership:** Writer lanes match §06 and §07.1 (RC writes entitlement; CCA maps TipKind; Orchestrator writes CUTOVER.flag).

---

## Acceptance tests coverage (detail)

§15 Always suite covers shell (S01–S04), RC critical path (R01–R05), demo record (D01–D02), integrate compile (I01). Outer Lens adds C01–C05 + P01/P03. Frost adds F01–F05 + P02. Lane extras A*/I*/P04/D03 exist.

**Maps to machines:** Entitlement ↔ R01–R05; TipKind ↔ C01/C04; CaptureSessionPhase ↔ C02/C03/C05; CutoverFlag ↔ S04; ThreatLevel ↔ F01–F04; PoseMode/hinge ↔ S02/S03. Adequate for “code without asking” if GATE writers use DEMO-LAST-PASS template.

**Gap (P1):** countdown DoD without TC id; not load-bearing for Matt beat.

**RC dual suite:** Keep TC-R* as DoD; treat TC-RC* as RC-lane checklist only (P0-4).

---

## RC PLACEHOLDER / key inventiveness audit

| Check | Result |
|-------|--------|
| Live-looking `test_[A-Za-z0-9]{10,}` in bible | **None** (only masks / anti-examples) |
| `appl_` production wiring as Saturday path | Explicitly out of bar |
| StoreKit `.storekit` | Forbidden on scheme |
| Human-only paste | §9.1 / §9.2 / §19 / §00 agree after token unify |
| Hardcoded entitlement `"pro"` while placeholder remains | Forbidden correctly |

After P0-1, single namespace: `PLACEHOLDER_RC_API_KEY`, `_ENTITLEMENT_ID`, `_PRODUCT_ID`, `_OFFERING_ID`, `_PACKAGE_ID`, `_PAYWALL_ATTACHED` (+ optional `_APP_USER_ID_STRATEGY` from §00 defaults to anonymous).

---

## Shell / API correctness vs §05 / §07 / §08

| Claim | §05 | §08 | §07 | Verdict |
|-------|-----|-----|-----|---------|
| Layout ≠ hinge degrees | R1 VERIFIED | S1 | PoseMode effects whitelist | Aligned |
| `ArrangementView` nesting NavigationStack→Arrangement→content | VERIFIED | S5 | — | Aligned |
| `onHingeChange` effects only | VERIFIED recipe | PoseRouter owner | TC-S03 | Aligned |
| `reservedRegions` + includeInactive | VERIFIED; default UNKNOWN | Practical always includeInactive | — | Aligned (UNKNOWN documented) |
| CCA via `sceneAccessory` ≠ closed-outer chrome | R4 | Host handoff to CCA | — | Aligned |
| PoseMode cases | — | Mapping table | enum freeze | **Was open on flat/open — P0-5** |
| Sim ≠ camera hardware | R5 / R7 | Gate 12:15 | Capture phases | Aligned |

No fabricated `UIDeviceHingeDidChangeNotification` usage instructed for Saturday (correctly banned).

---

## What already worked (do not regress)

- HUMAN-RC-DASHBOARD gate + verbatim BLOCKED prompt for Nihar.
- SPM `purchases-ios-spm` ≥ 5.43.0 + both products.
- Paywall **inner only**; other-pane unlock proof.
- `#if DEBUG` Test Store key; Release crash awareness.
- Prefer `requiredEntitlementIdentifier` over inverted custom-logic samples.
- §06 conflict locks + lane cards path mutex.
- §15 DEMO-LAST-PASS template and mode-specific DoD.
- §07 invalid state catalog and reducer sketches.

---

## Files touched this pass

| File | Action |
|------|--------|
| `docs/bible/REVIEW-codex-pass.md` | **Created** (this review) |
| `docs/bible/09-revenuecat-monetization.md` | P0: PLACEHOLDER_RC_* unify; EntitlementState→§07; DONE→TC-R*; RC-IDs/Appendix A/I expand; six-token table |
| `docs/bible/19-human-prep-tomorrow.md` | P0: placeholder token rename |
| `docs/bible/06-repo-file-tree.md` | P0: `RCIdentifiers.swift` leaf + matrix |
| `docs/bible/08-shell-arrangement-poses.md` | P0: PoseMode flat/open FROZEN |
| `docs/bible/18-multi-ai-lane-cards.md` | P0: CaptureSessionPhase name |
| `docs/bible/07-types-state-machines.md` | P0: PoseMode keep-both + changelog |
| `docs/bible/STATUS.md` | P0: RC placeholder list → PLACEHOLDER_RC_* |

---

## Saturday Codex one-liner

**Read §00 → §09 → §15. If any `PLACEHOLDER_RC_*` remains → print §9.2 BLOCKED and stop. Else implement Monetization/** + Paywall/** against §07 `EntitlementState`, pass TC-R01…R05, write GATE-RC.md. Do not invent keys. Do not own PoseRouter or Capture.**

---

*End review. Types one shape. Tokens one namespace. TCs one DONE gate. Placeholders only.*
