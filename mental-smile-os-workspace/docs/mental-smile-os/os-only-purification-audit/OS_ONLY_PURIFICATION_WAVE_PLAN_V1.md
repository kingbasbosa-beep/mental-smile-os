# OS_ONLY_PURIFICATION_WAVE_PLAN_V1

## Wave 1: Safe Internal Runtime Symbol Cleanup

Status: SAFE

Scope:

- Rename `MentalKeyApp` to `MentalSmileOSApp`.
- Rename `buildMentalKeyTheme` to `buildMentalSmileOSTheme`.
- Update references in `lib/main.dart` and `lib/app/app.dart`.
- Optionally rename test wording from `clean core` to `source core package`.

Validation:

- `dart format` on changed Dart files.
- `flutter analyze`.
- `flutter test` if Owner wants.
- `flutter build apk --debug` if Owner wants release-candidate confidence.

Forbidden in Wave 1:

- Firebase project ID changes.
- `.firebaserc` changes.
- `firebase.json` changes.
- `lib/firebase_options.dart` changes.
- GitHub Actions Firebase project changes.
- Android `applicationId` changes.
- File deletion or archive movement.

## Wave 2: Public Link / Domain Alignment

Status: OWNER_DECISION_REQUIRED

Scope:

- Replace `https://mental-smile-app-clean.web.app` with final public Mental Smile URL when chosen.

Blocked by:

- Final domain/hosting decision.

## Wave 3: Android Identity Decision

Status: OWNER_DECISION_REQUIRED

Scope:

- Decide whether to keep `com.mentalkey.app.flutterprojects` for continuity or migrate applicationId.

Blocked by:

- Google Play continuity decision.
- Firebase Android app registration decision.
- `google-services.json` alignment.

## Wave 4: Firebase Project Identity Decision

Status: OWNER_DECISION_REQUIRED

Scope:

- Decide whether `mental-smile-app-clean` remains the production Firebase project or whether a new Mental Smile OS project is created.

Blocked by:

- Firebase project ownership.
- Hosting continuity.
- Auth/user data continuity.
- Rules and Functions validation.

## Wave 5: Historical Documentation Normalization

Status: OPTIONAL

Scope:

- Only clarify old references that are ambiguous.
- Do not remove archive evidence.

## Safe First Cleanup Recommendation

Start with Wave 1 only.

