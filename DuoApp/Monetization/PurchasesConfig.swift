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
        #if DEBUG
        Purchases.logLevel = .debug
        #endif
        let key = RCIdentifiers.apiKey
        precondition(!key.contains("PLACEHOLDER"), "RC BLOCKED: paste RC-IDs.md — see bible §09 §9.2")
        Purchases.configure(withAPIKey: key)
        #else
        print("PurchasesConfig: RevenueCat SDK not linked in this build environment.")
        #endif
    }
}
