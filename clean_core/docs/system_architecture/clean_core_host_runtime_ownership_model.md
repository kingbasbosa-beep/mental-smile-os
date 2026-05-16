# clean_core Host Runtime Ownership Model

This model defines the runtime ownership boundary after package activation.

## Host App Owns

- Flutter UI and widgets.
- Navigation and route execution.
- Localization generation and text resolution.
- Asset resolution.
- Firebase initialization.
- Auth/session runtime.
- Firestore/Storage/Functions runtime.
- Analytics/telemetry runtime.
- Print/PDF/share/download runtime.
- Platform setup.

## Backend Owns

- Trusted operations.
- Signed authority.
- Protected field decisions.
- Provider execution authority.
- Policy publication authority.
- Review/escalation final authority.
- Runtime activation authority.

## clean_core Owns

- Contracts.
- Governance state language.
- Policy references.
- Backend boundary shapes.
- Safety decision shapes.
- Fail-closed defaults.
- Deny-by-default defaults.

## Ownership Violation Examples

- clean_core initializing Firebase.
- clean_core importing Flutter UI.
- clean_core invoking provider SDKs.
- clean_core creating network clients.
- host app treating clean_core enums as backend approval.
- adapter resolving protected fields without backend authority.

## Model Verdict

The host remains the runtime shell, backend remains trusted authority, and clean_core remains the contract kernel.
