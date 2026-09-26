//
//  OfferingsRepository.swift
//  DuoApp
//
//  OWNER: LANE-RC · Offerings diagnostics and package retrieval.
//

import Foundation
#if canImport(RevenueCat)
import RevenueCat
#endif

public enum OfferingsRepository {
    #if canImport(RevenueCat)
    public static func currentPackages() async throws -> [Package] {
        guard Purchases.isConfigured else { return [] }
        let offerings = try await Purchases.shared.offerings()
        guard let current = offerings.current else { return [] }
        return current.availablePackages
    }

    public static func assertCurrentOfferingMatchesDashboard() async throws {
        guard Purchases.isConfigured else { return }
        let offerings = try await Purchases.shared.offerings()
        guard let current = offerings.current else {
            throw OfferingsError.currentNil
        }
        let expected = RCIdentifiers.offeringId
        precondition(!expected.contains("PLACEHOLDER"), "RC BLOCKED §9.2")
        if current.identifier != expected {
            print("GATE-RC WARN: current.identifier=\(current.identifier) expected=\(expected)")
        }
    }

    public static func currentCustomerInfo() async throws -> SubscriptionSnapshot {
        let info = try await fetchCustomerInfo()
        return SubscriptionSnapshot(customerInfo: info)
    }

    public static func restorePurchases() async throws -> SubscriptionSnapshot {
        guard Purchases.isConfigured else { throw SubscriptionError.notConfigured }
        do {
            let info = try await Purchases.shared.restorePurchases()
            return SubscriptionSnapshot(customerInfo: info)
        } catch {
            throw SubscriptionError.underlying(error.localizedDescription)
        }
    }

    /// Purchases one wired offering package. Do not call this while `PaywallView` is purchasing.
    public static func purchase(packageIdentifier: String) async throws -> SubscriptionSnapshot {
        guard RCIdentifiers.subscriptionPackageIds.contains(packageIdentifier) else {
            throw SubscriptionError.missingPackage(packageIdentifier)
        }
        guard Purchases.isConfigured else { throw SubscriptionError.notConfigured }
        let offerings = try await Purchases.shared.offerings()
        guard let current = offerings.current else { throw SubscriptionError.missingOffering }
        let wired = OfferingPackages.matchingWiredPackages(
            availableIdentifiers: current.availablePackages.map(\.identifier)
        )
        guard wired.contains(packageIdentifier),
              let package = current.availablePackages.first(where: { $0.identifier == packageIdentifier })
        else {
            throw SubscriptionError.missingPackage(packageIdentifier)
        }
        do {
            let result = try await Purchases.shared.purchase(package: package)
            if result.userCancelled {
                throw SubscriptionError.cancelled
            }
            return SubscriptionSnapshot(customerInfo: result.customerInfo)
        } catch let error as SubscriptionError {
            throw error
        } catch {
            let nsError = error as NSError
            if nsError.code == ErrorCode.purchaseCancelledError.rawValue {
                throw SubscriptionError.cancelled
            }
            throw SubscriptionError.underlying(error.localizedDescription)
        }
    }

    private static func fetchCustomerInfo() async throws -> CustomerInfo {
        guard Purchases.isConfigured else { throw SubscriptionError.notConfigured }
        do {
            return try await Purchases.shared.customerInfo()
        } catch {
            throw SubscriptionError.underlying(error.localizedDescription)
        }
    }
    #else
    public static func assertCurrentOfferingMatchesDashboard() async throws {
        print("OfferingsRepository: RevenueCat SDK not linked in this build environment.")
    }

    public static func currentCustomerInfo() async throws -> SubscriptionSnapshot {
        throw SubscriptionError.notConfigured
    }

    public static func restorePurchases() async throws -> SubscriptionSnapshot {
        throw SubscriptionError.notConfigured
    }

    public static func purchase(packageIdentifier: String) async throws -> SubscriptionSnapshot {
        _ = packageIdentifier
        throw SubscriptionError.notConfigured
    }
    #endif
}

public enum OfferingsError: Error {
    case currentNil
}

public struct SubscriptionSnapshot: Equatable, Sendable {
    public var photonProActive: Bool
    public var proActive: Bool
    public var activeEntitlementIDs: [String]

    public var isUnlocked: Bool {
        SubscriptionAccess.isUnlocked(activeEntitlementIDs: activeEntitlementIDs)
    }

    #if canImport(RevenueCat)
    init(customerInfo: CustomerInfo) {
        let active = Array(customerInfo.entitlements.active.keys).sorted()
        activeEntitlementIDs = active
        photonProActive = active.contains(RCIdentifiers.photonProEntitlementId)
        proActive = active.contains(RCIdentifiers.entitlementId)
    }
    #endif
}

public enum SubscriptionError: LocalizedError, Equatable {
    case notConfigured
    case missingOffering
    case missingPackage(String)
    case cancelled
    case underlying(String)

    public var errorDescription: String? {
        switch self {
        case .notConfigured:
            return "Purchases are not configured."
        case .missingOffering:
            return "No current offering is available."
        case .missingPackage(let identifier):
            return "Package \(identifier) is not in the current offering."
        case .cancelled:
            return "Purchase was cancelled."
        case .underlying(let message):
            return message
        }
    }
}
