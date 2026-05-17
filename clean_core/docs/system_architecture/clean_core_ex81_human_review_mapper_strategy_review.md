# EX-81 Human Review Mapper Strategy Review

## Package-Safe Fields

`EscalationAssignment`:

- `escalationId`
- `assignedTo`
- `assignedBy`
- `state`
- `assignedAt`

`EscalationResolution`:

- `escalationId`
- `resolvedBy`
- `state`
- `outcomeKey`
- `sanitizedResolutionNote`
- `auditLink`
- `resolvedAt`

`EscalationReview`:

- `escalationId`
- `reviewerId`
- `state`
- `sanitizedReviewNote`
- `auditLink`
- `reviewedAt`

## Host-Side Responsibilities

Must remain host-side:

- `cloud_firestore`
- `toMap`
- future `fromMap`, if added
- Firestore field names
- `FieldValue.serverTimestamp()`
- `Timestamp` conversion
- nested audit-link serialization
- null handling
- compatibility paths

## Strategy

Use additive mapper split only:

1. semantic freeze
2. package model introduction
3. host-side mapper introduction
4. compatibility path retained
5. no reconnect or consumer migration

## Rollback

Rollback can remain local to new package model, new mapper, and one explicit export per record if introduced separately.
