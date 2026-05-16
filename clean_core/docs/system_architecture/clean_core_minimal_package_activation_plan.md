# clean_core Minimal Package Activation Plan

This is a future activation plan only. No activation was executed in EX-20.

## Activation Sequence

1. Create minimal pubspec.
2. Add local path dependency in host app.
3. Run limited package import migration later.
4. Reconnect tests through public barrel.
5. Introduce adapter-only contracts after review.
6. Defer runtime bridges.
7. Review runtime activation in a separate future phase.

## Phase 1: Minimal Pubspec

Create only package identity and SDK constraint. Do not add runtime dependencies.

## Phase 2: Local Path Dependency

Add host path dependency in a dedicated checkpoint. Do not change host imports in the same step unless explicitly scoped.

## Phase 3: Limited Import Migration

Migrate only approved contract consumers. Avoid broad automated rewrites.

## Phase 4: Adapter-Only Reconnect

Introduce adapter contracts only after import and semantic review. Implementations remain host/backend owned.

## Phase 5: Deferred Runtime Bridges

Runtime bridge architecture must wait for:

- backend authority review
- adapter review
- security review
- fail-closed verification
- provider onboarding governance

## Activation Prohibitions

Activation must not create:

- AI runtime
- provider execution
- Firebase runtime inside package
- networking clients
- orchestration startup
- privileged client authority

## Activation Verdict

Minimal package activation is conceptually approved only as package identity plus controlled local dependency. Runtime activation remains prohibited.
