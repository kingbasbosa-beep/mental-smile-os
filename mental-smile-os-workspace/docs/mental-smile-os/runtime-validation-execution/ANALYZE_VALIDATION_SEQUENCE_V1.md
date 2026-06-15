# ANALYZE_VALIDATION_SEQUENCE_V1

## Objective

Validate that the active Flutter runtime compiles semantically before build execution.

## Exact Sequence

1. Confirm working branch and git status.
2. Confirm no unrelated patch is staged for validation.
3. Run dependency resolution:

```powershell
flutter pub get
```

4. Run static analysis:

```powershell
flutter analyze
```

5. Record every error and warning.
6. Classify findings:
   - BLOCKER
   - WARNING
   - ACCEPTED_TEMPORARY_IDENTITY_RESIDUE
   - NON_BLOCKING_LINT
7. Stop if analysis produces compile-breaking errors.

## Pass Criteria

- `flutter pub get` succeeds.
- `flutter analyze` produces no build-blocking errors.
- Any remaining warnings are documented and accepted by Owner before production activation.

## Known Watch Areas

- `package:flutterprojects` import identity.
- `mental_smile_clean_core` dependency.
- Generated localization imports.
- Firebase initialization references.
- Router imports.

