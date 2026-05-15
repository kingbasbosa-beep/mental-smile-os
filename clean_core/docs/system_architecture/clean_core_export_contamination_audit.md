# Clean Core Export Contamination Audit

Draft audit for future extraction planning. No extraction, package move, import rewrite, Firebase setup, runtime activation, or legacy deletion was performed.

## Scope

Target: `clean_core`

Purpose: identify likely contamination and coupling risks before separating clean_core from `mental-smile-app-clean2`.

This report is intentionally conservative. It treats any app-shell, Firebase, routing, asset, localization, generated, platform, or legacy feature dependency as a review item until manually verified.

## Summary

The newer governance, safety, legal, runtime, provider, audit, policy, environment, release, rollback, bootstrap, and architecture-manifest foundations are structurally suitable for later export because they are contract-oriented and isolated under `lib/core/*`, `lib/features/legal`, and related documentation/test foundations.

The broader clean_core app is not safe to export as an independent package yet because it still likely contains app-level Flutter/Firebase/routing/feature pages, generated app assumptions, assets, localization, and legacy migration boundaries.

## Safe To Export Later

- Pure Dart foundation contracts under `lib/core/*` that do not import Flutter, Firebase, generated files, app router files, or feature UI.
- Legal consent contract files under `lib/core/legal/` when they remain plain model/service helpers.
- AI safety/governance placeholder contracts that remain runtime-disabled and provider-agnostic.
- Backend-boundary, audit, policy, human-review, runtime-environment, provider-governance, safety-decision, conversation-session, response-composition, safety-memory, runtime-execution, governance, trusted-backend, secure-runtime, federation, readiness, topology, manifest, activation, wiring, enablement, routing, environment, rollback, observability, isolation, release, bootstrap, and provider-onboarding contracts, subject to import verification.
- Documentation under `docs/legal/`, `docs/compliance/`, `docs/store_review/`, and `docs/system_architecture/`.
- Offline contract test fixtures under `test/contracts/`, `test/safety/`, and `test/emulator/` if they do not require live Firebase or app-generated setup.

## Not Safe Yet

- App shell, router, and page-level Flutter UI that depends on the current application package structure.
- Firebase-authenticated feature flows that assume app Firebase initialization.
- Firestore-backed booking, registration, dashboard, session, and profile flows that depend on current rules posture and app collections.
- Any code importing generated localization, Firebase options, generated plugin registrants, assets, app router paths, or platform-specific files.
- Any feature still relying on deferred placeholder routes for admin, full chat, payment proof, AI/legal/crisis runtime, or clinician chat inbox behavior.

## Needs Review

- Imports that reference parent paths, legacy package names, app-specific generated files, or current app-only routing.
- Firebase options and initialization assumptions.
- Asset paths and pubspec asset declarations.
- Localization strategy, including generated `AppLocalizations` or `flutter_gen` output.
- Router constants and navigation targets tied to placeholder/deferred routes.
- Feature modules that look clean but still depend on app-level providers, auth state, Firebase instances, or global singletons.
- Tests that assume emulator startup, Firebase project ids, or application package names.

## Legacy Contamination Candidates

- Relative imports that escape `clean_core`.
- Imports from old project paths or package names outside the future clean_core boundary.
- Hardcoded mentions of `mental-smile-app-clean2`.
- Firestore and Firebase options used directly in reusable domain contracts.
- UI pages with direct route names, app shell assumptions, or legacy navigation flows.
- Asset references that assume the current app pubspec layout.
- Generated files committed or referenced as if they are stable package API.

## Extraction Blockers

- No confirmed clean package identity for extracted clean_core.
- No finalized pubspec/package split.
- No verified import graph proving clean_core does not reference legacy app paths.
- No standalone asset strategy.
- No standalone localization strategy.
- No Firebase options strategy for extracted package or app boundary.
- No routing boundary contract for exported feature modules.
- No environment/config boundary for local, staging, production, and restricted review modes.
- No confirmed emulator/test startup strategy independent of the current app.
- Deferred app routes and runtime systems remain intentionally placeholders.

## Recommended Order Before Separation

1. Run a manual import graph audit for parent-path, legacy-package, generated-file, and app-specific imports.
2. Classify clean_core files into exportable contracts, app-bound UI, Firebase-bound data flows, generated/config-bound files, and deferred placeholders.
3. Define the future package identity and public export surface.
4. Create asset, localization, Firebase, routing, and environment boundary strategies.
5. Verify test/emulator assumptions without introducing live services.
6. Freeze exported contract APIs and document non-exported app-bound modules.
7. Extract only after all blockers are reviewed and signed off.

## Explicit Non-Action

No extraction was performed. No files were moved. No pubspec/package structure was changed. No Firebase setup, runtime activation, provider integration, or legacy deletion was performed.
