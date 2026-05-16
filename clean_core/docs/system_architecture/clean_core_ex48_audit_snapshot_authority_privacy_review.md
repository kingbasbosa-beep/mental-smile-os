# EX-48 Audit Snapshot Authority Privacy Review

Phase: EX-48 - audit_snapshot Split Design

## Authority-Sensitive Fields

Authority-sensitive fields:

- `createdBy`
- `policyVersion`
- `immutable`

These fields describe governance/audit posture but must not grant client-side authority.

## Privacy-Sensitive Fields

Privacy-sensitive or visibility-sensitive fields:

- `createdBy`
- `visibilityScope`
- `hashPlaceholder`

These should remain sanitized and non-diagnostic.

## Immutable Snapshot Semantics

`immutable` indicates snapshot posture, but pure contract ownership must not enforce persistence-level immutability.

Persistence immutability must be enforced by:

- backend authority
- Firestore rules
- signed operation policy later
- host/backend mapper discipline

## Backend Authority Caveat

The pure model may describe snapshot data. It must not decide:

- whether a snapshot is trusted
- whether a snapshot may be written
- whether a snapshot may be made immutable
- whether a policy version is active
- whether a client can publish or approve a snapshot

## Authority/Privacy Finding

`AuditSnapshot` can become a package-safe pure model only if backend authority and persistence enforcement remain outside the package.

