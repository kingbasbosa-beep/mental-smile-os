# EX-92 EscalationRequest Execution Readiness

## Current Readiness

Execution is not approved in EX-92. The request metadata boundary is frozen, but `EscalationBoundaryMarker` remains a blocker for direct additive execution.

## Future Simulation Preconditions

EX-93 may simulate a metadata-only additive split if it preserves:

- existing host compatibility path;
- host-owned Firestore mapper responsibilities;
- exclusion of `boundaryMarker`;
- exclusion of queue/routing logic;
- no package imports into `clean_core/lib/core`;
- no reconnect or consumer migration.

## Future Mapper Responsibilities

A future host mapper must own:

- `cloud_firestore` import
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- Firestore field names
- null handling
- vocabulary `.key` serialization
- nested audit-link serialization
- nested policy-reference serialization
- boundary marker serialization, if compatibility with existing host storage shape is preserved

## Rollback Boundary

Rollback can remain local only if future execution is additive and limited to:

- future package request model;
- future host mapper;
- one explicit package export.

Rollback is not local if boundary marker, queue logic, or consumer imports are moved.

## Execution Readiness Verdict

EX-93 should be simulation only. Execution remains blocked until simulation confirms the metadata-only shape and boundary exclusion.
