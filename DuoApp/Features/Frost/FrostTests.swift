//
//  FrostTests.swift
//  Verification suite for Milestone M2: FrostDuo Standby Slice (TC-F01 to TC-F04)
//

import Foundation
import SwiftUI

@main
struct TestRunner {
    static func main() async {
        await runAllTests()
    }
}

@MainActor
func runAllTests() async {
    print("=== Starting FrostDuo Slice Verification Suite ===")
    var failures = 0

    func assertEqual<T: Equatable>(_ actual: T, _ expected: T, _ message: String) {
        if actual == expected {
            print("  ✓ PASS: \(message)")
        } else {
            print("  ✗ FAIL: \(message) — Expected [\(expected)], got [\(actual)]")
            failures += 1
        }
    }

    func assertTrue(_ condition: Bool, _ message: String) {
        if condition {
            print("  ✓ PASS: \(message)")
        } else {
            print("  ✗ FAIL: \(message)")
            failures += 1
        }
    }

    // -------------------------------------------------------------
    // Test Group 1: ThreatLevel Ladder & Tokens (TC-F01)
    // -------------------------------------------------------------
    print("\n--- Testing TC-F01: Progressive Threat Ladder & Blur Radii ---")
    assertEqual(ThreatLevel.clear.blurRadius, 0.0, "ThreatLevel.clear blur radius is 0.0pt")
    assertEqual(ThreatLevel.cautious.blurRadius, 8.0, "ThreatLevel.cautious blur radius is 8.0pt (--blur-cautious)")
    assertEqual(ThreatLevel.threatened.blurRadius, 16.0, "ThreatLevel.threatened blur radius is 16.0pt (--blur-threatened)")
    assertEqual(ThreatLevel.locked.blurRadius, 24.0, "ThreatLevel.locked blur radius is 24.0pt (full frost max)")

    assertEqual(ThreatLevel.clear.brightnessAttenuation, 0.0, "ThreatLevel.clear brightness drop is 0.0")
    assertEqual(ThreatLevel.threatened.brightnessAttenuation, 0.06, "ThreatLevel.threatened brightness drop is 6%")
    assertEqual(ThreatLevel.locked.statusBadgeText, "Covered", "ThreatLevel.locked badge is 'Covered'")
    assertEqual(ThreatLevel.locked.alternateBadgeText, "Private", "ThreatLevel.locked alternate badge is 'Private'")
    assertTrue(ThreatLevel.cautious.statusBadgeText == nil, "ThreatLevel.cautious has no badge (quiet)")

    assertEqual(FrostTheme.durFrost, 0.28, "F1 Frost settle duration is 280ms (--dur-frost)")
    assertEqual(FrostTheme.durDecoy, 0.40, "F3 Vault crossfade duration is 400ms (--dur-decoy)")

    // -------------------------------------------------------------
    // Test Group 2: Decoy Packs & Outer Decoy State (TC-F02 & TC-F04)
    // -------------------------------------------------------------
    print("\n--- Testing TC-F02: Outer Decoy Pack Definitions & Defaults ---")
    assertEqual(DecoyPack.aLockLookalike.requiresPro, false, "Decoy Pack A (Lock Lookalike) is free")
    assertEqual(DecoyPack.bBusyCover.requiresPro, false, "Decoy Pack B (Busy Cover) is free teaser")
    assertEqual(DecoyPack.cVaultCover.requiresPro, true, "Decoy Pack C (Vault Cover) requires Pro")

    let defaultMode = FrostMode()
    assertEqual(defaultMode.threat, .clear, "Default FrostMode threat is .clear")
    assertEqual(defaultMode.protectEnabled, true, "Default FrostMode protectEnabled is true")
    assertEqual(defaultMode.activeDecoy, .aLockLookalike, "Default FrostMode activeDecoy is Pack A")

    // -------------------------------------------------------------
    // Test Group 3: Simulation Controller & Force-Lock (TC-F03)
    // -------------------------------------------------------------
    print("\n--- Testing TC-F03: Hardware-Independent Simulation Controller ---")
    let controller = ThreatSimulationController()
    assertEqual(controller.threatLevel, .clear, "Controller initializes at .clear")
    assertEqual(controller.isSimulating, false, "Controller is not simulating initially")

    // Step ladder cycle: 0 -> 1 -> 2 -> 3 -> 0
    controller.stepThreat()
    assertEqual(controller.threatLevel, .cautious, "stepThreat() moves 0 -> 1 (.cautious)")
    controller.stepThreat()
    assertEqual(controller.threatLevel, .threatened, "stepThreat() moves 1 -> 2 (.threatened)")
    controller.stepThreat()
    assertEqual(controller.threatLevel, .locked, "stepThreat() moves 2 -> 3 (.locked)")
    assertTrue(controller.isSimulating, "Controller marks isSimulating true at .locked")
    controller.stepThreat()
    assertEqual(controller.threatLevel, .clear, "stepThreat() wraps 3 -> 0 (.clear)")

    // Force lock
    controller.forceLock()
    assertEqual(controller.threatLevel, .locked, "forceLock() sets threat to .locked")
    assertTrue(controller.isSimulating, "forceLock() sets isSimulating to true")

    // Clear threat
    controller.clearThreat()
    assertEqual(controller.threatLevel, .clear, "clearThreat() sets threat to .clear")
    assertTrue(!controller.isSimulating, "clearThreat() sets isSimulating to false")

    // Simulate Threat with duration (test 0.1s for fast automated test)
    controller.simulateThreat(duration: 0.1)
    assertEqual(controller.threatLevel, .locked, "simulateThreat sets threat to .locked immediately")
    assertTrue(controller.isSimulating, "simulateThreat sets isSimulating to true")
    
    // Wait for auto-reset
    try? await Task.sleep(nanoseconds: 150_000_000) // 150ms
    assertEqual(controller.threatLevel, .clear, "simulateThreat auto-resets to .clear after duration")
    assertTrue(!controller.isSimulating, "simulateThreat resets isSimulating to false")

    // -------------------------------------------------------------
    // Test Group 4: Entitlements Gating on Decoy Pack C (TC-F04)
    // -------------------------------------------------------------
    print("\n--- Testing TC-F04: Decoy Pack C Entitlement Gating ---")
    let freeState = EntitlementState(status: .inactive)
    assertTrue(!freeState.isPro, "Free state has isPro == false")

    let proState = EntitlementState(status: .active)
    assertTrue(proState.isPro, "Active entitlement has isPro == true")

    // Verify Decoy Pack C requires Pro
    let packC = DecoyPack.cVaultCover
    assertTrue(packC.requiresPro, "DecoyPack.cVaultCover is gated by requiresPro")

    // -------------------------------------------------------------
    // Test Group 5: View Instantiation Verification
    // -------------------------------------------------------------
    print("\n--- Testing View Instantiation & Configuration ---")
    let sensitiveView = SensitiveSurfaceView(threatLevel: .locked, protectEnabled: true)
    assertTrue(sensitiveView.protectEnabled, "SensitiveSurfaceView instantiates in .locked state with protectEnabled")

    let controlsView = FrostControlsView(controller: controller, onUnlockVault: {})
    assertTrue(controlsView.controller.threatLevel == .clear, "FrostControlsView instantiates cleanly with controller")

    let overlayView = FrostOverlayView(threatLevel: .locked, customBadge: "Covered")
    assertEqual(overlayView.customBadge, "Covered", "FrostOverlayView instantiates cleanly with custom badge")

    let decoyViewFree = OuterDecoyStageView(threatLevel: .locked, activeDecoy: .aLockLookalike, isPro: false)
    assertEqual(decoyViewFree.isPro, false, "OuterDecoyStageView instantiates in free locked state")

    let decoyViewPro = OuterDecoyStageView(threatLevel: .locked, activeDecoy: .cVaultCover, isPro: true)
    assertEqual(decoyViewPro.isPro, true, "OuterDecoyStageView instantiates in pro unlocked state")

    print("\n=== Verification Suite Completed ===")
    if failures == 0 {
        print("🎉 ALL TESTS PASSED SUCCESSFULLY! (0 failures)")
    } else {
        print("💥 TEST FAILURES DETECTED: \(failures) test(s) failed.")
        exit(1)
    }
}
