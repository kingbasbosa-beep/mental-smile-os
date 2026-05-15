# Clean Core Adapter Strategy

Draft strategy for future package boundaries. No adapters were implemented in this phase.

## Adapter Principle

External systems should cross the clean_core boundary through explicit adapters. The extracted package should not directly own app runtime setup, Firebase setup, navigation, localization generation, assets, platform setup, provider SDKs, or deployment logic.

## Adapter Categories

### Firebase Adapter

Purpose: isolate Auth, Firestore, Storage, Functions, and Firebase options.

Future rules:

- clean_core may define data contracts and boundary expectations.
- Host app owns Firebase initialization and credentials.
- Server-owned governance fields remain backend-governed.
- No client-side runtime activation or governance authority.

### Auth Adapter

Purpose: pass user identity and authorization context without coupling contracts to Firebase Auth.

Future rules:

- Contracts may accept safe identity references.
- Host app resolves active auth state.
- Sensitive decisions stay backend-governed.

### Routing Adapter

Purpose: decouple clean_core feature logic from app navigation.

Future rules:

- Contracts should not import app route tables.
- Host app maps route intents to actual pages.
- Deferred admin/chat/payment/AI/legal/crisis routes remain app-owned until implemented.

### Localization Adapter

Purpose: separate package text contracts from generated app localization.

Future rules:

- Core contracts should avoid generated l10n imports.
- Legal/support copy can remain plain reusable strings until a package l10n strategy exists.
- Host app owns generated localization output.

### Environment/Config Adapter

Purpose: isolate local, staging, production, restricted review, and fallback-only configuration.

Future rules:

- Core contracts define allowed config shapes and fail-closed defaults.
- Host app supplies actual environment selection.
- No runtime switching during extraction.

### Observability Adapter

Purpose: connect audit/observability contracts to future telemetry without embedding telemetry runtime.

Future rules:

- Core contracts expose sanitized observations, audit links, and placeholders.
- Host/backend owns pipeline implementation.
- No raw sensitive content or live analytics in core contracts.

### Provider Adapter

Purpose: keep OpenAI/Gemini/local/mock providers outside core contracts until approved.

Future rules:

- Core contracts define provider capability, onboarding, isolation, and governance checks.
- Host/backend owns SDKs, keys, networking, and execution.
- Providers stay blocked by default.

## Non-Action Confirmation

No runtime adapters, provider adapters, Firebase adapters, routing adapters, or dependency injection runtime were implemented.
