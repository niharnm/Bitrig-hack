# Bitrig task assignment

Updated: 2026-09-26. Owner: Nihar.

This assignment replaces the optional Bitrig role in the original routing plan. Bitrig takes visual QA and Duo demo captures, then the ASSETS polish lane after its current owner hands off. Cursor keeps scaffold, integration, and Frost standby. Lane path locks and the maximum of three simultaneous code writers still apply.

See [capability research](bitrig-capability-research.md) for Reddit, Hacker News, developer examples, contrary reports, and vendor sources. Pose visualization has the strongest independent task-specific support. Better code generation than the existing tools is unproven.

## Why this task fits

Bitrig documents native Xcode builds, build-error inspection, simulator interaction, isolated conversation worktrees, and a 3D folding simulator. These make simulator-driven visual checks and short UI refinement cycles a reasonable assignment. This is a task-fit inference, not a measured comparison of coding quality.

Sources checked on 2026-09-26:

- [Native builds and inline preview](https://bitrig.com/blog/meet-bitrig-for-mac)
- [Agent build diagnostics](https://bitrig.com/blog/meet-bitrig-agent)
- [Isolated workspaces and simulator testing](https://bitrig.com/blog/run-parallel-agents)
- [Duo folding simulator and required toolchain](https://bitrig.com/blog/bitrig-builds-iphone-duo-apps)
- [Selection editing](https://bitrig.com/blog/select-to-edit-in-the-simulator)
- [Simulator interaction tools](https://bitrig.com/blog/bitrig-simulator-use)

## Local evidence and limits

- The existing `DuoApp` folder opens and its Swift sources are visible in Bitrig.
- Both subscription providers were connected. Use the Codex provider for this task; launching Claude Code requires Nihar's explicit request.
- The prior built-in preview stayed on a loading indicator after relaunch. An ordinary iPhone run was attempted, but a running app was not verified.
- The Xcode simulator picker showed ordinary iPhones and no Duo destination. This does not establish whether Bitrig's separate 3D preview is available.
- The scaffold gate records Xcode 27.0 and no Duo runtime. Refresh that evidence before relying on it. The vendor requires Xcode 27.1 beta and the iOS 27.1 simulator for Duo.
- Other tasks are editing app files. Preserve their changes and record the exact revision and dirty state used for every check.

## Phase 1: visual QA and preview diagnosis, start now

### Conversation scope

Use multiple Bitrig chats, one per bounded task. Start a fresh chat when the objective, owner, or validation revision changes substantially. Keep each handoff short: objective, exact revision and dirty state, files to read or write, verified evidence, blockers, and expected output. Do not carry the full project history into every chat.

- Keep setup/build diagnosis, visual QA, demo planning/captures, and authorized ASSETS edits in separate chats.
- Give each chat its own output file. The visual QA chat owns `BITRIG-REVIEW.md`; the demo planning chat owns `BITRIG-DEMO-PLAN.md` under `DuoApp/docs-runtime/`.
- Only one chat controls the shared simulator or builds the shared checkout at a time. Independent source review and demo planning may run alongside it.
- Preserve existing file ownership and the three-writer limit. New chats do not grant new code-edit permissions.
- Close each task with a compact result and use that result as the next chat's handoff.

Code is read-only. Bitrig may write only `DuoApp/docs-runtime/BITRIG-REVIEW.md`. Build output and screenshots belong in temporary directories outside the repository.

1. Read the lane contract, design direction, acceptance tests, and current scaffold gate.
2. Record the selected Xcode version, installed runtimes, preview destination, Git revision, and dirty state. Check ordinary iPhone preview and Duo preview separately.
3. Inspect actual build or preview errors before proposing a fix. Report the exact blocker and a concrete next action. Do not change global Xcode selection, install toolchains, alter signing, or edit project configuration.
4. Run available demo interactions in the simulator. Check legibility, clipping, contrast, control placement, Reduce Motion, and Dynamic Type. Check flat, tabletop, book, and closed poses only when Duo is available.
5. Record each check as PASS, FAIL, BLOCKED, or NOT RUN, with destination and evidence. File findings against their owning lanes. Static inspection alone cannot pass a visual or hardware check.

Done: the report contains environment evidence, preview diagnosis, reproducible findings, and the next action for each blocker. A missing runtime may block pose checks while ordinary iPhone checks continue.

## Phase 2: ASSETS polish, after handoff

Bitrig replaces Cursor as the ASSETS owner only after the integrator records the file handoff and the current ASSETS writer stops. Bitrig consumes one of the three code-writer slots; it replaces the standby or polish slot rather than adding a fourth writer.

Owned paths after handoff:

- `DuoApp/DesignSystem/Tokens.swift`
- `DuoApp/DesignSystem/Motion.swift`
- `DuoApp/Resources/Assets.xcassets/Coach/**`
- `DuoApp/Resources/Assets.xcassets/Frost/**`
- `DuoApp/Resources/Assets.xcassets/Shared/**`

Implement only token, asset, or motion fixes supported by the Phase 1 findings and the frozen design direction. View-file changes require a named handoff from that feature owner. Keep capture, entitlement behavior, pose routing, shared types, project files, and cutover decisions with their existing owners.

Done: TC-A01 through TC-A03 have actual evidence or explicit blockers, relevant checks pass, the demo screens are visually checked on the recorded destination, and the diff stays inside handed-off paths. Simulator results do not prove camera accessory hardware behavior.

## Phase 3: demo captures and final QA

When the Duo preview works, Bitrig owns the capture sequence: flat to tabletop, subject-coach or cutover outer result, Pro result, and closed pose if implemented. Save screenshots outside the repository and record their paths and source revision in `BITRIG-REVIEW.md`. Prepare the ordered shot list for a short folding demo recording; record video only if a recording tool is actually available. This transfers demo presentation work from the Cursor QA checklist to Bitrig, while Nihar still performs the live demo.

Bitrig supplies the visual QA findings and simulator evidence to the QA owner. Nihar owns the timed rehearsal, gate decisions, and final `DEMO-LAST-PASS.md` approval. After freeze, Bitrig edits code only for a named demo blocker with an explicit file assignment.

## Dispatch status

The first visual QA task was submitted through Bitrig with the Codex provider on 2026-09-26. The UI showed an active agent and the submitted prompt. Its review results and local preview success are pending.

## First task prompt

```text
SYSTEM: You are the visual QA worker operating inside Bitrig for Outer Lens.
OBJECTIVE: Diagnose preview readiness and produce a reproducible visual QA report for the existing app.
BOUNDARIES AND INPUTS:
- Project: /Users/nihar/Desktop/Bitrig Hack/DuoApp.
- Read: ../docs/bitrig-task-plan.md, ../docs/bitrig-capability-research.md, ../docs/bible/00-front-matter-agent-contract.md, ../docs/design-direction.md, ../docs/bible/15-acceptance-tests.md, docs-runtime/GATE-SCAFFOLD.md.
- Write only: docs-runtime/BITRIG-REVIEW.md. All app code and existing user changes are read-only. Screenshots and build artifacts go outside the repo.
- Use actual build logs and simulator observations. Record toolchain, destination, revision, dirty state, and PASS/FAIL/BLOCKED/NOT RUN separately.
- Check ordinary iPhone and Duo preview separately. No invented Duo APIs, RC IDs, or visual passes. Do not switch branches, commit, push, install software, change signing, modify global settings, or launch another coding agent.
- If preview is blocked, report its exact error and continue available static checks, labeling them static. ASSETS code edits await a recorded handoff.
- Address Nihar in every visible response.
EXPECTED OUTPUT:
Return the report path, verified checks, exact blockers, and owner-specific next actions. Save the same evidence in docs-runtime/BITRIG-REVIEW.md.
```
