//
//  Entitlements.swift
//  DuoApp
//
//  Live EntitlementState publisher. Owned by LANE-RC (Codex).
//

import Foundation
import Combine
#if canImport(RevenueCat)
import RevenueCat
#endif

@MainActor
public final class EntitlementsModel: ObservableObject {
    public static let shared = EntitlementsModel()

    @Published public private(set) var state = EntitlementState(
        status: .unknown,
        entitlementID: RCIdentifiers.entitlementId,
        lastError: nil
    )

    private init() {
        start()
    }

    public func start() {
        state = EntitlementState(status: .loading, entitlementID: RCIdentifiers.entitlementId, lastError: nil)
        #if canImport(RevenueCat)
        Task {
            guard Purchases.isConfigured else {
                state = EntitlementState(status: .inactive, entitlementID: RCIdentifiers.entitlementId, lastError: nil)
                return
            }
            for await info in Purchases.shared.customerInfoStream {
                let id = RCIdentifiers.entitlementId
                let unlocked = info.entitlements[id]?.isActive == true
                self.state = EntitlementState(
                    status: unlocked ? .active : .inactive,
                    entitlementID: id,
                    lastError: nil
                )
            }
        }
        #else
        state = EntitlementState(status: .inactive, entitlementID: RCIdentifiers.entitlementId, lastError: nil)
        #endif
    }

    /// Rehearsal and stage-safe recovery helper
    public func simulateUnlock() {
        self.state = EntitlementState(status: .active, entitlementID: RCIdentifiers.entitlementId, lastError: nil)
    }

    public func simulateLock() {
        self.state = EntitlementState(status: .inactive, entitlementID: RCIdentifiers.entitlementId, lastError: nil)
    }
}
