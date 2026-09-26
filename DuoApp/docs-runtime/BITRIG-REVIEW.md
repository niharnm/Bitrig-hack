# Bitrig visual QA review

Historical record. For the current combined source and acceptance gaps, see [completion board](../../docs/project-status.md) and [reconciliation receipt](../../docs/repository-cleanup-20260926.md).

Date: 2026-09-26. Scope: iPhone Duo only. App code and concurrent changes were read-only. Screenshots are outside the repository. Ordinary iPhone and iPad checks were cancelled by Nihar.

## Workspace and source state

- Project: `/Users/nihar/Desktop/Bitrig Hack/DuoApp`; Git root: `/Users/nihar/Desktop/Bitrig Hack`.
- Branch: `docs/bitrig-routing`; HEAD at latest inspection: `975b6947d61b830a13cc1940dfcca0d53fd2c391`, ahead of `origin/docs/bitrig-routing` by 19 commits. The failed-build source state below was HEAD `1a4e42fedffca355d3f4fdfa6f6802c5dd7462f8` plus concurrent dirty files. The branch had changed from `native/contracts-standby` earlier in this assignment.
- Dirty app file at latest inspection: `Resources/Localizable.strings`. This report is also modified. The failed-build state at `1a4e42f` had eight dirty app files: `Features/Capture/InnerCaptureView.swift`, `Features/Paywall/PaywallHostView.swift`, `Monetization/Entitlements.swift`, `Monetization/OfferingsRepository.swift`, `Monetization/PurchasesConfig.swift`, `Monetization/RCIdentifiers.swift`, `Resources/Localizable.strings`, and `Tests/PaywallPresentationTests.swift`. All app edits were concurrent and untouched by this reviewer. Untracked `../AGENTS.md` and `../docs/tasks/` appeared at the latest status check and were untouched.
- Observed toolchain: Xcode 27.1 (`27A9269`) at `/Applications/Xcode-27.1-beta.app/Contents/Developer`; iOS 27.1 runtime `24A94401`. No toolchain or signing changes were made.
- Final destination: built-in iPhone Duo. After a successful new build, Bitrig displayed the Duo home screen with fold controls enabled. Fully Open was selected at close. Simulator inventory reported the Duo running, but direct simulator UI reads intermittently failed; the app did not appear on the home screen or launch in the preview.
- `b041f88a4d4a7dc4f181a0af656c3ae20e1dab12` was verified as an ancestor of the tested PR7 merge `bd010b23b41de2c482426dcb6ca53b19a9ca6fd2`.

## Revision-specific results

| Source state | Check | Result | Evidence and limit |
| --- | --- | --- | --- |
| Clean `bd010b23b41de2c482426dcb6ca53b19a9ca6fd2` | Native Bitrig Debug build, Duo selected | PASS | `build_project` returned success; log contained `** BUILD SUCCEEDED **`. |
| Clean `bd010b2` | Free capture frame and tip | PASS, limited | Duo inner screenshot `/tmp/outer-lens-bd010b2-duo-baseline.png`. A single frame is not fold-pose or Dynamic Type acceptance. |
| Clean `bd010b2` | Simulated Pro label | PASS | After Settings > Simulate Pro, accessibility showed outer `SIMULATED PRO` and inner `Simulated Pro`. Inner screenshot: `/tmp/outer-lens-bd010b2-duo-simulated-pro.png`. Simulation is not transaction evidence. |
| `4dda7f0260370fbd320fd673be2103b77b351031`, then current | Native Bitrig Debug build and app primer | PASS, historical | Build succeeded. The app showed a camera-permission primer; Continue displayed the system permission prompt. Permission was not granted during that observation. |
| `4dda7f0`, then current | Duo pose controls and device geometry | PASS, simulator shell only | Fully Open, Partially Open, Seated, Standing, and Closed showed flat, book-like, tabletop, tent, and closed device geometry. Fully Open was restored. The app was behind the permission prompt; no app layout passed. |
| `edf9b87f62c86bfa41924e1ae106e25a9b47798e`, then current | Native Bitrig Debug build | PASS, historical | Build succeeded before later concurrent checkout changes. No Duo app acceptance was completed at this revision. |
| HEAD `1a4e42f` plus eight dirty app files above | Native Bitrig Debug build, Duo selected | FAIL | Raw Bitrig log: `/Users/nihar/Desktop/Bitrig Hack/DuoApp/Features/Capture/InnerCaptureView.swift:242:25: error: extra arguments at positions #1, #2, #3 in call`; then `** BUILD FAILED **`. The uncommitted file calls `CustomerCenterView(usesNavigationStack: true, usesExistingNavigation: true, shouldShowCloseButton: false)`. This failure belongs to the dirty checkout, not committed `1a4e42f`. |
| HEAD `1a4e42f` plus eight dirty app files | Duo app launch and app layouts | BLOCKED, historical | Bitrig displayed `Build failed.` and disabled fold controls. This state preceded the later successful build. |
| `975b6947d61b830a13cc1940dfcca0d53fd2c391` plus dirty localization file | Fresh native Bitrig Debug build, Duo selected | PASS | `build_project` returned `{"diagnostics":[],"result":"success"}`. Bitrig showed the Duo home screen and enabled fold controls. |
| `975b6947` plus dirty localization file | Current Duo app launch and app layouts | BLOCKED | The preview remained on the Duo home screen. Simulator inventory reported Duo running, but direct UI reads intermittently returned `An error occurred while communicating with a remote process` or `Failed to read the simulator state.` No current Outer Lens app frame or app-pose screenshot was obtained. |

## Duo visual and behavior checks

| Check | Result | Evidence or limit |
| --- | --- | --- |
| Simulated Pro label on both displays | PASS, historical | Observed on clean `bd010b2` as above. No live purchase was observed. |
| Shared tip and panel spacing | PASS, static only | On `bd010b2`, `FilmToolTokens.Tip.primarySize` is 28 pt; `TipPlateView` uses 24 pt horizontal and 16 pt vertical padding. The free-state screenshot showed a tip, but did not measure rendered spacing. |
| Countdown with Reduce Motion | BLOCKED, runtime; PASS, static only | Source at `bd010b2` uses identity transition and no countdown animation under Reduce Motion. A runtime countdown check was interrupted by a revision change. Reduce Motion was restored to disabled. |
| Guide crossfade and shutter press motion | BLOCKED, runtime; PASS, static only | Source at `bd010b2` uses opacity for the guide under Reduce Motion and a 0.94 pressed shutter scale, with animation removed under Reduce Motion. No timed Duo observation was completed. |
| Dynamic Type, clipping, contrast, control placement | BLOCKED | The current build passed, but the preview remained on the home screen. The historical single frame is insufficient. |
| Flat, tabletop, book, closed app layouts | BLOCKED | Pose geometry was observed at `4dda7f0`, but the app was behind a permission prompt. No app-pose screenshots exist. |
| Camera permission, capture preview, saved photo, physical camera or microphone | NOT RUN | A simulator permission prompt appeared; it was left undecided. The current app did not launch in the preview. No physical camera or microphone was accessed. |
| Live purchase and entitlement | NOT RUN | Simulate Pro is a debug simulation. No transaction or live entitlement was observed. |
| Timed demo video | NOT RUN | No recording tool was confirmed available and no video was recorded. |

Ordered Duo shot list after reliable app launch: (1) flat, inner capture and outer subject stage; (2) tabletop, media above and controls below; (3) book, both roles visible; (4) closed, outer continuation; (5) free tip and clearly marked Simulated Pro state. None of these app-pose shots is complete. Historical screenshots outside the repo also include `/tmp/outer-lens-duo-d0e4243-launch.png` from the earlier `d0e4243` setup check.

## Coordinator and owner findings, not checks run here

- Coordinator reports an isolated Release build of committed `main` at `1a4e42f` passed with SDK 27.1. This reviewer did not run that build. It does not clear the failed Debug build of the dirty shared checkout.
- Coordinator reports the Release binary retains the supplied RevenueCat Test Store key and DEBUG bootstrap logs it. The key is omitted. Documentation PR #8 records these findings. Antigravity is the Codex-assigned RC owner.
- Earlier coordinator findings: no live purchase or cross-display entitlement evidence; Release configuration was missing at that stage; the cutover reader accepted `true` and `frostDuo` while frozen sections 12 and 18 require exact `frost`. These findings were not re-tested here and may have changed.

## Owner actions

1. **Capture/integration owner:** The uncommitted `CustomerCenterView` initializer error at `Features/Capture/InnerCaptureView.swift:242` blocked the earlier dirty checkout. The later `975b6947` build passed. Keep that distinction when reviewing the integration change; do not attribute the earlier failure to committed `1a4e42f`.
2. **Antigravity, RC owner:** Address Release Test Store key retention and DEBUG key logging without reproducing the key. Supply separate live transaction and entitlement evidence; the simulated badge does not supply it.
3. **Capture owner:** Supply actual capture-preview and saved-photo evidence. The primer and source code do not establish camera behavior.
4. **Bitrig preview/integration owner:** Restore reliable app launch in the built-in Duo preview on the passing `975b6947` checkout. The simulator reached its home screen but did not show Outer Lens, and direct state reads intermittently failed. Once it launches, visual QA can capture four app fold poses outside the repo and check Dynamic Type, Reduce Motion countdown and guide, shutter feedback, tip spacing, clipping, and contrast.
5. **Cutover owner:** Reconcile the exact `frost` contract from frozen sections 12 and 18 if the mismatch remains.

At close, Reduce Motion had been restored to disabled and Bitrig showed Fully Open selected on iPhone Duo. No camera permission was granted.
