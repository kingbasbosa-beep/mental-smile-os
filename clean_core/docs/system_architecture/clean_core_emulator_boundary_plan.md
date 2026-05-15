# Clean Core Emulator Boundary Plan

Draft emulator ownership plan. No emulator setup or test code was created.

## Emulator Boundary Principle

Emulator startup and Firebase runtime validation are host/test-harness responsibilities. clean_core may define fixtures and contracts, but exported clean_core tests must not require emulator startup.

## clean_core May Define

- Protected-field fixture shapes.
- Trusted operation mock payload shapes.
- Policy snapshot fixtures.
- Runtime-disabled config fixtures.
- Deny-by-default expectation documents.
- Contract-level test helpers that do not import Firebase SDKs.

## Host/Test Harness Owns

- Firebase emulator startup.
- Firestore rules loading.
- Auth emulator users.
- Functions emulator later.
- Project id and app initialization.
- App adapter integration tests.
- Protected write verification.

## Emulator Test Targets

Future emulator tests should validate:

- Firestore deny-by-default posture.
- Protected governance fields.
- Server-owned booking/payment/admin/risk/lifecycle fields.
- Legal consent write boundaries.
- Chat write denial until backend path exists.
- Backend-governed trusted operation behavior when implemented.
- Adapter behavior between host app and clean_core contracts.

## Public Package Constraint

The exported clean_core package should not require:

- Firebase emulator.
- Firebase options.
- App shell.
- Generated localization.
- Flutter UI.
- Platform setup.

## Explicit Non-Action

No emulator tests, Firebase setup, or rules changes were performed.
