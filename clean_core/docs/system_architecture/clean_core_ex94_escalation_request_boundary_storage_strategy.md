# EX-94 EscalationRequest Boundary Storage Strategy

## Current Storage Shape

The current host `EscalationRequest.toMap` writes:

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

## Boundary Exclusion

`boundaryMarker` is excluded from the package model because it carries:

- backend governance semantics;
- client outcome write policy semantics;
- emergency guarantee semantics.

## Preservation Strategy

The future host mapper must still write `boundaryMarker` using a host-side marker value. Default behavior should use:

- `EscalationBoundaryMarker.safeDefault`

Callers may pass a different host marker only through the mapper API, not through the package model.

## Storage Compatibility Verdict

Existing Firestore storage shape can be preserved without package exposure if the mapper owns `boundaryMarker` serialization.
