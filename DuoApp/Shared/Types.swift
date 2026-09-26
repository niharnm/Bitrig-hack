//
//  Types.swift
//  DuoApp
//
//  Single source of truth for domain models, state machines, and contracts.
//  Obeys docs/bible/07-types-state-machines.md. Owned by INTEGRATOR.
//

import Foundation

// MARK: - Cutover Flag
public enum CutoverFlag: String, Codable, Sendable {
    case outerLens   // default / flag absent / false
    case frost       // CUTOVER.flag contents "frost"
}

// MARK: - App State Machine
public enum AppState: Equatable, Sendable {
    case launching
    case shellReady
    case outerLens(OuterLensPhase)
    case frostDuo(FrostDuoPhase)
    case blocked(BlockReason)
    case frozenForDemo
}

public enum OuterLensPhase: Equatable, Sendable {
    case permission(PermissionSubstate)
    case capture(CaptureSessionPhase)
    case paywall
    case recovery(RecoveryKind)
}

public enum FrostDuoPhase: Equatable, Sendable {
    case clear
    case frostActive(ThreatLevel)
    case paywall
    case vaultUnlock
}

public enum RecoveryKind: Equatable, Sendable {
    case simulatedTip
    case cameraDenied
    case accessoryUnavailable
}

// MARK: - Permission Substate
public enum PermissionSubstate: Equatable, Sendable {
    case notDetermined
    case requesting
    case authorized
    case denied
    case restricted
}

// MARK: - Capture Session Phase
public enum CaptureSessionPhase: Equatable, Sendable {
    case idle
    case permissionRequired
    case starting
    case live
    case accessoryUnavailable
    case accessoryReady(enabled: Bool)
    case interrupted
    case failed(CaptureFailure)
    case shutterFlash
}

public enum CaptureFailure: Equatable, Sendable {
    case configuration
    case runtime
    case unknown
}

// MARK: - Tip Models
public enum TipKind: Equatable, Sendable {
    case line          // T1 free text tip
    case guide         // T2 Pro guide oval
    case countdown     // T3 countdown
}

public struct CoachTip: Equatable, Identifiable, Sendable {
    public var id: String
    public var kind: TipKind
    public var text: String          // <= 8 words for T1/T2
    public var symbolName: String?   // SF Symbol optional
    public var requiresPro: Bool

    public init(id: String, kind: TipKind, text: String, symbolName: String? = nil, requiresPro: Bool = false) {
        self.id = id
        self.kind = kind
        self.text = text
        self.symbolName = symbolName
        self.requiresPro = requiresPro
    }
}

// MARK: - Entitlements State Contract
public struct EntitlementState: Equatable, Sendable {
    public var status: EntitlementStatus
    public var entitlementID: String   // always "pro"
    public var isPro: Bool { status == .active }
    public var lastError: String?

    public init(status: EntitlementStatus = .unknown, entitlementID: String = "pro", lastError: String? = nil) {
        self.status = status
        self.entitlementID = entitlementID
        self.lastError = lastError
    }
}

public enum EntitlementStatus: Equatable, Sendable {
    case unknown
    case loading
    case inactive
    case active
    case error
}

// MARK: - Duo Pose Mode
public enum PoseMode: Equatable, Sendable {
    case flat
    case open
    case tabletop
    case book
    case closed
    case unknown
}

// MARK: - FrostDuo Models
public enum ThreatLevel: Int, Comparable, Equatable, Sendable {
    case clear = 0
    case cautious = 1
    case threatened = 2
    case locked = 3

    public static func < (lhs: ThreatLevel, rhs: ThreatLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

public enum DecoyPack: String, Equatable, Sendable {
    case aLockLookalike   // free
    case bBusyCover       // free teaser
    case cVaultCover      // Pro
}

// MARK: - Demo Script Phases
public enum DemoPhase: Equatable, Sendable {
    case coldOpen          // 0:00–0:10
    case climax            // 0:10–0:45
    case monetize          // 0:50–1:05
    case unlockProof       // 1:05–1:20
    case close             // 1:20–1:30
}

public enum BlockReason: Equatable, Sendable {
    case toolchain
    case missingRCIDs
    case cutoverPending
}
