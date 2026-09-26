# Bitrig capability research

Checked: 2026-09-26. Decision for Outer Lens: assign pose visualization, demo captures, and visual QA first; transfer ASSETS polish only after a file handoff and a successful local preview check.

Confidence: moderate for this task fit, low for claims that Bitrig generates better code than Cursor or Codex. No controlled comparison was found or run. Bitrig hosts coding agents, so results depend on the selected agent, context, and tools as well as the application.

## Evidence reviewed

Public Reddit discussions, Hacker News, a developer's published experience and GitHub examples, a hands-on press review, vendor release notes, and the installed application were reviewed. Dates below distinguish older iPhone/interpreter reports from the current Mac workflow. Repeated posts of the same demo count as one example. Promotional posts and competitor comparisons are not independent benchmarks.

| Source and date | What it supports | Limits and relevance |
| --- | --- | --- |
| [Reddit, Duo UX demo](https://www.reddit.com/r/UXDesign/comments/1wm2acl/i_think_im_addicted_to_the_iphone_duo/), Sep 21, 2026 | The developer reports using Bitrig for the demo video and describes its folding controls as more intuitive than the Xcode interaction. | One self-reported example. Supports pose presentation and demonstration, not superior code generation. |
| [Reddit, same dog-tracker demo in iosdev](https://www.reddit.com/r/iosdev/comments/1wlrj2w/i_think_im_addicted_to_developing_for_the_iphone/), Sep 21, 2026 | The author again identifies Bitrig as the environment for improved 3D models and animations; notes the simulator update prerequisite. | Duplicate evidence from the same app, not a second independent success. |
| [Reddit, SwiftUI HIG discussion](https://www.reddit.com/r/SwiftUI/comments/1whgsiw/ai_coding_agents_are_confidently_wrong_about/), Sep 15, 2026 | One commenter says Bitrig addressed their problem with AI-generated UI. | No reproducible test, diff, or comparison accompanies that claim. Too weak to establish HIG compliance or coding superiority. |
| [Reddit, native Swift overview](https://www.reddit.com/r/ThatAppleGuide/comments/1ugqkhd/bitrig_makes_building_a_native_swift_app_easier/), Jun 27, 2026 | Describes native code, inline preview, and export. | Mostly promotional framing and team credentials. Not evidence of reliability. |
| [Reddit, App Store discussion](https://www.reddit.com/r/iosdev/comments/1mwcvh1/how_did_this_app_get_through_app_store_review/), Oct 23, 2025 comment | A user reports attractive in-app results but repeated TestFlight failure and delayed support. | Older iPhone product. A caution about checking the actual deployment path, not proof of a current Mac limitation. |
| [Launch HN discussion](https://news.ycombinator.com/item?id=45041185), Aug 2025 | Users report pleasant UI output alongside placeholder API data and lost work while moving between screens. Founder replies acknowledge those areas needed improvement. | Historical launch behavior. Does not establish that these bugs remain in September 2026. |
| [Amos Gyamfi, month of daily use](https://www.linkedin.com/pulse/2026-year-building-ios-apps-your-iphone-amos-gyamfi-c6lff), Jan 2026 context | Reports useful SwiftUI experiments but unfulfilled feature claims and occasions requiring fixes in Cursor or Xcode. | Single-file interpreter, framework, and iPad limitations described here predate the current Mac releases. Do not carry them forward as current restrictions. |
| [Open SwiftUI Apps](https://github.com/amosgyamfi/open-swiftui-apps), inspected Sep 26, 2026 | Public source examples include a configurable shimmer playground and calculator; the maintainer attributes work to Bitrig with Claude and Codex models. | README and repository inspected; examples were not built or tested. Supports a visible UI experimentation use case, not production readiness. No source was copied into Outer Lens. |
| [Tom's Guide hands-on review](https://www.tomsguide.com/ai/i-tried-an-app-that-makes-apps-using-ai-on-my-iphone-and-it-felt-like-the-future), 2025 | The reviewer reports a working simple reminder example but nonfunctional controls in other generated apps. | Older iPhone version and a small test sample. Reinforces interaction testing rather than judging only screenshots. |
| [Ars OpenForum firsthand report](https://arstechnica.com/civis/threads/adventures-coding-with-ai.1501554/page-52), Jul 3, 2026 | A user describes a useful Mac audio utility made in Bitrig, with an export crash. | One anecdote. Suggests small native utilities can be productive while output paths still need testing. |

## Current capabilities documented by the vendor

These are advertised capabilities, checked against current release notes. Local availability and task success still need verification.

| Capability | Primary source | Assignment implication |
| --- | --- | --- |
| Native Xcode compilation and inline simulator | [Mac release, Mar 5](https://bitrig.com/blog/meet-bitrig-for-mac) | Build and preview the existing Swift app in one surface. |
| Build-error inspection and multiple source files | [Agent release, Mar 31](https://bitrig.com/blog/meet-bitrig-agent) | Diagnose the preview blocker using actual errors. |
| Select UI elements and annotate screenshots as prompt context | [Selection editing, Jun 2](https://bitrig.com/blog/select-to-edit-in-the-simulator) | Make a small visual correction after the relevant owner hands off the file. |
| Screenshot and accessibility inspection, tapping, scrolling, rotating, and log inspection | [Simulator use, Jun 17](https://bitrig.com/blog/bitrig-simulator-use) | Exercise demo controls and check layout. Automated inspection is not a guarantee of accessibility compliance. |
| Bring Codex or other agents with existing configuration | [Agent choice, Aug 26](https://bitrig.com/blog/bring-your-own-coding-agents) | Treat Bitrig as the development environment. Use the selected Codex provider for this assignment. |
| Conversation worktrees and separate build data | [Parallel workspaces, Sep 3](https://bitrig.com/blog/run-parallel-agents) | Verify the actual workspace path and source snapshot before comparing results or merging. |
| Interactive 3D Duo poses with Xcode 27.1 beta and iOS 27.1 simulator prerequisite | [Duo release, Sep 18](https://bitrig.com/blog/bitrig-builds-iphone-duo-apps) | Best-supported distinct role: visualize fold transitions and prepare demo captures. |

## Task decisions

| Task | Fit and evidence | Decision |
| --- | --- | --- |
| Duo pose visualization and demo captures | Strongest independent task-specific signal, supported by the vendor's documented simulator | Assign to Bitrig once the local Duo preview works. Capture flat, tabletop, book, and closed states and the demo transition sequence. |
| Visual QA and interaction checks | Useful documented workflow; no independent reliability benchmark found | Assign now with evidence required for each pass. Diagnose preview first. |
| Small token, asset, and motion corrections | Selection editing and public UI examples make this a reasonable inference | Assign after current ASSETS owner hands off; check the result in the running app. |
| Capture/CCA architecture or pose routing | No evidence found that Bitrig's host environment improves correctness for these tasks | Keep existing owners. Simulator presentation cannot prove accessory hardware behavior. |
| RevenueCat setup and purchase correctness | The vendor advertises integration support, but no task-specific independent comparison was established | Keep the existing RC lane and its real dashboard IDs. |
| Whole-app takeover or automatic release | Historical reports are mixed; current local preview is unverified | No reassignment based on these sources. |

## Local validation gate

The installed app opens the existing folder and shows source code. Codex is selectable. A prior preview remained loading, and the ordinary Xcode destination picker did not list Duo. These are local observations, not proof that the advertised 3D simulator is absent.

The first Bitrig task must report its toolchain, actual workspace, tested revision and dirty state, preview errors, and a screenshot of a running app if available. Produce `DuoApp/docs-runtime/BITRIG-REVIEW.md`. Record blocked Duo checks explicitly. A second phase may collect demo captures outside the repo and implement handed-off ASSETS fixes. Keep the three-code-writer limit and existing file ownership.

## What remains unknown

- Whether the local Bitrig preview can currently run this project.
- Whether the required Duo toolchain and runtime are installed or selectable in Bitrig now.
- Whether Bitrig's supplied simulator tools are available to the selected Codex session.
- Comparative patch quality, task completion time, or reliability versus Cursor using the same model and task.
- Current end-to-end publishing reliability. The research did not test TestFlight or the App Store.

Search coverage was broad enough to find task-specific examples and contrary reports, but not exhaustive. Reddit reports were sparse and often repeated; they do not establish a community consensus.
