//
//  OuterDecoyStageView.swift
//  DuoApp
//
//  SCR-FD-C: Outer decoy stage supporting Lock Lookalike A, Busy Cover B, and Vault Cover C.
//  Obeys docs/bible/12-frostduo-cutover.md (§12.7), §13.7, and §14.6 (F2 Decoy snap & F3 Vault crossfade).
//  Owned by LANE-FROST.
//

import SwiftUI

public struct OuterDecoyStageView: View {
    public let threatLevel: ThreatLevel
    public let activeDecoy: DecoyPack
    public let isPro: Bool

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        threatLevel: ThreatLevel = .clear,
        activeDecoy: DecoyPack = .aLockLookalike,
        isPro: Bool = false
    ) {
        self.threatLevel = threatLevel
        self.activeDecoy = activeDecoy
        self.isPro = isPro
    }

    /// Determines the active visual pack based on threat and entitlement tier (§12.7.2)
    private var resolvedPack: DecoyPack {
        if isPro && activeDecoy == .cVaultCover {
            return .cVaultCover
        }
        return activeDecoy
    }

    public var body: some View {
        ZStack {
            // Background Canvas: Never blank black, never mirroring inner (§12.7.2)
            FrostTheme.darkCanvas
                .ignoresSafeArea()

            if threatLevel == .clear {
                // Clear / Idle state: Calm ambient wallpaper (§12.7.2)
                DecoyAmbientIdleView()
                    .transition(reduceMotion ? .identity : .opacity)
            } else {
                // Locked state: Render selected decoy pack
                Group {
                    switch resolvedPack {
                    case .aLockLookalike:
                        DecoyPackALockLookalikeView()
                    case .bBusyCover:
                        DecoyPackBBusyCoverView()
                    case .cVaultCover:
                        DecoyPackCVaultCoverView(isPro: isPro)
                    }
                }
                .transition(
                    reduceMotion ? .identity :
                        (resolvedPack == .cVaultCover
                            ? .opacity.animation(.easeInOut(duration: FrostTheme.durDecoy))  // F3 400ms crossfade
                            : .opacity.animation(.easeInOut(duration: FrostTheme.durFrost))) // F2 ~280ms snap
                )
            }
        }
        .animation(
            reduceMotion ? nil : .easeInOut(duration: resolvedPack == .cVaultCover ? FrostTheme.durDecoy : FrostTheme.durFrost),
            value: threatLevel
        )
        .animation(
            reduceMotion ? nil : .easeInOut(duration: FrostTheme.durDecoy),
            value: isPro
        )
    }
}

// MARK: - Decoy Ambient Idle View (§12.7.2)
private struct DecoyAmbientIdleView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 18/255, green: 24/255, blue: 32/255),
                    Color(red: 28/255, green: 38/255, blue: 48/255),
                    Color(red: 12/255, green: 16/255, blue: 22/255)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                // Status bar time indicator
                HStack {
                    Text("9:41")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.white.opacity(0.6))
                    Spacer()
                    Image(systemName: "battery.100")
                        .font(.system(size: 12))
                        .foregroundColor(Color.white.opacity(0.6))
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                Spacer()

                // Subtle ambient glow
                Circle()
                    .fill(Color(red: 74/255, green: 107/255, blue: 115/255).opacity(0.18))
                    .frame(width: 220, height: 220)
                    .blur(radius: 60)

                Spacer()
            }
        }
    }
}

// MARK: - Pack A: Lock Lookalike (Free Default, §12.7.1)
public struct DecoyPackALockLookalikeView: View {
    public init() {}

    public var body: some View {
        ZStack {
            // Calm abstract wallpaper
            LinearGradient(
                colors: [
                    Color(red: 35/255, green: 45/255, blue: 60/255),
                    Color(red: 20/255, green: 28/255, blue: 38/255),
                    Color(red: 10/255, green: 14/255, blue: 20/255)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 8) {
                // Padlock glyph
                Image(systemName: "lock.fill")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.85))
                    .padding(.top, 40)

                // Date label
                Text("Saturday, September 26")
                    .font(.system(size: 17, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white.opacity(0.85))
                    .padding(.top, 4)

                // Large iOS Lock Clock
                Text("09:41")
                    .font(.system(size: 76, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(-1)

                // Banal Weather Widget
                HStack(spacing: 8) {
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.yellow)
                    Text("Cupertino · 72° Mostly Sunny")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(Color.white.opacity(0.80))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.12))
                )
                .padding(.top, 8)

                Spacer()

                // Bottom iOS shortcuts
                HStack {
                    Circle()
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 48, height: 48)
                        .overlay(
                            Image(systemName: "flashlight.on.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                        )
                    Spacer()
                    Circle()
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 48, height: 48)
                        .overlay(
                            Image(systemName: "camera.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                        )
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
            }
        }
    }
}

// MARK: - Pack B: Busy Cover (Free Teaser / Climax Alternative, §12.7.1)
public struct DecoyPackBBusyCoverView: View {
    public init() {}

    public var body: some View {
        ZStack {
            Color(red: 245/255, green: 246/255, blue: 248/255)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                // Header Bar
                HStack {
                    Text("Messages")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color.primary)
                    Spacer()
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 18))
                        .foregroundColor(FrostTheme.accent)
                }
                .padding(.top, 24)

                // Innocuous message threads (§12.7.1: generic names + neutral icons only)
                VStack(spacing: 12) {
                    DecoyMessageRow(
                        sender: "Mom",
                        preview: "Sounds great! See you at dinner tonight at 6:30.",
                        time: "9:38 AM",
                        unread: true
                    )
                    DecoyMessageRow(
                        sender: "Team Lunch",
                        preview: "Marcus: Pushed lunch table to 12:30 PM.",
                        time: "9:15 AM",
                        unread: true
                    )
                    DecoyMessageRow(
                        sender: "Flight Alerts",
                        preview: "Gate B14 is now open for boarding.",
                        time: "Yesterday",
                        unread: false
                    )
                }

                // Calendar "Busy until 4 PM" card
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(FrostTheme.accent)
                        .frame(width: 4, height: 36)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Busy until 4:00 PM")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.primary)
                        Text("Architecture Design Sync · Room 4B")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color.secondary)
                    }
                    Spacer()
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
                )

                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

private struct DecoyMessageRow: View {
    let sender: String
    let preview: String
    let time: String
    let unread: Bool

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.gray.opacity(0.25))
                .frame(width: 42, height: 42)
                .overlay(
                    Text(String(sender.prefix(1)))
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.primary)
                )

            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(sender)
                        .font(.system(size: 15, weight: unread ? .bold : .medium, design: .rounded))
                        .foregroundColor(Color.primary)
                    Spacer()
                    Text(time)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.secondary)
                }
                Text(preview)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color.secondary)
                    .lineLimit(1)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 1)
        )
    }
}

// MARK: - Pack C: Vault Cover (Pro Exclusive, §12.7.1)
public struct DecoyPackCVaultCoverView: View {
    public let isPro: Bool
    
    public init(isPro: Bool = false) {
        self.isPro = isPro
    }

    public var body: some View {
        ZStack {
            // Editorial frosted glass gradient wallpaper
            LinearGradient(
                colors: [
                    Color(red: 22/255, green: 28/255, blue: 38/255),
                    Color(red: 45/255, green: 55/255, blue: 72/255),
                    Color(red: 18/255, green: 22/255, blue: 30/255)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                // Discreet Lock Glyph + Pro Badge
                VStack(spacing: 14) {
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 72, height: 72)
                        .overlay(
                            Image(systemName: isPro ? "lock.shield.fill" : "lock.fill")
                                .font(.system(size: 28, weight: .medium))
                                .foregroundColor(isPro ? FrostTheme.amber : Color.white.opacity(0.85))
                        )
                        .overlay(
                            Circle()
                                .stroke(isPro ? FrostTheme.amber.opacity(0.4) : Color.white.opacity(0.12), lineWidth: 1)
                        )

                    VStack(spacing: 6) {
                        Text("COMMUTER VAULT")
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                            .tracking(3)
                            .foregroundColor(isPro ? FrostTheme.amber : Color.white.opacity(0.60))

                        Text("Curated Editorial Edition")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }

                    if !isPro {
                        Text("Pro Entitlement Required")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(FrostTheme.amber)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(FrostTheme.amber.opacity(0.15))
                            .clipShape(Capsule())
                            .padding(.top, 4)
                    }
                }
                .padding(28)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(isPro ? FrostTheme.amber.opacity(0.3) : Color.white.opacity(0.1), lineWidth: 1)
                )

                Spacer()

                // Subtle collection footer metadata
                Text("Pack C · Vault Cover Pack · iPhone Duo")
                    .font(.system(size: 11, weight: .regular, design: .rounded))
                    .foregroundColor(Color.white.opacity(0.35))
                    .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
    }
}
