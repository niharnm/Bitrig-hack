# Project: Dual-Engine Filter System for iPhone Duo

## Architecture
The Dual-Engine Filter System spans two primary user-facing domains operating across parallel displays:
1. **Outer Coach & Kid Magnet Lane (`sat/coach`)**:
   - Manages the outer display experience facing the subject.
   - `KidMagnetView`: Visual animated delight cue (`pawprint.fill`, `face.smiling`) near the top camera lens, gently pulsing/bouncing to engage children. Halts animation when `accessibilityReduceMotion` is enabled.
   - `GuideOvalView`: T2 Pro pose guide oval styled in amber `#E8A838` with dashed stroke (`dash: [8, 6]`), centered without obscuring the subject's face.
   - `CountdownView`: T3 140pt bold rounded monospaced countdown digits for the 3-2-1 shutter sequence.
   - `SubjectCoachView`: Coordinates dynamic tier switching (T1 tips, T2 guide oval, T3 countdown, and Kid Magnet) based on `isPro` and `TipPack` (`kidsPro`).
   - `tip.kids.1..3`: Playful child-facing prompts in `Resources/Localizable.strings`.

2. **Inner Capture & Film Stock Lane (`sat/capture`)**:
   - Manages the inner display experience facing the photographer.
   - `FilmStock` enum (`natural`, `leicaMono`, `warmAmber`, `portraSoft`) with strict `requiresPro` gating (Free: `natural`; Pro: `leicaMono`, `warmAmber`, `portraSoft`).
   - `FilmGrade` tokens in `DesignSystem/Tokens.swift`: Color grading parameters (contrast, saturation, amber tint opacity, tint color).
   - `FilmStockSelectorView`: Tactile glass selector pill (`.ultraThinMaterial`, capsule border) displaying Pro lock badges, triggering haptic feedback, and presenting `PaywallHostView` sheet on locked presets.
   - `CaptureSessionController`: Real `AVCaptureSession` serial queue management, photo capture triggering, and graceful simulator fallback when no physical camera exists.
   - `InnerCaptureView`: Embeds `FilmStockSelectorView`, applies zero-latency GPU preview grading (`.contrast()`, `.saturation()`, tint overlay), wires shutter actions, and connects locked presets to paywall presentation.

3. **Integration, Quality Gate & Main Merge (`sat/filters-integrate`)**:
   - Clean merge of `sat/coach` and `sat/capture` branches with zero conflict.
   - Full automated test suite execution via Xcode 27.1 on iPhone Duo iOS 27.1 simulator:
     `DEVELOPER_DIR=/Users/vachanbhogi/Desktop/Xcode.app/Contents/Developer xcodebuild test -project DuoApp/DuoApp.xcodeproj -scheme DuoApp -destination "platform=iOS Simulator,name=iPhone Duo,OS=27.1"`
   - Quality gate verification: Code Review, Challenge Stress-testing, Forensic Integrity Audit.
   - Clean fast-forward / merge into `main`.

## Code Layout
- `DuoApp/Shared/Types.swift`: Domain enums (`FilmStock`, `TipPack`)
- `DuoApp/DesignSystem/Tokens.swift`: Color palette, `FilmGrade` grading values, `KidMagnet` constants
- `DuoApp/DesignSystem/Motion.swift`: Motion animations, `kidMagnetPulseAnimation`, `kidMagnetBounceOffset`
- `DuoApp/Features/CoachOverlay/KidMagnetView.swift`: Animated outer display cue
- `DuoApp/Features/CoachOverlay/GuideOvalView.swift`: Amber dashed pose oval
- `DuoApp/Features/CoachOverlay/CountdownView.swift`: 140pt monospaced shutter countdown
- `DuoApp/Features/CoachOverlay/SubjectCoachView.swift`: Dynamic outer coach coordinator
- `DuoApp/Features/Capture/FilmStockSelectorView.swift`: Tactile glass selector pill
- `DuoApp/Features/Capture/CaptureSessionController.swift`: Camera session lifecycle & simulator fallback
- `DuoApp/Features/Capture/InnerCaptureView.swift`: Preview grading, shutter, and paywall trigger
- `DuoApp/Resources/Localizable.strings`: Film stocks and playful kids strings
- `DuoApp/Tests/CoachOverlayTests.swift`: Unit tests for Coach Overlay
- `DuoApp/Tests/CaptureFilmStockTests.swift`: Unit tests for Capture & Film Stocks
- `DuoApp/DuoApp.xcodeproj/project.pbxproj`: Project reference catalog

## Feature Inventory
Every feature identified during Survey is assigned to a milestone below:
| # | Feature | Description | Milestone | Source |
|---|---------|-------------|-----------|--------|
| 1 | Worktree Initialization | Create `sat/coach`, `sat/capture`, and `sat/filters-integrate` worktrees off `main` | M1 & M2 | Survey |
| 2 | Shared Types & Gating | Define `FilmStock` enum (`natural`, `leicaMono`, `warmAmber`, `portraSoft`) with `requiresPro` and `TipPack` enum (`free`, `kidsPro`, `portraitPro`) in `Shared/Types.swift` | M1 & M2 | Survey |
| 3 | Design System Tokens | Add `FilmGrade` color grading tokens and `KidMagnet` motion/timing constants in `DesignSystem/Tokens.swift` and `Motion.swift` | M1 & M2 | Survey |
| 4 | KidMagnetView Component | Create `KidMagnetView.swift` with animated pulsing cue (`pawprint.fill`, `face.smiling`) near top lens, respecting `accessibilityReduceMotion` | M1 | R1 Spec |
| 5 | GuideOvalView Dashed Stroke | Update `GuideOvalView.swift` to use amber `#E8A838` dashed stroke (`dash: [8, 6]`), centered without obscuring face | M1 | R1 Spec |
| 6 | CountdownView Integration | Verify 140pt monospaced bold countdown digits and smooth numeric transition in shutter sequence | M1 | R1 Spec |
| 7 | SubjectCoachView Dynamic Wiring | Wire `KidMagnetView`, `GuideOvalView`, `CountdownView`, and `TipPlateView`; activate Kid Magnet on `isPro && activePack == .kidsPro` | M1 | R1 Spec |
| 8 | Playful Kids Localizations | Update `Localizable.strings` (`tip.kids.1..3`) with playful child-facing prompts | M1 | R1 Spec |
| 9 | FilmStockSelectorView Component | Create tactile glass selector pill with lock badges on Pro presets and paywall sheet trigger | M2 | R2 Spec |
| 10 | CaptureSessionController Simulator Fallback | Implement real `AVCaptureSession` queue management, photo capture triggering, and graceful simulator fallback | M2 | R2 Spec |
| 11 | InnerCaptureView Filter & Paywall Wiring | Embed selector, apply zero-latency GPU preview grading, wire shutter, and present paywall sheet on locked presets | M2 | R2 Spec |
| 12 | Film Stock Localizations | Add localized names and descriptions for all 4 film stocks in `Resources/Localizable.strings` | M2 | R2 Spec |
| 13 | Coach Overlay Unit Tests | Create `DuoApp/Tests/CoachOverlayTests.swift` covering tip cycles, countdown, pack gating, and reduce motion | M1 | Survey |
| 14 | Capture & Film Stock Unit Tests | Create `DuoApp/Tests/CaptureFilmStockTests.swift` covering stock requirements, grading values, and simulator fallback | M2 | Survey |
| 15 | Multi-Worktree Integration | Clean merge of `sat/coach` and `sat/capture` into `sat/filters-integrate` with zero symbol collisions | M3 | R3 Spec |
| 16 | Full Automated Test Verification | Execute full automated test suite via Xcode 27.1 on iPhone Duo iOS 27.1 simulator | M3 | R3 Spec |
| 17 | Final Clean Merge to Main | Fast-forward / merge validated `sat/filters-integrate` into `main` | M3 | R3 Spec |

## Milestones
| # | Name | Scope | Dependencies | Status |
|---|------|-------|-------------|--------|
| M1 | Outer Coach & Kid Magnet Lane (`sat/coach`) | `Features/CoachOverlay/**`, `KidMagnetView`, `GuideOvalView`, `CountdownView`, `SubjectCoachView`, `Localizable.strings`, `CoachOverlayTests` | none | IN_PROGRESS |
| M2 | Inner Capture & Film Stock Lane (`sat/capture`) | `FilmStock` enum, `FilmGrade` tokens, `FilmStockSelectorView`, `CaptureSessionController`, `InnerCaptureView`, `Localizable.strings`, `CaptureFilmStockTests` | none | IN_PROGRESS |
| M3 | Integration, Quality Gates & Main Merge (`sat/filters-integrate`) | Merge `sat/coach` & `sat/capture`, Design System & RevenueCat gating verification, automated tests, merge to `main` | M1, M2 | PLANNED |

## Interface Contracts

### Shared Types (`Shared/Types.swift`)
```swift
public enum FilmStock: String, CaseIterable, Identifiable, Sendable {
  case natural
  case leicaMono
  case warmAmber
  case portraSoft

  public var id: String { rawValue }

  public var requiresPro: Bool {
    switch self {
    case .natural: return false
    case .leicaMono, .warmAmber, .portraSoft: return true
    }
  }

  public var displayNameKey: String {
    switch self {
    case .natural: return "filmStock.natural.name"
    case .leicaMono: return "filmStock.leicaMono.name"
    case .warmAmber: return "filmStock.warmAmber.name"
    case .portraSoft: return "filmStock.portraSoft.name"
    }
  }

  public var descriptionKey: String {
    switch self {
    case .natural: return "filmStock.natural.description"
    case .leicaMono: return "filmStock.leicaMono.description"
    case .warmAmber: return "filmStock.warmAmber.description"
    case .portraSoft: return "filmStock.portraSoft.description"
    }
  }
}

public enum TipPack: String, CaseIterable, Identifiable, Sendable {
  case free
  case kidsPro
  case portraitPro

  public var id: String { rawValue }

  public var requiresPro: Bool {
    switch self {
    case .free: return false
    case .kidsPro, .portraitPro: return true
    }
  }
}
```

### Design System Tokens (`DesignSystem/Tokens.swift` & `Motion.swift`)
```swift
extension FilmToolTokens {
  public struct FilmGrade: Sendable {
    public let contrast: Double
    public let saturation: Double
    public let amberTintOpacity: Double
    public let tintColor: Color

    public static let natural = FilmGrade(contrast: 1.0, saturation: 1.0, amberTintOpacity: 0.0, tintColor: .clear)
    public static let leicaMono = FilmGrade(contrast: 1.28, saturation: 0.0, amberTintOpacity: 0.0, tintColor: .clear)
    public static let warmAmber = FilmGrade(contrast: 1.08, saturation: 1.15, amberTintOpacity: 0.24, tintColor: FilmToolTokens.Palette.accent)
    public static let portraSoft = FilmGrade(contrast: 0.94, saturation: 0.90, amberTintOpacity: 0.08, tintColor: Color(red: 245/255, green: 215/255, blue: 185/255))
  }

  public enum KidMagnet {
    public static let pulseDuration: TimeInterval = 0.85
    public static let bounceOffset: CGFloat = 8.0
    public static let minScale: CGFloat = 0.96
    public static let maxScale: CGFloat = 1.16
  }
}

extension FilmStock {
  public var grade: FilmToolTokens.FilmGrade {
    switch self {
    case .natural: return .natural
    case .leicaMono: return .leicaMono
    case .warmAmber: return .warmAmber
    case .portraSoft: return .portraSoft
    }
  }
}
```
