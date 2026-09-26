# Bitrig visual QA review

Date: 2026-09-26. Scope: read-only review of Outer Lens in Bitrig. App code, signing, toolchain selection, and existing user changes were not changed for this review.

## Workspace and evidence boundary

- Open project: `/Users/nihar/Desktop/Bitrig Hack/DuoApp`; Git root: `/Users/nihar/Desktop/Bitrig Hack`.
- Branch at the last check: `native/contracts-standby`; HEAD: `d0e4243dbbcb5efe67153d1897d3e5f72a7c7550`. The branch name did not change during this review, but HEAD advanced several times while other lanes worked. At the last check, the app directory had no local modifications; four files under `../docs/` were modified and two were untracked. This report is an additional untracked file.
- Selected toolchain: Xcode 27.1, build `27A9269`, at `/Applications/Xcode-27.1-beta.app/Contents/Developer`. Installed simulator runtimes: iOS 27.0 (`24A5370g`) and iOS 27.1 (`24A94401`). Xcode's Duo device is `AF299D52-1471-4F63-9B56-877C15E9C8A4`; ordinary iPhone 17 Pro is `70F305D8-F91D-41F6-8BDD-2573B1559F40`.
- Bitrig selected the iPhone family with iPhone Duo visibly rendered in its preview. Its simulator inventory exposed `dev.outerlens.DuoApp/iphone` and `dev.outerlens.DuoApp/ipad`. The earlier failed build log identifies `DerivedData/builtin-simulator/DuoApp-simulator-iphone-Debug-cbc947d268` and compilation for `arm64` and `x86_64`. Its exact source revision cannot be certified because HEAD moved during that build. The failure matches `7e6eb80` source.
- Fresh setup check on `d0e4243dbbcb5efe67153d1897d3e5f72a7c7550`: HEAD and the app-code dirty state were the same before and after one native Bitrig build. `build_project` returned `{"diagnostics":[],"result":"success"}`; the filtered build log contained `** BUILD SUCCEEDED **`. Bitrig's Duo preview initially remained on its home screen. Launching the already-installed `dev.outerlens.DuoApp` on the booted Duo simulator returned PID `83568`, and Bitrig's simulator screenshot then showed the Outer Lens app. Launch evidence: `/tmp/outer-lens-duo-d0e4243-launch.png`.
- A separate, fixed snapshot of commit `e538562a15f3686767f4b946b966162f0b67d436` was archived under `/tmp/outer-lens-qa-snapshot-e538562a`. Its ordinary iPhone 17 Pro Debug simulator build **passed** with Xcode 27.1. Log: `/tmp/outer-lens-qa-snapshot-e538562a/iphone-build.log`, ending `** BUILD SUCCEEDED **`. This older commit does not include the later RC implementation that fails in Bitrig.

## Checks

| Check | Destination | Result | Evidence and limit |
| --- | --- | --- | --- |
| Toolchain and iOS 27.1 runtime available | Host | PASS | `xcodebuild -version` and `xcrun simctl list runtimes` returned the versions above. |
| Fixed-revision Debug compile | iPhone 17 Pro, iOS 27.0 | PASS | Xcode build log for commit `e538562a` ends `** BUILD SUCCEEDED **`. Compile only, not a current app preview. |
| Previous Bitrig Debug compile | Built-in iPhone simulator | FAIL, historical | Bitrig returned `** BUILD FAILED **` with `Monetization/Entitlements.swift:19:40: error: property cannot be declared public because its type uses an internal type`. `EntitlementsModel.state` was public in `7e6eb80`; the error preceded the `d0e4243` fix. |
| Fresh Bitrig Debug compile | Built-in iPhone simulator, Duo selected | PASS | One `build_project` run on `d0e4243` returned success with no diagnostics, and the build log contained `** BUILD SUCCEEDED **`. No app-code changes were present before or after the build. |
| Duo simulator shell and pose controls | Bitrig built-in preview, Duo selected | PASS | Simulator accessibility tree showed the home screen. Bitrig UI showed the Duo home screen, `Fully Open`, `Partially Open`, `Closed`, `Seated`, and `Standing` controls. I selected `Fully Open` and observed its selected state, then restored `Partially Open`. Nihar also reported seeing the home screen and fold controls after Bitrig restarted. This passes only simulator-shell readiness. |
| Current app launch | Bitrig Duo preview, `d0e4243` | PASS | After the successful build, `simctl launch` returned PID `83568`. The Bitrig simulator screenshot showed the Outer Lens wordmark, black capture surface, subject control, and shutter. Screenshot: `/tmp/outer-lens-duo-d0e4243-launch.png`. This is first-frame evidence for TC-S01, not feature or pose acceptance. |
| Current app launch and visual QA | Bitrig ordinary iPhone preview | NOT RUN after fresh build | The previous attempt, before the passing build, returned `Simulator state is stale because project files changed. Run build_project successfully before using simulator state tools again.` This setup pass kept Duo selected and did not switch to an ordinary iPhone. |
| Previously installed app launch | Xcode iPhone 17 Pro and Duo simulators | PASS, historical only | `simctl launch dev.outerlens.DuoApp` returned process IDs on both. Screenshots outside the repo: `/tmp/outer-lens-iphone-existing-install.png` and `/tmp/outer-lens-duo-existing-inner.png`. The iPhone showed an Outer Lens placeholder; Duo showed an older capture shell with an unavailable subject-screen message. Both installed executable hashes differed from the newly built binary. They are not evidence for the current checkout or a visual acceptance pass. |
| Flat, tabletop, book, closed app states | Bitrig Duo preview | NOT RUN | The app launched, but this narrowed setup pass did not exercise app pose transitions. No pose-specific app screenshots were taken. A previous capture of Duo display 2 through `simctl` did not complete and was stopped; no outer-display image is claimed. |
| Legibility, clipping, contrast, control placement, Dynamic Type, Reduce Motion, interaction flow | Current app on both devices | NOT RUN | The Duo first frame was observed, but these checks require separate interactions and settings changes. |
| Camera accessory, RevenueCat purchase, other-display unlock, timed demo | Current app | NOT RUN | These require a successful build and observed interactions. No RC ID, purchase, hardware, or visual pass is inferred from source or simulator controls. |

## Static observations, not visual passes

- The failed build's compiler error is in RC-owned `Monetization/Entitlements.swift`. The access-level mismatch was visible in `7e6eb80`. In `d0e4243`, the property is no longer public and the fresh Bitrig Debug build passed. RC runtime behavior remains untested.
- The inspected root routes Outer Lens to `InnerCaptureView`. At the inspected revision, `InnerCaptureView` used a black preview stand-in and a shutter action awaiting capture wiring. This is source inspection only and may change as other lanes land work.
- `PoseRouter` separates `effectAngle` from its pose classification and the root uses size class and reserved-region hints. This is a static code observation, not TC-S02 pose-remap proof.
- Film Tool colors and motion constants are present in `DesignSystem/Tokens.swift` and `DesignSystem/Motion.swift`; the ASSETS acceptance tests remain unverified on screen. No ASSETS edits are authorized until the recorded handoff.

## Owner actions

1. **Integrator / Bitrig build owner:** Preserve the passing `d0e4243` setup evidence. Run an ordinary iPhone destination separately when that check is assigned, recording HEAD and dirty state around the run.
2. **Bitrig visual QA:** In a follow-up visual pass, inspect flat, tabletop, book, and closed Duo states; capture each outside the repo with the source revision; then check tip and control readability, clipping, contrast, Dynamic Type, Reduce Motion, and demo interactions. Record PASS or FAIL per observed state.
3. **LANE-RC:** Verify purchase and other-display unlock separately. The passing compile and first app frame do not establish RC behavior.
4. **ASSETS owner and Orchestrator:** Record the file handoff before Bitrig edits tokens, motion, or assets. Nihar retains demo gate and rehearsal decisions.

Planned capture order once a current Duo app launches: (1) flat, inner capture with visible outer subject stage; (2) tabletop, media above and controls below; (3) book, both roles visible; (4) closed, outer continuation; (5) free tip to Pro other-display result, if purchase wiring is working. This is a shot list, not completed footage. No video was recorded.

## Coordinator handoff, not visual QA results

The coordinator reports that Cursor reproduced the same iOS 27.1 Debug error on `origin/main` at `7e6eb80`. The coordinator also reports that `PurchasesConfig` logs the Test Store key when invoked, Release configuration is missing, and no live purchase or unlock has been observed. The key is intentionally omitted here. Cursor is regenerating the project in an isolated checkout to include `OfferingsRepository.swift`. The coordinator identifies a cutover contract mismatch: the current reader accepts `true` and `frostDuo`, while frozen sections 12 and 18 require exact `frost`. The `docs-runtime` path inside `DuoApp` is correct. These are owner findings and ongoing work, not checks passed by this Bitrig visual QA run. RC, integration, and cutover owners should resolve them within their lanes.
