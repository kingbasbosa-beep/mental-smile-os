# FIRST_RELEASE_COMMIT_STRATEGY_V1

## Purpose

Define a safe first historical release commit strategy.

## Recommended Commit Shape

Use one historical commit for Generation 1 release candidate if Owner accepts the large documentation set.

Suggested message:

```text
Prepare Mental Smile OS Generation 1 release candidate
```

## Recommended Staging Scope

Stage:

- runtime identity migration files
- Android namespace migration files
- `firestore.rules` duplicate helper cleanup
- `pubspec.yaml`
- `pubspec.lock`
- updated test proof file
- Mental Smile OS documentation generated through Release Candidate V1
- prompt asset records through `PROMPT_ASSET_090`

Exclude:

- `.firebase/`

Owner decision:

- `mental-smile-os-runtime/`
- `forensic-audit/`

## Pre-Commit Checklist

1. Owner confirms staging scope.
2. Owner runs/accepts validation results.
3. `git status --short` reviewed.
4. `git diff --staged` reviewed.
5. No `.firebase/` staged.
6. No deploy/push/tag performed by commit step.

## Commit Status

Commit created: NO

Push performed: NO

Tag created: NO

