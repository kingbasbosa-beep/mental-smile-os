# Clean Core Host App Integration Test Boundary

Draft boundary for host app integration testing.

## Host-Owned Integration Tests

The following tests should remain host app owned:

- Flutter UI rendering.
- Navigation and route behavior.
- Firebase initialization.
- Auth session behavior.
- Firestore-backed registration, booking, dashboard, session, and profile flows.
- Generated localization behavior.
- Asset loading.
- Platform-specific behavior.
- App shell lifecycle.

## Adapter Integration Tests

After extraction, host app integration tests should validate:

- Environment/config adapter reconnect.
- Auth/session adapter reconnect.
- Firebase data adapter reconnect.
- Routing intent adapter reconnect.
- Localization/text adapter reconnect.
- Observability adapter reconnect.
- Provider/backend bridge blocked defaults.

## Rules

- Do not move host integration tests into pure clean_core package tests.
- Do not require clean_core package tests to initialize Firebase.
- Keep UI tests app-owned unless a future UI package is created.
- Keep protected-field and security behavior in host/emulator validation.

## Runtime Test Boundary

Runtime/provider tests remain deferred:

- No live provider calls.
- No OpenAI/Gemini SDKs.
- No chat AI.
- No Cloud Functions orchestration.
- No escalation automation.

## Explicit Non-Action

No host app integration tests were created or moved.
