# Clean Core Post-Extraction Reconnect Plan

Draft reconnect plan for future extraction. No reconnect was implemented.

## Reconnect Principle

After extraction, the host app should reconnect to clean_core through explicit adapter boundaries, not through hidden app-owned imports.

## Host App Integration

Future steps:

1. Add local/package dependency after extraction.
2. Replace direct internal imports with curated package imports.
3. Keep app shell, routing, Firebase, assets, localization, and platform setup in host app.
4. Verify app-owned feature flows remain stable.

## Adapter Reconnects

Reconnect in this order:

1. Environment/config adapter.
2. Auth identity adapter.
3. Firebase data adapter.
4. Routing intent adapter.
5. Localization/text adapter.
6. Observability/audit adapter.
7. Provider governance adapter.

## Runtime Reconnects

Runtime reconnects are deferred. Do not reconnect:

- Runtime execution.
- Provider execution.
- Chat AI.
- Cloud Functions orchestration.
- Telemetry runtime.
- Deployment/release activation.

## Firebase Reconnect

Firebase remains host-app owned:

- Host app initializes Firebase.
- clean_core receives only safe references/contracts.
- Firestore server-owned fields remain backend-governed.
- Payment, admin, risk, escalation, and governance writes remain protected.

## Provider Reconnect

Provider reconnect is deferred:

- No SDKs in clean_core.
- No API keys in clean_core.
- No network calls in clean_core.
- Provider onboarding and governance review required before any future activation.

## Governance Verification

Before reconnect completion, verify:

- Fail-closed defaults remain intact.
- Runtime disabled defaults remain intact.
- Provider blocked defaults remain intact.
- Audit/review/backend authority expectations remain documented.
- No generated/app-owned imports leak into exported contracts.

## Explicit Non-Action

No host app reconnect, dependency change, adapter implementation, runtime activation, Firebase setup, provider integration, or deployment work was performed.
