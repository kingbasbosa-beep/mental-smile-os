# clean_core Audit Lane Backend Authority Flags

This review flags backend authority concerns in the audit lane.

## Backend-Sensitive Concepts

- `AuditActorType.trustedServer`
- `AuditVisibilityScope.trustedServerOnly`
- `AuditEventType.protectedWriteDenied`
- `AuditEventType.safetyReviewRequired`
- `AuditReference.collectionPath`
- `AuditSnapshot.immutable`

These are contract labels and do not grant backend authority by themselves.

## Authority Rules

Future extraction must preserve:

- backend owns trusted execution
- backend owns protected writes
- backend owns audit persistence where sensitive
- clean_core defines references and markers only
- audit records do not prove authority unless backend-signed or backend-created

## Backend-Owned Semantics

Firestore persistence, server timestamps, immutable snapshot storage, and trusted audit creation remain backend/host-owned.

## Backend Authority Verdict

Audit contracts are useful for backend boundaries, but they must not be interpreted as backend authority or trusted persistence implementation.
