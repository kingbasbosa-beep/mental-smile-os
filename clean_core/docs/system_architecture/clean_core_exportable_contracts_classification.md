# Clean Core Exportable Contracts Classification

Draft classification before future package extraction. No extraction, barrel exports, file movement, pubspec change, command scan, runtime activation, provider integration, or Firebase setup was performed.

## Classification Rules

- Pure Dart contracts first.
- No Flutter UI exports.
- No Firebase setup exports.
- No routing exports.
- No generated file exports.
- No provider SDK exports.
- No active runtime exports.
- Preserve fail-closed and deny-by-default posture.
- Mark unstable lock, seal, readiness, topology, and freeze internals as internal unless clearly stable.

## Export Now Candidate

These are conceptually suitable for the first curated export, assuming final import verification confirms no app-owned dependencies:

- Legal consent enums, version constants, records, payload helpers, and disclaimer text.
- AI safety identity, risk level, risk result, response mode, fail-safe, and deterministic placeholder guard contracts.
- Audit event type, severity, actor type, references, redaction, retention, and sanitized trace contracts.
- Backend-boundary contracts for trusted operation types, server-owned fields, protected governance fields, and protected collection contracts.
- Policy runtime modes, profiles, requirements, modules, fallback, and snapshot references.
- Safety decision verdicts, confidence, reasons, rules, result, guard, and fallback contracts.

## Export After Import Verification

These likely belong in the public API but must first be verified for imports:

- Human review and escalation contracts.
- Trusted backend request/response/reference/fallback contracts.
- Trusted pipeline stage/request/result/reference contracts.
- Runtime environment contracts.
- Conversation session sanitized reference contracts.
- Response composition support/fallback/disclaimer contracts.
- Safety memory boundary, retention, redaction, and preview contracts.

## Export After Semantic Review

These may become public API after naming, authority, and lifecycle semantics settle:

- Provider governance capability matrices, restrictions, safety profiles, compatibility, and policy links.
- Provider onboarding profiles, candidates, policies, guards, and readiness markers.
- Runtime activation, enablement, wiring, routing, rollback, observability, isolation, release, and bootstrap governance contracts.
- Governance kernel, lifecycle, compliance, registry, and capability contracts.
- Architecture manifest entries and freeze/readiness references.

## Internal-Only

Keep hidden from early exports:

- Lock/seal/readiness markers that may change.
- Temporary orchestration placeholders.
- Topology internals.
- Federation internals.
- Architecture freeze internals.
- Runtime bootstrap/release internals unless a stable external need is proven.
- Any placeholder that only documents future backend-governed implementation details.

## Adapter-Contract Only

Can be represented as contracts later, but not implementation:

- Firebase access.
- Auth identity.
- Routing intent.
- Localization/text resolution.
- Environment/config resolution.
- Observability bridge.
- Provider bridge.
- Emulator/test setup.

## App-Owned / Never First Export

- Flutter UI pages.
- App shell.
- Routing/navigation implementation.
- Firebase initialization and options.
- Firestore-backed UI flows.
- Generated files.
- Localization generation.
- Assets and platform setup.

## Deferred Until Runtime Phase

- Runtime execution.
- Provider execution.
- Provider SDKs.
- Cloud Functions orchestration.
- Chat AI.
- Escalation automation.
- Telemetry/analytics runtime.
- Deployment/release activation.

## Explicit Non-Action

This classification does not create exports or alter package structure.
