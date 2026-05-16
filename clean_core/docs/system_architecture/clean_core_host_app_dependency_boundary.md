# clean_core Host App Dependency Boundary

This document clarifies dependency ownership between the host Flutter app and extracted `mental_smile_clean_core`.

## Host-Owned Dependencies

The host app remains owner of:

- Flutter UI
- Firebase initialization
- Firestore runtime
- Firebase Auth runtime
- Cloud Functions runtime
- routing/navigation
- localization generation
- generated files
- assets
- analytics/telemetry runtimes
- provider SDKs
- networking clients
- print/PDF/share/download runtimes
- platform setup

## clean_core Dependency Boundary

clean_core should own:

- pure Dart contracts
- governance markers
- policy references
- backend boundary contracts
- safety decision contracts
- trusted backend/pipeline contracts
- declarative fail-closed states

clean_core must not own:

- runtime execution
- provider execution
- SDK setup
- platform APIs
- host app UI
- generated artifacts
- privileged backend writes

## Adapter Boundary

Adapters are future boundary concepts. Their contracts may be defined later in clean_core only if they remain pure Dart and implementation-free. Adapter implementations must remain host/backend owned.

## Dependency Direction Law

- Host app may depend on clean_core.
- clean_core must not depend on host app.
- clean_core must not import `package:flutterprojects/...`.
- clean_core must not import app-owned generated files.
- clean_core must not import Firebase/Flutter/platform/runtime packages.

## Boundary Verdict

The host app stays the runtime shell. clean_core stays the declarative governed kernel.
