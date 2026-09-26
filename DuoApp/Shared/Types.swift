enum CutoverFlag: String, Codable, Sendable {
  case outerLens
  case frost
}

enum AppState: Equatable, Sendable {
  case launching
  case shellReady
  case outerLens(OuterLensPhase)
  case frostDuo(FrostDuoPhase)
  case blocked(BlockReason)
  case frozenForDemo
}

enum OuterLensPhase: Equatable, Sendable {
  case permission(PermissionSubstate)
  case capture(CaptureSessionPhase)
  case paywall
  case recovery(RecoveryKind)
}

enum FrostDuoPhase: Equatable, Sendable {
  case clear
  case frostActive(ThreatLevel)
  case paywall
  case vaultUnlock
}

enum PermissionSubstate: Equatable, Sendable {
  case notDetermined
  case requesting
  case authorized
  case denied
  case restricted
}

enum CaptureSessionPhase: Equatable, Sendable {
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

enum CaptureFailure: Equatable, Sendable {
  case configuration
  case runtime
  case unknown
}

enum TipKind: Equatable, Sendable {
  case line
  case guide
  case countdown
}

struct CoachTip: Equatable, Identifiable, Sendable {
  var id: String
  var kind: TipKind
  var text: String
  var symbolName: String?
  var requiresPro: Bool
}

struct EntitlementState: Equatable, Sendable {
  var status: EntitlementStatus
  var entitlementID: String
  var isPro: Bool { status == .active }
  var lastError: String?
}

enum EntitlementStatus: Equatable, Sendable {
  case unknown
  case loading
  case inactive
  case active
  case error
}

enum PoseMode: Equatable, Sendable {
  case flat
  case open
  case tabletop
  case book
  case closed
  case unknown
}

enum ThreatLevel: Int, Comparable, Equatable, Sendable {
  case clear = 0
  case cautious = 1
  case threatened = 2
  case locked = 3

  static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}

enum DecoyPack: String, Equatable, Sendable {
  case aLockLookalike
  case bBusyCover
  case cVaultCover
}

enum DemoPhase: Equatable, Sendable {
  case coldOpen
  case climax
  case monetize
  case unlockProof
  case close
}

enum BlockReason: Equatable, Sendable {
  case toolchain
  case missingRCIDs
  case cutoverPending
  case scopeNack(String)
}

enum RecoveryKind: Equatable, Sendable {
  case openSettings
  case simulateTip
  case simulatePro
  case simulateCountdown
  case tipOnlyOuter
}
