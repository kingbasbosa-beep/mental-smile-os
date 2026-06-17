# Rollback Evidence Registry V1

Status: ROLLBACK_EVIDENCE_PRESERVED

## Rollback Evidence

| Evidence | Purpose | Keep |
| --- | --- | --- |
| `android/app/google-services.json.backup-before-mental-smile-platform-cutover` | Restore previous Android Firebase app config if needed | YES |
| `ROLLBACK_APPLICATION_ID_CARD_V1.md` | Documents applicationId rollback method | YES |
| `ROLLBACK_FIREBASE_HOSTING_CARD_V1.md` | Documents Firebase hosting rollback method | YES |
| `ROLLBACK_CARD_V1.md` | General cutover rollback doctrine | YES |
| `OLD_INFRASTRUCTURE_EVIDENCE_CARD_V1.md` | Captures old infrastructure identity | YES |
| Git history | Full source rollback line | YES |

## Rollback Boundary

Rollback evidence may describe legacy identities. That does not make those identities active.

## Current Rollback Risk

Partial alignment creates risk: Android config now points to Mental Smile Platform while runtime Firebase options still point to legacy Firebase. Rollback evidence is preserved, but forward completion is recommended before deploy.

Result: ROLLBACK_EVIDENCE_COMPLETE
