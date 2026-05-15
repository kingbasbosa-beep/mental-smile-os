# Clean Core Extraction Readiness Gates

Draft readiness gates for future extraction.

## Gate 0: Documentation Complete

Requirements:

- Contamination audit complete.
- Import graph audit complete.
- Boundary hardening complete.
- Public API inventory and classification complete.
- Adapter/Firebase/routing/l10n/assets/test boundary plans complete.

## Gate 1: Import Contamination Reviewed

Requirements:

- Parent-path imports reviewed.
- Legacy package imports reviewed.
- Firebase/generated/router/platform imports reviewed.
- Test/emulator assumptions reviewed.

## Gate 2: Export-Safe Contracts Verified

Requirements:

- Pure Dart contracts identified.
- No Flutter UI imports.
- No Firebase setup imports.
- No generated file imports.
- No routing ownership.
- Fail-closed defaults verified.

## Gate 3: Adapter Boundaries Reviewed

Requirements:

- Firebase adapter plan reviewed.
- Auth/session adapter plan reviewed.
- Routing/text/environment/provider/backend adapter plans reviewed.
- Adapter implementations confirmed outside clean_core.

## Gate 4: App-Owned Responsibilities Verified

Requirements:

- Host owns UI, routing, Firebase, generated files, assets, platform setup, runtime SDKs, deployment, and provider execution.
- clean_core owns contracts only.

## Gate 5: Rollback/Reconnect Plans Reviewed

Requirements:

- Rollback checkpoints defined.
- Temporary dual-link strategy reviewed.
- Reconnect order reviewed.
- Stop conditions accepted.

## Gate 6: Runtime/Provider Execution Still Disabled

Requirements:

- No runtime AI activation.
- No provider SDK integration.
- No Cloud Functions runtime.
- No networking.
- No privileged client writes.

## Gate 7: Final Manual Architecture Review

Requirements:

- Governance review complete.
- Security/fail-closed review complete.
- Export surface review complete.
- Host app authority review complete.
- Extraction approval recorded.

## Explicit Non-Action

No gate was executed in this phase.
