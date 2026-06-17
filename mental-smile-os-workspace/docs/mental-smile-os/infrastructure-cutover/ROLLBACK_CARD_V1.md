# Rollback Card V1

## Identity

Card ID: ROLLBACK_CARD_V1

Purpose: Define rollback method for future infrastructure cutover.

Status: PREPARED_NOT_USED

## Current Rollback Need

No rollback is needed now because no infrastructure cutover was performed.

## Future Rollback Targets

If cutover is later performed, rollback must restore:

1. `android/app/build.gradle.kts`
2. `android/app/google-services.json`
3. `.firebaserc`
4. `firebase.json`
5. `lib/firebase_options.dart`, if changed
6. GitHub Actions workflows, if changed
7. Firebase project selection

## Future Rollback Method

1. Stop deployment.
2. Restore backed-up files.
3. Run `flutter clean`.
4. Run `flutter pub get`.
5. Run `flutter analyze`.
6. Run `flutter build apk --debug`.
7. Verify `firebase use`.
8. Do not deploy rollback without Owner confirmation.

## Risk Level

HIGH.

Rollback touches runtime identity and backend linkage.
