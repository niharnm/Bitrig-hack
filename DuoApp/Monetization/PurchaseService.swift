//
//  PurchaseService.swift
//  DuoApp
//
//  OWNER: LANE-RC · Fallback custom purchase helper (Bible §09 §9.9).
//

import Foundation
#if canImport(RevenueCat)
import RevenueCat
#endif

enum PurchaseOutcome: Sendable {
    case purchased
    case cancelled
    case failed(String)
}

enum PurchaseService {
    #if canImport(RevenueCat)
    @MainActor
    static func buy(_ package: Package) async -> PurchaseOutcome {
        guard Purchases.isConfigured else {
            return .failed("Purchases is not configured")
        }
        do {
            let result = try await Purchases.shared.purchase(package: package)
            if result.userCancelled {
                return .cancelled
            }
            // Do NOT mutate EntitlementState directly; Entitlements.swift observes customerInfoStream
            return .purchased
        } catch {
            let nsError = error as NSError
            if nsError.code == ErrorCode.purchaseCancelledError.rawValue {
                return .cancelled
            }
            return .failed(error.localizedDescription)
        }
    }
    #else
    @MainActor
    static func buyMock(isPro: Bool) async -> PurchaseOutcome {
        return isPro ? .purchased : .cancelled
    }
    #endif
}
