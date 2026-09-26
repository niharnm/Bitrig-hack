import Foundation
import SwiftUI

// Reader for docs-runtime/CUTOVER.flag. Only the Orchestrator writes that file; see bible §02 and §07.3.
extension CutoverFlag {
  /// Mode for this launch. Relaunch the app after the Orchestrator changes the flag.
  static let current = resolve()

  var isFrost: Bool { self == .frost }

  /// `frost` selects the cutover. `true` and `frostDuo` also map to frost per §07.3B. Anything else, including an empty or missing file, is Outer Lens.
  init(flagContents: String?) {
    switch flagContents?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
    case "frost", "true", "frostduo":
      self = .frost
    default:
      self = .outerLens
    }
  }

  private static func resolve() -> CutoverFlag {
    // Launch argument override for device runs and tests: `-cutover frost`.
    if let override = UserDefaults.standard.string(forKey: "cutover") {
      return CutoverFlag(flagContents: override)
    }
    for url in flagFileCandidates {
      if let contents = try? String(contentsOf: url, encoding: .utf8) {
        return CutoverFlag(flagContents: contents)
      }
    }
    return .outerLens
  }

  private static var flagFileCandidates: [URL] {
    var urls: [URL] = []
    #if DEBUG && targetEnvironment(simulator)
      // Simulator apps can read the host checkout, so the Orchestrator's file applies without a rebuild.
      urls.append(
        URL(filePath: #filePath)
          .deletingLastPathComponent()
          .deletingLastPathComponent()
          .appending(path: "docs-runtime/CUTOVER.flag"))
    #endif
    if let bundled = Bundle.main.url(forResource: "CUTOVER", withExtension: "flag") {
      urls.append(bundled)
    }
    return urls
  }
}

extension EnvironmentValues {
  /// Active product mode. Feature lanes read this and never write the flag.
  @Entry var cutoverFlag: CutoverFlag = .current
}
