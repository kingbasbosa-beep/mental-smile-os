# Clean Core Test Split Plan

Draft test split plan for future extraction. No test implementations, emulator setup, CI config, package extraction, runtime activation, provider integration, or command execution was performed.

## Test Split Principle

The extracted clean_core package should be testable without Firebase, Flutter UI, generated app files, platform setup, networking, or emulator startup. Host app and emulator tests should remain outside the pure package contract layer.

## Test Categories

### 1. Pure clean_core Contract Tests

Expected scope:

- Dart-only.
- Enums and value objects.
- Immutable-oriented records.
- Serialization helpers when pure.
- No Flutter UI.
- No Firebase.
- No emulator.
- No platform setup.
- No generated files.

### 2. Governance Contract Tests

Expected scope:

- Policies.
- Guards.
- Fallbacks.
- Audit/review references.
- Fail-closed defaults.
- Deny-by-default behavior.
- Runtime-disabled and provider-blocked defaults.

### 3. Adapter Contract Tests

Expected scope:

- Contract shape only.
- Mock host/backend implementations only.
- No real SDKs.
- No network calls.
- No live Firebase.
- No provider calls.

### 4. Host App Integration Tests

Expected scope:

- Flutter UI.
- Routing.
- Firebase initialization.
- Auth runtime.
- Firestore flows.
- Generated localization.
- Assets.
- Platform-specific behavior.

### 5. Emulator Tests

Expected scope:

- Firestore rules.
- Firebase Auth.
- Functions later.
- Protected-field behavior.
- Backend-governed writes.
- App adapter behavior.

Ownership: host app/test harness.

### 6. Runtime/Provider Tests

Expected scope:

- Deferred.
- No provider SDK calls yet.
- No live AI calls.
- No Cloud Functions orchestration yet.
- Future dry-runs only after backend-governed provider onboarding.

## Boundary Rules

- clean_core package tests must not require Firebase.
- clean_core package tests must not require Flutter UI unless a future UI package exists.
- Emulator tests remain host-owned.
- Provider tests remain deferred.
- Fixtures must not contain raw sensitive content.
- Safety tests must remain non-diagnostic and fail-closed.

## Explicit Non-Action

No tests were added or moved.
