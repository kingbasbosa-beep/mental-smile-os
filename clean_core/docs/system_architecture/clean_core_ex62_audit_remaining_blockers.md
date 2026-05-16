# EX-62 Audit Remaining Blockers

Phase: EX-62 - Audit Dependency Vocabulary Review

## Unresolved Authority Semantics

Remaining authority caveats:

- `trustedServer` and `admin` actor labels are not authority proof.
- `protectedWriteDenied` is not enforcement.
- `visibilityScope` is not access control.
- `AuditReference` is not integrity proof.

## Unresolved Privacy Semantics

Privacy-sensitive areas:

- `actorId` in future audit event model
- `sanitizedPreview`
- `AuditReference.collectionPath`
- `AuditReference.documentId`

## Serialization Ownership

`AuditReference.toMap()` is generic, but future Firestore mapper must own persistence interpretation and nested reference mapping.

## Runtime Semantics

`AuditEventType.runtimeDisabled` and `providerRejected` are labels only.

Runtime execution remains outside package.

## Remaining Blocker Finding

The remaining blockers are caveat and mapper-ownership issues, not implementation impurity in the vocabulary contracts.

