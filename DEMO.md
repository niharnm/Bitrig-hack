# Insider demo

Insider learns the angle you look best from, then guides whoever holds the phone to it.
The iPhone Duo's two displays split the job: INNER coaches the photographer, OUTER shows you the match.

No camera on the simulator, so the phone's position is simulated. Tap an arrow (or drag the stage) to "move the phone".

## Run it

Needs Xcode 27.1.

```bash
cd DuoApp && DEVELOPER_DIR=/Applications/Xcode-27.1-beta.app/Contents/Developer xcodebuild build -project DuoApp.xcodeproj -scheme DuoApp -destination "platform=iOS Simulator,name=iPhone Duo,OS=27.1"
```

Start fresh at account creation (clears the saved account, angles, and Pro):

```bash
xcrun simctl launch --terminate-running-process "iPhone Duo" dev.outerlens.DuoApp -resetDemo YES
```

For the AI step, add a few selfies to the simulator first (drag image files onto the simulator window).
With no faces in the picked photos the app says so and you set angles by hand.

## Tap path

1. **Create account**: type a name, tap Create account.
2. **Set your angles**: pick Camera height, Your good side, Framing. The stick figure previews the angle.
3. **Pro (payments)**: Let AI find your best angles, then Unlock with Pro, then Unlock Pro. The RevenueCat Test Store dialog appears; choose Test valid purchase. If the store fails, a "Simulate purchase (demo)" button appears.
4. **AI analysis**: Choose favorite photos. On-device face detection reads head turn, tilt, and face size in each photo and sets your angles.
5. **Save my angles**: the Duo splits into two panes.
   - INNER (photographer): your stick figure, a dashed amber ghost of your saved angle, arrows (Raise, Lower, Left, Right, Closer, Back), one instruction line.
   - OUTER (you): how you look right now and a live match percentage.
6. **Follow the arrows**: each tap moves the phone. Three taps per arrow; the match climbs to 100% and turns green, "Perfect angle. Take it."
7. **New stranger** resets the phone off-angle. The account button has Edit my angles and Sign out.
