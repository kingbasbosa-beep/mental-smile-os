# Clean Core Public Contract Groups

Draft grouping proposal for future curated exports.

## Likely Public Groups

### Legal

- Legal consent types, versions, records, services, and disclaimer copy.
- Export after verifying no app-owned generated localization or UI coupling.

### Safety

- AI safety placeholders.
- Safety decision contracts.
- Safe response, conversation, and memory boundary contracts.
- Export as inert, non-diagnostic, runtime-disabled contracts.

### Governance

- Governance kernel, lifecycle, compliance, capability, registry, federation, readiness, topology, and architecture manifest contracts.
- Export stable subsets only; keep unstable markers internal.

### Audit

- Audit event, trace, snapshot, reference, redaction, retention, and observability contracts.
- Export sanitized, privacy-first contracts.

### Provider Governance

- Provider capability, restriction, safety profile, compatibility, onboarding, audit reference, and policy link contracts.
- Export only governance contracts, not SDKs or provider calls.

### Runtime Governance

- Runtime environment, runtime execution boundary, activation, wiring, enablement, routing, rollback, observability, isolation, release, and bootstrap governance contracts.
- Export carefully with clear inactive/fail-closed defaults.

### Review And Escalation

- Human review, escalation, queue, assignment, visibility, and resolution contracts.
- Export as backend-governed review contracts only.

### Backend Boundaries

- Trusted backend, trusted pipeline, server-owned fields, protected governance fields, and boundary contracts.
- Export contracts only, not backend implementation.

### Environment And Policy

- Runtime environment, policy packs, runtime profiles, guards, requirements, fallbacks, and snapshot references.
- Export stable policies and references after version review.

## Likely Internal Groups

- Internal markers.
- Temporary topology internals.
- Experimental runtime planning shapes.
- Lock/seal/readiness implementation details that may change.
- Any placeholder that is not yet stable enough for semantic versioning.

## App-Owned Groups

- Flutter UI pages.
- Firebase setup and app services.
- Routing/navigation.
- Localization generation.
- Asset generation and manifests.
- Platform setup.
- Generated files.
- Firestore-backed feature flows.

## Explicit Non-Action

This file defines contract groups only. No exports were created.
