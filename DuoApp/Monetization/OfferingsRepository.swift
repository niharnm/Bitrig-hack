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
    #else
    public static func assertCurrentOfferingMatchesDashboard() async throws {
        print("OfferingsRepository: RevenueCat SDK not linked in this build environment.")
    }
    #endif
}

public enum OfferingsError: Error {
    case currentNil
}
