# EX-56 AuditRuntimeMarker Exposure Options

Phase: EX-56 - AuditRuntimeMarker Package Exposure Simulation

## Scope

This document simulates future exposure options for:

- `clean_core/lib/core/audit/audit_runtime_marker.dart`

No files were moved, no source files were modified, no imports were changed, no exports were changed, no dependencies were added, and no runtime systems were activated.

## Option A - Export as Package Public Contract

Description:

- Move/export `AuditRuntimeMarker` as-is as a public package contract.

Pros:

- unblocks `audit_event` pure model with typed marker
- preserves current field shape
- simple rollback if isolated

Cons:

- highest public API semantic risk
- runtime/provider/fallback vocabulary may be misread as execution authority
- increases package surface sensitivity

## Option B - Keep Host-Side Only

Description:

- Keep `AuditRuntimeMarker` only in `clean_core`.

Pros:

- avoids exposing runtime-sensitive vocabulary
- keeps package surface cleaner

Cons:

- blocks direct typed `AuditEvent` package model unless marker is omitted or flattened

## Option C - Copy/Split into Package-Safe Marker

Description:

- Create a package-safe marker with clearer naming and label-only semantics.

Pros:

- supports package model
- allows semantic cleanup
- can reduce runtime authority confusion

Cons:

- requires mapping between host marker and package marker
- potential duplication during transition

## Option D - Replace in audit_event Pure Model by Primitive Fields

Description:

- Avoid marker dependency and use primitive label fields in the package event model.

Pros:

- avoids exporting marker type
- keeps event model simple
- reduces dependency coupling

Cons:

- loses typed grouping
- can scatter runtime-sensitive labels across event model

## Option E - Defer Until Observability/Runtime Governance

Description:

- Do not expose marker until runtime and observability governance matures.

Pros:

- safest governance posture
- avoids premature runtime vocabulary exposure

Cons:

- delays full audit event package model

