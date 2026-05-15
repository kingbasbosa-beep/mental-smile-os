# Clean Core Extraction Transition Plan

Draft extraction transition plan. No extraction, file movement, global import rewrite, runtime activation, provider execution, Firebase integration, package creation, or command execution was performed.

## Conceptual Extraction Flow

1. Freeze verification.
2. Export manifest verification.
3. Manual import scan.
4. Curated export preparation.
5. Package skeleton creation later.
6. Controlled contract migration later.
7. Host-app reconnect preparation.
8. Adapter reconnect preparation.
9. Validation and review later.
10. Staged activation later.

## Extraction Principles

- Curated extraction only.
- No export-all surface.
- Preserve fail-closed posture.
- Preserve deny-by-default posture.
- Preserve backend-governed authority.
- Preserve runtime-disabled state during extraction.
- Preserve provider-blocked state during extraction.
- Keep adapter implementations outside clean_core.
- Keep host app ownership of UI, Firebase, routing, assets, generated files, platform setup, deployment, and runtime SDKs.

## Transition Preconditions

Before extraction starts:

- Final export manifest reviewed.
- Import boundary manually scanned.
- App-owned exclusions confirmed.
- Adapter-only boundaries confirmed.
- Runtime-deferred areas confirmed inactive.
- Rollback checkpoints accepted.

## Explicit Non-Action

This plan does not create a package skeleton or change imports.
