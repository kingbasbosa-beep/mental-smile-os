# EX-56 AuditRuntimeMarker Recommendation

Phase: EX-56 - AuditRuntimeMarker Package Exposure Simulation

## Recommendation

Recommended option: Option C, copy/split into a package-safe marker with clearer label-only semantics.

## Rationale

This path:

- supports future `audit_event` package model
- avoids exposing host-side runtime marker as-is
- allows naming cleanup
- reduces runtime authority confusion
- keeps rollback scoped
- avoids blocking audit event split indefinitely

## Suggested Future Package Marker Shape

Possible future package type:

- `AuditRuntimeContext`
- `AuditRuntimeLabel`
- `AuditRuntimeReference`

Possible fields:

- runtime mode label
- provider label
- policy version reference
- fallback reason label

All fields must remain strings or simple value objects and must be documented as metadata only.

## Not Recommended

Not recommended:

- exporting `AuditRuntimeMarker` as-is without caveats
- keeping marker host-only if audit event split must proceed soon
- flattening runtime labels into audit event without grouping
- moving observability contracts at the same time

