# ANDROID_BUILD_VALIDATION_SEQUENCE_V1

## Objective

Validate Android debug build readiness without changing package identity.

## Exact Sequence

1. Confirm Android namespace/applicationId status:
   - Current: `com.mentalkey.app.flutterprojects`
   - Target decision remains separate under identity execution authorization.
2. Confirm no namespace migration is included in this validation pass.
3. Run:

```powershell
flutter build apk --debug
```

4. Confirm APK debug build completes.
5. Record Android warnings.
6. Confirm no Google Play publish action is performed.

## Pass Criteria

- Debug APK builds.
- No Android manifest failure.
- No Gradle namespace failure.
- No missing asset/localization failure.

## Known Watch Areas

- Legacy namespace warning.
- Firebase Android config alignment.
- Android label.
- Kotlin package path.

