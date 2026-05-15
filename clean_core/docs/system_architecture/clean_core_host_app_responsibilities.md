# Clean Core Host App Responsibilities

Draft responsibilities for the host app after future clean_core extraction.

## Runtime Ownership

The host app owns:

- Flutter app startup.
- Dependency runtime.
- Platform bootstrapping.
- Firebase initialization.
- Auth session runtime.
- Firestore/Storage/Functions runtime access.
- Environment loading.

## Provider Ownership

The host/backend owns:

- Provider SDKs.
- API keys and secrets.
- Network calls.
- Provider execution.
- Provider onboarding implementation.
- Provider rollback and release implementation.

clean_core may define governance contracts, but not execution.

## UI Ownership

The host app owns:

- Flutter pages and widgets.
- App shell.
- Navigation.
- Route tables.
- User flows.
- Generated localization integration.
- Asset loading.

## Deployment Ownership

The host app owns:

- Android/iOS/web/macOS setup.
- Store configuration.
- Deployment pipelines.
- Firebase project configuration.
- Release signing and store review operations.

## Observability Ownership

The host/backend owns:

- Analytics SDKs.
- Telemetry pipelines.
- Log transport.
- Runtime observability implementation.

clean_core may define sanitized observation and audit contracts only.

## Governance Obligations

When reconnecting to clean_core, the host app must:

- Preserve fail-closed defaults.
- Keep runtime AI disabled unless future backend-governed activation is approved.
- Keep provider execution blocked by default.
- Avoid client-side authority over admin, risk, payment, moderation, escalation, or runtime governance.
- Keep generated files and runtime setup out of clean_core public API.

## Explicit Non-Action

No host app code was changed.
