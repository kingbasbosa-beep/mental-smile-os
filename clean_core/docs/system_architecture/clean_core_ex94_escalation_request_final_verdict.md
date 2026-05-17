# EX-94 EscalationRequest Final Verdict

## Naming Decision

Use `EscalationRequest` for the future package model, with strong metadata-only caveats.

## Mapper API Decision

Use optional host-side `EscalationBoundaryMarker` parameter defaulting to `EscalationBoundaryMarker.safeDefault`.

## Boundary Strategy

Keep `boundaryMarker` out of the package model. Preserve the existing Firestore `boundaryMarker` storage field in the host mapper.

## Rollback Boundary

Rollback remains local if EX-95 is limited to:

- package request model file;
- host request mapper file;
- one explicit barrel export.

Rollback becomes non-local if EX-95 touches existing host request, queue, boundary, consumer imports, pubspecs, or runtime/provider systems.

## Final Verdict

EX-95 is approved as controlled additive execution with caveats.
