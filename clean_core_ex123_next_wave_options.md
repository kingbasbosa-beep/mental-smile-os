# EX-123 Next Wave Options

## Scope

Docs/handoff only. This document lists safe next wave options after the
completed migration milestones.

## Recommended Option 1: Doctrine Registry

Create a documentation index that links the audit, human-review,
queue/boundary, and runtime/provider doctrine reports.

Why this is safe:

- docs only
- improves handoff continuity
- no package surface changes
- no consumer reconnection
- no runtime activation

## Recommended Option 2: Package Surface Verification

Verify current public exports and classify them as audit, human review,
governance, policy runtime, safety decision, trusted backend, or trusted
pipeline.

Why this is safe:

- review/docs only
- catches accidental exports
- reinforces barrel governance

## Recommended Option 3: Host-Side Mapper Containment Verification

Verify that audit and human-review Firestore mappers remain host-side and that
package contracts stay free of Firebase/Firestore persistence behavior.

Why this is safe:

- review/docs only
- protects package purity
- preserves rollback boundaries

## Recommended Option 4: Consumer Readiness Review

Review possible future consumer migration order without changing imports.

Why this is safe:

- planning only
- identifies risk before reconnecting consumers
- avoids accidental runtime activation

## Recommended Option 5: Runtime/Provider Orchestration Isolation Mapping

Continue runtime/provider work only as host/backend mapping. Do not introduce
package diagnostics until orchestration ownership is isolated.

Why this is safe:

- maintains holdback doctrine
- focuses on host/backend responsibility
- prevents fake AI guarantees

## What To Avoid As The Immediate Next Wave

Avoid:

- package export expansion
- consumer migration
- mapper creation inside the package
- runtime/provider diagnostic implementation
- queue/boundary exposure
- emergency capability exposure
- provider/fallback/retry labels
- pub get/analyze unless explicitly requested

## Recommended Next Step

The safest next wave is a documentation registry plus package surface
verification. This gives the next session a stable map before any implementation
or migration wave begins.
