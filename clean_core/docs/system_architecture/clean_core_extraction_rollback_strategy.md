# Clean Core Extraction Rollback Strategy

Draft rollback strategy for future extraction transition.

## Rollback Principles

- Rollback must preserve fail-closed behavior.
- Rollback must not activate runtime implicitly.
- Rollback must preserve backend authority expectations.
- Rollback must preserve provider-blocked defaults.
- Rollback must keep app-owned implementations intact.

## Staged Rollback

Each stage should have a rollback checkpoint:

- Stage 1 rollback: restore pure contract references to original path.
- Stage 2 rollback: disable signed/review/legal contract package references.
- Stage 3 rollback: disconnect adapter contract package references.
- Stage 4 rollback: keep runtime-deferred placeholders internal and inactive.

## Partial Reconnect Rollback

If reconnect fails:

- Stop replacing imports.
- Restore host app reference to prior implementation path.
- Keep extracted package dependency disabled or unused.
- Reclassify failing area as app-owned or adapter-required.

## Adapter Disconnect Fallback

If an adapter is unavailable:

- Fail closed.
- Preserve review-required state.
- Avoid direct Firebase/provider/backend calls from clean_core.
- Use host-owned legacy path until adapter is reviewed.

## Freeze Reactivation

Rollback should reactivate freeze rules:

- No new app-owned imports in export candidates.
- No provider SDKs.
- No generated file exports.
- No runtime activation.

## Rollback Audit Expectations

Future rollback should record:

- Stage.
- Trigger.
- Affected contract group.
- Restored path.
- Remaining risk.
- Required follow-up review.

## Explicit Non-Action

No rollback was performed.
