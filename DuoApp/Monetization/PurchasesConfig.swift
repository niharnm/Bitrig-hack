//
//  PurchasesConfig.swift
//  DuoApp
//
//  RevenueCat bootstrap configuration. Owned by LANE-RC (Codex).
//

import Foundation
#if canImport(RevenueCat)
import RevenueCat
#endif

public enum PurchasesConfig {
    public static func configureIfNeeded() {
        #if canImport(RevenueCat)
        guard Purchases.isConfigured == false else { return }
        Purchases.logLevel = .debug
        #if DEBUG
        let key = RCIdentifiers.apiKey
        precondition(!key.contains("PLACEHOLDER"), "RC BLOCKED: paste RC-IDs.md — see bible §09 §9.2")
        Purchases.configure(withAPIKey: key)
        print("PurchasesConfig: Configured RevenueCat with Test Store key: \(key)")
        #else
        assertionFailure("Release configure not used in Duo hackathon demo path")
        #endif
        #else
        print("PurchasesConfig: RevenueCat SDK not linked in this build environment.")
        #endif
    }
}
