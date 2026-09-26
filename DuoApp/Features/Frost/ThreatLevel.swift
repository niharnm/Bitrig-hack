//
//  ThreatLevel.swift
//  DuoApp
//
//  FrostDuo lane extensions and theme tokens for ThreatLevel and DecoyPack.
//  Obeys docs/bible/12-frostduo-cutover.md, 13-design-system-tokens.md, 14-motion-interaction.md.
//  Owned by LANE-FROST.
//

import SwiftUI
import Foundation

// MARK: - ThreatLevel Lane Extensions
extension ThreatLevel {
    /// Visual blur radius corresponding to threat ladder steps (§12.5.2)
    public var blurRadius: CGFloat {
        switch self {
        case .clear:
            return 0.0
        case .cautious:
            return 8.0   // --blur-cautious
        case .threatened:
            return 16.0  // --blur-threatened
        case .locked:
            return 24.0  // full frost max
        }
    }

    /// Brightness drop applied at progressive threat stages (§12.5.2)
    public var brightnessAttenuation: Double {
        switch self {
        case .clear:
            return 0.0
        case .cautious:
            return 0.02
        case .threatened:
            return 0.06  // ~6% brightness drop
        case .locked:
            return 0.12
        }
    }

    /// Quiet non-alarmist corner badge text (§12.5.2)
    public var statusBadgeText: String? {
        switch self {
        case .clear, .cautious, .threatened:
            return nil
        case .locked:
            return "Covered"
        }
    }

    /// Alternate non-alarmist status badge text (§12.5.2)
    public var alternateBadgeText: String? {
        switch self {
        case .clear, .cautious, .threatened:
            return nil
        case .locked:
            return "Private"
        }
    }

    /// Human-readable label for inspection and sim tools
    public var displayName: String {
        switch self {
        case .clear: return "Clear"
        case .cautious: return "Cautious"
        case .threatened: return "Threatened"
        case .locked: return "Locked"
        }
    }

    /// Returns next level in the 0..3 threat ladder cycle
    public var nextLevel: ThreatLevel {
        switch self {
        case .clear: return .cautious
        case .cautious: return .threatened
        case .threatened: return .locked
        case .locked: return .clear
        }
    }

    public var isLocked: Bool {
        self == .locked
    }
}

// MARK: - DecoyPack Lane Extensions
extension DecoyPack {
    public var displayName: String {
        switch self {
        case .aLockLookalike: return "Lock Lookalike (Pack A)"
        case .bBusyCover: return "Busy Cover (Pack B)"
        case .cVaultCover: return "Vault Cover (Pack C)"
        }
    }

    public var shortName: String {
        switch self {
        case .aLockLookalike: return "Lock Screen"
        case .bBusyCover: return "Busy Day"
        case .cVaultCover: return "Vault Editorial"
        }
    }

    public var requiresPro: Bool {
        switch self {
        case .aLockLookalike, .bBusyCover:
            return false
        case .cVaultCover:
            return true
        }
    }
}

// MARK: - FrostMode Model (§12.4)
public struct FrostMode: Equatable, Sendable {
    public var threat: ThreatLevel
    public var protectEnabled: Bool
    public var activeDecoy: DecoyPack

    public init(
        threat: ThreatLevel = .clear,
        protectEnabled: Bool = true,
        activeDecoy: DecoyPack = .aLockLookalike
    ) {
        self.threat = threat
        self.protectEnabled = protectEnabled
        self.activeDecoy = activeDecoy
    }
}

// MARK: - Frost Design System Tokens (§13.7 & §14.6)
public enum FrostTheme {
    /// Light paper canvas for sensitive document (#F3F4F6)
    public static let canvas = Color(red: 243/255, green: 244/255, blue: 246/255)
    
    /// Quiet teal-slate accent for Protect toggle & CTAs (#4A6B73)
    public static let accent = Color(red: 74/255, green: 107/255, blue: 115/255)
    
    /// Ice tint for lock overlay (rgba(200, 230, 240, 0.10))
    public static let ice = Color(red: 200/255, green: 230/255, blue: 240/255).opacity(0.10)
    
    /// Ink for frost badge and quiet corner labels (rgba(255, 255, 255, 0.70))
    public static let ink = Color.white.opacity(0.70)
    
    /// Secondary ink for metadata
    public static let inkMuted = Color.white.opacity(0.45)
    
    /// Dark contrast background for decoy screens (#050505)
    public static let darkCanvas = Color(red: 5/255, green: 5/255, blue: 5/255)
    
    /// Film tool amber accent (#E8A838)
    public static let amber = Color(red: 232/255, green: 168/255, blue: 56/255)

    // Motion timing constants (§14.6)
    /// F1 Frost settle duration: 280ms
    public static let durFrost: Double = 0.28
    
    /// F3 Vault crossfade duration: 400ms
    public static let durDecoy: Double = 0.40
}
