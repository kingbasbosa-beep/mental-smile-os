# EX-91 EscalationRequest Candidate Strategy

## Strategy Options

### Direct extraction

Blocked. Current file imports Firestore and owns serialization.

### Simple additive split

Not ready. The request model includes `EscalationBoundaryMarker`, which is not package-safe as-is.

### Additive split after semantic freeze

Possible if future package model excludes or detoxes `boundaryMarker` and treats all fields as passive metadata.

### Decomposition-first strategy

Recommended. Split the problem into:

- request metadata model;
- boundary marker detox/redesign;
- host Firestore mapper;
- queue/routing logic retained host/backend-side.

## Candidate Package Field Set

Potential request metadata fields:

- `uid`
- `level`
- `reason`
- `state`
- `priority`
- `visibilityScope`
- `sanitizedPreview`
- `auditLink`
- `policyReference`
- `createdAt`

Deferred/manual-review field:

- `boundaryMarker`

## Rollback Strategy

If later split is additive and compatibility-preserving, rollback can remain local to:

- future package request model;
- future host mapper;
- future explicit barrel export.

Rollback is not local if queue or boundary semantics are moved together.

## Recommended Next Phase

EX-92 should be semantic freeze and boundary-marker redesign review, not execution.
