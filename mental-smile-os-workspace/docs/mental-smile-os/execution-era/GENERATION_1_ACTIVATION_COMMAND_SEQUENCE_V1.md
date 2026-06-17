# Generation 1 Activation Command Sequence V1

Status: COMMAND_SEQUENCE_PREPARED
Prompt Asset: PROMPT_ASSET_066

## Purpose

Define the safe command sequence for production activation preparation.

## Phase 1: Safety Verification

```powershell
git status
git branch --show-current
```

Expected:

- Branch is `ai-lab`.
- Existing changes are reviewed before commit.
- No destructive cleanup is performed.

## Phase 2: Dependency Preparation

```powershell
flutter pub get
```

Expected:

- Dependencies resolve.
- No legacy packages are introduced without review.

## Phase 3: Static Validation

```powershell
flutter analyze
```

Expected:

- Runtime imports valid.
- YAML references valid.
- No unresolved generated assets.

## Phase 4: Tests

Run tests only if a test directory or configured tests exist:

```powershell
flutter test
```

Expected:

- Existing test suite passes.
- If tests do not exist, record as `NO_TESTS_PRESENT`.

## Phase 5: Firebase Local Check

Run only if Firebase emulators are configured:

```powershell
firebase emulators:start --only firestore,storage
```

Validation purpose only. No deploy.

## Forbidden Commands In This Pack

```powershell
firebase deploy
git push
git reset --hard
git checkout -- .
Remove-Item -Recurse
flutter build appbundle
```

These require separate Owner confirmation.

