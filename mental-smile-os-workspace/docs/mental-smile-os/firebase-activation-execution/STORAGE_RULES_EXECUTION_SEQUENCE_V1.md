# STORAGE_RULES_EXECUTION_SEQUENCE_V1

## Objective

Prepare Firebase Storage rules for activation after Admin Zero cleanup.

## Current Authority Target

Owner privileged authority must remain:

```text
request.auth != null
&& request.auth.token.role == 'owner'
```

## Exact Execution Sequence

1. Open `storage.rules`.
2. Confirm `isOwnerAuthority()` exists.
3. Confirm `isOwnerAuthority()` does not use Firestore `admins` documents.
4. Confirm all former `isAdmin()` references are replaced.
5. Confirm file-owner helper `isOwner(uid)` is preserved as file ownership, not platform authority.
6. Review clinician and center helpers.
7. Decide whether Firestore role document fallback remains temporarily or becomes claim-only.
8. Confirm protected storage paths remain unchanged.
9. Confirm file size and type validation remains unchanged.
10. Confirm deny-all fallback remains active.
11. Run Storage rules validation.
12. Stop before deployment.

## Validation Points

```powershell
firebase deploy --only storage --dry-run
firebase emulators:start --only storage
```

## Approval Gate

Owner must approve the final decision for clinician/center Firestore fallback before production deploy.

