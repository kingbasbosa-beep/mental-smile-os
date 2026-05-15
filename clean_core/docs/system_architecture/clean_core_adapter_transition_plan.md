# Clean Core Adapter Transition Plan

Draft adapter transition plan. No adapters were implemented.

## Adapter Transition Principle

Adapters should be introduced as boundaries before implementations move or reconnect. The extracted clean_core package should define contracts only; the host app should own runtime implementations.

## Firebase Adapter

Transition steps:

1. Define contract shape for safe data access.
2. Keep Firebase initialization in host app.
3. Keep Firestore writes backend-governed.
4. Reconnect feature flows only after rules and adapter behavior are reviewed.

## Auth Adapter

Transition steps:

1. Define safe identity reference contract.
2. Keep active auth state in host app.
3. Avoid exporting Firebase Auth directly.
4. Require backend authority for governance-sensitive operations.

## Routing Adapter

Transition steps:

1. Define route intent contracts.
2. Keep actual routes and navigation in host app.
3. Keep deferred placeholder routes app-owned.
4. Reconnect feature UI only after route ownership is stable.

## Localization Adapter

Transition steps:

1. Keep generated localization app-owned.
2. Define package text strategy for reusable copy.
3. Avoid generated l10n imports in pure contracts.
4. Add package localization only after extraction strategy is stable.

## Environment Adapter

Transition steps:

1. Define environment/config contract.
2. Keep local/staging/production selection in host app.
3. Preserve fallback-only and runtime-disabled defaults.
4. Do not enable runtime switching during extraction.

## Observability Adapter

Transition steps:

1. Define sanitized observation and audit-link contracts.
2. Keep telemetry runtime out of clean_core.
3. Reconnect observability through backend/app implementation later.
4. Preserve no raw sensitive data defaults.

## Provider Adapter

Transition steps:

1. Define provider capability and governance contracts.
2. Keep SDKs, keys, and networking outside clean_core.
3. Require provider onboarding and backend-governed approval.
4. Keep providers blocked by default.

## Explicit Non-Action

No runtime adapters, dependency injection, Firebase setup, routing implementation, provider SDK integration, or runtime activation was added.
