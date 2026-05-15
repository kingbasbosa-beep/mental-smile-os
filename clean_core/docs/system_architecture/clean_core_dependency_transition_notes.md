# Clean Core Dependency Transition Notes

Draft transition guidance for moving from direct dependencies to adapter boundaries.

## Transition Pattern

1. Identify direct dependency.
2. Classify it as app-owned, adapter-required, internal, or export-safe.
3. Define a contract boundary if the dependency must cross clean_core.
4. Keep implementation in host app or backend.
5. Reconnect after extraction through the adapter.
6. Verify fail-closed defaults remain intact.

## Reducing Legacy Imports

Future cleanup should:

- Remove parent-path imports before extraction.
- Avoid imports from legacy app package names.
- Keep generated files out of exported contracts.
- Replace app runtime references with adapter contracts.
- Avoid broad import rewrites until package identity is approved.

## Replacing Generated/Runtime Coupling

Generated and runtime coupling should be replaced by:

- Text/localization contracts instead of generated l10n imports.
- Route intents instead of router imports.
- Environment contracts instead of runtime loaders.
- Safe identity references instead of direct Auth runtime access.
- Audit/observation contracts instead of telemetry SDK imports.

## Host App Reconnect Guidance

After extraction, reconnect in this order:

1. Environment/config.
2. Auth/session.
3. Firebase data access.
4. Routing intents.
5. Localization/text resolution.
6. Observability/analytics.
7. Provider/backend bridges.

## Guardrails

- No runtime activation during transition.
- No provider execution during transition.
- No Firebase setup inside clean_core.
- No generated file exports.
- No UI rendering ownership in clean_core.
- Preserve backend-governed authority.

## Explicit Non-Action

No dependencies were transitioned in this phase.
