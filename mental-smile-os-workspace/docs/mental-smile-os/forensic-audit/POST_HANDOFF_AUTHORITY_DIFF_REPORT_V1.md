# POST_HANDOFF_AUTHORITY_DIFF_REPORT_V1

## Authority Changes

| Area | Change | Classification | Doctrine Match |
|---|---|---|---|
| Storage owner authority | New `isOwnerAuthority()` helper uses `request.auth.token.role == 'owner'`. | EXPECTED | Matches Owner Authority and Admin Zero direction. |
| Storage admin authority | Removed `isAdmin()`, removed `role == 'admin'`, removed `admins` collection fallback. | EXPECTED | Matches Admin Zero. |
| Firestore authority | No post-handoff change detected. | ACCEPTABLE | No admin grant found. |
| Route authority | Construction Workbench added to `_ownerOnlyRoutes`. | ACCEPTABLE_WITH_WARNING | Owner-protected; review because executable surface exists. |
| GitHub/Firebase deploy authority | GitHub Actions can deploy Firebase Hosting live on push to `ai-lab`. | ACCEPTABLE_WITH_WARNING | Operationally powerful; requires owner confirmation before treating as production-safe. |

## Active Authority Sources

- Firestore: custom claims through `request.auth.token.role`.
- Storage public asset writes: owner custom claim.
- Storage user-owned file writes: authenticated UID ownership plus role checks for clinician/center paths.
- App route protection: `AccountAccessService` and route role gates.
- Functions: Firebase Admin SDK server authority.

## Authority Warnings

1. Storage still uses Firestore document fallback for clinician/center identity.
2. Firestore rules still duplicate `isMonitoringOperator()`.
3. GitHub Actions live deployment on branch push should be treated as production authority, not just CI convenience.

## Owner Bypass Search

No active code or rules phrase indicating owner bypass of registry/audit/compliance was found.
