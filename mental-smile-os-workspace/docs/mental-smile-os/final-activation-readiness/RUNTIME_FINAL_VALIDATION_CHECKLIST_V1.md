# RUNTIME_FINAL_VALIDATION_CHECKLIST_V1

## Checklist

- [ ] Run runtime smoke validation.
- [ ] Run route smoke validation.
- [ ] Validate Splash.
- [ ] Validate Login.
- [ ] Validate Home/Menu.
- [ ] Validate Client Registration.
- [ ] Validate Client runtime surface.
- [ ] Validate Provider runtime surface.
- [ ] Validate Center runtime surface.
- [ ] Validate Library runtime.
- [ ] Validate Owner protected routes.
- [ ] Validate Monitoring protected routes.
- [ ] Validate signal event creation.
- [ ] Validate no direct cross-zone runtime mutation.
- [ ] Validate no admin authority is required.

## Commands

```powershell
flutter pub get
flutter analyze
flutter test
flutter build web
```
