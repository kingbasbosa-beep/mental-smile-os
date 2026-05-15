# Clean Core Export Surface Strategy

Draft future export strategy. No package extraction, package rename, barrel export, import rewrite, Firebase setup, runtime activation, provider integration, or deployment work was performed.

## Strategy

The future clean_core package should expose curated, stable, pure contract groups first. Export decisions should be governance-first and fail-closed by default.

## Export Rules

- Use curated exports only.
- Do not create giant export-all barrels.
- Do not export unstable/internal markers by default.
- Export pure Dart contracts before any Flutter UI.
- Export backend-governed contracts carefully and document authority boundaries.
- Keep runtime/provider execution disabled by default.
- Keep generated, Firebase, platform, asset, localization, routing, and app-shell files out of the public surface.
- Preserve deny-by-default and fail-closed semantics in all exported contracts.

## Initial Export Shape

The first future package surface should favor:

- Enums and value objects.
- Immutable-oriented records.
- Guard, policy, fallback, and reference contracts.
- Legal consent contracts.
- Audit/review/governance contracts.
- Provider/runtime governance contracts that remain inert and backend-governed.

The first future package surface should avoid:

- UI widgets and pages.
- Firebase initialization or Firestore flows.
- Provider SDK adapters.
- Router/app navigation.
- Generated files.
- Platform setup.
- Runtime orchestration.

## Public API Acceptance Checklist

Before exporting a symbol:

- Confirm it has no app-owned imports.
- Confirm it has a stable name and behavior.
- Confirm it does not grant client-side governance authority.
- Confirm fail-closed defaults are documented.
- Confirm backend authority expectations are clear.
- Confirm it can evolve without broad breaking changes.

## Explicit Non-Action

This document prepares strategy only. No actual package exports or barrel files were created.
