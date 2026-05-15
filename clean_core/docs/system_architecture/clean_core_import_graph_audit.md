# Clean Core Import Graph Audit

Draft import graph audit for future extraction readiness. No extraction, command-based scan, package identity change, file movement, Firebase setup, provider integration, or runtime activation was performed.

## Import Risk Summary

Clean-core contains two broad zones:

- Pure contract zones that are likely safe for later export after import verification.
- App-owned zones that likely depend on Flutter UI, Firebase, routing, localization, assets, generated files, platform setup, or feature runtime assumptions.

Because no command-based scan was performed in this phase, this audit is conservative. Any import category that could couple clean_core to `mental-smile-app-clean2` remains a manual review item before export.

## Contaminated Import Categories

### Extraction Blocker

- Relative imports that escape `clean_core`, such as parent-path imports into the legacy app.
- Imports from `../lib` or other old source project paths.
- Imports from legacy app package names that would not exist after clean_core extraction.
- Firebase options or generated Firebase config imports inside reusable contract files.
- Generated localization imports inside pure `lib/core/*` contracts.
- Router/app navigation imports inside reusable contracts.

### App-Owned Dependency

- Flutter page/widget imports in feature UI modules.
- Firebase Auth, Firestore, Storage, or Functions imports in app data flows.
- App shell, route constants, deferred placeholder routes, and navigation adapters.
- Platform-specific imports or generated app plugin/config files.
- Asset-generated imports or hardcoded asset paths tied to the current pubspec.

### Needs Review

- Test imports that assume the app shell, Firebase initialization, or emulator setup.
- Feature modules that are mostly clean but still depend on auth providers, global app state, or app-level services.
- Any `package:` import that points at the current app package identity rather than a future clean_core package.
- Any generated file import that could change when package boundaries change.

### Can Remain Until Later

- App-owned feature UI imports that are intentionally not part of the first export surface.
- Firebase-backed app flows that remain inside the host app.
- Router and placeholder-route imports that stay app-owned.
- Platform and asset imports that are not exported.

## Likely Safe Export Zones

- Plain Dart model/contract files under governance-oriented `lib/core/*` folders.
- Legal, audit, runtime, provider, safety, policy, review, memory, topology, manifest, activation, wiring, enablement, routing, environment, rollback, observability, isolation, release, bootstrap, and provider-onboarding contracts when they import only sibling contract files.
- Documentation under `docs/*`.
- Offline test plan markdown files.

## Blocked Export Zones

- App shell and router.
- Feature pages with Flutter UI and navigation assumptions.
- Firebase-initialized services and Firestore-backed workflow pages.
- Generated localization/config/plugin files.
- Platform-specific setup.
- Assets and generated asset references.
- Deferred app routes and placeholders that represent unfinished admin, full chat, payment, AI, legal, crisis, or provider runtime behavior.

## Files Needing Manual Review

Before extraction, manually review:

- Every `lib/core/*` file for imports of Flutter, Firebase, generated files, router files, or app package paths.
- Every `lib/features/*` file for Firebase, router, localization, assets, and app-shell imports.
- Every test file for emulator/app-shell assumptions.
- Every generated-file reference for package-boundary assumptions.
- Any file referencing `mental-smile-app-clean2` directly.

## Cleanup Order

1. Identify all imports that escape `clean_core`.
2. Identify all imports from old app package names.
3. Separate pure Dart contracts from Flutter/Firebase feature code.
4. Keep router, Firebase options, platform setup, assets, and generated files app-owned.
5. Create explicit boundary adapters for app-owned dependencies before export.
6. Define the future clean_core package identity and public API.
7. Re-run import graph verification manually before package extraction.

## Explicit Non-Action

No extraction was performed. No imports were rewritten. No files were moved or deleted. No pubspec, Firebase, runtime, provider, or deployment configuration was changed.
