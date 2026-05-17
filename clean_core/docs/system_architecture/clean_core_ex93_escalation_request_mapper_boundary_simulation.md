# EX-93 EscalationRequest Mapper Boundary Simulation

## Simulated Mapper Responsibilities

The future host mapper would own:

- `cloud_firestore` import
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- Firestore field names
- null/default handling
- `EscalationLevel.key` serialization
- `EscalationReason.key` serialization
- `EscalationState.key` serialization
- `ReviewPriority.key` serialization
- `ReviewVisibilityScope.key` serialization
- nested `EscalationAuditLink` serialization/deserialization
- nested `EscalationPolicyReference` serialization/deserialization
- host `EscalationBoundaryMarker` serialization/deserialization for compatibility

## Storage Shape Preservation

The existing host `toMap` writes:

- `uid`
- `level`
- `reason`
- `state`
- `priority`
- `visibilityScope`
- `sanitizedPreview`
- `auditLink`
- `policyReference`
- `boundaryMarker`
- `createdAt`

Even though `boundaryMarker` is excluded from the package model, the mapper should preserve this storage shape by accepting or applying host-side boundary marker defaults.

## Import Boundary

The mapper must use local host compatibility imports only and must not import `package:mental_smile_clean_core`.

## Mapper Verdict

Mapper split is feasible, but the mapper must explicitly handle the excluded boundary marker host-side to avoid storage-shape regression.
