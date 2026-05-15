# Clean Core Public API Candidates

Draft boundary-hardening document. No package extraction, package rename, file movement, runtime activation, Firebase setup, provider integration, or deployment work was performed.

## Public API Principle

The future clean_core public API should start with pure Dart contracts only. Export stable enums, value objects, immutable-oriented records, policy contracts, audit/review references, and governance placeholders before exporting any UI, Firebase, routing, generated, or platform-dependent code.

## Strong Public API Candidates

- Legal consent contracts and legal text helpers.
- AI safety and governance placeholder contracts.
- Audit, observability, and redaction contracts.
- Backend-boundary and trusted-operation contracts.
- Policy runtime/profile contracts.
- Human review and escalation contracts.
- Provider governance and provider onboarding contracts.
- Safety decision contracts.
- Conversation-session, response-composition, and safety-memory contracts when they remain storage-safe and UI-free.
- Runtime environment, execution, activation, wiring, enablement, routing, rollback, observability, isolation, release, and bootstrap governance contracts.
- Governance kernel, lifecycle, compliance, registry, capability, federation, readiness, topology, and architecture manifest contracts.
- Documentation and compliance traceability documents.

## Public API Candidate Rules

- Export only pure Dart models, enums, guards, policies, records, references, and fallback contracts first.
- Keep defaults fail-closed, runtime-disabled, provider-blocked, and backend-governed.
- Avoid exporting Flutter widgets as the first package surface.
- Avoid exporting Firebase initialization or Firestore write/read orchestration.
- Avoid exporting generated localization, Firebase options, platform setup, route tables, or app shell files.
- Keep placeholder systems documented as inactive contracts, not runtime behavior.

## Candidate Review Checklist

Before a file becomes public API, verify:

- It imports only Dart SDK or clean_core contract files.
- It does not import Flutter UI unless explicitly classified as a UI package layer.
- It does not import Firebase, generated files, router files, assets, app package paths, or parent paths.
- It does not expose mutable governance authority to clients.
- It preserves deny-by-default and backend-governed posture.
- It has a stable name and versioning expectation.

## Explicit Non-Action

This document identifies future candidates only. No export file, public barrel, pubspec, package identity, or runtime system was changed.
