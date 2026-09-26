# §09 — RevenueCat Monetization

**Bible chapter:** `09-revenuecat-monetization.md`  
**Product:** Outer Lens (Film Tool) · cutover FrostDuo shares the same RC host  
**Event:** Bitrig Hacks: iPhone Duo · Sat Sep 26, 2026 · ~4h · YC SF  
**Lane:** **LANE-RC** (primary tool: Codex CLI or Cursor+GPT; backup: Claude Code + Sonnet)  
**Owns:** `DuoApp/Monetization/**`, `DuoApp/Features/Paywall/**`  
**Consumes (human-only):** `DuoApp/docs-runtime/RC-IDs.md`  
**Path lock:** Same file as bible shorthand `docs-runtime/RC-IDs.md` (relative to `DuoApp/` root). Do not create a second RC-IDs at the agent-store root.  
**Produces:** `EntitlementState.isPro` · paywall entry · `GATE-RC.md`  
**Ingest:** `internal/research-revenuecat.md` · win bar · multi-AI routing · single-theme contract  
**Constraint:** Spec / paste recipes only. **No Saturday app sources in this store.** **Never invent real API keys or dashboard IDs.**

---

## 9.0 Verdict (one page)

For Outer Lens, RevenueCat is not a logo. It is the **Matt Berry / sponsor-depth climax**: free outer tip stays free; Pro coaching overlays (or Frost vault decoy C) unlock on the **other Duo pane** after a live **Test Store Successful Purchase**.

| Lock | Value |
|------|-------|
| Store channel Saturday | **RevenueCat Test Store** only (`test_` key) |
| SDK floor | `purchases-ios` / `purchases-ios-spm` **≥ 5.43.0** |
| Products on target | **`RevenueCat`** + **`RevenueCatUI`** |
| Entitlement id | Human pastes into `RC-IDs.md` (expected: `pro`) — never invent |
| Paywall path | **RevenueCatUI** (`PaywallView` / contextual sheet) — freemium, **inner only** |
| Unlock surface | **Other pane** via shared `EntitlementState` observers |
| Out of bar | App Store Connect · Apple sandbox IDs · StoreKit `.storekit` scheme files · shipping `test_` in Release |

**Win-bar mapping** (`docs/win-completeness-bar.md`): RC must be real live — SDK + paywall + Test Store purchase → `CustomerInfo` / entitlement active → **other-pane feature change**. Fake “Pro unlocked” buttons fail the bar. ASC/sandbox fights are explicitly out of bar for a 4h hack.

**Theme-contract mapping** (`docs/bible-single-theme-contract.md`): Milestone **M5** (35 min) + **M6** integrate (15 min). Screens **SCR-OL-D** / **SCR-FD-D** = `Features/Paywall/PaywallHostView.swift`. Paywall **never** on the outer. Demo seconds **0:50–1:20**.

**Routing mapping** (`docs/multi-ai-build-routing.md`): Lane 5 owns monetization paths only. If `RC-IDs.md` still contains placeholders → **BLOCKED**; show Nihar the exact prompt in §9.2; **stop**; do not invent IDs.

Every paragraph below maps to a **file path**, a **demo second**, a **TC-RC-*** id, or a **HUMAN dashboard click**. If it cannot, delete it.

---

## 9.1 HUMAN GATE — dashboard before Saturday (tomorrow / pre-doors)

**Who:** Nihar only. **No Xcode. No Swift. No AI inventing keys.**  
**Done when:** `DuoApp/docs-runtime/RC-IDs.md` has **no** `PLACEHOLDER_*` strings and every row below is checked.

### 9.1.1 Placeholder tokens (paste these into `RC-IDs.md` until real values exist)

| Token | Meaning | Expected shape when filled |
|-------|---------|----------------------------|
| `PLACEHOLDER_RC_API_KEY` | Test Store public SDK key | Starts with `test_` |
| `PLACEHOLDER_RC_ENTITLEMENT_ID` | Entitlement identifier string used in code | Must become exact string `pro` (case-sensitive) |
| `PLACEHOLDER_RC_PRODUCT_ID` | Test Store product identifier | Human dashboard id (immutable after create) |
| `PLACEHOLDER_RC_OFFERING_ID` | Current / default offering identifier | Immutable after create; whatever you named it |
| `PLACEHOLDER_RC_PACKAGE_ID` | Package identifier inside that offering | e.g. `$rc_monthly` or custom package id |
| `PLACEHOLDER_RC_PAYWALL_ATTACHED` | Offering has published paywall | `true` / `false` (human) |

**Canonical namespace:** all tokens are `PLACEHOLDER_RC_*` per §00. Do not invent alternate names (`PLACEHOLDER_ENTITLEMENT_PRO`, bare `PLACEHOLDER_OFFERING_ID`, etc.).

**Rule:** AIs and Saturday recipes must reference these tokens or read from `RC-IDs.md`. **Never** fabricate a `test_…` string, never copy a key from memory, never “guess” offering names.

### 9.1.2 Click path — create / verify Test Store catalog

Do this once in [app.revenuecat.com](https://app.revenuecat.com). Stay inside the Duo / Outer Lens project for every step.

| # | Action | Exact dashboard path | Paste into `RC-IDs.md` | Done when |
|---|--------|----------------------|------------------------|-----------|
| H1 | Create / open project | Account → Project for Outer Lens / Duo | Project name (human note) | Left sidebar shows **Apps and providers**, **Product catalog**, **Project Settings** |
| H2 | Enable Test Store | **Apps and providers** → **Test configuration** → **Test Store** → Create / Enable | — | Test Store appears; a Test Store API key is shown |
| H3 | Copy Test Store API key | **Project Settings → API keys** (also shown at Test Store create) | Replace `PLACEHOLDER_RC_API_KEY` | Value starts with `test_`; stored in password manager / Notes — **not** a public gist |
| H4 | Create entitlement | **Product catalog → Entitlements → + New** → identifier | Replace `PLACEHOLDER_RC_ENTITLEMENT_ID` | Entitlement listed; identifier matches what code will read (must be `pro`) |
| H5 | Create ≥1 Test Store product | **Product catalog → Products → + New** → store = **Test Store** → identifier + price/duration → Save | Replace `PLACEHOLDER_RC_PRODUCT_ID` | ≥1 Test Store product exists. **Identifiers / duration / price cannot be edited after save** — create a new product if wrong |
| H6 | Attach product → entitlement | Open entitlement → **Attach** → select Test Store product | — | Product listed under the entitlement |
| H7 | Create offering + package | **Product catalog → Offerings → + New** → add package → attach product(s) → set **Default / Current** | Replace `PLACEHOLDER_RC_OFFERING_ID` + `PLACEHOLDER_RC_PACKAGE_ID` | `getOfferings().current` will be non-nil Saturday |
| H8 | Attach RevenueCatUI paywall | Offering detail → Paywall Editor → template or blank → **publish** / assign to offering | Replace `PLACEHOLDER_RC_PAYWALL_ATTACHED` with `true` | Offering has a published paywall (not SDK fallback-only) |

### 9.1.3 Also confirm (still dashboard, still human)

- New projects often auto-provision a Test Store with sample products — **still** verify offering + entitlement attachment yourself.
- Optional: open Sandbox data view so Saturday transactions are visible.
- Screenshot: offering → packages → entitlement attachment → Current offering with paywall. Bring screenshot to venue.
- Clipboard / Notes: the real `test_` key for paste into `RC-IDs.md` on the build Mac.

### 9.1.4 Explicitly do **not** need before Saturday

| Skip | Why |
|------|-----|
| App Store Connect app | Test Store is RC-hosted |
| Paid Apps Agreement | Not needed for Test Store |
| Real `appl_` key wiring | DEBUG uses `test_` only |
| StoreKit Configuration `.storekit` file | Different channel; confuses demos |
| Sandbox Apple ID | Not required for Test Store |
| IAP capability for Test Store start | Docs: come back when connecting real App Store |

### 9.1.5 Bring-to-venue checklist (HUMAN)

- [ ] `PLACEHOLDER_RC_API_KEY` replaced with real `test_…` in `RC-IDs.md`
- [ ] `PLACEHOLDER_RC_ENTITLEMENT_ID` replaced with exact `pro`
- [ ] `PLACEHOLDER_RC_PRODUCT_ID` replaced
- [ ] `PLACEHOLDER_RC_OFFERING_ID` replaced
- [ ] `PLACEHOLDER_RC_PACKAGE_ID` replaced
- [ ] `PLACEHOLDER_RC_PAYWALL_ATTACHED` = `true`
- [ ] Current offering marked Default/Current
- [ ] Paywall published on that offering
- [ ] Product attached to entitlement
- [ ] Screenshot of catalog graph saved offline
- [ ] Key also in password manager (repo paste is DEBUG-only; still treat as sensitive)

**Gate name:** `HUMAN-RC-DASHBOARD`. Saturday LANE-RC may not start wiring real IDs until this gate is green.

---

## 9.2 Exact prompt text — AIs must show Nihar if placeholders remain

**Trigger:** Any of these substrings still appear in `DuoApp/docs-runtime/RC-IDs.md` **or** in configure/gate source after a human claimed they pasted:

- `PLACEHOLDER_RC_API_KEY`
- `PLACEHOLDER_RC_ENTITLEMENT_ID`
- `PLACEHOLDER_RC_PRODUCT_ID`
- `PLACEHOLDER_RC_OFFERING_ID`
- `PLACEHOLDER_RC_PACKAGE_ID`
- `PLACEHOLDER_RC_PAYWALL_ATTACHED` (if still `false` / placeholder — paywall publish gate)

**Required AI behavior:**

1. Set lane status **BLOCKED**.
2. Do **not** invent, hallucinate, or “temporarily” substitute keys/IDs.
3. Do **not** continue past configure stubs that still contain placeholders into a live purchase demo claim.
4. Print **exactly** the following message to Nihar (copy verbatim; do not paraphrase away the placeholders):

```text
BLOCKED — RevenueCat IDs still placeholders.

Nihar: paste real dashboard values into DuoApp/docs-runtime/RC-IDs.md before LANE-RC continues.

Replace ALL of:
  PLACEHOLDER_RC_API_KEY           → Test Store public key (must start with test_)
  PLACEHOLDER_RC_ENTITLEMENT_ID    → entitlement identifier (must be: pro)
  PLACEHOLDER_RC_PRODUCT_ID        → Test Store product identifier
  PLACEHOLDER_RC_OFFERING_ID       → Current/Default offering identifier
  PLACEHOLDER_RC_PACKAGE_ID        → package identifier on that offering
  PLACEHOLDER_RC_PAYWALL_ATTACHED  → true (after Paywall Editor publish)

Dashboard path (human only):
  Apps and providers → Test configuration → Test Store
  Project Settings → API keys
  Product catalog → Entitlements / Products / Offerings
  Offering → Paywall Editor → publish

I will not invent keys or offering IDs. Wire Monetization/ + Features/Paywall/ against RC-IDs.md only after placeholders are gone.
Mark GATE-RC.md = BLOCKED until you paste.
```

**Also paste this shorter sticky** into any chat / PR comment when blocked:

```text
RC BLOCKED: RC-IDs.md still has PLACEHOLDER_RC_* (API_KEY / ENTITLEMENT_ID / PRODUCT_ID / OFFERING_ID / PACKAGE_ID / PAYWALL_ATTACHED). Nihar must paste real Test Store values. AI must not invent keys.
```

**Allowed while blocked:** empty file stubs, `#if DEBUG` configure skeleton that **reads** the placeholder string from `RC-IDs.md` / a constants file **without claiming a successful purchase**, compile checks that do not require network, writing `GATE-RC.md` with `status: BLOCKED`.

**Forbidden while blocked:** inventing a `test_` key, switching to a fictional `appl_` key, hardcoding entitlement `"pro"` while `PLACEHOLDER_RC_ENTITLEMENT_ID` remains (unless `RC-IDs.md` explicitly says the human chose `pro` and removed the placeholder), claiming TC-RC-* pass, claiming Matt demo ready.

---

## 9.3 `RC-IDs.md` contract (human paste target)

**Path:** `DuoApp/docs-runtime/RC-IDs.md`  
**OWNER:** HUMAN (write) · LANE-RC (read) · all other lanes (read `EntitlementState` only — not this file’s secrets into UI)  
**FORBIDDEN_WRITERS:** every AI lane for inventing values

### 9.3.1 Required template (ship this stub in scaffold)

```markdown
# RC-IDs — HUMAN PASTE ONLY

Status: BLOCKED until every PLACEHOLDER_* is replaced.

| Field | Value |
|-------|-------|
| api_key | PLACEHOLDER_RC_API_KEY |
| entitlement_id | PLACEHOLDER_RC_ENTITLEMENT_ID |
| product_id | PLACEHOLDER_RC_PRODUCT_ID |
| offering_id | PLACEHOLDER_RC_OFFERING_ID |
| package_id | PLACEHOLDER_RC_PACKAGE_ID |
| paywall_attached | PLACEHOLDER_RC_PAYWALL_ATTACHED |

Notes:
- api_key must start with test_ for Saturday DEBUG / Test Store.
- entitlement_id is case-sensitive; must become exact `pro`.
- product_id is the Test Store product (human note / diagnostics; RevenueCatUI uses Current offering).
- offering_id must be the Current/Default offering with a published paywall.
- paywall_attached must be `true` before claiming TC-R02 PASS.
- Do not commit real keys to a public remote if avoidable; venue paste OK for hackathon Debug.

Filled by: ________  Date: ________
```

### 9.3.2 Code consumption rule

Saturday, LANE-RC loads IDs **only** from this file (or a generated `Monetization/RCIdentifiers.swift` that is a mechanical transcription of this file). Prefer:

1. Human pastes into `RC-IDs.md`.
2. LANE-RC creates `Monetization/RCIdentifiers.swift` with the six `PLACEHOLDER_RC_*` string constants copied **literally**.
3. `PurchasesConfig.swift` and entitlement gate read those constants.

If transcription still contains `PLACEHOLDER_`, §9.2 fires.

### 9.3.3 Why six `PLACEHOLDER_RC_*` tokens (not one)

| Placeholder | Failure mode if wrong |
|-------------|----------------------|
| API key | Auth errors; no offerings; configure banner missing |
| Entitlement | Purchase “works” but UI stays locked (`Pro` ≠ `pro`) |
| Product | Dashboard attach / Matt talk-track mismatch; diagnostics only for RevenueCatUI path |
| Offering | `offerings.current == nil` or wrong packages |
| Package | Custom purchase path targets wrong package; paywall may still work if Current offering is correct — still freeze for demo clarity |
| Paywall attached | Fallback-only template; TC-R02 visual quality / publish gate |

---

## 9.4 File tree freeze — Monetization + Paywall

Root: `DuoApp/`. Paths match single-theme contract §4. LANE-RC owns only the leaves marked below.

```text
DuoApp/
  Monetization/                              # LANE-RC
    PurchasesConfig.swift                    # configure once; DEBUG test_ only
    Entitlements.swift                       # EntitlementState publisher / observable (§07)
    RCIdentifiers.swift                      # REQUIRED mechanical copy of RC-IDs.md (no invention)
    OfferingsRepository.swift                # optional; getOfferings wrapper / GATE diagnostics
    PurchaseService.swift                    # optional custom purchase; prefer RevenueCatUI
  Features/
    Paywall/                                 # LANE-RC
      PaywallHostView.swift                  # SCR-OL-D / SCR-FD-D — inner only
  docs-runtime/
    RC-IDs.md                                # HUMAN write · PLACEHOLDER_RC_* only until paste
    GATE-RC.md                               # LANE-RC write
```
### 9.4.1 Leaf responsibilities

| Path | One-sentence responsibility | Consumes | Produces |
|------|----------------------------|----------|----------|
| `Monetization/PurchasesConfig.swift` | Call `Purchases.configure` once at launch under `#if DEBUG` with Test Store key from `RCIdentifiers` | `RCIdentifiers.apiKey` | Configured `Purchases.shared` |
| `Monetization/RCIdentifiers.swift` | Hold the four dashboard strings transcribed from `RC-IDs.md` | Human paste | Constants for configure + gate |
| `Monetization/Entitlements.swift` | Own `EntitlementState` (`isPro`) driven by `customerInfoStream` / entitlement id | `RCIdentifiers.entitlementId` | Observable `isPro` for other lanes |
| `Monetization/OfferingsRepository.swift` | Fetch `Offerings.current` / packages for diagnostics or custom UI | `Purchases.shared` | Packages / nil-current error |
| `Monetization/PurchaseService.swift` | Optional custom `purchase(package:)` — **do not** call while `PaywallView` is active | Package | Outcome enum; does **not** set `isPro` directly |
| `Features/Paywall/PaywallHostView.swift` | Present RevenueCatUI paywall on **inner** only; Pro CTA entry | Entitlement gate + offering | SCR-OL-D / SCR-FD-D |
| `docs-runtime/GATE-RC.md` | Pass/fail/blocked for RC lane | TC-RC-* | Integrator handoff |

### 9.4.2 Must NOT create / touch

| Forbidden | Why |
|-----------|-----|
| `Features/Capture/**`, `Features/CoachOverlay/**` | LANE-CCA observes `EntitlementState` only |
| `Features/Frost/**` | LANE-FROST observes only |
| `Duo/PoseRouter.swift` | Shell lane |
| Paywall SwiftUI hosted as `.sceneAccessory` / outer CCA content | Contract: paywall **inner only** |
| Second entitlement beyond the one in `RC-IDs.md` | Scope |
| StoreKit `.storekit` file in the scheme | Wrong testing channel |
| Hardcoded fake `isPro = true` demo toggles in Release path | Win-bar violation |

### 9.4.3 Shared type (Integrator owns file; RC defines runtime behavior)

`Shared/Types.swift` (**§07 is canonical**). LANE-RC must **not** invent a parallel `EntitlementState`. Use this shape exactly:

```swift
/// Owned writer at runtime: Monetization/Entitlements.swift (LANE-RC).
/// Readers: Features/CoachOverlay/**, Features/Frost/**, Integrator demo hooks.
struct EntitlementState: Equatable, Sendable {
    var status: EntitlementStatus
    var entitlementID: String   // from RCIdentifiers — must become "pro"
    var isPro: Bool { status == .active }
    var lastError: String?
}

enum EntitlementStatus: Equatable, Sendable {
    case unknown
    case loading
    case inactive
    case active
    case error
}
```

Exact storage (`ObservableObject`, `@Observable`, `AsyncStream` bridge) is Saturday implementation detail — contract is: **one writer, many observers, other-pane unlock**, status machine per §07.7.

---

## 9.5 LANE-RC ownership card (paste into agent session)

```text
You are LANE-RC for Duo Sat build.
Read bible §00 invariants, then §09 (this chapter) only for monetization.
Owned paths: DuoApp/Monetization/**, DuoApp/Features/Paywall/**, DuoApp/docs-runtime/GATE-RC.md
Forbidden: Duo/, Features/Capture, Features/CoachOverlay, Features/Frost, DesignSystem rewrite, inventing RC IDs.
Consume: DuoApp/docs-runtime/RC-IDs.md (human). If any PLACEHOLDER_* remains, print §09 §9.2 BLOCKED text verbatim and stop inventing.
Produce: EntitlementState (§07 status machine → isPro), PaywallHostView (inner), GATE-RC.md.
SDK: purchases-ios-spm ≥ 5.43.0 products RevenueCat + RevenueCatUI; Test Store only; #if DEBUG test_ key.
Unlock: other pane observes EntitlementState — you do not layout Capture/Coach/Frost views.
Done when TC-R01…TC-R05 (§15 Always suite) PASS (or documented waivers) and GATE-RC.md = PASS.
TC-RC-01…12 are lane diagnostics aliased to TC-R* in §9.16.3 — do not invent a third numbering scheme or block Integrator on TC-RC-13…18.
```

**Primary tool:** Codex CLI or Cursor+GPT. **Backup:** Claude Code + Sonnet. **Hard avoid:** pose router, CCA, inventing dashboard IDs.

**Parallel OK after M2:** LANE-RC ∥ LANE-CCA (or FROST if cutover) ∥ COPY/ASSETS. Max three coding writers.

---

## 9.6 SPM pins

### 9.6.1 Package URL (preferred)

```text
https://github.com/RevenueCat/purchases-ios-spm.git
```

Docs recommend the **`-spm` mirror** for faster resolve. Alternate (older docs / same products):

```text
https://github.com/RevenueCat/purchases-ios.git
```

Prefer **`-spm`**. Do not add both.

### 9.6.2 Version floor

| Constraint | Min | Pin recommendation |
|------------|-----|--------------------|
| Test Store support | **5.43.0** | Up to Next Major from `5.43.0`, or Exact latest 5.x (≥5.43) |
| RevenueCatUI paywalls | 5.16+ / 5.27.1+ cited in docs | Same pin as SDK — always ship UI product with core |
| Research-time latest | 5.91.0 (2026-09-23) | Acceptable Exact pin if resolve is flaky |

**Hard rule:** Do **not** land below **5.43.0**. Test Store products will not work.

### 9.6.3 Products to add to the app target

When “Choose Package Products” appears, add **both**:

1. `RevenueCat`
2. `RevenueCatUI`

Scaffold may add SPM stubs early; LANE-RC verifies both link to the app target before configure.

### 9.6.4 Platform floors

| Surface | Floor |
|---------|-------|
| RevenueCatUI `PaywallView` | **iOS 15.0+** |
| Duo / Xcode 27.1 template | Set deployment target ≥ iOS 15 if using RevenueCatUI (UNKNOWN exact Duo template default — raise if lower) |

### 9.6.5 Xcode clicks (Saturday, after HUMAN gate)

1. File → Add Package Dependencies…
2. Paste `https://github.com/RevenueCat/purchases-ios-spm.git`
3. Dependency Rule: **Up to Next Major Version** from `5.43.0` (or Exact `5.91.0` / latest ≥5.43)
4. Add products `RevenueCat` + `RevenueCatUI` to **DuoApp** target
5. Confirm scheme has **StoreKit Configuration = None**

### 9.6.6 Capability note

For Test Store only: App Store IAP capability is **not** required to start. Do not burn clock on ASC wiring Saturday.

---

## 9.7 Configure (`PurchasesConfig.swift`)

**Path:** `DuoApp/Monetization/PurchasesConfig.swift`  
**Called from:** `DuoApp/App/DuoAppApp.swift` init (SHELL owns the App file; RC owns the configure helper SHELL calls once — Integrator wires the one-liner if needed).

### 9.7.1 Rules

1. Configure **once**, early, before any `Purchases.shared` use.
2. Saturday DEMO builds: **DEBUG + Test Store key only**.
3. Never put `PLACEHOLDER_RC_API_KEY` into a path that claims TC pass.
4. Never ship `test_` in Release — SDK **logs, alerts, then force-crashes** on purpose if a Test Store key is used outside Debug (and TestFlight is Release-compiled).
5. Prefer SPM **source** (`purchases-ios-spm`), not a prebuilt Release XCFramework, when using Test Store.

### 9.7.2 Recipe — `#if DEBUG` (hackathon-sufficient)

```swift
import RevenueCat
import Foundation

enum PurchasesConfig {
    static func configureIfNeeded() {
        guard Purchases.isConfigured == false else { return } // if API available; else call once from App.init only
        Purchases.logLevel = .debug
        #if DEBUG
        let key = RCIdentifiers.apiKey
        precondition(!key.contains("PLACEHOLDER"), "RC BLOCKED: paste RC-IDs.md — see bible §09 §9.2")
        Purchases.configure(withAPIKey: key)
        #else
        // Saturday: do not demo Release with Test Store.
        // Production appl_ key is OUT OF BAR for the hackathon slice.
        assertionFailure("Release configure not used in Duo hackathon demo path")
        #endif
    }
}
```

`RCIdentifiers.apiKey` must be the transcribed `PLACEHOLDER_RC_API_KEY` replacement (real `test_…`).

### 9.7.3 Optional hardening (xcconfig) — only if time after green path

Pattern from RC Test Store iOS codelab: `Debug.xcconfig` → `REVENUECAT_API_KEY = test_…` → Info.plist `$(REVENUECAT_API_KEY)`. For a 4h hack, `#if DEBUG` + constants file is enough **if** the key never leaves the Debug branch.

### 9.7.4 App entry wiring (SHELL / Integrator one-liner)

```swift
@main
struct DuoAppApp: App {
    init() {
        PurchasesConfig.configureIfNeeded()
    }
    var body: some Scene {
        WindowGroup { RootArrangementView() }
    }
}
```

LANE-RC does not own `DuoAppApp.swift` after scaffold lock — request Integrator to add the one call if missing.

### 9.7.5 Verify configure

Xcode console should show a Purchases configured banner (skill/docs: look for Purchases configured / INFO logs). Wrong key → auth errors on first `getOfferings`. No logs → configure not running or log level not debug.

**Maps to:** TC-RC-01, TC-R01.

---

## 9.8 Offerings

**Path:** `DuoApp/Monetization/OfferingsRepository.swift` (optional but useful for GATE diagnostics).

### 9.8.1 Fetch current packages

```swift
import RevenueCat

enum OfferingsRepository {
    static func currentPackages() async throws -> [Package] {
        let offerings = try await Purchases.shared.getOfferings()
        guard let current = offerings.current else { return [] }
        return current.availablePackages
    }

    static func assertCurrentOfferingMatchesDashboard() async throws {
        let offerings = try await Purchases.shared.getOfferings()
        guard let current = offerings.current else {
            throw OfferingsError.currentNil
        }
        // Compare to RCIdentifiers.offeringId when non-placeholder
        let expected = RCIdentifiers.offeringId
        precondition(!expected.contains("PLACEHOLDER"), "RC BLOCKED §9.2")
        // Offering.identifier should match human paste when Current is set correctly
        if current.identifier != expected {
            // Log loud — dashboard Current offering mismatch
            print("GATE-RC WARN: current.identifier=\(current.identifier) expected=\(expected)")
        }
    }
}

enum OfferingsError: Error {
    case currentNil
}
```

### 9.8.2 If `offerings.current == nil`

Human dashboard fix (not AI invention):

1. Offering exists?
2. Marked **Default / Current**?
3. Packages attached with Test Store products?
4. SDK ≥ 5.43 and `test_` key?

### 9.8.3 Package id

`PLACEHOLDER_RC_PACKAGE_ID` is for demo clarity and optional custom purchase path. **RevenueCatUI `PaywallView()`** loads Current offering packages itself — still keep package id filled so TC diagnostics and Matt talk track can name the product.

**Maps to:** TC-RC-02.

---

## 9.9 Purchase (custom path — optional)

**Preferred Saturday path:** RevenueCatUI owns purchase (§9.11). Custom `purchase(package:)` is **backup / diagnostic only**.

**Hard footgun:** Do **not** call `Purchases.shared.purchase(package:)` while also showing `PaywallView` — double-charge risk.

### 9.9.1 Async purchase recipe (if custom UI ever needed)

```swift
import RevenueCat

enum PurchaseOutcome {
    case purchased
    case cancelled
    case failed(Error)
}

enum PurchaseService {
    static func buy(_ package: Package) async -> PurchaseOutcome {
        do {
            let result = try await Purchases.shared.purchase(package: package)
            if result.userCancelled { return .cancelled }
            // Do NOT set EntitlementState.isPro here — Entitlements.swift listens to customerInfoStream
            return .purchased
        } catch {
            let nsError = error as NSError
            if nsError.code == ErrorCode.purchaseCancelledError.rawValue {
                return .cancelled
            }
            return .failed(error)
        }
    }
}
```

### 9.9.2 Test Store modal outcomes

With Test Store, purchase presents RC’s modal — **not** the Apple sheet:

| Button | Expected app behavior |
|--------|----------------------|
| **Successful Purchase** | `CustomerInfo` updates; entitlement active; `isPro == true` |
| **Failed Purchase** | Error path; gate stays locked |
| **Cancel** | Cancelled path; gate stays locked; no error alert spam |

### 9.9.3 Restore

`restorePurchases` / `syncPurchases` are **not meaningfully supported** on Test Store (no Apple account ownership). For Saturday: demo **purchase → entitlement**, not restore-across-reinstall. A Restore button may exist on the dashboard paywall template — do not spend clock debugging restore on Test Store.

**Maps to:** TC-RC-03 (Success), TC-RC-04 (Cancel/Fail).

---

## 9.10 Entitlement gate (`Entitlements.swift`)

**Path:** `DuoApp/Monetization/Entitlements.swift`  
**Role:** **Only writer** of live `EntitlementState` for Pro.

### 9.10.1 Read once

```swift
import RevenueCat

func hasProEntitlement() async -> Bool {
    do {
        let info = try await Purchases.shared.customerInfo()
        let id = RCIdentifiers.entitlementId
        precondition(!id.contains("PLACEHOLDER"), "RC BLOCKED §9.2")
        return info.entitlements[id]?.isActive == true
        // equivalent: info.entitlements.active[id] != nil
    } catch {
        return false
    }
}
```

### 9.10.2 Reactive stream (preferred for Duo dual-pane)

```swift
import RevenueCat
import Observation // or Combine — match project Swift version

@MainActor
final class EntitlementsModel: ObservableObject {
    @Published private(set) var state = EntitlementState(
        status: .unknown,
        entitlementID: RCIdentifiers.entitlementId,
        lastError: nil
    )

    func start() {
        state = EntitlementState(status: .loading, entitlementID: RCIdentifiers.entitlementId, lastError: nil)
        Task {
            for await info in Purchases.shared.customerInfoStream {
                let id = RCIdentifiers.entitlementId
                precondition(!id.contains("PLACEHOLDER"), "RC BLOCKED §9.2")
                let unlocked = info.entitlements[id]?.isActive == true
                state = EntitlementState(
                    status: unlocked ? .active : .inactive,
                    entitlementID: id,
                    lastError: nil
                )
            }
        }
    }
}
```

Inject / environment-object this model from root (Integrator) so **both panes** observe the same instance.

### 9.10.3 Case sensitivity

Entitlement ids are **case-sensitive**. `Pro` ≠ `pro`. Dashboard + `RC-IDs.md` + code must match exactly. Contract expectation is `pro` once placeholder is replaced.

### 9.10.4 Product not attached

Purchase can succeed while UI stays locked if the Test Store product is not attached to the entitlement — human dashboard fix (H6).

**Maps to:** TC-RC-05, TC-RC-06.

---

## 9.11 RevenueCatUI paywall (`PaywallHostView.swift`)

**Path:** `DuoApp/Features/Paywall/PaywallHostView.swift`  
**SCR-ID:** **SCR-OL-D** (primary) · **SCR-FD-D** (cutover; same host)  
**Demo seconds:** **0:50–1:05** present · purchase closes into **1:05–1:20** unlock  
**Placement:** **Inner display only.** Never mount paywall on outer / CCA accessory.

### 9.11.1 Why RevenueCatUI (not custom) for Saturday

| Path | Use Saturday? |
|------|---------------|
| RevenueCatUI + dashboard paywall | **Yes — preferred** |
| Custom SwiftUI list + `purchase(package:)` | Only if UI paywall blocked; still Test Store |
| Hard paywall fullScreen on launch | **No** for Outer Lens freemium — free outer preview must work first |

### 9.11.2 Contextual sheet (matches freemium + Pro CTA on SCR-OL-B)

```swift
import SwiftUI
import RevenueCat
import RevenueCatUI

struct PaywallHostView: View {
    @Binding var isPresented: Bool

    var body: some View {
        PaywallView(displayCloseButton: true)
            .onPurchaseCompleted { customerInfo in
                // EntitlementsModel stream is source of truth; optional log:
                print("RC purchase completed: \(customerInfo.entitlements)")
                isPresented = false
            }
            .onRestoreCompleted { _ in
                // Test Store restore not meaningful — do not block demo on this
            }
    }
}
```

Present from **inner** capture / frost controls:

```swift
.sheet(isPresented: $showPaywall) {
    PaywallHostView(isPresented: $showPaywall)
}
```

`PaywallView()` loads `Offerings.current` + dashboard paywall. If you see the **default fallback** template, human must publish/attach paywall (H8).

### 9.11.3 `presentPaywallIfNeeded` — use carefully

Allowed form:

```swift
.someInnerRoot()
    .presentPaywallIfNeeded(
        requiredEntitlementIdentifier: RCIdentifiers.entitlementId,
        purchaseCompleted: { _ in },
        restoreCompleted: { _ in }
    )
```

**Docs footgun:** custom-logic samples that return `customerInfo.entitlements.active.keys.contains("pro")` while commenting “Returning true will present the paywall” can read **inverted**. Prefer **`requiredEntitlementIdentifier:`**. Do not copy custom-logic samples blindly.

For Outer Lens, prefer **CTA → sheet** so free outer preview is never blocked by an automatic hard paywall.

### 9.11.4 Close button / V2 templates

`displayCloseButton` affects original templates; V2 dashboard paywalls may render their own close affordance. Freemium demo needs a dismiss path for Cancel rehearsal (TC-RC-04).

### 9.11.5 Do not double-purchase

RevenueCatUI owns the purchase. No parallel `PurchaseService.buy` on the same interaction.

**Maps to:** TC-RC-07, TC-RC-08, TC-R02.

---

## 9.12 Other-pane unlock contract

This is the load-bearing sponsor beat. A same-screen toast that says “Pro!” **fails** the win bar.

### 9.12.1 Definition

| Term | Meaning for Duo Saturday |
|------|--------------------------|
| **Purchase pane** | **Inner** — where SCR-OL-D / SCR-FD-D paywall is presented |
| **Other pane** | The **outer** (or opposite) surface that changes when `EntitlementState.isPro` flips |
| **Unlock proof** | A visible feature change on the other pane within demo **1:05–1:20**, no narration required |

### 9.12.2 Outer Lens (CUTOVER.flag = false)

| Tier | Other pane (SCR-OL-C) | Gate |
|------|------------------------|------|
| Free | T1 tip line on subject coach | Always |
| Pro | T2 guide oval / Pro overlay pack | `EntitlementState.isPro == true` |

**Writer of overlay layout:** LANE-CCA (`Features/CoachOverlay/GuideOvalView.swift` etc.).  
**Writer of `isPro`:** LANE-RC.  
**CCA must not** configure Purchases or invent entitlements.

### 9.12.3 FrostDuo cutover (CUTOVER.flag = true)

| Tier | Other pane (SCR-FD-C) | Gate |
|------|------------------------|------|
| Free | Decoy packs A/B | Always when locked |
| Pro | Vault decoy C | `EntitlementState.isPro == true` |

**Writer of decoy layout:** LANE-FROST. **Same** `EntitlementState` from RC.

### 9.12.4 Integration rule (M6)

```text
LANE-RC publishes EntitlementState.isPro
        │
        ▼
INTEGRATOR ensures single observed instance across panes
        │
        ├─► CoachOverlay reads isPro → show/hide T2 (Outer Lens)
        └─► OuterDecoyStageView reads isPro → allow pack C (Frost)
```

RC does **not** import Capture/Coach/Frost view bodies. Features do **not** write `isPro`.

### 9.12.5 Anti-patterns (nack)

| Anti-pattern | Why banned |
|--------------|------------|
| Unlock toast only on inner | Judges can’t see Duo-native value |
| Paywall on outer | Theme contract kill list |
| Local `@State isPro = true` after purchase callback without CustomerInfo | Drift; restore/fail paths lie |
| Gating chrome (button color) instead of overlays/vault | Win bar: gate differentiated Duo surface |
| Second entitlement for “outer only” | Scope |

**Maps to:** TC-RC-09, TC-RC-10, TC-R04.

---

## 9.13 Demo beat (90s script — RC segment)

Full script owned by COPY / DEMO-SCRIPT; RC owns these seconds working.

| Time | Surface | What judges see | Owner |
|------|---------|-----------------|-------|
| 0:00–0:10 | Voice + SCR-OL-A | Brad one-liner; perm | COPY / CCA |
| 0:10–0:45 | SCR-OL-B / SCR-OL-C | Live capture + free outer T1 tip | CCA |
| **0:50–1:05** | **SCR-OL-D inner** | Pro CTA → RevenueCatUI paywall | **RC** |
| **1:05** | Test Store modal | Tap package → **Successful Purchase** | **RC** + human click |
| **1:05–1:20** | **SCR-OL-C outer** | T2 Pro overlay blooms (M3 motion) | CCA observes `isPro` |
| ~1:20 | Voice | Matt line: free tip / Pro overlays on outer | COPY |

**Frost cutover appendix:** same RC seconds; unlock = decoy C / vault on SCR-FD-C.

**Talk track (Matt):** “Free = outer preview + one tip; Pro = coaching overlays on the subject display.” Prove with Test Store — no App Store Connect.

**Maps to:** TC-RC-11, TC-P03 (COPY).

---

## 9.14 Saturday minute plan — RC lane only

Aligns with milestone M5 (35 min) inside the 3h coding slice. Orchestrator owns global clock.

| Order | Step | Path / artifact | Minutes (budget) |
|------:|------|-----------------|-----------------:|
| 1 | Confirm `RC-IDs.md` has zero `PLACEHOLDER_*` | else §9.2 BLOCKED | 2 |
| 2 | SPM `purchases-ios-spm` ≥5.43; products both linked | project | 5 |
| 3 | `RCIdentifiers.swift` transcription | `Monetization/` | 3 |
| 4 | `PurchasesConfig.configureIfNeeded` + App init call | Monetization + Integrator | 5 |
| 5 | `EntitlementsModel` + `customerInfoStream` | `Entitlements.swift` | 8 |
| 6 | `PaywallHostView` sheet from inner Pro CTA | `Features/Paywall/` | 7 |
| 7 | Rehearse Successful Purchase → other pane | device/sim | 3 |
| 8 | Rehearse Cancel / Failed once | — | 1 |
| 9 | Write `GATE-RC.md` | docs-runtime | 1 |

If blocked on step 1, do only stubs + GATE-RC BLOCKED; return clock to Orchestrator.

---

## 9.15 Pitfalls (Saturday)

### 9.15.1 Shipping / using `test_` wrong

- Release / non-DEBUG: SDK **force-crashes** with Test Store key.
- TestFlight = Release compile → `test_` crashes there too.
- Prebuilt **XCFramework** is Release-compiled → Test Store key can crash even in Debug app — prefer SPM source.
- `forceAllowTestStoreInReleaseBuilds` (≥5.89.0) is for internal never-shipped builds — **do not** use for App Store submission; out of hackathon bar anyway.

### 9.15.2 StoreKit Configuration confusion

| Mode | Saturday? |
|------|-----------|
| RevenueCat Test Store (`test_`) | **Yes** |
| StoreKit `.storekit` on scheme | **No** — leave **None** |
| Apple Sandbox + `appl_` | Overkill / out of bar |

Leaving a StoreKit Configuration selected while demoing Test Store confuses judges (Apple UI / empty restores).

### 9.15.3 Simulator vs Duo

Test Store works on simulator/CI. Duo outer / `CameraCaptureAccessory` may still need Duo sim/device — treat RC and Duo API as **independent** systems. RC green does not prove CCA.

### 9.15.4 Compressed renewals

Test Store subscription renewals are compressed (e.g. monthly → every ~5 min, max ~5 renewals). Entitlement may expire mid-afternoon — fine for demo; re-purchase if needed before judging.

### 9.15.5 Sandbox Testing Access

Dashboard settings can block who receives entitlements from test purchases. If purchase “works” but entitlement stays inactive, human checks dashboard access + product→entitlement attach.

### 9.15.6 Invented IDs

Scope-guard / Integrator **nack** any patch that introduces a non-`RC-IDs.md` key or offering string. Cite this chapter §9.2–§9.3.

---

## 9.16 Acceptance tests — **TC-RC-*** suite

Run on Duo sim or device with DEBUG + Test Store. Record results in `docs-runtime/GATE-RC.md` and roll into `DEMO-LAST-PASS.md`.

### 9.16.1 Core suite (must)

| ID | Assertion | Evidence / path | Demo sec |
|----|-----------|-----------------|----------|
| **TC-RC-01** | `Purchases.configure` runs once in DEBUG with key from `RC-IDs.md` that starts with `test_` and contains **no** `PLACEHOLDER_` | `Monetization/PurchasesConfig.swift` · console banner | — |
| **TC-RC-02** | `getOfferings().current` is non-nil; packages available | `OfferingsRepository` / logs · offering id matches paste | — |
| **TC-RC-03** | Test Store **Successful Purchase** yields active entitlement for `RCIdentifiers.entitlementId` | Live modal · `CustomerInfo` | 1:05 |
| **TC-RC-04** | **Cancel** and **Failed Purchase** leave `isPro == false` and Pro UI hidden | Rehearse once each | — |
| **TC-RC-05** | `EntitlementState.isPro` tracks `customerInfoStream` (not a one-shot local bool) | `Monetization/Entitlements.swift` | — |
| **TC-RC-06** | Entitlement id string equals human paste (case-sensitive) | `RC-IDs.md` ↔ code | — |
| **TC-RC-07** | Paywall presents via RevenueCatUI on **inner** (`PaywallHostView`) | SCR-OL-D / SCR-FD-D | 0:50–1:05 |
| **TC-RC-08** | Paywall shows dashboard template (not only anonymous fallback) **or** waiver noting fallback still purchaseable | Visual | 0:50 |
| **TC-RC-09** | After Success, unlock is visible on the **other** pane (Outer Lens T2 or Frost decoy C) | SCR-OL-C / SCR-FD-C | **1:05–1:20** |
| **TC-RC-10** | LANE-RC did not edit Capture/Coach/Frost layout files to force unlock | Path review | — |
| **TC-RC-11** | Happy path fits demo window 0:50–1:20 without ASC login | Rehearsal | 0:50–1:20 |
| **TC-RC-12** | Zero `PLACEHOLDER_*` remain in `RC-IDs.md` and `RCIdentifiers.swift` at GATE pass | Grep | — |

### 9.16.2 Extended / diagnostic (do not block win if waived)

| ID | Assertion | Notes |
|----|-----------|-------|
| **TC-RC-13** | Scheme StoreKit Configuration = None | Avoid channel mix |
| **TC-RC-14** | SPM version ≥ 5.43.0; both products linked | Package.resolved |
| **TC-RC-15** | Dashboard Sandbox view shows the test transaction | Optional Matt flex |
| **TC-RC-16** | No `purchase(package:)` alongside active `PaywallView` purchase path | Code review |
| **TC-RC-17** | Release configuration does not embed `test_` key | Quick config sanity — do not Demo Release |
| **TC-RC-18** | `presentPaywallIfNeeded` not used with inverted custom logic | Prefer `requiredEntitlementIdentifier` or CTA sheet |

### 9.16.3 Crosswalk to theme-contract Always tests (AUTHORITATIVE)

**DECISION (Claude review P0):** Saturday gate / DoD / `DEMO-LAST-PASS.md` tick **§15 `TC-R01`–`TC-R05` only**. `TC-RC-*` are LANE-RC extended diagnostics that **feed** those five — never a second win-suite. Do not invent TC-OL / TC-RC / TC-R mixed rows as substitutes.

| §15 Always ID (gate) | Satisfied by granular | Notes |
|----------------------|----------------------|-------|
| **TC-R01** | TC-RC-01 (+ TC-RC-12) | configure with human `test_` · zero placeholders |
| **TC-R02** | TC-RC-07 (+ TC-RC-02, TC-RC-08) | paywall presents inner via RevenueCatUI |
| **TC-R03** | TC-RC-03 (+ TC-RC-06) | Successful Purchase → entitlement active |
| **TC-R04** | TC-RC-09 (+ TC-RC-05) | unlock visible on **other** pane |
| **TC-R05** | TC-RC-04 | Cancel/Fail keeps `isPro == false` |

Extended TC-RC-13…18 and §15 TC-R06+ may be waived in writing. GATE-RC status rows must name **TC-R01–R05**.

### 9.16.4 Related feature tests (not owned by RC, but RC must enable)

| ID | Assertion | RC dependency |
|----|-----------|---------------|
| TC-C04 | Pro guide follows `EntitlementState.isPro` | TC-RC-05 + TC-RC-09 |
| TC-F04 | Pro vault/decoy C gated by entitlement | Same |
| TC-P03 | Matt free-vs-Pro sentence | Demo after TC-RC-09 |

---

## 9.17 `GATE-RC.md` template

**Path:** `DuoApp/docs-runtime/GATE-RC.md`  
**Writer:** LANE-RC

```markdown
# GATE-RC

status: PASS | FAIL | BLOCKED
time_local:
spm_version:
api_key_prefix: test_ | OTHER | PLACEHOLDER
placeholders_remaining: none | LIST
tc_results:
  # Always (§15) — required for PASS
  TC-R01:
  TC-R02:
  TC-R03:
  TC-R04:
  TC-R05:
  # Extended diagnostics (optional)
  TC-RC-01:
  TC-RC-02:
  TC-RC-03:
  TC-RC-04:
  TC-RC-05:
  TC-RC-06:
  TC-RC-07:
  TC-RC-08:
  TC-RC-09:
  TC-RC-10:
  TC-RC-11:
  TC-RC-12:
notes:
blocked_message_shown_to_nihar: yes | no | n/a
```

Integrator merges RC before relying on Pro overlays (prefer **RC before CCA Pro overlays** so `EntitlementState` exists).

---

## 9.18 Integrator + conflict locks

| Hot file | Lock |
|----------|------|
| `Monetization/Entitlements.swift` / `EntitlementState` | **RC writes**; CCA/Frost **observe** only |
| `Features/Paywall/*` | **RC owns** structure; polish may restyle via DesignSystem APIs only |
| `docs-runtime/RC-IDs.md` | **Human pastes**; RC consumes |
| `App/DuoAppApp.swift` | Scaffold/Integrator adds configure call; RC does not drive-by rewrite root |
| `Package.resolved` / pbxproj SPM | Scaffold until GATE-SCAFFOLD; then Orchestrator/Integrator for target membership |

Merge window **B3** (blueprint): ~T+2:30 `sat/rc` → `sat/integrate` before Pro bloom polish.

---

## 9.19 Copy strings RC must not “improve”

Frozen elsewhere (COPY). RC surfaces may show dashboard paywall copy from RevenueCat editor — that is OK. In-app Pro CTA label should match COPY tables, e.g. unlock Pro coaching overlays — **do not** invent alternate brand nouns (PoseAgent, etc.).

Brad (Outer Lens): parents photographing kids… free outer preview, Pro pose overlays.  
Matt: free outer tip / Pro overlays on outer.

---

## 9.20 Kill list (RC-specific)

Banned in this chapter’s implementation notes and Saturday patches:

- Inventing `PLACEHOLDER_*` replacements
- ASC product creation as a Saturday dependency
- StoreKit Configuration file as the demo channel
- Paywall on outer / CCA
- Hard paywall that blocks free outer T1 before Pro CTA
- Fake Pro toggle for judges
- Auth, Supabase, server receipts, webhooks
- Second climax API bundled into paywall work
- Forking PrivacyScreen / SnapShield / Moments packages
- Using secret API keys in the client

---

## 9.21 UNKNOWN / do not invent

| Item | Status |
|------|--------|
| Whether a separate RevenueCat trophy exists beyond Matt judging | UNKNOWN — still ship live purchase |
| Exact Paywall Editor click labels (UI churn) | High-level H8; verify live Friday/pre-doors |
| Duo sim + Test Store odd interaction | Treat independent; no primary-source conflict found |
| Custom-logic `presentPaywallIfNeeded` sample polarity in docs | Prefer `requiredEntitlementIdentifier` |
| Exact Duo template default iOS deployment target | Raise to ≥15 if needed for RevenueCatUI |

---

## 9.22 Sources (chapter authority)

Primary research pack: `internal/research-revenuecat.md` (Sep 26, 2026).

Also:

- [RevenueCat Test Store](https://www.revenuecat.com/docs/test-and-launch/sandbox/test-store)
- [Configuring the SDK](https://www.revenuecat.com/docs/getting-started/configuring-sdk)
- [iOS installation](https://www.revenuecat.com/docs/getting-started/installation/ios)
- [Entitlements](https://www.revenuecat.com/docs/getting-started/entitlements)
- [Offerings / Products](https://www.revenuecat.com/docs/offerings/overview)
- [Displaying Products](https://www.revenuecat.com/docs/getting-started/displaying-products)
- [Making Purchases](https://www.revenuecat.com/docs/getting-started/making-purchases)
- [Customer Info](https://www.revenuecat.com/docs/customers/customer-info)
- [Paywalls](https://www.revenuecat.com/docs/tools/paywalls) · [Displaying Paywalls](https://www.revenuecat.com/docs/tools/paywalls/displaying-paywalls)
- [Freemium paywalls](https://www.revenuecat.com/docs/playbooks/guides/freemium)
- [purchases-ios 5.43.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.43.0) · [5.91.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.91.0)
- [Test Store iOS Codelab](https://revenuecat.github.io/codelabs/test-store-ios.html)
- Win bar: `docs/win-completeness-bar.md`
- Routing: `docs/multi-ai-build-routing.md`
- Theme contract: `docs/bible-single-theme-contract.md`
- Blueprint §09 / §18B LANE-RC: `docs/build-bible-blueprint.md`

Official skill recipes consulted in isolation (not installed into the project store): RevenueCat ai-toolkit `integrate-revenuecat`, `revenuecat-paywall`, `revenuecat-purchase-flow`, `revenuecat-testing-setup` — reconciled against Duo Test Store + placeholder rules above.

---

## 9.23 One-page cheat sheet (print)

```text
HUMAN (before Sat)
  Test Store → test_ key → entitlement → product attach → Current offering → publish paywall
  Fill RC-IDs.md: replace PLACEHOLDER_RC_API_KEY, PLACEHOLDER_RC_ENTITLEMENT_ID,
                  PLACEHOLDER_RC_OFFERING_ID, PLACEHOLDER_RC_PACKAGE_ID

AI if placeholders remain → print §9.2 BLOCKED text → STOP

SAT LANE-RC
  SPM purchases-ios-spm ≥5.43 → RevenueCat + RevenueCatUI
  PurchasesConfig #if DEBUG test_ from RCIdentifiers
  Entitlements.swift owns EntitlementState.isPro via customerInfoStream
  PaywallHostView (inner) → RevenueCatUI PaywallView
  Success → other pane Pro (T2 or decoy C)
  Cancel/Fail → stay locked
  GATE-RC.md + TC-RC-01…12

NEVER
  Invent keys · ASC fight · .storekit scheme · paywall on outer · fake isPro
```

---

## Appendix A — Full `RCIdentifiers` stub (placeholders only)

```swift
enum RCIdentifiers {
    static let apiKey = "PLACEHOLDER_RC_API_KEY"
    static let entitlementId = "PLACEHOLDER_RC_ENTITLEMENT_ID"
    static let productId = "PLACEHOLDER_RC_PRODUCT_ID"
    static let offeringId = "PLACEHOLDER_RC_OFFERING_ID"
    static let packageId = "PLACEHOLDER_RC_PACKAGE_ID"
    static let paywallAttached = "PLACEHOLDER_RC_PAYWALL_ATTACHED"
}
```

Replace values **only** by human transcription from `RC-IDs.md` (§00 token names). Shipping this stub unchanged must keep GATE-RC = BLOCKED (§9.2). After human fill: `entitlementId` must be exact `pro`; `paywallAttached` must be `true` before TC-R02 PASS.

---

## Appendix B — Inner Pro CTA wiring sketch (Integrator / CCA consumes)

LANE-RC exposes presentation; CCA owns the button on SCR-OL-B:

```swift
// Features/Capture/InnerCaptureView.swift — LANE-CCA
// Reads entitlements.isPro; presents paywall binding owned at root
Button("Unlock Pro coaching overlays") {
    showPaywall = true
}
.disabled(entitlements.state.isPro)
.sheet(isPresented: $showPaywall) {
    PaywallHostView(isPresented: $showPaywall) // LANE-RC view
}
```

Outer coach:

```swift
// Features/CoachOverlay/SubjectCoachView.swift — LANE-CCA
TipPlateView(style: .t1)
if entitlements.state.isPro {
    GuideOvalView() // T2 — other-pane unlock proof
}
```

---

## Appendix C — Frost cutover unlock sketch

```swift
// Features/Frost/OuterDecoyStageView.swift — LANE-FROST
// Pack C only when isPro
if entitlements.state.isPro {
    DecoyPackCView()
} else {
    DecoyPackAorBView()
}
```

Same `EntitlementsModel` instance. Same paywall host SCR-FD-D.

---

## Appendix D — Minute-by-minute rehearsal checklist (RC)

1. Cold launch DEBUG → configure banner → no placeholder precondition fire.  
2. Outer free tip visible without paywall.  
3. Inner Pro CTA → paywall sheet.  
4. Select package → Test Store → Successful Purchase.  
5. Sheet dismisses → outer Pro overlay visible ≤ ~5s.  
6. Kill app? Optional — not required. Prefer stream correctness over restore.  
7. Second run: Cancel path once → still locked.  
8. Dashboard Sandbox: transaction present (optional).  
9. Mark TC-RC-* in GATE-RC.  
10. Hand Integrator for M6 bloom motion M3.

---

## Appendix E — Scope-guard nack citations

When rejecting bad patches, cite:

- §9.2 invented keys / placeholders  
- §9.12 other-pane unlock required  
- §9.11.5 double purchase  
- §9.20 kill list  
- Theme contract §2B “Paywall on the outer”  
- Routing lane 5 “do not invent RC dashboard IDs”

---

## Appendix F — HUMAN dashboard deep walkthrough (tomorrow)

This appendix expands §9.1 into click-level narrative. Still **human-only**. AIs may read it to answer questions; they still must not invent `PLACEHOLDER_*` replacements.

### F.1 Project creation

1. Open the RevenueCat app host you use for this account (commonly `app.revenuecat.com` — exact login URL variants are UNKNOWN; use the host RevenueCat currently serves).
2. Create a project with a clear name such as `Outer Lens Duo` or `Bitrig Duo Outer Lens`.
3. Confirm the left sidebar exposes **Apps and providers**, **Product catalog**, and **Project Settings**.
4. Do not create a second project Saturday morning unless the first is irrecoverably wrong — catalog IDs are immutable for offerings once created.

### F.2 Test Store enablement

1. Sidebar → **Apps and providers**.
2. Find **Test configuration** (wording may churn; look for Test Store).
3. **Test Store** → Create / Enable.
4. Copy the presented API key immediately into a password manager.
5. Confirm later under **Project Settings → API keys** that a key with prefix `test_` exists.
6. Community pitfall: the `test_` key often does **not** appear under API keys until Test Store exists — if you cannot find it, re-check Test Store creation first, do not invent a key.

### F.3 Entitlement `PLACEHOLDER_RC_ENTITLEMENT_ID`

1. **Product catalog → Entitlements → + New entitlement**.
2. Identifier: type the string you will paste into `RC-IDs.md` (contract expects **`pro`** — lowercase).
3. Display name can be human-friendly (“Outer Lens Pro”); **code reads the identifier**, not the display name.
4. Save. Open the entitlement detail page and leave it ready for Attach in F.5.

### F.4 Test Store product

1. **Product catalog → Products → + New product**.
2. Store = **Test Store** (not App Store).
3. Choose a simple identifier such as `pro_monthly` or `pro_lifetime` — this is **not** `PLACEHOLDER_RC_PACKAGE_ID` (package ≠ product), but note it in your screenshot caption.
4. Set price/duration thoughtfully once — **cannot edit** after save on Test Store.
5. Suggested minimal catalog: **one** monthly or lifetime product attached to the Pro entitlement.

### F.5 Attach product → entitlement

1. Open entitlement detail for the identifier you will paste as `PLACEHOLDER_RC_ENTITLEMENT_ID` replacement.
2. **Attach** → select the Test Store product from F.4.
3. Confirm the product appears listed under the entitlement.
4. Failure mode if skipped: Test Store purchase succeeds, `CustomerInfo` updates, but `entitlements[id]?.isActive` stays false / missing → UI never unlocks.

### F.6 Offering + package (`PLACEHOLDER_RC_OFFERING_ID` / `PLACEHOLDER_RC_PACKAGE_ID`)

1. **Product catalog → Offerings → + New**.
2. Set Offering **Identifier** + Description. Identifier is immutable later — choose carefully (e.g. `default` or `outer_lens_pro`).
3. Paste that identifier into `RC-IDs.md` replacing `PLACEHOLDER_RC_OFFERING_ID`.
4. **+ Add package** → pick a duration/package identifier → attach the Test Store product.
5. Paste the package identifier into `RC-IDs.md` replacing `PLACEHOLDER_RC_PACKAGE_ID`.
6. Mark this offering **Default / Current**.
7. Alternate path (also valid): create Test Store products from the offering edit page — still end with Current offering + package + product→entitlement attach.

### F.7 Paywall Editor

1. Open the Current offering detail.
2. Create or assign a **Paywall** in the Paywall Editor (template or blank).
3. Include at least one package from the offering so the UI is not empty.
4. **Publish** / attach so RevenueCatUI does not fall back to the anonymous default-only template.
5. Screenshot the paywall preview for venue confidence.

### F.8 Fill `RC-IDs.md` on the build Mac

On the hackathon Mac (or the night before, if the file is private):

1. Open `DuoApp/docs-runtime/RC-IDs.md`.
2. Replace all `PLACEHOLDER_RC_*` tokens with the real dashboard strings.
3. Grep the file for `PLACEHOLDER_` — count must be **0**.
4. Set Status line to `READY` (human).
5. Do **not** ask an AI to “fill reasonable defaults.”

### F.9 Pre-doors verification script (5 minutes)

| Check | Pass |
|-------|------|
| `test_` key opens Project Settings → API keys | Visible |
| Entitlement identifier matches `RC-IDs.md` exactly | Match |
| Product listed under entitlement | Yes |
| Offering is Current | Yes |
| Package present on offering | Yes |
| Paywall published | Yes |
| `PLACEHOLDER_*` grep on `RC-IDs.md` | Zero hits |
| Screenshot offline | Saved |

If any row fails, HUMAN-RC-DASHBOARD stays red. LANE-RC stays BLOCKED per §9.2.

---

## Appendix G — Failure mode matrix (diagnose → owner)

| Symptom | Likely cause | Owner | Fix |
|---------|--------------|-------|-----|
| Configure precondition fires / BLOCKED prompt | Placeholders remain | Human | §9.2 + F.8 |
| No Purchases logs | Configure not called / log level not debug | RC / Integrator | App init one-liner |
| Auth errors on offerings | Wrong key / typo | Human | Re-copy `test_` |
| `offerings.current == nil` | Not Current / empty packages | Human | F.6 |
| Paywall fallback template only | Paywall not published | Human | F.7 |
| Purchase Success but UI locked | Product not attached to entitlement **or** id case mismatch | Human / RC check | F.5 + TC-RC-06 |
| Unlock only on inner toast | Other-pane observe missing | Integrator / CCA/Frost | §9.12 |
| Apple purchase sheet appears | StoreKit Configuration set / wrong key channel | RC | Scheme → None; use `test_` |
| Crash on launch with Test Store key | Running Release / TestFlight / XCFramework Release | RC | DEBUG + SPM source |
| Double charge / weird dual sheets | Custom `purchase` + PaywallView | RC | Remove custom path |
| Restore does nothing | Expected on Test Store | Demo | Do not demo restore |
| Entitlement expires mid-day | Compressed Test Store renewals | Demo | Re-purchase before judging |
| AI invented `test_abc…` | Violation | Scope guard | Nack; wipe; §9.2 |

---

## Appendix H — File-by-file Saturday implementation order

Execute in order. Do not skip to paywall UI before configure + identifiers.

### H.1 `docs-runtime/RC-IDs.md` (HUMAN)

Already filled. If not → stop.

### H.2 `Monetization/RCIdentifiers.swift`

1. Create enum with four `static let` strings.
2. Copy **literally** from `RC-IDs.md`.
3. Grep: no `PLACEHOLDER_` left **or** leave placeholders and accept BLOCKED (never invent).
4. OWNER comment at top: `OWNER: LANE-RC · SOURCE: docs-runtime/RC-IDs.md`.

### H.3 `Monetization/PurchasesConfig.swift`

1. Import `RevenueCat`.
2. `configureIfNeeded()` as in §9.7.2.
3. Precondition against `PLACEHOLDER` substring.
4. `#if DEBUG` only for Test Store key.

### H.4 App init hook

1. Integrator/SHELL: call `PurchasesConfig.configureIfNeeded()` from `DuoAppApp.init`.
2. RC verifies console banner (TC-RC-01).

### H.5 `Monetization/Entitlements.swift`

1. Create `EntitlementsModel` owning `@Published state: EntitlementState`.
2. Start `customerInfoStream` loop on appear / app launch.
3. Map `entitlements[RCIdentifiers.entitlementId]?.isActive`.
4. Expose via `EnvironmentObject` / `@Observable` injection from root.

### H.6 `Monetization/OfferingsRepository.swift` (optional)

1. Async `currentPackages()`.
2. Diagnostic assert for offering id mismatch (warn, don’t invent).

### H.7 `Features/Paywall/PaywallHostView.swift`

1. Import `RevenueCatUI`.
2. `PaywallView(displayCloseButton: true)` (+ purchase completed dismiss).
3. No outer placement.
4. No parallel `purchase(package:)`.

### H.8 Wire Pro CTA (CCA owns button; RC owns sheet content)

1. Binding `showPaywall` at a shared parent.
2. Inner button → sheet → `PaywallHostView`.
3. Confirm outer never presents sheet.

### H.9 Other-pane observe

1. Outer Lens: `GuideOvalView` gated by `isPro`.
2. Frost: decoy C gated by `isPro`.
3. Run TC-RC-09.

### H.10 `GATE-RC.md`

Fill template §9.17. Status PASS only if **TC-R01…TC-R05** (§15 Always suite) green (or written waivers). TC-RC-01…12 are diagnostic aliases (§9.16.3); TC-RC-13…18 extended never block GATE-RC PASS.

---

## Appendix I — EntitlementState contract (for §07 alignment)

### I.1 Canonical shape (§07 — do not invent a parallel struct)

```swift
struct EntitlementState: Equatable, Sendable {
    var status: EntitlementStatus
    var entitlementID: String   // from RCIdentifiers — must become "pro"
    var isPro: Bool { status == .active }
    var lastError: String?
}

enum EntitlementStatus: Equatable, Sendable {
    case unknown, loading, inactive, active, error
}
```

### I.2 Invariants

1. `entitlementID` always equals `RCIdentifiers.entitlementId` after configure (even when `isPro == false`).
2. `isPro` is true **only** when `status == .active` (RevenueCat reports entitlement active).
3. Feature lanes may read `isPro`; they must not set `status`.
4. Demo debug toggles, if any, must be `#if DEBUG` and **removed** before judging — prefer none.
5. When `CUTOVER.flag` flips, the same `EntitlementState` continues to drive Frost Pro surfaces — do not create `EntitlementStateFrost`.

### I.3 Threading

Update UI on MainActor. `customerInfoStream` callbacks must hop to main before publishing.

### I.4 Initial value

Start with `status: .unknown` then `.loading` until the first customer info event; treat as not-Pro for gating UI. Do not flash Pro chrome optimistically.

### I.5 Mapping to tip styles / decoys

| `isPro` | Outer Lens SCR-OL-C | FrostDuo SCR-FD-C |
|---------|---------------------|-------------------|
| `false` | T1 tip only | Decoy A/B |
| `true` | T1 + T2 guide oval | Decoy C / vault |

T3 countdown remains free polish if present — not an RC gate unless COPY freezes otherwise.

---

## Appendix J — Agent session openers (paste packs)

### J.1 LANE-RC cold start

```text
You are LANE-RC. Read bible chapter §09 RevenueCat Monetization end-to-end.
Owned: Monetization/**, Features/Paywall/**, docs-runtime/GATE-RC.md
First action: open docs-runtime/RC-IDs.md. If any PLACEHOLDER_RC_* remain (API_KEY / ENTITLEMENT_ID / PRODUCT_ID / OFFERING_ID / PACKAGE_ID / PAYWALL_ATTACHED), print the §9.2 BLOCKED message verbatim to Nihar and stop inventing IDs.
If READY: implement configure → EntitlementState (§07 status machine) stream → PaywallHostView (inner) → document TC-R01…R05 in GATE-RC.md (TC-RC-* optional diagnostics).
Unlock must appear on the other Duo pane via observers — do not edit Capture/Coach/Frost layouts except read-only EntitlementState.
SDK: purchases-ios-spm ≥5.43.0, products RevenueCat + RevenueCatUI, Test Store only.
```

### J.2 Scope guard reviewer

```text
Read-only. Nack any patch that invents RevenueCat API keys or offering/package/entitlement IDs not present in docs-runtime/RC-IDs.md after placeholder removal. Nack paywall on outer. Nack fake isPro. Nack StoreKit .storekit as the demo channel. Cite bible §09 §9.2, §9.12, §9.20.
```

### J.3 Integrator merge of sat/rc

```text
Merge sat/rc into sat/integrate. Ensure EntitlementsModel is a single shared instance visible to both panes. Confirm App.init calls PurchasesConfig.configureIfNeeded(). Run TC-RC-09 visually. Do not expand RC scope.
```

---

## Appendix K — Mapping to win completeness bar (checklist reprint)

From `docs/win-completeness-bar.md` — RC subset. Tick during GATE-RC.

- [ ] RevenueCat SDK live (`purchases-ios` ≥ **5.43.0**)
- [ ] RevenueCatUI paywall
- [ ] Test Store **Successful Purchase** → entitlement flips (`PLACEHOLDER_RC_ENTITLEMENT_ID` replacement active)
- [ ] Unlock visible on the **other** Duo surface
- [ ] One free-vs-paid sentence for Matt
- [ ] No fake Pro button
- [ ] No ASC / Apple sandbox dependency in the critical path

---

## Appendix L — Mapping to multi-AI routing (lane 5 reprint)

| Routing rule | §09 enforcement |
|--------------|-----------------|
| Owns `Monetization/`, `Features/Paywall/`, consumes `RC-IDs.md` | §9.4–§9.5 |
| If placeholders remain → BLOCKED | §9.2 exact text |
| Unlock other display via `EntitlementState` | §9.12 |
| Do not own Capture/Coach layout | §9.4.2 |
| Primary Codex/Cursor+GPT; backup Claude Sonnet | §9.5 |
| Parallel with CCA after shell | §9.14 |
| Human pastes IDs | §9.1 / Appendix F |

---

## Appendix M — Mapping to single-theme contract

| Contract item | §09 location |
|---------------|--------------|
| M5 RevenueCat 35 min | §9.14 |
| M6 integrate other-pane | §9.12 · §9.18 |
| Paths `Monetization/**`, `Features/Paywall/**` | §9.4 |
| SCR-OL-D / SCR-FD-D | §9.11 |
| Paywall never on outer | §9.11 · §9.20 |
| TC-R01…R05 | §9.16.3 crosswalk → TC-RC-* |
| Demo 0:50–1:20 | §9.13 |
| Free T1 / Pro T2 | §9.12.2 · Appendix I |

---

## Appendix N — What “~pages” means for this chapter

This chapter is written as a **load-bearing bible section**, not fluff. Target band **25–35 pages** when exported with the mega-bible’s default Markdown→PDF styling (body ~11pt, tables dense, code blocks kept). Authors integrating into the mega PDF should:

1. Keep all TC-RC tables and §9.2 verbatim prompt.
2. Prefer cutting Appendix J–N polish language before cutting §9.1–§9.17.
3. Never cut: HUMAN gate, BLOCKED prompt, SPM floor, other-pane contract, TC-RC-01…12, placeholder rule.

---

## Appendix O — Grep gates (run before claiming PASS)

Run on the DuoApp tree Saturday:

```bash
# Must be zero after human paste:
rg -n "PLACEHOLDER_RC_API_KEY|PLACEHOLDER_RC_ENTITLEMENT_ID|PLACEHOLDER_RC_OFFERING_ID|PLACEHOLDER_RC_PACKAGE_ID" \
  DuoApp/docs-runtime/RC-IDs.md DuoApp/Monetization || true

# Must not appear as invented secrets in source (allow the words test_ / appl_ only in comments explaining prefixes):
rg -n "apiKey\s*=\s*\"test_[A-Za-z0-9]" DuoApp/Monetization && echo "FAIL: hardcoded test key" || echo "OK"

# Paywall must not live under Coach outer paths:
rg -n "PaywallView|PaywallHostView" DuoApp/Features/CoachOverlay && echo "FAIL: paywall in coach" || echo "OK"

# Entitlement writes should be centralized:
rg -n "isPro\s*=" DuoApp/Features && echo "REVIEW: feature lane writing isPro?" || echo "OK"
```

Document outcomes in `GATE-RC.md` notes.

---

## Appendix P — Demo judge Q&A (RC only)

| Judge question | Answer |
|----------------|--------|
| Is this a real purchase? | Yes — RevenueCat Test Store updates `CustomerInfo` and dashboard Sandbox; not a mocked boolean. |
| Why not App Store Connect? | 4h bar is polished demo; Test Store is the supported fast channel (SDK ≥5.43). |
| Where is Pro value? | On the **other** display — overlays / vault — not a same-screen badge. |
| Can I restore? | Not meaningful on Test Store; we demo purchase→entitlement. |
| Free tier? | Outer tip / preview always works without paying. |

---

## Appendix Q — Cut list if RC clock dies

If M5 is slipping, cut in this order (keep other-pane Success path):

1. Cut OfferingsRepository diagnostics.
2. Cut custom `PurchaseService` entirely (keep RevenueCatUI only).
3. Cut TC-RC-13…18 extended.
4. Cut dashboard Sandbox flex during demo.
5. Cut restore button debugging.
6. **Never cut:** configure, entitlement stream, paywall present, Successful Purchase, other-pane unlock, Cancel once.

If HUMAN placeholders still present at T+RC start: do not steal CCA/Frost minutes inventing keys — escalate to Orchestrator / Nihar with §9.2 text.

---

*End §09 RevenueCat Monetization. Next consumers: §07 `EntitlementState` signature freeze · §11 SCR-OL-D · §12 SCR-FD-D · §17 global TC rollup · §18B LANE-RC card.*
