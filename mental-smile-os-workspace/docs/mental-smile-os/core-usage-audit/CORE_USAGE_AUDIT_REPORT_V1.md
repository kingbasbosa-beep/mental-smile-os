# CORE_USAGE_AUDIT_REPORT_V1

## Result

All known active references to `mental_smile_clean_core` were documented.

## Findings

| Finding | Result |
| --- | --- |
| Direct dependency exists | YES |
| Lockfile entry exists | YES |
| Direct runtime `lib/` import exists | NO |
| Direct test import exists | YES |
| Source repository path reference exists | YES |
| Generated import found | NO |
| `analysis_options.yaml` dependency/reference found | NO |

## Counts

Files importing/referencing `mental_smile_clean_core`: 4

Used symbols/classes/functions: 3

## Used Symbols

- `AuditActorType`
- `AuditActorType.admin`
- `AuditActorTypeKey.key`

## Complexity Score

MEDIUM

## Recommended Extraction Strategy

Multiple waves:

1. Replace proof test with OS-owned test.
2. Remove dependency from `pubspec.yaml` and regenerate `pubspec.lock`.
3. Keep or retarget the Construction Workbench source repository path separately.
4. Archive or move the `mental_smile_clean_core` folder only after Owner approval.

## Safe To Attempt Wave 1 Extraction?

YES.

Wave 1 is safe if limited to replacing the proof test and validating.

Do not remove the dependency or source folder in the same step unless Owner explicitly expands scope.

## Validation Commands To Document Only

```powershell
flutter pub get
flutter analyze
flutter build apk --debug
flutter build web
```

## Boundary Confirmation

- No runtime modified.
- No dependency removed.
- No file moved.
- No Firebase edited.
- No deploy.
- No push.
- No commit.

