# Clean Core Host App Retention Summary

Draft summary of host/backend-retained responsibilities.

## Host App Retains

- Firebase initialization and runtime.
- Firebase options/config and project ids.
- Auth/session runtime.
- Routing/navigation.
- Flutter UI and app shell.
- Localization generation.
- Assets and platform setup.
- Generated files.
- Environment runtime loading.
- App integration tests.
- Emulator startup through test harness.

## Backend Retains

- Cloud Functions runtime.
- Trusted operation execution.
- Provider execution authority.
- Privileged Firestore writes.
- Governance-sensitive enforcement.
- Escalation creation/transitions.
- Notification dispatch.
- Audit event creation.
- Runtime/provider orchestration if approved later.

## Host/Backend Retain

- Analytics/telemetry runtime.
- Deployment/release runtime.
- Provider SDKs, API keys, networking, and secrets.
- Store/platform release operations.

## clean_core Retains

- Contracts.
- Policy and governance models.
- Fail-closed defaults.
- Legal/safety/audit/review references.
- Backend-boundary definitions.
- Adapter blueprints.

## Explicit Non-Action

No ownership was transferred in code.
