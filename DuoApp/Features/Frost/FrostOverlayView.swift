//
//  FrostOverlayView.swift
//  DuoApp
//
//  Multi-layer blur, material wash, and frost shaders responding to ThreatLevel.
//  Obeys docs/bible/12-frostduo-cutover.md (§12.5.2), §13.7, and §14.6 (F1 Frost settle).
//  Owned by LANE-FROST.
//

import SwiftUI

public struct FrostOverlayView: View {
    public let threatLevel: ThreatLevel
    public let customBadge: String?
    
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    public init(threatLevel: ThreatLevel, customBadge: String? = nil) {
        self.threatLevel = threatLevel
        self.customBadge = customBadge
    }
    
    private var badgeText: String? {
        customBadge ?? threatLevel.statusBadgeText
    }
    
    public var body: some View {
        ZStack {
            // Layer 1: Ultra-thin material layer active at .locked
            if threatLevel == .locked {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .transition(reduceMotion ? .identity : .opacity)
            }
            
            // Layer 2: Ice tint wash (§13.7 --frost-ice: rgba(200, 230, 240, 0.10))
            if threatLevel >= .threatened {
                Rectangle()
                    .fill(FrostTheme.ice)
                    .opacity(threatLevel == .locked ? 1.0 : 0.4)
                    .transition(reduceMotion ? .identity : .opacity)
            }
            
            // Layer 3: Sparse frost grain texture simulation (~0.25 density)
            if threatLevel == .locked {
                FrostSparseGrainLayer()
                    .opacity(0.25)
                    .blendMode(.overlay)
                    .transition(reduceMotion ? .identity : .opacity)
            }
            
            // Layer 4: Quiet corner status badge & subtle snowflake glyph
            if threatLevel == .locked, let badge = badgeText {
                VStack {
                    HStack {
                        HStack(spacing: 6) {
                            Image(systemName: "snowflake")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(FrostTheme.ink)
                                .opacity(0.80)
                            
                            Text(badge)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundColor(FrostTheme.ink)
                                .tracking(0.3)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.black.opacity(0.35))
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.12), lineWidth: 0.5)
                        )
                        .padding(.top, 14)
                        .padding(.leading, 16)
                        
                        Spacer()
                    }
                    Spacer()
                }
                .transition(reduceMotion ? .identity : .opacity.combined(with: .scale(scale: 0.96)))
            }
        }
        // CRITICAL: Must never intercept touches intended for underlying document or controls (§12.5.2)
        .allowsHitTesting(false)
        .animation(
            reduceMotion ? nil : .easeInOut(duration: FrostTheme.durFrost),
            value: threatLevel
        )
    }
}

// MARK: - Procedural Sparse Frost Grain Layer
/// Generates a subtle procedural dot pattern matching sparse frost grain specs (~0.25 density)
private struct FrostSparseGrainLayer: View {
    var body: some View {
        Canvas { context, size in
            let step: CGFloat = 16.0
            var x: CGFloat = 4.0
            while x < size.width {
                var y: CGFloat = 4.0
                while y < size.height {
                    // Hash-based pseudo random opacity
                    let hash = sin(x * 12.9898 + y * 78.233) * 43758.5453
                    let rand = hash - floor(hash)
                    if rand > 0.72 {
                        let dotRect = CGRect(x: x, y: y, width: 1.5, height: 1.5)
                        context.fill(Path(ellipseIn: dotRect), with: .color(Color.white.opacity(rand * 0.4)))
                    }
                    y += step
                }
                x += step
            }
        }
    }
}

// MARK: - View Modifier Convenience
extension View {
    /// Applies the progressive FrostDuo overlay driven by ThreatLevel
    public func frostOverlay(threatLevel: ThreatLevel, customBadge: String? = nil) -> some View {
        self.overlay(
            FrostOverlayView(threatLevel: threatLevel, customBadge: customBadge)
        )
    }
}
