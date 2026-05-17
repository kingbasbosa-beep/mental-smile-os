# EX-92 EscalationRequest Boundary Strategy

## Current Boundary Marker

Current file:

- `clean_core/lib/core/human_review/escalation_boundary_marker.dart`

Current fields:

- `backendGoverned`
- `clientOutcomeWritesAllowed`
- `emergencyGuarantee`

## Risk Review

These fields are not package-safe as-is:

- `backendGoverned` can imply backend execution or governance guarantee.
- `clientOutcomeWritesAllowed` can imply write authority or policy enforcement.
- `emergencyGuarantee` can imply emergency response guarantee.

The current marker also owns `toMap`, which is serialization logic and must not enter the package model.

## Strategy Options

1. Keep host-only: safest current choice.
2. Redesign into package-safe passive label contract: possible later if labels avoid authority wording.
3. Decompose into smaller metadata-only labels: preferred if package exposure becomes necessary.
4. Block entirely from package extraction: acceptable until a clear package need exists.

## Recommended Strategy

Keep `EscalationBoundaryMarker` host-only for now. If future exposure is required, perform a separate boundary-marker redesign review and create passive metadata labels that do not imply backend governance, client write permission, or emergency guarantee.

## Boundary Verdict

`boundaryMarker` is explicitly excluded from the future package-safe `EscalationRequest` model.
