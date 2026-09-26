# Event demo (two-pane stand-in)

No physical iPhone Duo and no simulator camera. The app launches straight into a two-pane stand-in:

- **INNER**: charcoal Film Tool stage with a drawn stand-in subject, plus the tip buttons and **Pro**.
- **OUTER**: one amber tip plate. Pro adds the dashed amber pose overlay.

Capture session, CameraCaptureAccessory, and permission screens are off the launch path
(`DuoApp/App/DuoAppApp.swift` now hosts `OuterLensDemoView`; `RootArrangementView` is untouched).

## Run it

Needs Xcode 27.1 (Xcode 27.0 is missing the Duo SDK symbols and fails to build).

```bash
cd DuoApp && DEVELOPER_DIR=/Applications/Xcode-27.1-beta.app/Contents/Developer xcodebuild build -project DuoApp.xcodeproj -scheme DuoApp -destination "platform=iOS Simulator,name=iPhone Duo,OS=27.1"
```

Or open `DuoApp/DuoApp.xcodeproj` in Xcode 27.1, pick **iPhone Duo**, press Run.

Before going on stage: relaunch the app so Pro is off and the subject is centered.
If you rehearsed with Pro on, open **Pro** and tap **Turn Pro off for rehearsal**.

## 70 second tap script

| Time | Tap | What the room sees | Say |
|------|-----|--------------------|-----|
| 0-10s | nothing (or **Reset**) | Subject centered, outer reads "Look at the outer" | **Brad:** "Parents photographing kids can't see framing or pose while they shoot. Duo's outer is the subject coach; free outer preview, Pro pose overlays." Then once: "No Duo in the room; this stand-in is the subject Capture Accessory would drive." |
| 10-20s | **Step left** | Subject slides left and leans; outer plate reads "Step left" | Point at the outer plate. |
| 20-30s | **Chin up** | Subject rises, eyes lift; outer reads "Chin up" | Point at the outer plate again. |
| 30-40s | **Hold still** | Subject freezes, "…" appears; outer reads "Hold still" | Let it sit for a beat. |
| 40-55s | **That's the shot** | Quick flash, subject settles with a bigger smile; outer reads "That's the shot" | "That's the shot." |
| 55-70s | **Pro**, then **Simulate Test Store purchase** | Sheet closes, amber guide oval lands around the subject and a pose overlay appears on the outer | **Matt:** "Free: outer preview. Pro: pose overlays on the outer display." |

## If something goes wrong

- A tap does nothing: tap again and hold a touch longer. There is no network or camera dependency on this path.
- The oval is already showing: Pro was left on. Use **Turn Pro off for rehearsal** or relaunch.
- Pro here is a simulated purchase. No real RevenueCat purchase runs and no store account is used.
