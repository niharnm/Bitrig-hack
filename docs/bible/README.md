# Outer Lens — Mega Build Bible

**Product:** Outer Lens (Film Tool) · Bitrig Hacks iPhone Duo · Sat Sep 26, 2026  
**Cutover:** FrostDuo behind `CUTOVER.flag` only — not a second product  
**Status:** **READY** — [STATUS.md](./STATUS.md) · **19/19 chapters ready** · **89,863** words · **299.5** pages (@300 wpp) · ≥200 **met**  
**Audit:** [COMPLETENESS-AUDIT.md](./COMPLETENESS-AUDIT.md)  
**Reviews:** [REVIEW-cursor-lanes-pass.md](./REVIEW-cursor-lanes-pass.md) · [REVIEW-claude-pass.md](./REVIEW-claude-pass.md) · [REVIEW-codex-pass.md](./REVIEW-codex-pass.md)  
**Store root:** `/cursor/stores/bc-efb3d903-44d1-4e0a-b492-044c558277f9/`  
**Chat pointer:** [`../OUTER-LENS-BIBLE.md`](../OUTER-LENS-BIBLE.md)

---

## HOW TO SEND TO CLAUDE / CODEX / CURSOR

### Universal (every tool, first message)

1. **Human first:** Complete [19-human-prep-tomorrow.md](./19-human-prep-tomorrow.md) — RevenueCat Test Store → fill `PLACEHOLDER_RC_*` into `docs-runtime/RC-IDs.md`. Never invent `test_` keys in AI chats.
2. Paste **[00-front-matter-agent-contract.md](./00-front-matter-agent-contract.md)** as message #1.
3. Paste the matching card from **[18-multi-ai-lane-cards.md](./18-multi-ai-lane-cards.md)** (own X / don’t touch Y).
4. Attach or `@` this whole `docs/bible/` folder + [13-design-system-tokens.md](./13-design-system-tokens.md).
5. Cap **three** coding writers. Follow [17-saturday-clock.md](./17-saturday-clock.md) (M0–M8 minutes 10/15/25/5/55/35/15/10/10). Gate CCA at **12:15**.

### Claude Code / Opus

```text
@docs/bible/00-front-matter-agent-contract.md
@docs/bible/18-multi-ai-lane-cards.md   # your lane only
# Then lane chapters from table below (Duo shell or Outer Lens)
Follow §00. Outer Lens Film Tool only. No invented RC IDs.
Report acceptance with canonical TC-* (§15), not TC-OL-* alone.
```

### Codex CLI / GPT

```text
Lane = RevenueCat (or Frost standby). Own ONLY Monetization/** + Features/Paywall/**
(or Features/Frost/**). Read docs/bible/09 + 15 (or 12 + 02).
If PLACEHOLDER_RC_* remain → BLOCKED. Do not invent keys.
```

### Cursor Agent / Composer (Mac + Xcode)

```text
@docs/bible — start Scaffold: 00, 06, 13. Empty boot on Duo sim.
Then integrate merges only. Do not cross lane paths without Integrator.
```

---

## Index & reviews

| Doc | Role |
|-----|------|
| [STATUS.md](./STATUS.md) | Live `wc -w` · page-equiv · decisions · REVIEW links |
| [COMPLETENESS-AUDIT.md](./COMPLETENESS-AUDIT.md) | Contract checklist · soft/hard FAILs |
| [REVIEW-cursor-lanes-pass.md](./REVIEW-cursor-lanes-pass.md) | Cursor lanes review (**landed**) |
| [REVIEW-claude-pass.md](./REVIEW-claude-pass.md) | Claude review (**landed**) |
| [REVIEW-codex-pass.md](./REVIEW-codex-pass.md) | Codex review (**landed**) |

---

## Reading order

| Order | Chapter | Status | Words |
|------:|---------|--------|------:|
| 0 | [00-front-matter-agent-contract.md](./00-front-matter-agent-contract.md) | **ready** | 4255 |
| 1 | [01-win-condition.md](./01-win-condition.md) | **ready** | 4050 |
| 2 | [02-concept-lock-cutover.md](./02-concept-lock-cutover.md) | **ready** | 3988 |
| 3 | [03-judge-sponsor-beats.md](./03-judge-sponsor-beats.md) | **ready** | 4906 |
| 4 | [05-duo-api-inventory.md](./05-duo-api-inventory.md) | **ready** | 4528 |
| 5 | [06-repo-file-tree.md](./06-repo-file-tree.md) | **ready** | 3586 |
| 6 | [07-types-state-machines.md](./07-types-state-machines.md) | **ready** | 4348 |
| 7 | [08-shell-arrangement-poses.md](./08-shell-arrangement-poses.md) | **ready** | 7123 |
| 8 | [09-revenuecat-monetization.md](./09-revenuecat-monetization.md) | **ready** | 8706 |
| 9 | [11-outer-lens-product.md](./11-outer-lens-product.md) | **ready** | 7327 |
| 10 | [11b-outer-lens-flows.md](./11b-outer-lens-flows.md) | **ready** | 4664 |
| 11 | [12-frostduo-cutover.md](./12-frostduo-cutover.md) | **ready** | 4261 |
| 12 | [13-design-system-tokens.md](./13-design-system-tokens.md) | **ready** | 4616 |
| 13 | [14-motion-interaction.md](./14-motion-interaction.md) | **ready** | 3824 |
| 14 | [15-acceptance-tests.md](./15-acceptance-tests.md) | **ready** | 6053 |
| 15 | [16-demo-script-90s.md](./16-demo-script-90s.md) | **ready** | 2821 |
| 16 | [17-saturday-clock.md](./17-saturday-clock.md) | **ready** | 2972 |
| 17 | [18-multi-ai-lane-cards.md](./18-multi-ai-lane-cards.md) | **ready** | 5155 |
| 18 | [19-human-prep-tomorrow.md](./19-human-prep-tomorrow.md) | **ready** | 2680 |

**Corpus:** 89,863 required words · **299.5** page-equiv (÷300) · **19/19 ready**.

---

## Lane → start chapters

| Lane | Tool | Read first |
|------|------|------------|
| Orchestrator (Nihar) | Human + cheap Cursor | 00, 17, 19, 16 |
| Scaffold / Cursor Mac | Cursor | 00, 06, 13 |
| Duo shell | Claude Opus | 00, 05, 08, 07 |
| Outer Lens feature | Claude Opus | 00, 11, 11b, 13, 14 |
| RevenueCat | Codex / GPT | 00, 09, 15, 19 |
| Frost cutover (standby) | Cursor BG / Codex | 00, 12, 02 |
| Polish / motion | Cursor + Sonnet | 00, 13, 14 |
| Demo / QA | Nihar + cheap Cursor | 00, 15, 16, 17 |
| Scope guard | Claude Opus RO | 00 + contract |

---

## Non-negotiables

- One theme: **Outer Lens Film Tool** (charcoal `#050505`, amber `#E8A838`).
- Climax: **`CameraCaptureAccessory`** outer tip → RC Test Store → Pro on **other** pane.
- Polished live slice wins — not App Store–complete ([win-completeness-bar](../win-completeness-bar.md)).
- No forks of Moments / PrivacyScreen / ClawKit / etc.
- No app code until Saturday doors.
- RC: `PLACEHOLDER_RC_*` until human fills `RC-IDs.md`.
- Acceptance: report **canonical TC-*** (§15 / contract §6); `TC-OL-*` are detail only (§11.8.0).

Upstream locks: [theme contract](../bible-single-theme-contract.md) · [3h plan](../outer-lens-3h-build-plan.md) · [design direction](../design-direction.md) · [model routing](../multi-ai-build-routing.md)
