# EX-93 EscalationRequest Boundary Exclusion Review

## Excluded Field

- `boundaryMarker`

## Current Boundary Marker Semantics

Current fields:

- `backendGoverned`
- `clientOutcomeWritesAllowed`
- `emergencyGuarantee`

## Exclusion Reason

These fields carry authority and guarantee wording that is not package-safe:

- backend governance may imply backend execution guarantee;
- client outcome writes may imply write authorization policy;
- emergency guarantee may imply emergency response or handling guarantee.

## Storage Impact

Excluding `boundaryMarker` from the package model could break storage-shape assumptions if the future mapper simply omits the persisted `boundaryMarker` field.

## Required Compatibility Strategy

The future host mapper should preserve the existing persisted `boundaryMarker` field using host-side `EscalationBoundaryMarker.safeDefault` unless a caller supplies a host-side marker through mapper-specific API.

## Boundary Verdict

Boundary exclusion is correct for package purity, but future mapper design must preserve host storage compatibility.
