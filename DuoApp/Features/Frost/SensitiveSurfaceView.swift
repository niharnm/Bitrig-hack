//
//  SensitiveSurfaceView.swift
//  DuoApp
//
//  SCR-FD-A: Inner sensitive surface with progressive frost ladder.
//  Obeys docs/bible/12-frostduo-cutover.md (§12.5), §13.7, and §14.6 (F1 Frost settle).
//  Owned by LANE-FROST.
//

import SwiftUI

public struct SensitiveSurfaceView: View {
    public let threatLevel: ThreatLevel
    public let protectEnabled: Bool
    
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        threatLevel: ThreatLevel = .clear,
        protectEnabled: Bool = true
    ) {
        self.threatLevel = threatLevel
        self.protectEnabled = protectEnabled
    }

    /// Effective threat level taking protectEnabled toggle into account (§12.5.3)
    private var activeThreat: ThreatLevel {
        protectEnabled ? threatLevel : .clear
    }

    /// Hero secret blur radius (blurs first at .cautious per §12.5.1)
    private var heroSecretBlur: CGFloat {
        switch activeThreat {
        case .clear: return 0
        case .cautious: return 8    // --blur-cautious
        case .threatened: return 16 // --blur-threatened
        case .locked: return 24     // full frost
        }
    }

    /// Body text blur radius (blurs at .threatened per §12.5.1)
    private var bodyTextBlur: CGFloat {
        switch activeThreat {
        case .clear, .cautious: return 0
        case .threatened: return 16 // --blur-threatened
        case .locked: return 24     // full frost
        }
    }

    public var body: some View {
        ZStack {
            // Background Canvas: Frost Paper (#F3F4F6)
            FrostTheme.canvas
                .ignoresSafeArea()

            // Private Document Surface (Mail Thread Option 1 per §12.5.1)
            VStack(alignment: .leading, spacing: 20) {
                // Header Metadata & Brand Whisper
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("FrostDuo")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundColor(FrostTheme.accent)
                        Text("Confidential Internal Document")
                            .font(.system(size: 11, weight: .regular, design: .default))
                            .foregroundColor(Color.secondary)
                    }
                    
                    Spacer()
                    
                    Text("RESTRICTED")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(FrostTheme.accent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(FrostTheme.accent.opacity(0.12))
                        .clipShape(Capsule())
                }
                .padding(.bottom, 6)

                // Mail Subject Line
                Text("Series A Term Sheet — Escrow Wire")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 20/255, green: 24/255, blue: 30/255))
                    .blur(radius: bodyTextBlur)

                // Sender / Timestamp Bar
                HStack(spacing: 8) {
                    Image(systemName: "envelope.fill")
                        .font(.system(size: 12))
                        .foregroundColor(FrostTheme.accent)
                    Text("From: legal@acmecapital.com · Today, 9:41 AM")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color.secondary)
                }
                .blur(radius: bodyTextBlur)

                Divider()

                // Hero Secret Card (§12.5.1: blurs first at .cautious)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("ONE-TIME WIRE AUTHORIZATION")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(Color.secondary)
                        Spacer()
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 12))
                            .foregroundColor(FrostTheme.accent)
                    }

                    Text("OTP 849-204 · $2,450,000.00")
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(red: 25/255, green: 30/255, blue: 36/255))
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
                )
                .blur(radius: heroSecretBlur)

                // Room-readable Body Text (>=18pt equivalent per §12.5.1)
                Text("Please confirm the authorization token above before releasing the initial equity disbursement to the escrow account. Do not share this OTP over unencrypted channels.")
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .lineSpacing(6)
                    .foregroundColor(Color(red: 40/255, green: 45/255, blue: 55/255))
                    .blur(radius: bodyTextBlur)

                Spacer()
            }
            .padding(24)
            .brightness(-activeThreat.brightnessAttenuation)
            .animation(
                reduceMotion ? nil : .easeInOut(duration: FrostTheme.durFrost),
                value: activeThreat
            )

            // Multi-Layer Frost Overlay with quiet "Covered" corner badge (§12.5.2)
            FrostOverlayView(threatLevel: activeThreat)
        }
    }
}
