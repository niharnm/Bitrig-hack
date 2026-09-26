//
//  Entitlements.swift
//  DuoApp
//
//  OWNER: LANE-RC · Live EntitlementState publisher.
//  Observes Purchases.shared.customerInfoStream and publishes EntitlementState.
//

import Foundation
import Combine
#if canImport(RevenueCat)
import RevenueCat
#endif

@MainActor
public final class EntitlementsModel: ObservableObject {
    public static let shared = EntitlementsModel()

    @Published private(set) var state: EntitlementState

    private var streamTask: Task<Void, Never>?

    public init() {
        self.state = EntitlementState(
            status: .unknown,
            entitlementID: RCIdentifiers.entitlementId,
            lastError: nil
        )
        start()
    }

    public func start() {
        state = EntitlementState(status: .loading, entitlementID: RCIdentifiers.entitlementId, lastError: nil)
        #if canImport(RevenueCat)
        streamTask?.cancel()
        streamTask = Task { [weak self] in
            guard Purchases.isConfigured else {
                self?.state = EntitlementState(
                    status: .inactive,
                    entitlementID: RCIdentifiers.entitlementId,
                    lastError: "Purchases not configured"
                )
                return
            }
            do {
                let info = try await Purchases.shared.customerInfo()
                self?.apply(info)
            } catch {
                self?.state = EntitlementState(
                    status: .error,
                    entitlementID: RCIdentifiers.entitlementId,
                    lastError: error.localizedDescription
                )
            }
            for await info in Purchases.shared.customerInfoStream {
                guard !Task.isCancelled else { break }
                self?.apply(info)
            }
        }
        #else
        state = EntitlementState(status: .inactive, entitlementID: RCIdentifiers.entitlementId, lastError: nil)
        #endif
    }

    #if canImport(RevenueCat)
    private func apply(_ info: CustomerInfo) {
        let activeIDs = info.entitlements.active.keys
        let unlocked = SubscriptionAccess.isUnlocked(activeEntitlementIDs: activeIDs)
        state = EntitlementState(
            status: unlocked ? .active : .inactive,
            entitlementID: SubscriptionAccess.displayedEntitlementID(activeEntitlementIDs: activeIDs),
            lastError: nil
        )
    }
    #endif

    deinit {
        streamTask?.cancel()
    }
}
