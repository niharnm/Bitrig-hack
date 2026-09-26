# §19 — Human prep (tonight / before doors)

**For:** Nihar · Bitrig Hacks iPhone Duo · Sat Sep 26, 2026 · YC SF  
**Role:** Everything **you** must finish before AI writers start — RC dashboard, Xcode 27.1, assets, paste packs  
**Rule:** Design assets + RC dashboard OK ahead of doors. **No Saturday app / Swift sources** until hacking starts (11:30).  
**Maps to:** `docs-runtime/RC-IDs.md` · GATE preflight · lane pastes from §18 · demo card from §16  
**Inputs:** `internal/research-revenuecat.md` · `docs/design-direction.md` · `docs/bible-single-theme-contract.md` · `docs/outer-lens-3h-build-plan.md` · `docs/bible/18-multi-ai-lane-cards.md` · `docs/bible/16-demo-script-90s.md` · `docs/bible/17-saturday-clock.md`  
**Compiled:** Sat Sep 26, 2026

---

## 0. Why this chapter exists

AIs will invent `test_` keys, Duo signatures, and tip copy if you leave gaps. Your job tonight/tomorrow morning is to remove those gaps **without writing the app**.

**Done for human prep** means: RC IDs real, Duo sim already cold-booted once, assets on disk, lane paste packs in Notes, Brad/Matt memorized, Frost decoys ready for cutover insurance.

---

## 1. Master checklist (tick in order)

### Tonight (or any time before doors)

- [ ] **H1** RevenueCat project + Test Store enabled  
- [ ] **H2** Entitlement `pro` created (exact string)  
- [ ] **H3** Test Store product + offering + package + paywall published  
- [ ] **H4** `test_` API key copied to password manager / private Notes (not public git)  
- [ ] **H5** Draft `RC-IDs.md` content ready to paste into `docs-runtime/` at venue  
- [ ] **H6** Tip strings on paper (3 free)  
- [ ] **H7** Frost decoy stills A/B/C exported (cutover insurance)  
- [ ] **H8** Brad + Matt lines memorized (Outer Lens; Frost variants known)  
- [ ] **H9** Print / Notes: §18 lane cards + §16 pocket card + §17 cheat sheet  
- [ ] **H10** Claude / Codex / Cursor accounts logged in; rate limits OK  
- [ ] **H11** Confirm theme lock: Outer Lens primary; Frost = flag only  
- [ ] **H12** Charger, dongle, battery ritual planned  

### Morning / pre-doors (10:30–11:30)

- [ ] **M1** macOS ≥ 26.6 confirmed  
- [ ] **M2** Xcode **27.1** selected; empty Duo target ⌘R already succeeded **earlier**  
- [ ] **M3** Duo simulator **first boot finished** (not starting cold at 11:30)  
- [ ] **M4** Wi‑Fi / venue network works; RC dashboard reachable  
- [ ] **M5** Paste `RC-IDs.md` into repo `docs-runtime/` (private)  
- [ ] **M6** Open three AI sessions max plan; paste §00 + cards ready  
- [ ] **M7** Pocket demo card in wallet / Notes widget  

---

## 2. RevenueCat dashboard — click-by-click

Source recipe: `internal/research-revenuecat.md`. Do this in browser only.

### 2.1 Project

1. Sign in at RevenueCat app host.  
2. Create / open project named clearly (**Outer Lens** or **Duo Sat**).  
3. Stay in that project for all steps.

### 2.2 Test Store + `test_` key

1. Sidebar → **Apps and providers**.  
2. **Test configuration** → **Test Store** → Create / Enable.  
3. Copy API key starting with **`test_`**.  
4. Re-find later: **Project Settings → API keys**.  
5. Store in password manager. **Never** paste into a public repo or Luma chat.

### 2.3 Entitlement

1. **Product catalog → Entitlements → + New**.  
2. Identifier: **`pro`** (case-sensitive — code will look up this exact id).  
3. Save.

### 2.4 Product (Test Store)

1. **Products → + New product**.  
2. Store = **Test Store**.  
3. Identifier example: `outerlens_pro_monthly` (immutable after save — pick carefully).  
4. Set price/duration; Save.  
5. If wrong later: create a **new** product and swap in the offering (cannot edit identity).

### 2.5 Offering + package + attach

1. **Offerings → + New** → set identifier + description.  
2. **+ Add package** → attach Test Store product.  
3. Mark offering **Default / Current**.  
4. Open entitlement `pro` → **Attach** product if not already.  
5. Confirm `getOfferings().current` will be non-nil (Current offering has package).

### 2.6 Paywall (RevenueCatUI)

1. On the Current offering → Paywall Editor → template or blank.  
2. **Publish** paywall on that offering.  
3. Screenshot offering → packages → `pro` attachment for venue reference.

### 2.7 What you do NOT need before Saturday

App Store Connect app · Paid Apps Agreement · `appl_` production key · StoreKit `.storekit` file · sandbox Apple ID · ASC IAP.

### 2.8 `docs-runtime/RC-IDs.md` template (fill real values)

Create at venue (or private machine). Prefer gitignore if repo is public.

```text
# HUMAN ONLY — do not invent in AI chats
# Replace every PLACEHOLDER_RC_* with dashboard values. Never invent test_ keys.
apiKey: PLACEHOLDER_RC_API_KEY
entitlementId: PLACEHOLDER_RC_ENTITLEMENT_ID
productId: PLACEHOLDER_RC_PRODUCT_ID
offeringId: PLACEHOLDER_RC_OFFERING_ID
packageId: PLACEHOLDER_RC_PACKAGE_ID
paywallAttached: PLACEHOLDER_RC_PAYWALL_ATTACHED
appUserIdStrategy: anonymous
dashboard_checked_at: <ISO time>
notes: Current offering set; product attached to entitlementId
```

**Placeholder tokens used in bible drafts until filled:**

| Token (§00 canonical) | Replace with |
|-------|----------------|
| `PLACEHOLDER_RC_API_KEY` | real `test_…` from dashboard |
| `PLACEHOLDER_RC_ENTITLEMENT_ID` | exact `pro` |
| `PLACEHOLDER_RC_PRODUCT_ID` | Test Store product id |
| `PLACEHOLDER_RC_OFFERING_ID` | offering id |
| `PLACEHOLDER_RC_PACKAGE_ID` | package id |
| `PLACEHOLDER_RC_PAYWALL_ATTACHED` | `true` when paywall published |

**DECISION (Claude review P0):** Use only `PLACEHOLDER_RC_*` from bible §00 §5.2. Never invent `test_` keys. Gate unlock = §15 TC-R01–R05.

**Rule for AIs:** If any `PLACEHOLDER_RC_*` remains → LANE-RC marks **BLOCKED** and stops. You paste IDs; they resume.

### 2.9 RC smoke (optional throwaway — still not the hack app)

If you want confidence: a **throwaway** sample configuring Test Store is OK **only if** it is not your submission binary and you do not reuse that project as the Saturday entry. Prefer dashboard completeness + Saturday configure.

---

## 3. Xcode 27.1 + Duo simulator

### 3.1 Toolchain

| Requirement | Evidence |
|-------------|----------|
| macOS **26.6+** | About This Mac |
| Xcode **27.1 beta** | [Apple downloads](https://developer.apple.com/download/applications/) → Xcode 27.1 beta (Jacob/Luma pointer) |
| `xcode-select` points at 27.1 | `xcodebuild -version` shows 27.1 |
| Duo SDK / sim runtime installed | Components / Platforms list includes Duo |

### 3.2 First-boot ritual (do BEFORE 11:30)

Duo sim first launch can take **many minutes**. Do this at home or at doors early:

1. Open Xcode 27.1.  
2. Create a **throwaway** empty app **or** open Apple sample — not your final submission if rules worry you; goal is sim warm.  
3. Run on **iPhone Duo** simulator.  
4. Confirm Device Hub / fold interaction reacts.  
5. Quit; leave sim installed.  
6. At 11:30 you only create the **real** DuoApp and ⌘R quickly.

### 3.3 Known quirks (do not debug as product)

| Quirk | Prep implication |
|-------|------------------|
| Slow first Simulator launch | Pre-boot |
| StandBy / many extensions unavailable in sim | Do not build demo on them |
| Sim ≠ camera accessory hardware | Ship Simulate tip / Pro / countdown |
| Entitlement keys for camera may be UNKNOWN until live SDK | Follow `research-duo-apis.md`; don’t invent |

### 3.4 Bring to venue

- Laptop + charger  
- Xcode already installed (venue Wi‑Fi for multi‑GB download is a trap)  
- Apple ID session valid for downloads if needed  
- Optional: Bitrig login if host-tool prize path matters (UNKNOWN — don’t bet the slice)

---

## 4. Assets (allowed before Saturday)

Assets ≠ app code. Prefer SF Symbols + solid colors if time dies.

### 4.1 Outer Lens (primary)

| Asset | Spec | Fallback |
|-------|------|----------|
| Brand wordmark feel | “Outer Lens” SF Pro Medium 13–15pt whisper | System text |
| Tip plate | Solid `#1C1C1E` + scrim — no glass | Code-drawn RoundedRectangle |
| Guide oval | Amber `#E8A838` stroke only | SwiftUI Ellipse stroke |
| Shutter | Solid ~80pt disc | Circle fill |
| Tip strings | See §5 — text only | Paper → Localizable Sat |

**Optional files (if you design ahead):**

```text
Assets/Tips/guide_oval.pdf          # T2 stroke art
Assets/Shared/brand_mark.pdf        # optional; text OK
```

### 4.2 FrostDuo cutover insurance (strongly recommended)

Even if you stay GREEN, export three stills:

| Pack | Content | File suggestion |
|------|---------|-----------------|
| **A Lock Lookalike** | Calm lock, large time, banal wallpaper | `Assets/Decoys/decoy_A_lock.png` |
| **B Busy Cover** | 2–3 innocuous bubbles; generic names; “Busy until 4” | `Assets/Decoys/decoy_B_busy.png` |
| **C Vault Cover** | Editorial frosted cover + quiet glyph | `Assets/Decoys/decoy_C_vault.png` |

**Do not:** invent cyber HUD, traffic-light threat banners, or Moments/PrivacyScreen forks.

### 4.3 Catalog partition (Saturday)

```text
Resources/Assets.xcassets/
  Coach/     # ASSETS lane
  Frost/     # ASSETS lane — decoys
  Shared/
```

---

## 5. Frozen copy to bring (paper + Notes)

### 5.1 Brad / Matt (Outer Lens)

**Brad:** Parents photographing kids can’t see framing or pose while they shoot — Duo’s outer is the subject coach; free outer preview, Pro pose overlays.

**Matt:** Free: outer preview. Pro: pose overlays on the outer display.

**Who pays:** Parents pay for the overlays that make the kid look good without turning the phone around. That’s Outer Lens.

### 5.2 Brad / Matt (Frost — cutover only)

**Brad:** Shoulder-surfers ruin private screens — Duo frosts the inner face and shows a decoy on the outer; Pro unlocks vault decoys.

**Matt:** Free: frost and a lock decoy. Pro: vault covers on the outer display.

### 5.3 Tip strings (≤8 words)

1. Chin up · eyes to the lens  
2. Fill the frame · step closer  
3. Soft smile · both faces in  

### 5.4 CCA flake line

Subject coach is CameraCaptureAccessory — the sim can’t always light the outer for camera. On device, the outer faces the kid.

### 5.5 Pocket 90s card

Copy from `docs/bible/16-demo-script-90s.md` §11 into Notes.

---

## 6. What to paste into each AI (Saturday morning)

Paste order every session: **(1) §00 invariants** → **(2) lane card** → **(3) chapter pointers**.

### 6.1 Universal first paste

Use either:

- Full text from `docs/bible/00-front-matter-agent-contract.md`, **or**  
- §00 block inside `docs/bible/18-multi-ai-lane-cards.md` §1  

Plus one sentence:

```text
Outer Lens Film Tool only. FrostDuo = CUTOVER.flag path only.
RC-IDs.md path: docs-runtime/RC-IDs.md (filled by human — do not invent keys).
Max 3 coding writers. Follow docs/bible/18-multi-ai-lane-cards.md for your lane.
```

### 6.2 Claude Code (Opus) — Duo-core then CCA

```text
[§00]
You are LANE-SHELL-DUOCORE until SHELL-READY.md exists, then LANE-CCA.
Own: PoseRouter / RootArrangementView first; then Features/Capture/** + CoachOverlay/** + CameraCaptureAccessoryHost.
Do not touch Monetization IDs or Features/Frost primary.
Read: bible/05-duo-api-inventory.md, bible/11-outer-lens-product.md, design-direction.md §2A §3A, research-outer-lens.md.
Done: TC-S02–S04 then TC-C01–C05 per lane card in 18-multi-ai-lane-cards.md §5–§6.
```

### 6.3 Codex CLI (or Cursor+GPT) — RC

```text
[§00]
You are LANE-RC.
Own ONLY Monetization/** and Features/Paywall/**.
Read docs-runtime/RC-IDs.md first — if placeholders remain, GATE-RC.md=BLOCKED and stop.
SDK ≥5.43 RevenueCat + RevenueCatUI Test Store; entitlement pro; other-pane unlock via EntitlementState.
Do not touch PoseRouter or Capture layout.
Done: TC-R01–R05 + GATE-RC.md. Card: 18-multi-ai-lane-cards.md §7.
```

### 6.4 Cursor Agent on Mac — scaffold / integrate / polish / optional Frost files

```text
[§00]
Morning: LANE-SHELL scaffold — GATE-SCAFFOLD.md. Card §4.
Mid: Integrator merges only; optional LANE-FROST files under Features/Frost/** if spare slot (card §8) — do not flip CUTOVER.flag.
Late: LANE-ASSETS polish (card §9) then assist LANE-QA.
Never fourth feature writer. Clock: bible/17-saturday-clock.md.
```

### 6.5 Optional Gemini / Claude.ai — ingest only

```text
Ingest the bible PDF/folder. Output: per-lane ownership table, SCR/TC index, BLOCKED/GAP list, hour-one cutover criteria verbatim.
Do not generate Swift. Do not expand beyond Outer Lens + Frost cutover.
```

### 6.6 Scope guard (Opus read-only)

Paste `18-multi-ai-lane-cards.md` §12 GUARD card. No write access.

### 6.7 Attach / @ list (minimum)

| Lane | Must see |
|------|----------|
| All | `00-front-matter-agent-contract.md`, `18-multi-ai-lane-cards.md` |
| SHELL | `06-repo-file-tree.md`, theme contract §4 |
| Duo-core | `05-duo-api-inventory.md`, `07-types-state-machines.md` |
| CCA | `11-outer-lens-product.md`, `13`/`design-direction`, `16` demo climax |
| RC | `09-revenuecat-monetization.md` or `internal/research-revenuecat.md`, `RC-IDs.md` |
| FROST | `12-frostduo-cutover.md` |
| QA | `15-acceptance-tests.md`, `16`, `17` |

---

## 7. Session layout (solo builder — recommended)

| Slot | Tool | Lane sequence |
|------|------|---------------|
| Mac Xcode | Cursor Agent | SHELL → INTEG → ASSETS → QA assist |
| Terminal A | Claude Code Opus | Duo-core → CCA |
| Terminal B | Codex CLI | RC (Frost stubs only if RED or spare) |
| Phone Notes | — | Brad/Matt, RC IDs, pocket script |
| Browser | RC dashboard | Fix offerings if GATE-RC fails |

**Two-AI fallback:** Cursor does scaffold+RC+polish; Claude does Duo-core+CCA. Drop live Frost until cutover.

---

## 8. Venue bag checklist

- [ ] Laptop + charger + backup battery  
- [ ] Xcode 27.1 already on disk  
- [ ] Headphones optional  
- [ ] Printed or offline Notes: Brad/Matt, tips, lane cards, 90s card, clock cheat  
- [ ] Password manager with `test_` key  
- [ ] Decoy PNGs on disk / AirDrop  
- [ ] Water / snack for 1:00 lunch-without-new-features  
- [ ] Know walk route to demo queue by 3:28  

---

## 9. Failure pre-briefs (decide now, not at 12:14)

| If this happens | You already decided |
|-----------------|---------------------|
| CCA red at 12:15 | Flip Frost; paste Frost Brad; promote FROST card; stop Capture feature work |
| RC-IDs missing at 1:45 | Paste IDs immediately or accept Simulate Pro + waiver in DEMO-LAST-PASS |
| Only two AI seats | Cursor+Claude plan above |
| Sim outer never lights | Simulate tip + honest CCA line — still ship |
| Tempted to add Vision/chat | Nack — kill list |

---

## 10. Definition of “human prep done”

All must be true before you feel entitled to start feature spam:

1. `RC-IDs.md` content ready with real `test_` + `pro` + offering/package/product.  
2. Xcode 27.1 + Duo sim proven with a prior ⌘R.  
3. Tip strings + Brad/Matt in Notes.  
4. Lane paste packs copied (Claude / Codex / Cursor).  
5. Frost decoys on disk **or** conscious accept of SF Symbol-only frost.  
6. Theme lock verbal: Outer Lens Film Tool; one climax.  

---

## 11. Night-before timeline (suggested)

| Local time | Action |
|------------|--------|
| T−12h | RC dashboard H1–H5 complete; screenshot offerings |
| T−10h | Export decoy A/B/C; tip strings in Notes |
| T−8h | Memorize Brad/Matt aloud ×5 |
| T−6h | Confirm Xcode 27.1 + Duo sim prior boot |
| T−4h | Copy lane paste packs into three Notes pages |
| T−2h | Charge laptop to 100%; pack bag §8 |
| T−1h | Re-open RC dashboard; still Current offering? |
| Doors 10:30 | Wi‑Fi; paste RC-IDs.md; warm sim; no feature code |
| 11:25 | Say climax sentence aloud; open AI sessions with §00 only |
| 11:30 | Scaffold starts |

---

## 12. RC dashboard verification screenshot list

Take these screenshots to Photos / AirDrop folder `Duo-RC-proof/`:

1. Test Store enabled under Apps and providers  
2. API keys page showing `test_` prefix (crop secret in shared slides)  
3. Entitlement `pro` detail with attached product  
4. Current offering with package  
5. Paywall editor showing Published  

At venue, if GATE-RC fails, open these before touching Swift.

---

## 13. “What NOT to do tonight”

| Temptation | Why not |
|------------|---------|
| Start DuoApp Swift sources | On-site code rule |
| Commit `test_` key to public git | Secret leak |
| Redesign Film Tool tokens | Already locked |
| Build Vision pose ML | Kill list / clock |
| Fork Moments / PrivacyScreen | Remix only |
| Write a second product bible | Theme contract |
| Depend on venue download of Xcode | Bandwidth trap |

---

## 14. Morning door script (10:30–11:30)

1. Sit; power on; join Wi‑Fi.  
2. Open Xcode 27.1; launch Duo sim (already warm).  
3. Create `docs-runtime/RC-IDs.md` from Notes.  
4. Open Cursor on Mac; Claude terminal; Codex terminal.  
5. Paste §00 into all three — **do not** start coding yet.  
6. At 11:30 sharp: paste SHELL card into Cursor; begin Block A.  
7. Keep Brad card visible on phone lock screen / Notes widget.

---

## 15. Cross-links

| Need | Doc |
|------|-----|
| Lane paste bodies | `docs/bible/18-multi-ai-lane-cards.md` |
| Clock / gates | `docs/bible/17-saturday-clock.md` |
| Demo seconds | `docs/bible/16-demo-script-90s.md` |
| RC deep recipe | `internal/research-revenuecat.md` |
| Tokens / decoys | `docs/design-direction.md` |
| Win bar | `docs/win-completeness-bar.md` |
| Agent contract | `docs/bible/00-front-matter-agent-contract.md` |

---

*End §19. Dashboard + toolchain + paste packs. AIs don’t invent secrets. You do the boring prep so Saturday is only the slice.*
