# RevenueCat — Outer Lens Pro (soft-fallback)

## Decision (2026-09-26)

- **Entitlement:** unlock only on `pro` (never `photon_pro` or other dashboard aliases).
- **Primary purchase surface:** `PaywallView` on the inner display (`PaywallHostView`).
- **Settings fallback:** when `Purchases.isConfigured`, inner capture settings expose Customer Center, restore, and lifetime/yearly/monthly package buttons.
- **Package resolution:** `OfferingPackages.resolvePurchasePackageId` prefers the requested id when present on the current offering; otherwise lifetime → yearly → monthly; finally authoritative `$rc_monthly`.
- **Configure:** `PurchasesConfig.configureIfNeeded()` remains DEBUG-only; Release hits `assertionFailure`.
- **Entitlements:** `EntitlementsModel` applies `SubscriptionAccess` from initial `customerInfo()` then `customerInfoStream`; paywall/settings call `apply(customerInfo:)` for immediate unlock.

## Files

- `DuoApp/Monetization/RCIdentifiers.swift` — dashboard ids + `SubscriptionAccess` + `OfferingPackages`
- `DuoApp/Monetization/OfferingsRepository.swift` — purchase/restore with soft resolver
- `DuoApp/Monetization/Entitlements.swift` — stream + dashboard offering assert
- `DuoApp/Features/Paywall/PaywallHostView.swift` — dismiss only when unlocked
- `DuoApp/Features/Capture/InnerCaptureView.swift` — settings purchase hooks

## Gate

See `DuoApp/docs-runtime/GATE-RC.md` — live purchase tests TC-R03/R04/R05 marked PARTIAL/BLOCKED until Test Store evidence is captured.
