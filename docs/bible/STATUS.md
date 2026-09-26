# Outer Lens bible — STATUS

**Updated:** Sat Sep 26, 2026 · integrator `bc-0028e8b6-8c6d-5949-8593-c31557f5154b`  
**Recount:** `wc -w docs/bible/*.md | sort -n` (soft-FAIL apply wave)  
**Page-equiv:** words ÷ **300**  
**Theme:** Outer Lens Film Tool only · FrostDuo = cutover · `PLACEHOLDER_RC_*` only  
**Audit:** [`COMPLETENESS-AUDIT.md`](./COMPLETENESS-AUDIT.md)

---

## Snapshot

| Metric | Value |
|--------|------:|
| Required chapters (00–19 + 11b) | **19 / 19 present · all ready** |
| Missing required | **0** |
| Required-chapter words | **89,863** |
| Page-equiv (÷300) | **299.5** |
| Target ≥200 pages? | **YES (299.5 ≥ 200)** |
| Thin (&lt;800w) required chapters | **0** |
| Soft FAIL-3 (TC-OL crosswalk) | **APPLIED** · §11 §11.8.0 · §11b §11b.8 |
| Soft FAIL-4 (M0–M8 minutes) | **APPLIED** · §17 §18.0 · 10/15/25/5/55/35/15/10/10 |
| Folder total incl. meta/REVIEW/audit | **93,820** |

---

## Per-chapter inventory (`wc -w` this run)

| Chapter | Words | Pages@300 | Status |
|---------|------:|----------:|--------|
| `00-front-matter-agent-contract.md` | 4255 | 14.2 | **ready** |
| `01-win-condition.md` | 4050 | 13.5 | **ready** |
| `02-concept-lock-cutover.md` | 3988 | 13.3 | **ready** |
| `03-judge-sponsor-beats.md` | 4906 | 16.4 | **ready** |
| `05-duo-api-inventory.md` | 4528 | 15.1 | **ready** |
| `06-repo-file-tree.md` | 3586 | 12.0 | **ready** |
| `07-types-state-machines.md` | 4348 | 14.5 | **ready** |
| `08-shell-arrangement-poses.md` | 7123 | 23.7 | **ready** |
| `09-revenuecat-monetization.md` | 8706 | 29.0 | **ready** |
| `11-outer-lens-product.md` | 7327+ | 24.4+ | **ready** · crosswalk added |
| `11b-outer-lens-flows.md` | 4664+ | 15.5+ | **ready** · crosswalk added |
| `12-frostduo-cutover.md` | 4261 | 14.2 | **ready** |
| `13-design-system-tokens.md` | 4616 | 15.4 | **ready** |
| `14-motion-interaction.md` | 3824 | 12.7 | **ready** |
| `15-acceptance-tests.md` | 6053 | 20.2 | **ready** |
| `16-demo-script-90s.md` | 2821 | 9.4 | **ready** |
| `17-saturday-clock.md` | 2972+ | 9.9+ | **ready** · M0–M8 minutes pasted |
| `18-multi-ai-lane-cards.md` | 5155 | 17.2 | **ready** |
| `19-human-prep-tomorrow.md` | 2680 | 8.9 | **ready** |
| **TOTAL required (pre-patch recount)** | **89863** | **299.5** | |

> Word counts for 11 / 11b / 17 will tick up slightly after soft-FAIL patches; ≥200 pages remains true.

### Meta / non-required in same folder

| File | Words | Role |
|------|------:|------|
| `README.md` | 675 | Master index |
| `STATUS.md` | (this file) | Counts / decisions |
| `COMPLETENESS-AUDIT.md` | 1949 | Soft/hard FAIL matrix (auditor) |

---

## REVIEW-* files present

| File | Words | Status |
|------|------:|--------|
| [`REVIEW-cursor-lanes-pass.md`](./REVIEW-cursor-lanes-pass.md) | 764 | **Landed** — Cursor lanes reviewer |
| [`REVIEW-claude-pass.md`](./REVIEW-claude-pass.md) | 2255 | **Landed** — Claude review |
| [`REVIEW-codex-pass.md`](./REVIEW-codex-pass.md) | 2105 | **Landed** — Codex review |

All three overnight review passes are in `docs/bible/`. Excluded from required-chapter word sum.

---

## Missing chapters

**None.**

---

## Soft FAIL remediation log

| ID | Issue | Fix |
|----|-------|-----|
| FAIL-1 | Stale STATUS 7/19 | This file — **19/19 ready · 299.5 pp** |
| FAIL-2 | README pending fill | README reading-order all **ready** |
| SOFT FAIL-3 | Dual TC-OL vs TC-* | §11 §11.8.0 + §11b §11b.8 crosswalk → contract §6 only |
| SOFT FAIL-4 | M0–M8 minutes missing | §17 §18.0 verbatim 10/15/25/5/55/35/15/10/10 |
| SOFT FAIL-5 | §09 Swift density | Optional — deferred (placeholders already; no key invention) |

---

## Decisions log

| UTC | Decision |
|-----|----------|
| Overnight | Outer Lens Film Tool only; FrostDuo = `CUTOVER.flag`; `PLACEHOLDER_RC_*` only. |
| Soft-FAIL wave | Re-verify `wc -w` → **89,863** required words · **299.5** pages (≥200 **true**). |
| Soft-FAIL wave | Apply crosswalk + M0–M8 minutes; strip invented TC-C06+ from draft crosswalk. |
| Soft-FAIL wave | STATUS REVIEW section reserves slots for Claude/Codex REVIEW files when they land. |
| Soft-FAIL wave | Link `COMPLETENESS-AUDIT.md` + `REVIEW-cursor-lanes-pass.md` from README. |

---

## RC placeholders (unchanged)

`PLACEHOLDER_RC_API_KEY` · `PLACEHOLDER_ENTITLEMENT_PRO` · `PLACEHOLDER_OFFERING_ID` · `PLACEHOLDER_PACKAGE_ID` · `PLACEHOLDER_PRODUCT_ID` — human fills `docs-runtime/RC-IDs.md` per §19. **No invented `test_` keys.**

---

## Audit

- [`COMPLETENESS-AUDIT.md`](./COMPLETENESS-AUDIT.md)  
- Integrator checklist: [`../../internal/bible/completeness-audit.md`](../../internal/bible/completeness-audit.md)
