# Clean Core CI Validation Phases

Draft CI validation plan for future extraction. No CI configuration was changed.

## Phase 0: Docs And Import Audits

Validate:

- Export contamination audit.
- Import graph audit.
- Boundary hardening docs.
- Public API inventory.
- App-owned dependency map.

No runtime validation required.

## Phase 1: Pure Dart Contract Tests

Validate:

- Pure model/enums/contracts.
- Serialization helpers where applicable.
- No Firebase, Flutter UI, generated, platform, or network dependencies.

## Phase 2: Governance Guard/Policy Tests

Validate:

- Fail-closed defaults.
- Runtime-disabled defaults.
- Provider-blocked defaults.
- Review-required defaults.
- Deny-by-default decisions.

## Phase 3: Adapter Contract Mock Tests

Validate:

- Adapter contract shapes.
- Mock host/backend implementations.
- Failure boundaries.
- No real SDKs or networking.

## Phase 4: Host App Integration Tests

Validate:

- Flutter UI.
- Routing.
- Firebase initialization.
- Auth runtime.
- Firestore flows.
- Generated localization.
- Assets and platform behavior.

Ownership: host app.

## Phase 5: Firebase Emulator/Security Tests

Validate:

- Firestore rules.
- Protected fields.
- Backend-governed writes.
- Auth emulator behavior.
- Functions emulator later.

Ownership: host app/test harness.

## Phase 6: Runtime/Provider Dry-Run Tests Later

Deferred until future backend-governed activation:

- Provider onboarding dry-runs.
- Runtime execution dry-runs.
- Cloud Functions orchestration tests.
- Observability pipeline tests.

No live provider calls until explicitly approved.

## Explicit Non-Action

No CI phases were implemented in configuration.
