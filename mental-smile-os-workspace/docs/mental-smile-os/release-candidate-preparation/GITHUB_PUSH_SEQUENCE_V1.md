# GITHUB_PUSH_SEQUENCE_V1

## Objective

Prepare a safe GitHub push sequence for the release candidate.

## Exact Sequence

1. Run `git status --short`.
2. Review all modified and untracked files.
3. Decide whether `.firebase/` remains excluded from staging.
4. Decide whether `mental-smile-os-runtime/` is included.
5. Decide whether forensic, constitutional, execution, and validation docs are included.
6. Stage only Owner-approved files.
7. Review staged diff.
8. Create one release candidate commit only after Owner approves commit scope.
9. Confirm target branch.
10. Push only after Owner explicitly confirms.

## Required Commands For Later Execution

```powershell
git status --short
git diff --staged
git branch --show-current
```

## Forbidden Without Owner Confirmation

- `git push`
- branch creation for release
- release tag
- production deploy trigger

