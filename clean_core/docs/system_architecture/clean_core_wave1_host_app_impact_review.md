# clean_core Wave 1 Host App Impact Review

## Host-App Impact Principle

Wave 1 should not change host app runtime ownership. The host app remains responsible for app shell, Firebase, routing, localization, assets, UI, provider SDKs, telemetry, and deployment/runtime systems.

## App Areas That May Import Extracted Contracts Later

Potential future consumers:

- app-level governance checks
- safe response decision surfaces
- admin/review surfaces after adapter work
- backend-boundary request builders
- policy status rendering
- trusted operation status rendering

These imports should happen only through curated package exports after the package exists.

## App Areas That Must Remain Unchanged

The following should not be moved or absorbed into the package:

- `lib/main.dart`
- `lib/app/**`
- `lib/features/**`
- `lib/l10n/**`
- `lib/shared/ui_kit/**`
- `lib/firebase_options.dart`
- `assets/**`
- platform folders
- app-coupled tests

## Host-Owned Runtime Systems

Host/backend ownership remains required for:

- Firebase initialization
- Firestore runtime
- Auth runtime
- Cloud Functions runtime
- routing/navigation
- generated localization
- assets/platform setup
- provider SDK runtime
- telemetry/analytics runtime
- environment loading
- deployment/release runtime

## Tests That May Break Later

Potential later breakage areas:

- tests importing current `lib/core/...` paths directly
- widget tests assuming app-shell access to core contracts
- Firebase emulator tests importing moved contract paths
- generated localization tests relying on app-level imports

Wave 1 should not attempt to fix these broadly during movement.

## Dual-Link Transition Impact

During a future dual-link phase:

- old host-app references may remain temporarily
- new package references should be introduced incrementally
- app-owned runtime imports must not be pulled into the package
- rollback should restore host references without runtime activation

## Hidden Host-App Risks

Risks to review before real movement:

- package identity mismatch in host imports
- app package imports inside extracted files
- UI/Firebase tests expecting old paths
- docs or names suggesting runtime is now ready
- governance contract names being mistaken for authority to execute

## Simulation Finding

Host-app impact is manageable if Wave 1 remains narrow, contract-only, and dual-link aware. The main risk is accidental dependency direction reversal, where package files begin importing host-owned runtime systems.
