# YAML_FINAL_VALIDATION_CHECKLIST_V1

## Checklist

- [ ] Review `pubspec.yaml` package name decision.
- [ ] Review all asset declarations.
- [ ] Detect old asset paths.
- [ ] Detect duplicate asset paths.
- [ ] Validate active assets exist.
- [ ] Confirm no unregistered asset enters production.
- [ ] Scan localization ARB files for legacy identity residue.
- [ ] Scan localization for booking/session/payment/admin semantic residue.
- [ ] Validate fonts.
- [ ] Validate theme references.
- [ ] Run `flutter pub get`.
- [ ] Run `flutter analyze`.

## Forbidden Without Owner Confirmation

- package rename
- dependency removal
- asset deletion
- pubspec destructive cleanup
