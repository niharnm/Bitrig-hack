//
//  PaywallHostView.swift
//  DuoApp
//
//  RevenueCatUI Paywall sheet host. Owned by LANE-RC (Codex).
//  STRICT RULE: Hosted on INNER display only. Never on outer CCA.
//

import SwiftUI
#if canImport(RevenueCat)
import RevenueCat
#endif
#if canImport(RevenueCatUI)
import RevenueCatUI
#endif

public struct PaywallHostView: View {
    @Binding public var isPresented: Bool
    @ObservedObject private var entitlements = EntitlementsModel.shared

    public init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }

    public var body: some View {
        NavigationStack {
            #if canImport(RevenueCatUI)
            PaywallView(displayCloseButton: true)
                .onPurchaseCompleted { customerInfo in
                    print("PaywallHostView: Purchase completed. Entitlements: \(customerInfo.entitlements)")
                    EntitlementsModel.shared.start()
                    isPresented = false
                }
                .onRestoreCompleted { customerInfo in
                    print("PaywallHostView: Restore completed.")
                    EntitlementsModel.shared.start()
                    if customerInfo.entitlements[RCIdentifiers.entitlementId]?.isActive == true {
                        isPresented = false
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close") { isPresented = false }
                    }
                }
            #else
            // Fallback when RevenueCatUI is not yet linked in environment
            VStack(spacing: 24) {
                Text("Outer Lens Pro")
                    .font(.largeTitle.bold())
                Text("Unlock outer display guide ovals & coach framing.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)

                Button("Simulate Successful Purchase (Demo)") {
                    EntitlementsModel.shared.simulateUnlock()
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 232/255, green: 168/255, blue: 56/255))
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { isPresented = false }
                }
            }
            #endif
        }
    }
}
