//
//  SimulateThreatControl.swift
//  DuoApp
//
//  Hardware-independent simulation controller & UI driving the 0..3 threat ladder.
//  Obeys docs/bible/12-frostduo-cutover.md (§12.6.2) and TC-F03.
//  Owned by LANE-FROST.
//

import SwiftUI
import Foundation

// MARK: - Simulation Controller
@MainActor
public final class ThreatSimulationController: ObservableObject {
    @Published public var threatLevel: ThreatLevel
    @Published public var isSimulating: Bool
    @Published public var protectEnabled: Bool
    @Published public var activeDecoy: DecoyPack
    
    private var simulationTask: Task<Void, Never>?

    public init(
        initialThreat: ThreatLevel = .clear,
        protectEnabled: Bool = true,
        activeDecoy: DecoyPack = .aLockLookalike
    ) {
        self.threatLevel = initialThreat
        self.isSimulating = false
        self.protectEnabled = protectEnabled
        self.activeDecoy = activeDecoy
    }

    /// Primary load-bearing simulation API (§12.6.2)
    /// Forces ThreatLevel.locked for `duration` seconds (default 3.0), then returns to clear.
    public func simulateThreat(duration: TimeInterval = 3.0) {
        guard protectEnabled else { return }
        
        simulationTask?.cancel()
        
        withAnimation(.easeInOut(duration: FrostTheme.durFrost)) {
            self.threatLevel = .locked
            self.isSimulating = true
        }

        simulationTask = Task { @MainActor in
            do {
                try await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
                if !Task.isCancelled {
                    withAnimation(.easeInOut(duration: FrostTheme.durFrost)) {
                        self.threatLevel = .clear
                        self.isSimulating = false
                    }
                }
            } catch {
                // Cancelled
            }
        }
    }

    /// Immediate force-lock API without auto-clear (§12.6.1)
    public func forceLock() {
        simulationTask?.cancel()
        withAnimation(.easeInOut(duration: FrostTheme.durFrost)) {
            self.threatLevel = .locked
            self.isSimulating = true
        }
    }

    /// Clears any active threat or simulation lock
    public func clearThreat() {
        simulationTask?.cancel()
        withAnimation(.easeInOut(duration: FrostTheme.durFrost)) {
            self.threatLevel = .clear
            self.isSimulating = false
        }
    }

    /// Cycles threat level 0 -> 1 -> 2 -> 3 -> 0 for granular testing
    public func stepThreat() {
        simulationTask?.cancel()
        withAnimation(.easeInOut(duration: FrostTheme.durFrost)) {
            self.threatLevel = self.threatLevel.nextLevel
            self.isSimulating = (self.threatLevel == .locked)
        }
    }

    /// Sets explicit threat level
    public func setThreatLevel(_ level: ThreatLevel) {
        simulationTask?.cancel()
        withAnimation(.easeInOut(duration: FrostTheme.durFrost)) {
            self.threatLevel = level
            self.isSimulating = (level == .locked)
        }
    }
}

// MARK: - Simulate Threat Button & Stepper Control View
public struct SimulateThreatControl: View {
    @ObservedObject public var controller: ThreatSimulationController
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    public init(controller: ThreatSimulationController) {
        self.controller = controller
    }

    public var body: some View {
        HStack(spacing: 12) {
            // Primary Climax Simulate Button (0:25 climax trigger)
            Button(action: {
                if controller.threatLevel == .locked {
                    controller.clearThreat()
                } else {
                    controller.simulateThreat(duration: 3.0)
                }
            }) {
                HStack(spacing: 8) {
                    Image(systemName: controller.threatLevel == .locked ? "lock.fill" : "snowflake")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(controller.threatLevel == .locked ? FrostTheme.amber : .white)
                    
                    Text(controller.threatLevel == .locked ? "Release Lock" : "Simulate Threat")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(controller.threatLevel == .locked ? Color.black.opacity(0.85) : FrostTheme.accent)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(controller.threatLevel == .locked ? FrostTheme.amber.opacity(0.4) : Color.white.opacity(0.15), lineWidth: 1)
                )
            }
            .buttonStyle(QuietPressButtonStyle())

            // Compact Stepper for granular TC verification (0..3 cycle)
            Button(action: {
                controller.stepThreat()
            }) {
                HStack(spacing: 4) {
                    Text("L\(controller.threatLevel.rawValue)")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundColor(FrostTheme.ink)
                    Image(systemName: "chevron.right.2")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(FrostTheme.inkMuted)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.black.opacity(0.40))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.white.opacity(0.10), lineWidth: 1)
                )
            }
            .buttonStyle(QuietPressButtonStyle())
            .accessibilityLabel("Step threat level: current level \(controller.threatLevel.rawValue)")
        }
    }
}

// MARK: - Quiet Press Micro-Interaction (§14)
public struct QuietPressButtonStyle: ButtonStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.88 : 1.0)
            .animation(.easeOut(duration: 0.14), value: configuration.isPressed)
    }
}
