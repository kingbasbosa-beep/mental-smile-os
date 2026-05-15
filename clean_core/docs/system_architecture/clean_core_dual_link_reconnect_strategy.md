# Clean Core Dual-Link Reconnect Strategy

Draft dual-link reconnect strategy.

## Purpose

Dual-link reconnect allows the host app to temporarily retain legacy source references while gradually replacing stable contract imports with the extracted package. It should be temporary, controlled, and rollback-safe.

## Reconnect Order

1. Pure contract references.
2. Environment/config adapter contracts.
3. Auth/session adapter contracts.
4. Firebase access adapter contracts.
5. Backend bridge contracts.
6. Routing/localization/asset intent contracts.
7. Observability/analytics contracts.
8. Provider governance contracts.
9. Release/deployment governance contracts.

## Reconnect Freeze Rules

- No runtime activation.
- No provider execution.
- No Firebase setup inside clean_core.
- No generated files exported.
- No privileged client writes.
- No hidden authority creation.
- No broad import rewrite without stage review.

## Compatibility Phase

During compatibility:

- Host app may continue using old paths for app-owned implementation.
- Extracted package should expose curated contracts only.
- Adapter implementation remains in host/backend.
- Runtime remains disabled.
- Rollback remains available.

## Validation Expectations

- Host app still starts with app-owned runtime systems.
- Extracted contracts do not require Firebase or Flutter UI.
- Adapter boundaries fail closed when missing.
- Backend authority expectations remain intact.

## Stop Conditions

Stop reconnect if:

- Missing adapter causes direct runtime access from clean_core.
- App-owned dependency leaks into public package surface.
- Runtime/provider systems become active.
- Generated files become required by package tests.

## Explicit Non-Action

No dual-link reconnect was implemented.
