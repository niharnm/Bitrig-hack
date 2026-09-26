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
            for await info in Purchases.shared.customerInfoStream {
                guard !Task.isCancelled else { break }
                self?.apply(customerInfo: info)
            }
        }
        #else
        state = EntitlementState(status: .inactive, entitlementID: RCIdentifiers.entitlementId, lastError: nil)
        #endif
    }

    /// Immediate unlock path for paywall completion — do not wait for the next stream tick.
    #if canImport(RevenueCat)
    public func apply(customerInfo info: CustomerInfo) {
        let id = RCIdentifiers.entitlementId
        precondition(!id.contains("PLACEHOLDER"), "RC BLOCKED §9.2")
        let unlocked = info.entitlements[id]?.isActive == true
        state = EntitlementState(
            status: unlocked ? .active : .inactive,
            entitlementID: id,
            lastError: nil
        )
    }
    #endif

    deinit {
        streamTask?.cancel()
    }
}
