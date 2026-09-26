# Win completeness bar — Bitrig Duo / YC-office short hacks

**For:** Nihar · Outer Lens Coach (FrostDuo cutover)  
**Event:** Bitrig Hacks: iPhone Duo · Sat Sep 26, 2026 · ~4h (11:30–3:30) · demos 3:30–5:00  
**Compiled:** Sat Sep 26, 2026 · primary Luma/Bitrig/Hsu/HackHQ verified this session; store dossiers for June Bitrig + sponsor patterns  
**Role:** How finished a winning entry must be — not a build plan.

---

## Verdict (one paragraph)

Winners at Bitrig and similar YC-office short hacks ship a **polished live vertical slice**, not an App Store–ready product. Hosts say so in plain language: *not* a complete end-to-end app; *real enough to demo*. For Duo, that means one Duo API climax you can see across the room, a YC-shaped one-liner, and (with Matt Berry in the room) a **real RevenueCat Test Store purchase** that unlocks on the other display — typically in a **~90s** demo across **~4–5 surfaces**, not a multi-feature product.

---

## 1. Full App Store app vs polished demo?

**Polished demos win. App Store–ready apps are not the bar.**

| Source | Exact bar |
|--------|-----------|
| **Bitrig Duo Luma** (this event) | “Entries do **not** need to be complete end-to-end apps. A **polished demo is enough**.” Goal: “something **newly possible** and make it **real enough to demo**.” ([Luma Duo](https://luma.com/yc-meetup-4378)) |
| **Kyle Macomber / Bitrig WWDC blog** (June event framing) | “The goal is **not** to build a **complete app**. The goal is to find something newly possible and make it real enough to demo.” ([Bitrig blog](https://bitrig.com/blog/join-us-at-wwdc26)) |
| **Bitrig WWDC outcome** | Hosts praised **“novelty and thoughtfulness”** and **advanced apps in ~3h** with Bitrig as accelerator — not ship-to-store completeness. ([Bitrig LinkedIn](https://www.linkedin.com/posts/bitrigapp_our-first-ever-bitrig-hacks-was-an-incredible-activity-7470707550108295169-tQCv); dossier: `internal/bitrig-past-winners.md`) |
| **YC Browser Use @ YC** (best published YC-office rubric) | Live demos required; Impact **40%** · Creativity 20% · Technical 20% · Demo **20%**; **4 minutes** + Q&A per team. ([HackHQ](https://hackhq.io/customers/browser-use-hackathon)) |
| **Reagan Hsu** (YC hack winner; Browser Use founding eng) | Hackathon projects are **proofs of concept** — end-to-end enough to demo; implementations need not be pretty. ([How to Win Hackathons](https://browser-use.com/posts/how-to-win-hackathons)) |

**What “polished” means here:** one killer flow that works live without apology — not five half-features, not slides, not a TestFlight ship.

**What it does *not* mean:** App Store Connect, ASO, onboarding funnels, account systems, production analytics, or multi-week Ship-a-ton completeness. Those contests (RevenueCat Shipaton) *do* require shipping to stores — that is a **different** bar from a 3–4h YC-office afternoon. ([sponsors-patterns](../internal/sponsors-patterns.md))

**UNKNOWN:** Official weighted Duo scorecard (none published). Use Browser Use 40/20/20/20 only as a rehearsal proxy. (`internal/yc-hackathon-criteria.md`)

---

## 2. Minimum viable completeness — 3–4h Bitrig Duo checklist

Freeze when every box is green. Anything else is cut.

### Must ship (hard)

- [ ] **Duo API in the climax** — hinge *effect* / ArrangementView / `CameraCaptureAccessory` visibly changes the UI; would not be as compelling on a normal iPhone. ([Luma What to Build](https://luma.com/yc-meetup-4378))
- [ ] **On-site code only** — design assets + RC dashboard OK ahead; no prewritten app. ([Luma Rules](https://luma.com/yc-meetup-4378))
- [ ] **Live demo path** — judges select from **live** demos; video-only is not the format. ([Luma Judging](https://luma.com/yc-meetup-4378))
- [ ] **One vertical slice frozen by ~hour one** — prove Duo API early; stop expanding. (Hsu: short demoable flow; June ~3h precedent)
- [ ] **Matter-of-fact YC sentence** — who / acute pain / why Duo *this week*. (Brad Flora anti-kabuki; GStack: treat like a YC application — `internal/yc-hackathon-criteria.md`)
- [ ] **Empty / denied / unavailable recoveries** so a flake does not brick the demo. (Outer Lens states in `internal/research-outer-lens.md`)
- [ ] **10–20 min rehearsal buffer** before 3:30. ([Hsu](https://browser-use.com/posts/how-to-win-hackathons))

### Strongly required if chasing Matt Berry / RC signal

- [ ] RevenueCat SDK live (`purchases-ios` ≥ **5.43.0**)
- [ ] RevenueCatUI paywall
- [ ] Test Store **Successful Purchase** → entitlement `pro` flips
- [ ] Unlock visible on the **other** Duo surface (not just a toast on the same pane)
- [ ] One free-vs-paid sentence for Matt

*(Organizer email / handoff: SDK required for RC prize; Luma lists RC sponsor + Matt Berry but **no separate RC prize bullet** — treat live purchase as judge signal either way. **UNKNOWN:** separate RC trophy.)*

### Optional / skip unless load-bearing

- [ ] On-device Foundation Models tip (June Wizard pattern — amp, not climax)
- [ ] OpenAI call landing on second surface
- [ ] Sentry breadcrumbs on hinge/paywall
- [ ] Supabase auth/sync
- [ ] Bitrig-primary build (only if Bitrig-built prize confirmed Sat AM — **UNKNOWN** on some Rules scrapes)

### Explicitly out of bar

App Store submission · ASC / Apple sandbox IAP · multi-user accounts · backend as product · five sponsor logos · architecture tour · pre-hack Swift.

---

## 3. Fake / stubbed vs must be real live

Rule from Hsu: mock **non-core** paths; mocking the **core** product path “really hurts” — judges can tell. ([How to Win](https://browser-use.com/posts/how-to-win-hackathons))

| Layer | Must be **real live** | OK to **stub / fake / skip** |
|-------|----------------------|------------------------------|
| **Duo climax** | Pose / CCA / ArrangementView response judges can see | Driving layout from hinge angle (wrong); StandBy / extensions (sim unsupported) |
| **Camera session (Outer Lens)** | Real `AVCaptureSession` + permission path when demoing capture | Fake “coaching” before session is live; Multipeer / second-phone remote |
| **Vision / pose ML** | — | Static tip fallback is the load-bearing path; vision is optional amp (`internal/research-outer-lens.md`) |
| **RevenueCat** | SDK + paywall + Test Store purchase → `CustomerInfo` / `pro` | Fake “Pro unlocked” button; ASC / Apple sandbox; StoreKit `.storekit` fight in 4h |
| **Pro unlock UX** | Other-pane feature actually changes after purchase | Extra Pro packs beyond one unlock beat |
| **OpenAI / cloud AI** | Only if it *is* the hard step | Skip entirely if on-device or static tips carry the story |
| **Supabase** | Only if sync/auth is the slice | Local / on-device state (default for Duo day) |
| **Sentry** | — | Optional init + one breadcrumb line; skip if time dies |
| **Onboarding / settings / gallery** | Minimal permission primer + deny→Settings | Full settings app, social feed, history, ASO |
| **Data feeds / catalogs** | — | Hardcoded tip packs, decoy wallpapers, mock “Busy until 4” bubbles |
| **Pitch slides** | — | Prefer live UI; Hsu allows short slides as aid — Duo format is live-first |

**Non-negotiable “real” for Outer Lens:** inner capture live → outer subject coach visible → Pro paywall → Test Store success → outer upgrades. Do not fake that chain.

---

## 4. How long is the demo / how many screens?

### Duration

| Event | Demo length (evidence) |
|-------|------------------------|
| **Bitrig Duo** | Schedule: demos **3:30–5:00** (90 min window for many teams). Per-team slot length **UNKNOWN** publicly. Rehearse **~90s** product path (store consensus from criteria + briefing). ([Luma schedule](https://luma.com/yc-meetup-4378), `docs/duo-research-briefing.md`) |
| **Browser Use @ YC** | **4 minutes** + questions. ([HackHQ](https://hackhq.io/customers/browser-use-hackathon)) |
| **Hsu general** | Keep the demoed user flow **as short as possible**; plan a **~2-minute** script; few words. ([How to Win](https://browser-use.com/posts/how-to-win-hackathons)) |

**Practical Duo target:** **60–90s** of live product + one closing who-pays line. Leave air if a beat stalls.

### Screen / surface count (typical winning slice)

Not a 12-screen app. YC-office short winners look like **one flow with a handful of surfaces**.

**Outer Lens — locked map** (`docs/design-direction.md`):

| Count | Surfaces |
|------:|----------|
| **4 core** | OL-A permission · OL-B capture (inner) · OL-C subject coach (outer) · OL-D paywall |
| **+1** | OL-E empty/error (must exist, may not appear in happy-path demo) |
| **Demo path** | Usually **3–4 visible beats**: grant → outer tip → Pro purchase → outer upgrade |

**FrostDuo cutover:** FD-A/B inner · FD-C outer decoy · FD-D paywall · optional FD-E — same **~4-surface** shape.

**June Wizard (best-documented Bitrig top entry):** multimodal intake → structured idea → swipe taste wall — still one product noun, not a platform. Exact screen count **UNKNOWN**. (`internal/bitrig-past-winners.md`)

---

## 5. RevenueCat / sponsor depth — real purchase vs logo?

**Real purchase. Logo salad loses.**

| Bar | Evidence |
|-----|----------|
| **Matt Berry (Partnerships, RevenueCat) judges this event** | Named on [Luma](https://luma.com/yc-meetup-4378) |
| **Operational rule** | Organizer email / handoff: must use **RevenueCat SDK** for RC prize path; Luma does **not** list a separate RC prize bullet → **UNKNOWN** if a distinct RC trophy exists; still ship the purchase for the judge in the room. (`docs/duo-research-briefing.md`, `internal/sponsors-patterns.md`) |
| **What “deep” means in 4h** | Test Store + RevenueCatUI → Successful Purchase → entitlement unlocks the **Duo-native** Pro surface on the **other** display. No ASC. (`internal/research-revenuecat.md`) |
| **Ship-a-ton / MeltingHack pattern** | Contests require SDK; paywall is the demo; gate the *value* feature (collab/AI), not chrome. Different event length — steal the *depth* pattern, not the “ship to store” requirement. (`internal/sponsors-patterns.md`) |
| **Kindred @ Moss** (YC-office overnight analog) | Host product in the **critical path** → overall + multiple sponsor tracks. Same lesson: depth ≫ stickers. (`internal/yc-hackathon-win-patterns-bitrig-duo.md`) |
| **Supabase / OpenAI / Sentry at Duo** | Credits for all / winners; **not** the climax. Use only if load-bearing. Deep Duo + RC beats five shallow logos. (`docs/duo-research-briefing.md`) |

**Matt sentence template:** “Free = outer preview + one tip; Pro = coaching overlays on the subject display.”

---

## 6. Outer Lens — MUST work in ~3–4h vs cut

Maps the completeness bar onto the locked concept (`internal/research-outer-lens.md`, `docs/design-direction.md`).

### MUST work (ship / demo these)

| # | Beat | Why it’s on the bar |
|---|------|---------------------|
| 1 | Camera permission primer → grant/deny | Empty/error hygiene; deny→Settings |
| 2 | Inner capture shell with **live** preview + shutter | Product is real, not a mock camera |
| 3 | **`CameraCaptureAccessory` outer coach** — preview + free tip line readable at 2–3 m | Duo climax; Kyle/Justin/Jane beat |
| 4 | Pro CTA → **RevenueCatUI** → Test Store Successful Purchase | Matt Berry / RC depth |
| 5 | Entitlement `pro` → **outer** tip upgrades (guide oval / Pro pack) | Other-pane proof; not same-screen toast |
| 6 | Accessory unavailable / session starting handled without bricking inner capture | Live reliability |
| 7 | Brad one-liner + who pays | Flora / YC interview prize shape |

**Hour budget discipline (from Outer Lens research):** ~45–60m CCA + session + outer preview · ~30–40m tips + RC · ~20–30m polish/states · 10–20m rehearsal.

### CUT hard (out of win bar)

| Cut | Why |
|-----|-----|
| Multipeer / Watch / second-phone remote | Not Duo; over-scope |
| Multicam grid, full lens rack, Moments social | Feature count ≠ novelty |
| Foundation Models / cloud tips as **load-bearing** | Optional amp after climax only |
| PrivacyScreen blur/vault as Outer Lens identity | That’s FrostDuo cutover product |
| ArrangementView gallery as a second product | Pose polish only if CCA already green late |
| Vision/pose ML required for tips | Static T1 is the bar; visionMiss → T1 |
| Supabase auth, multi-user, backend | Not required for slice |
| ASC / Apple sandbox IAP | Kills the clock |
| Accorduon-class hinge-as-whole-product | Crowded lane (`docs/luma-chat-intel.md`) |

### Hour-one cutover (still wins the completeness bar)

If CCA/session is **red by ~12:15** → flip to **FrostDuo**: inner frost + outer decoy + same RC other-pane unlock. Same completeness rules; different Duo climax. Do not invent a third product at lunch.

### 90s demo script (completeness = these seconds work)

1. One-liner (who / pain).  
2. Grant camera → inner preview live.  
3. Outer subject display: tip (“Chin up · fill the frame”).  
4. Pro → paywall → Test Store success → outer Pro overlay blooms.  
5. Who pays — stop talking.

---

## Evidence map (what this doc rests on)

| Claim family | Primary / store |
|--------------|-----------------|
| Polished demo ≠ complete app | [Luma Duo](https://luma.com/yc-meetup-4378), [Bitrig WWDC blog](https://bitrig.com/blog/join-us-at-wwdc26) — **verified this session** |
| Live demos / Impact weighting | [HackHQ Browser Use](https://hackhq.io/customers/browser-use-hackathon) — **verified** |
| Don’t mock the core path; short flow; rehearse | [Hsu — How to Win](https://browser-use.com/posts/how-to-win-hackathons) — **verified** |
| June Bitrig novelty + 3h demos | `internal/bitrig-past-winners.md` |
| Rubric / Flora / demo formula | `internal/yc-hackathon-criteria.md` |
| Sponsor depth / RC | `internal/sponsors-patterns.md`, `internal/research-revenuecat.md` |
| Cross-event win patterns (Moss/Kindred, GStack, Supabase) | `internal/yc-hackathon-win-patterns-bitrig-duo.md` |
| Outer Lens slice / screens | `internal/research-outer-lens.md`, `docs/design-direction.md` |
| Event logistics / collisions | `docs/luma-chat-intel.md`, `docs/duo-research-briefing.md` |

---

## UNKNOWN (do not invent)

- Official Duo / Bitrig **weighted** scorecard  
- Exact **per-team demo minutes** at Duo (only the 3:30–5:00 block is public)  
- Whether a **separate RevenueCat trophy** exists beyond Matt Berry judging + email SDK rule  
- Whether **Bitrig-built** prize sentence is live on all Rules pages Sat AM  
- Official June **1st-place project** identity (Prabaljit self-claim; project still unknown)  
- Exact screen counts for Wizard / other June entries  
- Whether all eight judges sit every demo or rotate  

---

## Bottom line for Saturday

Ship a **demo-grade product slice**: Duo climax real, RC purchase real, story clear, everything else cut. That is what hosts asked for and what short YC-office winners repeatedly look like — not an App Store submission.
