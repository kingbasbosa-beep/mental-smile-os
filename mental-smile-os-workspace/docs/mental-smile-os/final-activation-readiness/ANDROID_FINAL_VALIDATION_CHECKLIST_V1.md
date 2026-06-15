# ANDROID_FINAL_VALIDATION_CHECKLIST_V1

## Checklist

- [ ] Decide Android applicationId option.
- [ ] Confirm namespace decision.
- [ ] Confirm `google-services.json` alignment.
- [ ] Confirm release signing readiness.
- [ ] Build debug APK.
- [ ] Validate app label is `Mental Smile`.
- [ ] Validate package identity warnings are accepted or resolved.
- [ ] Confirm Google Play publish remains forbidden without explicit authorization.

## Commands

```powershell
flutter build apk --debug
```

## Owner Decision Required

Android applicationId decision remains owner-gated.
