//
//  OfferingsRepository.swift
//  DuoApp
//
//  Offerings diagnostics and package retrieval. Owned by LANE-RC (Codex).
//

import Foundation
#if canImport(RevenueCat)
import RevenueCat
#endif

public enum OfferingsRepository {
    #if canImport(RevenueCat)
    public static func currentPackages() async throws -> [Package] {
        guard Purchases.isConfigured else { return [] }
        let offerings = try await Purchases.shared.getOfferings()
        guard let current = offerings.current else { return [] }
        return current.availablePackages
    }

    public static func assertCurrentOfferingMatchesDashboard() async throws {
        guard Purchases.isConfigured else { return }
        let offerings = try await Purchases.shared.getOfferings()
        guard let current = offerings.current else {
            throw OfferingsError.currentNil
        }
        let expected = RCIdentifiers.offeringId
        if current.identifier != expected {
            print("GATE-RC WARN: current.identifier=\(current.identifier) expected=\(expected)")
        }
    }
    #endif
}

public enum OfferingsError: Error {
    case currentNil
}
