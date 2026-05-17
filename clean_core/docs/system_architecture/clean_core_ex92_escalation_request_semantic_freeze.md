# EX-92 EscalationRequest Semantic Freeze

## Scope

This freeze covers a future package-safe `EscalationRequest` metadata model only. It does not approve source execution, movement, import migration, reconnect, or package export changes.

## Frozen Package-Safe Fields

A future package-safe request model may include only:

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

## Explicitly Deferred Fields and Logic

The following are excluded from the package-safe request model:

- `boundaryMarker`
- queue acceptance/routing logic
- backend governance flags
- client outcome write policy
- emergency guarantee semantics

## Required Caveats

- Request metadata does not initiate escalation execution.
- `level` and `priority` do not route or schedule.
- `reason` does not prove provider/runtime causality.
- `state` does not progress workflow.
- `visibilityScope` does not enforce authorization.
- `sanitizedPreview` is not privacy or security proof.
- `auditLink` and `policyReference` remain metadata only.
- `createdAt` does not prove backend ingestion or processing.
- A request record does not approve, route, execute, own, or guarantee escalation handling.

## Current Host Coupling

The current host file remains Firestore-coupled through `cloud_firestore`, `FieldValue.serverTimestamp()`, `Timestamp.fromDate`, and `toMap`. These responsibilities must remain mapper-side in any future execution.

## Freeze Verdict

The metadata field set is frozen for simulation only. Execution remains blocked until a simulation confirms that `boundaryMarker` remains excluded and compatibility stays intact.
