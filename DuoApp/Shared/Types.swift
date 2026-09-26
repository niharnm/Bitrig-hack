// Integrator owns this file (bible §07.2). Duo-core needs only these two shapes; the Integrator's full §07 file supersedes it.

enum CutoverFlag: String, Codable, Sendable {
  case outerLens
  case frost
}

enum PoseMode: Equatable, Sendable {
  case flat
  case open
  case tabletop
  case book
  case closed
  case unknown
}
