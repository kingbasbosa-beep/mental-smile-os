# Clean Core Import Cleanup Plan

Draft cleanup plan for future extraction readiness. No cleanup was performed in this phase.

## Goals

- Preserve deny-by-default and backend-governed architecture.
- Export only stable, pure contracts first.
- Keep app-owned dependencies inside the host app until explicit boundaries exist.
- Avoid broad import rewrites before the future package identity is approved.

## Cleanup Order

### 1. Prove The Import Boundary

Classify every import as:

- Internal clean_core import.
- Flutter framework import.
- Firebase import.
- Generated app import.
- Router/navigation import.
- Asset/localization import.
- Legacy/parent-path import.
- Test/emulator-only import.

Any parent-path, `../lib`, or legacy app package import must be treated as a blocker before export.

### 2. Lock The Export Surface

Start with:

- Pure Dart `lib/core/*` contracts.
- Documentation.
- Offline contract/test planning artifacts.

Delay:

- UI feature pages.
- Firebase-backed data flows.
- Router integrations.
- Generated files.
- Platform setup.

### 3. Create Boundary Adapters

Before exporting app-bound modules, define adapters for:

- Firebase/Auth/Firestore.
- Routing/navigation.
- Localization.
- Assets.
- Environment/config.
- Emulator/test setup.

Adapters should live at package boundaries and should not activate runtime AI, provider execution, Cloud Functions, or deployment logic.

### 4. Separate Tests

Split tests into:

- Pure contract tests that can run without app shell or Firebase.
- Emulator-ready tests that require explicit local setup.
- Host-app integration tests that remain outside exported package scope.

### 5. Review Generated Dependencies

Do not export generated files as public API until:

- Generation ownership is defined.
- Package build strategy is stable.
- Host app integration is documented.

### 6. Final Pre-Extraction Gate

Before extraction, confirm:

- No parent-path or legacy package imports.
- No app-owned generated config in exported contracts.
- No direct Firebase setup in reusable contracts.
- No router, localization, asset, or platform coupling in exported core.
- Test/emulator setup is explicitly documented.
- Deferred runtime/provider/admin/chat/payment/legal/crisis flows remain inactive and app-owned.

## Files Needing Manual Review

- All `lib/core/*` files for unexpected Flutter/Firebase/generated/router imports.
- All `lib/features/*` files for app-owned dependencies.
- All `test/*` files for app shell and emulator assumptions.
- All docs that mention package names or current workspace paths.

## Explicit Non-Action

No extraction was performed. No files were moved. No imports were rewritten. No pubspec or package identity was changed. No Firebase setup, runtime activation, provider integration, or deployment logic was added.
