//
//  FrostControlsView.swift
//  DuoApp
//
//  SCR-FD-B: Inner quiet management controls and simulation triggers.
//  Obeys docs/bible/12-frostduo-cutover.md (§12.6), §13.7, and §14.6.
//  Owned by LANE-FROST.
//

import SwiftUI

public struct FrostControlsView: View {
    @ObservedObject public var controller: ThreatSimulationController
    public var onUnlockVault: (() -> Void)?
    
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        controller: ThreatSimulationController,
        onUnlockVault: (() -> Void)? = nil
    ) {
        self.controller = controller
        self.onUnlockVault = onUnlockVault
    }

    public var body: some View {
        VStack(spacing: 16) {
            // Header Row: Protect Toggle & Quiet Status Flake (§12.6.1)
            HStack(alignment: .center) {
                // Protect Toggle: Enables automatic threat sensing
                Toggle(isOn: $controller.protectEnabled) {
                    HStack(spacing: 8) {
                        Image(systemName: "shield.lefthalf.filled")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(controller.protectEnabled ? FrostTheme.accent : Color.secondary)
                        
                        Text("Protect")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.primary)
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: FrostTheme.accent))

                Spacer(minLength: 16)

                // Status Flake: Tiny SF Symbol (clear = hidden; locked = snowflake ~80% opacity per §12.6.1)
                HStack(spacing: 6) {
                    Image(systemName: "snowflake")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(controller.threatLevel == .locked ? FrostTheme.accent : Color.clear)
                        .opacity(controller.threatLevel == .locked ? 0.80 : 0.0)
                    
                    Text(controller.threatLevel == .locked ? "Covered" : "Standby")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(controller.threatLevel == .locked ? FrostTheme.accent : Color.secondary)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(controller.threatLevel == .locked ? FrostTheme.accent.opacity(0.12) : Color.black.opacity(0.04))
                )
                .animation(reduceMotion ? nil : .easeInOut(duration: FrostTheme.durFrost), value: controller.threatLevel)
            }

            // Action Buttons Row: Simulate Threat & Frost Now (§12.6.1)
            HStack(spacing: 12) {
                // Primary Simulator Trigger (0:25 climax trigger)
                SimulateThreatControl(controller: controller)

                // Manual Instant-Lock Fallback Button ("Frost Now")
                Button(action: {
                    if controller.threatLevel == .locked {
                        controller.clearThreat()
                    } else {
                        controller.forceLock()
                    }
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: controller.threatLevel == .locked ? "lock.open.fill" : "hand.raised.fill")
                            .font(.system(size: 13, weight: .medium))
                        Text(controller.threatLevel == .locked ? "Clear" : "Frost Now")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                    }
                    .foregroundColor(Color(red: 50/255, green: 55/255, blue: 65/255))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Color.black.opacity(0.06))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.black.opacity(0.08), lineWidth: 1)
                    )
                }
                .buttonStyle(QuietPressButtonStyle())
            }

            // Monetization CTA: Unlock Cover Vault (§12.6.1 & §12.8: presents PaywallHostView)
            Button(action: {
                onUnlockVault?()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(FrostTheme.amber)
                    
                    Text("Unlock Cover Vault")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("PRO")
                        .font(.system(size: 10, weight: .heavy, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(FrostTheme.amber)
                        .cornerRadius(4)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(red: 25/255, green: 30/255, blue: 38/255))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(FrostTheme.amber.opacity(0.3), lineWidth: 1)
                )
            }
            .buttonStyle(QuietPressButtonStyle())

            // Jane Manchun Wong Anti-Creep Guarantee (§12.6.3)
            HStack(spacing: 6) {
                Image(systemName: "lock.shield")
                    .font(.system(size: 11))
                    .foregroundColor(Color.secondary)
                Text("On-device. Faces never leave this iPhone.")
                    .font(.system(size: 11, weight: .regular, design: .rounded))
                    .foregroundColor(Color.secondary)
            }
            .padding(.top, 2)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
        )
    }
}
