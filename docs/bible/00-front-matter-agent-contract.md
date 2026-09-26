# §00 — Front matter & agent contract

**Bible chapter:** `docs/bible/00-front-matter-agent-contract.md`  
**For:** Any AI tool (Claude Code, Codex CLI, Cursor Agent/Composer, Gemini, GPT-in-Cursor, human Integrator) that touches Outer Lens / FrostDuo Saturday work  
**Event:** Bitrig Hacks: iPhone Duo · Sat Sep 26, 2026 · YC SF · build 11:30–3:30 · demos 3:30–5:00  
**Product lock:** Outer Lens (Film Tool) primary · FrostDuo hour-one cutover only  
**Constraint:** This chapter is **instructions + invariants**. It contains **zero shipping Swift**. Agents implement from later chapters on Saturday.  
**Upstream contracts:** `docs/bible-single-theme-contract.md` · `docs/build-bible-blueprint.md` · `docs/multi-ai-build-routing.md` · `docs/outer-lens-3h-build-plan.md`  
**Compiled:** Sat Sep 26, 2026

---

## 0. How ANY AI must open this bible

### 0.1 Mandatory read order (every session, every tool)

Paste or attach **in this order** before writing a single line of app code:

| Step | Artifact | Why |
|-----:|----------|-----|
| 1 | **This file (§00)** | DQ, lane mutex, placeholders, merge, human-vs-agent rules |
| 2 | Your **lane card** (§0.4 below + `docs/multi-ai-build-routing.md` §3 stub) | Path ownership |
| 3 | Linked **screen / API / RC** chapters you were told to open | Spec fuel only |
| 4 | Matching research pack if cited on the lane card | VERIFIED symbols |

**Refuse** the session if step 1–2 are missing. Do not “skim the PDF and start coding.”

### 0.2 Prompt template (paste verbatim into Claude / Codex / Cursor / Gemini)

```text
You are LANE-<ID> for Outer Lens / Duo Sat Sep 26 build.
Read bible §00 (docs/bible/00-front-matter-agent-contract.md) first.
Then read ONLY your lane card and cited §§.
Owned paths: <list from §0.4>.
Forbidden paths: everything else + any path not on your card.
Consume contracts: Shared/Types.swift signatures (Integrator-owned).
Produce: files on your card + GATE-*.md handoff.
Done when your lane TCs pass. Do not expand scope.
Do NOT invent PLACEHOLDER_RC_* values, Duo API signatures, or SCR-IDs.
Do NOT write shipping Swift before doors (prep phase) or outside owned paths (Sat).
If blocked, write BLOCKED: <reason> + owner — stop.
```

### 0.3 Tool-agnostic behavior rules

| Tool | Allowed | Forbidden |
|------|---------|-----------|
| **Claude Code / Opus** | Duo core · Outer Lens CCA · cutover architecture review · scope nacks (read-only role) | Inventing RC IDs · editing `CUTOVER.flag` · merging `.pbxproj` without Integrator |
| **Codex CLI / GPT** | RevenueCat recipe in `Monetization/**` + `Features/Paywall/**` · Frost stubs if assigned | PoseRouter edits · CCA host redesign · dashboard ID invention |
| **Cursor Agent on Xcode Mac** | Scaffold · integrate · polish · QA checklists · sim clicks via human | Owning all lanes at once · silent cross-lane patches |
| **Cursor Background Agent** | Frost standby files behind flag | Flipping cutover · Capture/Coach edits |
| **Gemini 2.5 Pro** | PDF/bible ingest → lane briefs, SCR/TC index, BLOCKED list | Writing Swift into the app repo |
| **Scope guard (Claude Opus read-only)** | Nack PRs that violate §00 / kill list | Write access |
| **Human (Nihar)** | Orchestrator · RC dashboard · `RC-IDs.md` paste · gate flips · merge clicks · demo | Pretending an AI owns the clock |

### 0.4 Lane roles (canonical — one owner per path)

Crosswalk: blueprint `LANE-*` ↔ routing-doc numbered lanes. **Max three coding writers live** after shell green.

| Lane ID | Routing # | Mission | Owns (exact) | Must NOT touch | Done when |
|---------|----------:|---------|--------------|----------------|-----------|
| **ORCHESTRATOR** | 0 | Clock, gates, cutover, demo call | `docs-runtime/GATE-*.md` writes · `docs-runtime/CUTOVER.flag` · merge decisions | Feature Swift as “orchestrator” | Gates recorded; freeze called |
| **BIBLE-INGEST** | 1 | Extract briefs from mega bible | Notes only / lane briefs | App repo Swift | SCR/TC index printed |
| **LANE-SHELL** | 2–3 | Scaffold + Duo Arrangement shell | `App/**` · `Duo/PoseRouter.swift` · `Duo/ArrangementRegions.swift` · `Shared/CutoverFlag.swift` · Xcode/SPM stubs | `Features/**` · `Monetization/**` | TC-S01–S04 · `GATE-SCAFFOLD.md` / shell ready |
| **LANE-CCA** | 4 | Outer Lens vertical slice | `Duo/CameraCaptureAccessoryHost.swift` · `Features/Capture/**` · `Features/CoachOverlay/**` | `Monetization/**` · `Features/Frost/**` · inventing RC IDs | TC-C01–C05 (primary mode) |
| **LANE-RC** | 5 | Test Store + EntitlementState | `Monetization/**` · `Features/Paywall/**` | PoseRouter · CCA logic · inventing IDs | TC-R01–R05 · `GATE-RC.md` |
| **LANE-FROST** | 6 | FrostDuo cutover (standby→primary) | `Features/Frost/**` only | Capture/Coach · flipping `CUTOVER.flag` | TC-F01–F04 (cutover mode); F05 optional |
| **LANE-ASSETS** | 7 | Tokens + xcassets | `DesignSystem/Tokens.swift` · `DesignSystem/Motion.swift` · `Resources/Assets.xcassets/**` | Behavior / RC configure | TC-A01–A03 |
| **LANE-COPY** | (prose) | Brad/Matt + strings + script | `Resources/Localizable.strings` · `docs-runtime/DEMO-SCRIPT.md` | SDK calls | TC-P01–P04 |
| **LANE-DEMO** | 8 | Rehearsal + last pass | `docs-runtime/DEMO-LAST-PASS.md` · read-only app unless hotfix named | New features after freeze | TC-D01–D03 |
| **INTEGRATOR** | (human+) | Types + merges + project files | `Shared/Types.swift` · `.pbxproj` / project.yml · merge windows on any path | Owning whole features as sole author | TC-I01–I04 · `sat/freeze` |
| **SCOPE-GUARD** | 9 | Nacks only | None (read-only) | Write access | Creep blocked |

**Lane ↔ product mode**

| Mode | `docs-runtime/CUTOVER.flag` | Active coding lanes | Parked |
|------|----------------------------|---------------------|--------|
| Primary Outer Lens | absent / `false` / empty | SHELL · CCA · RC · COPY · ASSETS · DEMO · INTEGRATOR | FROST = file-isolated stubs only |
| Cutover FrostDuo | **`frost`** (exact; never `true`) | SHELL · FROST · RC · COPY · ASSETS · DEMO · INTEGRATOR | CCA **stops** feature work |

### 0.5 Path mutex (hard)

1. An agent may **write** only paths on its lane card (plus `/tmp` notes and its `GATE-*.md`).  
2. `Shared/Types.swift` = **Integrator-only** after scaffold (lanes submit type snippets in notes, not drive-bys).  
3. `CUTOVER.flag` + `GATE-CCA.md` = **Orchestrator-only** writes.  
4. `docs-runtime/RC-IDs.md` = **Human paste only** for real values; agents may create the file skeleton with `PLACEHOLDER_RC_*` only.  
5. Crossing paths without Integrator approval = **defect** (Scope Guard nacks).

---

## 1. Shared invariants (print on pages 1–2 of any PDF export)

Every agent session pastes this block:

1. **Event clock:** Build ~11:30–3:30; demos 3:30–5:00. Ship a live vertical slice, not a platform. Milestone map: M0–M8 in `docs/bible-single-theme-contract.md` §3 · wall clock in `docs/outer-lens-3h-build-plan.md` §4.  
2. **Human prep ≠ agent build:** Before doors, humans must **not** prewrite the shipping app. Specs, assets, RC **dashboard**, and this bible are allowed. **On Saturday, agents write the Swift.**  
3. **DQ:** No forks of scored OSS as the submission; no slides-only demo; no generic cloud-chat wrapper as the product; no Accorduon-as-accordion clone as the whole app; no pre-Saturday shipping binary.  
4. **Duo climax:** If it runs identically on a non-Duo iPhone, it fails the brief. Layout via `ArrangementView` / reserved regions; `onHingeChange` = effects/input only — never layout. Climax API primary = `CameraCaptureAccessory` via `.sceneAccessory` (`Duo/CameraCaptureAccessoryHost.swift`).  
5. **Entitlements:** Free vs Pro must be real `EntitlementState` from RevenueCat Test Store. Gate the differentiated Duo surface (outer T2 / vault decoy C), not chrome. Unlock must be visible on the **other** display (demo **1:05–1:20**).  
6. **Sponsor depth:** Duo APIs + RevenueCat are critical path. OpenAI / Sentry / Supabase = skip unless a later chapter marks load-bearing.  
7. **Scope freeze:** No new screens, packs, or climax APIs after Integrator freeze (~**3:00**, tag `sat/freeze`). Optional on-device tip = one string after climax, or cut.  
8. **Lane discipline:** Write only owned paths. Update gate artifacts. Escalate `BLOCKED` gaps to human — do not invent API signatures or RC IDs.  
9. **Cutover:** If CCA gate fails by **12:15**, activate FrostDuo per §02; RC + pitch muscle memory stay. Orchestrator flips flag; CCA stops.  
10. **Truthfulness:** Do not invent prize tiers, judge attendance, or unverified SDK symbols. Mark `UNKNOWN` / `DOC-ONLY` / `VERIFIED` / `SIM-OBS`.  
11. **Theme lock:** Outer Lens Film Tool only. FrostDuo = flagged cutover module, not a second equal product. Kill list in §02 / theme contract §2.  
12. **Every claim → path or demo second.** Idea clouds are deleted.

---

## 2. DQ rules (disqualification / reject)

### 2.1 Formal DQ / hard reject (do not ship)

| Rule | Evidence / path | Agent action if tempted |
|------|-----------------|-------------------------|
| Prewritten shipping app sources before doors | Luma Rules · theme contract §2B | Delete / refuse paste; keep specs only |
| Fork Moments / PrivacyScreen / SnapShield / Shot Caller / ClawKit / Cosign / Accorduon into submission | `docs/design-direction.md` §7 · win bar | Remix patterns only; cite, never copy repo |
| Slides / video replacing live demo | Luma Judging | Demo must be live Duo sim/device |
| Generic cloud-chat / “agents” as climax | theme contract §2A | Nack chat tabs / tool-calling kabuki |
| Accorduon / hinge-instrument as whole product | `docs/luma-chat-intel.md` | Hinge = effects only |
| Paywall on outer display | SCR-OL-D / SCR-FD-D inner only | Move paywall to inner |
| Layout driven by hinge degrees | `Duo/PoseRouter.swift` · TC-S03 | Strip hinge→layout |
| Invented RC production IDs / ASC sandbox fight | `Monetization/**` · RC research | Test Store only |
| Second climax API in one demo path (CCA **and** frost both “live”) | One climax glass ≤30s | Pick mode via `CUTOVER.flag` |
| Auth / Supabase / backend / multi-user sync as product | Out of §00 | Cut |
| Purple→indigo / cream+terracotta / broadsheet / glow / emoji chrome | `DesignSystem/Tokens.swift` | Film Tool or Frost tokens only |

### 2.2 Soft reject (Integrator / Scope Guard nacks without DQ claim)

- New SCR-IDs outside SCR-OL-* / SCR-FD-*.  
- Tip lists / icon grids / floating face badges on outer.  
- Skeleton HUD / traffic-light threat banners on Frost.  
- Liquid Glass over outer tip text or face (`docs/ios-craft-addendum.md`).  
- Foundation Models / Vision as load-bearing climax.  
- Multipeer / Watch / multicam / lens rack.  
- Fourth live coding writer.

### 2.3 Scope Guard nack template

```text
NACK — violates bible §00 / theme contract §2.
Offense: <banned noun or path cross>.
Required: <owned path or TC>.
Cite: docs/bible/00-front-matter-agent-contract.md · docs/bible-single-theme-contract.md
Do not merge.
```

---

## 3. No prewritten code until Saturday

### 3.1 Timeline law

| Phase | Wall clock | Allowed | Forbidden |
|-------|------------|---------|-----------|
| **Prep (now → doors)** | Fri night → Sat 10:30 | Bible Markdown · design assets · decoy stills · tip copy · RC **dashboard** · Xcode/sim **empty** boot · lane prompt packs | Shipping Swift meant to paste as the entry · secret finished binary · “almost done” feature trees |
| **Doors / opening** | 10:30–11:30 | Confirm toolchain · paste §00 · human RC-IDs if still placeholder | Feature commits pretending to be pre-work |
| **Build** | 11:30–3:00 | Agents write Swift per lanes from this bible | Expanding past M0–M8 / ON list |
| **Freeze** | ≤3:00 | `sat/hotfix/*` demo-blockers only | New screens / packs / climax APIs |
| **Rehearse / demo** | 3:00–5:00 | Script · TC ticks · live path | Refactors |

### 3.2 What “assets OK / code not OK” means precisely

**OK before doors**

- `docs/bible/**` chapters (this set).  
- Tip strings on paper / Notes (land into `Resources/Localizable.strings` Sat).  
- Decoy wallpapers on disk → `Resources/Assets.xcassets/Frost/` Sat.  
- Coach glyphs → `Resources/Assets.xcassets/Coach/` Sat.  
- RevenueCat dashboard: Test Store, `test_` key, entitlement `pro`, offering, paywall published.  
- Empty Xcode project **boot test** with **no feature implementation** (toolchain proof only).  
- `docs-runtime/RC-IDs.md` skeleton with `PLACEHOLDER_RC_*` (human replaces tomorrow / pre-doors).

**Forbidden before doors**

- Implemented `CameraCaptureAccessoryHost`, capture session controllers, paywall presenters, frost overlays as shippable sources.  
- Checking in a “starter” that already passes TC-C01 / TC-R03.  
- Embedding a finished app inside a skill / zip / gist to unpack Sat morning.

### 3.3 Agent instruction if asked to “port the prep app”

```text
REFUSE. Bible §00 §3: no prewritten shipping sources.
I will implement from SCR specs on Saturday under my lane card only.
```

---

## 4. HUMAN RC setup — tomorrow / pre-doors (not agent work)

### 4.1 Owner

**Nihar (human only).** No AI may create Test Store products, entitlement IDs, or API keys in the dashboard. Agents **consume** `docs-runtime/RC-IDs.md` after human paste.

### 4.2 Dashboard checklist (from `internal/research-revenuecat.md`)

Do once before 11:30 Sat (ideally Fri night / Sat AM). No Xcode required.

| # | Action | Dashboard path | Done when | Paste target |
|---|--------|----------------|-----------|--------------|
| 1 | Open/create RC project | app.revenuecat.com → Project | Project visible | — |
| 2 | Enable Test Store | Apps and providers → Test configuration → Test Store | Test Store exists | — |
| 3 | Copy API key | Project Settings → API keys | Key starts with `test_` | `PLACEHOLDER_RC_API_KEY` |
| 4 | Entitlement | Product catalog → Entitlements → New | Identifier exactly `pro` | `PLACEHOLDER_RC_ENTITLEMENT_ID` (= `pro`) |
| 5 | Test Store product | Products → New → store Test Store | ≥1 product | `PLACEHOLDER_RC_PRODUCT_ID` |
| 6 | Attach product → `pro` | Entitlement attach | Listed under `pro` | — |
| 7 | Offering + package | Offerings → New → package → Default/Current | `getOfferings().current` will be non-nil | `PLACEHOLDER_RC_OFFERING_ID` |
| 8 | Paywall | Offering → Paywall Editor → publish | Not fallback-only | `PLACEHOLDER_RC_PAYWALL_ATTACHED=true` |
| 9 | Screenshot offering→`pro` map | — | On phone/Notes for venue | — |

**Do NOT need:** App Store Connect, Paid Apps Agreement, `appl_` key, StoreKit `.storekit` file, sandbox Apple ID.

### 4.3 Bring to venue

- `test_` key on clipboard / Notes (never commit real key to a public remote).  
- Screenshot of offering → packages → `pro`.  
- Confirmation Current offering has published paywall.  
- Filled `docs-runtime/RC-IDs.md` (see §5).

### 4.4 If human is late

LANE-RC may scaffold `PurchasesConfig.swift` reading from `RC-IDs.md` **placeholders** and mark:

```text
BLOCKED: PLACEHOLDER_RC_* still unset — human paste required before TC-R01.
```

Do **not** invent a fake `test_` string that looks real. Do **not** switch to ASC sandbox to “unblock.”

---

## 5. PLACEHOLDER_RC_* rules

### 5.1 Why placeholders exist

RC IDs are **dashboard facts**, not model inventions (`docs/multi-ai-build-routing.md` §2 · `internal/research-revenuecat.md`). Until Nihar pastes real values, the bible and any `RC-IDs.md` skeleton use **explicit tokens**.

### 5.2 Canonical placeholder vocabulary

| Token | Meaning | Real value shape | Who replaces |
|-------|---------|------------------|--------------|
| `PLACEHOLDER_RC_API_KEY` | Test Store public SDK key | `test_…` | Human |
| `PLACEHOLDER_RC_ENTITLEMENT_ID` | Entitlement identifier | Must become exactly `pro` | Human (prefer set dashboard to `pro` now) |
| `PLACEHOLDER_RC_PRODUCT_ID` | Test Store product id | e.g. `pro_monthly` | Human |
| `PLACEHOLDER_RC_OFFERING_ID` | Offering identifier | dashboard offering id | Human |
| `PLACEHOLDER_RC_PACKAGE_ID` | Package inside offering | e.g. `$rc_monthly` or custom | Human |
| `PLACEHOLDER_RC_PAYWALL_ATTACHED` | Whether offering has published paywall | `true` / `false` | Human |
| `PLACEHOLDER_RC_APP_USER_ID_STRATEGY` | Demo user id approach | `anonymous` (default) or documented | Human/RC lane (default anonymous) |

### 5.3 File: `docs-runtime/RC-IDs.md` (Saturday handoff artifact)

Agents may create this skeleton **only**. Human replaces tokens.

```markdown
# RC-IDs — HUMAN PASTE ONLY

| Key | Value |
|-----|-------|
| apiKey | PLACEHOLDER_RC_API_KEY |
| entitlementId | pro |
| productId | PLACEHOLDER_RC_PRODUCT_ID |
| offeringId | PLACEHOLDER_RC_OFFERING_ID |
| packageId | PLACEHOLDER_RC_PACKAGE_ID |
| paywallAttached | PLACEHOLDER_RC_PAYWALL_ATTACHED |
| appUserIdStrategy | anonymous |
| sdk | purchases-ios-spm ≥ 5.43.0 |
| packages | RevenueCat + RevenueCatUI |

Rules:
- LANE-RC reads this file; does not invent values.
- If any PLACEHOLDER_RC_* remains at configure time → BLOCKED + stop.
- Never commit real test_ keys to public remotes; local/venue Notes OK.
```

### 5.4 Code-side consumption rules (Saturday LANE-RC)

| Rule | Path | Detail |
|------|------|--------|
| Configure once | `Monetization/PurchasesConfig.swift` | `Purchases.configure` with key from `RC-IDs.md`; `#if DEBUG` Test Store path |
| Entitlement observe | `Monetization/Entitlements.swift` | Publish `EntitlementState.isPro` from `CustomerInfo.entitlements["pro"]` (or configured id) |
| Paywall host | `Features/Paywall/PaywallHostView.swift` | RevenueCatUI; **inner only** |
| Others observe | CoachOverlay / Frost | Read `EntitlementState` — **never** call `Purchases.configure` |
| Fail closed | — | If placeholder remains → compile OK with stub, runtime marks blocked; **no** fake Success |

### 5.5 Anti-patterns (instant nack)

- Agent “helpfully” pastes a guessed `test_abc123` from training data.  
- Agent switches entitlement id to `premium` / `pro_coach` without human dashboard match.  
- Agent adds StoreKit Configuration file to “make purchase work.”  
- Agent puts API key in `Localizable.strings` or a public README.  
- Agent treats `PLACEHOLDER_RC_*` as a string customers should see on glass.

### 5.6 Replacement protocol (human)

1. Open dashboard → copy real values.  
2. Replace tokens in `docs-runtime/RC-IDs.md`.  
3. Tell LANE-RC: “RC-IDs live — run TC-R01.”  
4. LANE-RC configures → paywall → Successful Purchase → other-pane unlock (TC-R02–R04).

---

## 6. Merge protocol (Integrator)

### 6.1 Integrator identity

**Default:** Nihar (human clicks merge on Xcode project files). Review models OK; **human owns `.pbxproj`.**

### 6.2 Branch / worktree topology

| Phase | When | Branch | Merge order | Rule |
|-------|------|--------|-------------|------|
| **B0 Scaffold** | T+0–15 (~11:30–11:45) | `sat/shell` from `main`/`sat/root` | — | SHELL creates project |
| **B1 Shell** | T+15–45 | `sat/shell` → `sat/integrate` | **1st** | No feature merge before TC-S01/S02 |
| **B2 Parallel** | T+45–~2:30 | `sat/cca`, `sat/rc`, `sat/frost` | — | Path mutex; rebase onto `sat/integrate` hourly |
| **B3 RC+UI** | ~T+2:30 | `sat/rc` then `sat/cca` → `sat/integrate` | **2nd** | Prefer RC before CCA Pro overlays so `EntitlementState` exists |
| **B4 Cutover** | If gate red ~12:15 | `sat/frost` → `sat/integrate` | Replaces CCA feature merge | Flip `CUTOVER.flag`; COPY switches script appendix |
| **B5 Assets/Copy** | Anytime before freeze | `sat/copy`, `sat/assets` | Soft | Never block B3 |
| **B6 Freeze** | ≤3:00 | tag `sat/freeze` | — | No new features; hotfixes `sat/hotfix/*` |
| **B7 Demo** | 3:00–3:30 | `sat/integrate` = demo branch | Hotfixes one-at-a-time | LANE-DEMO go/no-go |

### 6.3 Conflict rules

| Hot file | Owner | Rule |
|----------|-------|------|
| `.pbxproj` / `project.yml` / `Package.resolved` | Integrator | Lanes never self-merge these into `sat/integrate` |
| `Shared/Types.swift` | Integrator | Lanes submit snippets in notes |
| `App/RootArrangementView.swift` | SHELL | Features inject via named slots only |
| `Duo/PoseRouter.swift` | SHELL | Features read `PoseMode`; don’t redefine table |
| `Duo/CameraCaptureAccessoryHost.swift` | CCA after shell handoff | SHELL leaves empty `.sceneAccessory` hook |
| `Monetization/Entitlements.swift` | RC | Others observe |
| `CUTOVER.flag` | Orchestrator | Read-only for AIs |
| `RC-IDs.md` | Human | RC consumes |
| `Assets.xcassets` | Partition `Coach/` · `Frost/` · `Shared/` | No cross-writes |

**Green build > clever merge.** If conflict >15 min → revert lane commit → smaller patch.

### 6.4 PR hygiene (if hosting used)

- One lane per PR.  
- Title: `LANE-CCA: TC-C01 outer tips`.  
- Description links bible §§ + TCs.  
- Authors do not self-merge into `sat/integrate`.

### 6.5 Gate artifacts (write live)

| File | When | Writer |
|------|------|--------|
| `docs-runtime/GATE-SCAFFOLD.md` | ~11:45 | SHELL/Scaffold |
| `docs-runtime/GATE-CCA.md` | **12:15** | Orchestrator |
| `docs-runtime/CUTOVER.flag` | 12:15 if RED | Orchestrator |
| `docs-runtime/GATE-RC.md` | ~2:15 | LANE-RC |
| `docs-runtime/GATE-FROST.md` | if cutover | LANE-FROST |
| `docs-runtime/DEMO-LAST-PASS.md` | 3:00–3:15 | LANE-DEMO |
| `docs-runtime/DEMO-SCRIPT.md` | COPY / Orchestrator | LANE-COPY |
| `docs-runtime/RC-IDs.md` | Pre-doors | **Human** |

---

## 7. Saturday start order (serial vs parallel)

Aligned with `docs/multi-ai-build-routing.md` §5 · `docs/outer-lens-3h-build-plan.md` §4.

```text
Pre-doors
  Human: RC-IDs paste · Duo sim first boot done · tip strings · decoy stills
  Optional: Gemini ingest → lane briefs

T+0:00  Orchestrator: §00 pasted into every session; Outer Lens lock spoken
T+0:15  [SERIAL] Scaffold (Cursor) → empty ⌘R · GATE-SCAFFOLD
T+0:30  [SERIAL] Duo core (Claude Opus) → Arrangement + pose chrome · TC-S01/S02
T+1:00  GATE-CCA (~12:15 wall)
          GREEN → Outer Lens primary
          RED  → CUTOVER.flag=frost → Frost primary; CCA stops
T+1:00  [PARALLEL ≤3]
          A: CCA (or FROST if cutover)
          B: RC
          C: Frost standby stubs OR polish (lowest priority if Outer green)
T+2:30  [SERIAL] Integrator: EntitlementState → other-pane unlock
T+3:00  FREEZE · DEMO TC suite · script ×2
T+4:00  Stop coding · human demos
```

---

## 8. File tree freeze (agents target these paths Saturday)

Root: **`DuoApp/`**. Rename only via Integrator + changelog. Forbidden top-level: `Agents/`, `Chat/`, `Interview/`, `HingeBeat/`, `PoseAgent/`, `Backend/`, `Marketing/`.

```text
DuoApp/
  App/
    DuoAppApp.swift                      # LANE-SHELL
    RootArrangementView.swift            # LANE-SHELL
  Duo/
    PoseRouter.swift                     # LANE-SHELL
    ArrangementRegions.swift             # LANE-SHELL
    CameraCaptureAccessoryHost.swift     # LANE-CCA
  Features/
    Capture/                             # LANE-CCA
      CaptureSessionController.swift
      InnerCaptureView.swift
      PermissionPrimerView.swift
      CaptureDeniedView.swift
    CoachOverlay/                        # LANE-CCA (+ COPY strings)
      SubjectCoachView.swift
      TipPlateView.swift
      GuideOvalView.swift
      CountdownView.swift
    Paywall/                             # LANE-RC
      PaywallHostView.swift
    Frost/                               # LANE-FROST (behind CutoverFlag)
      SensitiveSurfaceView.swift
      FrostControlsView.swift
      FrostOverlayView.swift
      OuterDecoyStageView.swift
      SimulateThreatControl.swift
      ThreatLevel.swift
  Monetization/
    PurchasesConfig.swift                # LANE-RC
    Entitlements.swift                   # LANE-RC → EntitlementState
  DesignSystem/
    Tokens.swift                         # LANE-ASSETS
    Motion.swift                         # LANE-ASSETS
  Resources/
    Assets.xcassets/
      Coach/                             # LANE-ASSETS
      Frost/                             # LANE-ASSETS
      Shared/
    Localizable.strings                  # LANE-COPY
  Shared/
    Types.swift                          # INTEGRATOR
    CutoverFlag.swift                    # LANE-SHELL
  docs-runtime/
    GATE-SHELL.md · GATE-CCA.md · GATE-RC.md · GATE-FROST.md
    RC-IDs.md · CUTOVER.flag · DEMO-SCRIPT.md · DEMO-LAST-PASS.md
```

**SPM locked:** `RevenueCat` + `RevenueCatUI` from `purchases-ios-spm` ≥ **5.43.0**. No PrivacyScreen / SnapShield / Moments packages.

---

## 9. Screen ID freeze (agents may only implement these)

### 9A. Outer Lens (primary)

| SCR-ID | Screen | Path | Demo seconds |
|--------|--------|------|--------------|
| SCR-OL-A | Permission primer | `Features/Capture/PermissionPrimerView.swift` | **0:00–0:10** |
| SCR-OL-B | Capture shell | `Features/Capture/InnerCaptureView.swift` | **0:10–0:40** |
| SCR-OL-C | Subject coach (outer) | `Features/CoachOverlay/SubjectCoachView.swift` | **0:15–0:45** T1 · **1:05–1:20** T2 |
| SCR-OL-D | Paywall (inner) | `Features/Paywall/PaywallHostView.swift` | **0:50–1:05** |
| SCR-OL-E | Empty/denied | `Features/Capture/CaptureDeniedView.swift` | fallback |

Tips: **T1** free line · **T2** Pro guide · **T3** countdown — inside SCR-OL-C only.  
Motions: **M1** tip settle · **M2** countdown · **M3** Pro bloom · **P1–P3** press micros on SCR-OL-B.

### 9B. FrostDuo (cutover)

| SCR-ID | Screen | Path | Demo seconds |
|--------|--------|------|--------------|
| SCR-FD-A | Sensitive surface | `Features/Frost/SensitiveSurfaceView.swift` | **0:00–0:15** |
| SCR-FD-B | Controls / Simulate | `Features/Frost/FrostControlsView.swift` | **0:15–0:35** |
| SCR-FD-C | Outer decoy | `Features/Frost/OuterDecoyStageView.swift` | **0:25–0:45** A/B · **1:05–1:20** C |
| SCR-FD-D | Paywall (inner) | shared `PaywallHostView.swift` | **0:50–1:05** |
| SCR-FD-E | Closed-cover vault | optional | cut first |

Decoys: **A** Lock Lookalike · **B** Busy Cover · **C** Vault Cover (Pro).  
Motions: **F1** frost settle · **F2** decoy snap · **F3** vault crossfade.

---

## 10. Acceptance tests agents must know (pointer)

Full suite lives in theme contract §6 and bible §01 / §17. Lane subsets:

| Lane | TCs |
|------|-----|
| SHELL | TC-S01–S04 |
| CCA | TC-C01–C05 |
| FROST | TC-F01–F05 |
| RC | TC-R01–R05 |
| COPY | TC-P01–P04 |
| ASSETS | TC-A01–A03 |
| DEMO | TC-D01–D03 |
| INTEGRATOR | TC-I01–I04 |

Win slice = **one** live Duo climax + RC other-pane unlock + 90s script. Pass all Primary **or** (after cutover) all Cutover, plus Always.

---

## 11. BLOCKED / UNKNOWN protocol

| Marker | Meaning | Agent behavior |
|--------|---------|----------------|
| `BLOCKED:` | Cannot proceed without human | Stop writing speculative code; name owner + unblock criterion |
| `UNKNOWN:` | Fact not verified | Do not invent; cite doc; prefer Simulate / tip-only fallback |
| `VERIFIED:` | Confirmed in research pack / Xcode | Safe to call |
| `SIM-OBS:` | Observed in simulator only | Do not claim device proof |
| `DOC-ONLY:` | Docs claim, not yet run on Nihar machine | Confirm Sat AM before load-bearing |

Example:

```text
BLOCKED: PLACEHOLDER_RC_API_KEY unset — owner: Human — unblock: paste test_ into docs-runtime/RC-IDs.md
UNKNOWN: camera entitlement key string — owner: SHELL/CCA — unblock: verify in Xcode 27.1 Info.plist templates
```

---

## 12. Creep protocol (lunch / late clock)

From `docs/outer-lens-3h-build-plan.md` §7:

- **1:00 lunch:** no new screens; merge/compile OK.  
- Request not on ON list → Scope Guard nacks or Orchestrator defers post-demo.  
- Behind at **2:00:** drop T3 polish, P2 glass brighten, tabletop; keep tip + purchase + bloom.  
- Behind at **2:30:** drop Simulate variety beyond one tip button; keep Successful Purchase.  
- **Never** invent Vision to “save” CCA — tip-only or cutover.

---

## 13. Agent checklist before first commit Saturday

1. [ ] §00 pasted into session.  
2. [ ] Lane ID spoken; owned paths listed.  
3. [ ] `CUTOVER.flag` read (do not write unless Orchestrator).  
4. [ ] No `PLACEHOLDER_RC_*` invention.  
5. [ ] Target SCR-IDs only from §9.  
6. [ ] Kill list obeyed (no PoseAgent / HingeBeat / interview / agents product).  
7. [ ] Will update `GATE-*.md` on done.  
8. [ ] Will stop at freeze.

---

## 14. Cross-links

| Need | Doc |
|------|-----|
| Theme + kill list + M0–M8 | `docs/bible-single-theme-contract.md` |
| Win bar / Brad-Matt / DoD | `docs/bible/01-win-condition.md` |
| Cutover matrix / Luma | `docs/bible/02-concept-lock-cutover.md` |
| Judges → demo seconds | `docs/bible/03-judge-sponsor-beats.md` |
| Lane routing + prompt stubs | `docs/multi-ai-build-routing.md` |
| Blueprint §18 merge | `docs/build-bible-blueprint.md` |
| 3h minute plan | `docs/outer-lens-3h-build-plan.md` |
| Tokens / SCR map | `docs/design-direction.md` |
| RC dashboard recipe | `internal/research-revenuecat.md` |
| CCA research | `internal/research-outer-lens.md` |
| Frost research | `internal/research-frostduo.md` |
| Duo API catalog | `internal/research-duo-apis.md` |

---

*End §00. If a paragraph in later chapters cannot map to a path or demo second, delete it. If an agent cannot name its lane, it does not write.*
