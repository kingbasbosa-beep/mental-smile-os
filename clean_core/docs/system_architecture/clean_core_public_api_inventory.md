# Clean Core Public API Inventory

Draft inventory for future package extraction. No package extraction, barrel export, pubspec change, file movement, command scan, runtime activation, provider integration, or Firebase setup was performed.

## Inventory Rules

- Pure Dart contracts first.
- No Flutter UI exports.
- No Firebase setup exports.
- No routing exports.
- No generated file exports.
- No provider SDK exports.
- No runtime execution exports.
- Preserve fail-closed and deny-by-default posture.

## Stable Public Candidates

These areas are likely suitable for future curated exports after import verification:

- Legal consent types, versions, records, service helpers, and disclaimer text.
- AI safety identity, risk, response-mode, fail-safe, guard, and placeholder policy contracts.
- Audit event, severity, actor, trace, reference, redaction, retention, and safety observability contracts.
- Backend-boundary contracts for server-owned fields, protected governance fields, trusted operations, and lifecycle boundaries.
- Policy runtime packs, profiles, modes, guards, requirements, fallbacks, and snapshot references.
- Safety decision rules, verdicts, confidence, reasons, guard, fallback, and results.
- Human review/escalation enums, request/review/queue/resolution/assignment contracts.
- Trusted backend and trusted pipeline request/result/reference/fallback contracts.

## Review-Required Candidates

These may become public API, but need semantic and import review first:

- Provider governance capability matrices, restrictions, safety profiles, compatibility, trust levels, and policy links.
- Provider onboarding candidates, profiles, policies, guards, and readiness markers.
- Runtime environment and environment activation contracts.
- Conversation session and response composition contracts.
- Safety memory contracts.
- Runtime activation, enablement, wiring, routing, rollback, observability, isolation, release, and bootstrap governance contracts.
- Governance lifecycle, compliance, capability, registry, federation, readiness, topology, and architecture manifest contracts.

## Internal-Only Candidates

These should not be exported until their shape stabilizes:

- Lock/seal/readiness markers.
- Temporary topology internals.
- Experimental orchestration placeholders.
- Internal governance runtime markers.
- Architecture freeze internals.
- Any placeholder that exists only to document future backend-governed behavior.

## App-Owned Exclusions

Do not include in early public API:

- Flutter UI pages.
- Firebase initialization and options.
- Firestore-backed UI workflows.
- Routing/navigation.
- Generated localization/config/plugin files.
- Assets and asset manifests.
- Platform setup.
- App shell.
- Deferred admin/chat/payment/AI/legal/crisis runtime routes.

## Adapter-Required Candidates

Export contracts only after adapter shape review:

- Firebase access adapter contracts.
- Auth identity adapter contracts.
- Routing intent adapter contracts.
- Localization/text adapter contracts.
- Environment/config adapter contracts.
- Observability bridge contracts.
- Provider bridge contracts.

## Deferred Runtime Candidates

Do not export as active runtime API yet:

- Runtime execution.
- Provider execution.
- OpenAI/Gemini/local provider SDKs.
- Cloud Functions orchestration.
- Chat AI.
- Escalation automation.
- Telemetry/analytics runtime.
- Deployment/release activation.

## Explicit Non-Action

This inventory does not create exports or change package structure.
