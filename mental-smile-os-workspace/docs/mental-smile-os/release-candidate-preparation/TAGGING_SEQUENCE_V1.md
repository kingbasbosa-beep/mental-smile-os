# TAGGING_SEQUENCE_V1

## Objective

Define the release candidate tagging sequence without creating a tag.

## Recommended Tag Pattern

`generation-1-rc-1`

## Exact Sequence

1. Confirm release candidate commit hash.
2. Confirm branch name.
3. Confirm validation reports are attached or referenced.
4. Confirm Firebase deploy has not been performed unless separately approved.
5. Confirm Google Play publish is not part of this tag.
6. Owner approves tag name and commit hash.
7. Create tag only after approval.
8. Push tag only after separate approval.

## Required Commands For Later Execution

```powershell
git log -1 --oneline
git tag --list
```

## Forbidden Without Owner Confirmation

- creating release tag
- pushing release tag
- associating tag with production deploy

