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
    public static let apiKey: String = {
        if let envKey = ProcessInfo.processInfo.environment["REVENUECAT_API_KEY"], !envKey.isEmpty {
            return envKey
        }
        return "test_vLzHLIyotfZAGehQHdRCKFPRyyN"
    }()
    public static let entitlementId = "pro"
    /// Entitlement requested for this integration. `pro` stays the existing Test Store id.
    public static let photonProEntitlementId = "photon_pro"
    public static let productId = "outerlens_pro_monthly"
    public static let offeringId = "default"
    public static let packageId = "$rc_monthly"
    /// Offering package identifiers. These are not App Store product ids.
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
        let ids = Set(activeEntitlementIDs)
        return ids.contains(RCIdentifiers.photonProEntitlementId) || ids.contains(RCIdentifiers.entitlementId)
    }

    public static func displayedEntitlementID(activeEntitlementIDs: some Sequence<String>) -> String {
        let ids = Set(activeEntitlementIDs)
        if ids.contains(RCIdentifiers.photonProEntitlementId) {
            return RCIdentifiers.photonProEntitlementId
        }
        if ids.contains(RCIdentifiers.entitlementId) {
            return RCIdentifiers.entitlementId
        }
        return RCIdentifiers.photonProEntitlementId
    }
}

public enum OfferingPackages {
    public static func matchingWiredPackages(availableIdentifiers: [String]) -> [String] {
        let available = Set(availableIdentifiers)
        return RCIdentifiers.subscriptionPackageIds.filter { available.contains($0) }
    }
}
