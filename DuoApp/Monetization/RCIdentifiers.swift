//
//  RCIdentifiers.swift
//  DuoApp
//
//  OWNER: LANE-RC · SOURCE: docs-runtime/RC-IDs.md
//  Exact mechanical transcription of dashboard constants (PLACEHOLDER_RC_* namespace).
//

import Foundation

public enum RCIdentifiers {
    // Transcribed dashboard constants from docs-runtime/RC-IDs.md
    #if DEBUG
    public static let apiKey: String = {
        if let envKey = ProcessInfo.processInfo.environment["REVENUECAT_API_KEY"], !envKey.isEmpty {
            return envKey
        }
        return "test_vLzHLIyotfZAGehQHdRCKFPRyyN"
    }()
    #else
    public static let apiKey: String = ""
    #endif
    public static let entitlementId = "pro"
    public static let productId = "outerlens_pro_monthly"
    public static let offeringId = "default"
    /// Authoritative package on the live Test Store offering.
    public static let packageId = "$rc_monthly"
    /// Optional offering package identifiers. Prefer these when present; else fall back to `packageId`.
    public static let lifetimePackageId = "lifetime"
    public static let yearlyPackageId = "yearly"
    public static let monthlyPackageId = "monthly"
    public static let subscriptionPackageIds = [lifetimePackageId, yearlyPackageId, monthlyPackageId]
    public static let paywallAttached = true

    // Exact PLACEHOLDER_RC_* namespace tokens per Bible §09.1.1 and §00
    public static let PLACEHOLDER_RC_API_KEY = apiKey
    public static let PLACEHOLDER_RC_ENTITLEMENT_ID = entitlementId
    public static let PLACEHOLDER_RC_PRODUCT_ID = productId
    public static let PLACEHOLDER_RC_OFFERING_ID = offeringId
    public static let PLACEHOLDER_RC_PACKAGE_ID = packageId
    public static let PLACEHOLDER_RC_PAYWALL_ATTACHED = paywallAttached
}

public enum SubscriptionAccess {
    public static func isUnlocked(activeEntitlementIDs: some Sequence<String>) -> Bool {
        Set(activeEntitlementIDs).contains(RCIdentifiers.entitlementId)
    }

    public static func displayedEntitlementID(activeEntitlementIDs: some Sequence<String>) -> String {
        _ = activeEntitlementIDs
        return RCIdentifiers.entitlementId
    }
}

public enum OfferingPackages {
    public static func matchingWiredPackages(availableIdentifiers: [String]) -> [String] {
        let available = Set(availableIdentifiers)
        return RCIdentifiers.subscriptionPackageIds.filter { available.contains($0) }
    }

    /// Prefer an exact custom package id when on the offering; otherwise soft-fall back to `$rc_monthly`.
    public static func resolvePurchasePackageId(
        requested: String,
        availableIdentifiers: [String]
    ) -> String? {
        let available = Set(availableIdentifiers)
        if available.contains(requested) {
            return requested
        }
        guard RCIdentifiers.subscriptionPackageIds.contains(requested)
            || requested == RCIdentifiers.packageId
        else {
            return nil
        }
        if available.contains(RCIdentifiers.packageId) {
            return RCIdentifiers.packageId
        }
        return nil
    }
}
