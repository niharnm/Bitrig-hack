//
//  PaywallHostView.swift
//  DuoApp
//
//  OWNER: LANE-RC · Inner display freemium paywall.
//  Strict contract: Confined to INNER display only (SCR-OL-D / SCR-FD-D).
//  Never hosted on outer display or CameraCaptureAccessory.
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
                    isPresented = false
                }
                .onRestoreCompleted { customerInfo in
                    print("PaywallHostView: Restore completed. Entitlements: \(customerInfo.entitlements)")
                    if customerInfo.entitlements[RCIdentifiers.entitlementId]?.isActive == true {
                        isPresented = false
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close") {
                            isPresented = false
                        }
                    }
                }
            #else
            // High-converting freemium value framing (Film Tool design system)
            ZStack {
                Color(red: 5/255, green: 5/255, blue: 5/255)
                    .ignoresSafeArea()

                VStack(spacing: 28) {
                    Spacer()

                    // Value Proposition Header
                    VStack(spacing: 8) {
                        Text("Outer Lens Pro")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(.white)

                        Text("Pose overlays on the subject screen")
                            .font(.system(.headline, design: .rounded, weight: .medium))
                            .foregroundColor(Color(red: 232/255, green: 168/255, blue: 56/255))
                            .multilineTextAlignment(.center)
                    }

                    // Freemium Feature Comparison Table
                    VStack(spacing: 16) {
                        FeatureRow(
                            icon: "eye.fill",
                            title: "Outer Subject Preview",
                            subtitle: "Free: Natural eye-contact framing on the outer display",
                            isPro: false
                        )

                        FeatureRow(
                            icon: "oval.portrait.fill",
                            title: "Real-time Guide Ovals",
                            subtitle: "Pro: Golden ratio & portrait framing aids on subject screen",
                            isPro: true
                        )

                        FeatureRow(
                            icon: "sparkles",
                            title: "Coaching Overlays",
                            subtitle: "Pro: Timed prompts that prompt natural smiles without stress",
                            isPro: true
                        )
                    }
                    .padding(.horizontal, 20)

                    // Behavioral Nudge / Pitch Alignment
                    Text("Free outer preview stays free. Pro unlocks coaching overlays on the subject display.")
                        .font(.system(.footnote, design: .default))
                        .foregroundColor(Color.white.opacity(0.65))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)

                    Spacer()

                    // Action Controls
                    VStack(spacing: 12) {
                        Button {
                            isPresented = false
                        } label: {
                            Text("Dismiss")
                                .font(.system(.body, design: .rounded, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.white.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        isPresented = false
                    }
                    .foregroundColor(.white)
                }
            }
            #endif
        }
    }
}

private struct FeatureRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let isPro: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(isPro ? Color(red: 232/255, green: 168/255, blue: 56/255) : .white.opacity(0.8))
                .frame(width: 28, height: 28)

            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(title)
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                        .foregroundColor(.white)

                    if isPro {
                        Text("PRO")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 5/255, green: 5/255, blue: 5/255))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color(red: 232/255, green: 168/255, blue: 56/255))
                            .clipShape(Capsule())
                    }
                }

                Text(subtitle)
                    .font(.system(.caption, design: .default))
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}
