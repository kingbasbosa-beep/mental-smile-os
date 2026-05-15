# Clean Core App Shell Contamination Prevention

Draft app-shell contamination prevention plan.

## Contamination Risks

App-shell coupling can leak into clean_core through:

- `BuildContext` coupling.
- Navigator/router coupling.
- Generated localization imports.
- Asset paths.
- Platform assumptions.
- Theme/UI assumptions.
- Scaffold/dialog/snackbar assumptions.
- Global app state.
- App dependency injection runtime.

## Prevention Rules

- Contracts before rendering.
- Intent before navigation.
- Semantic identifiers before localized strings.
- References before asset resolution.
- Adapter contracts before runtime integrations.
- No runtime UI ownership in clean_core.
- No platform bootstrapping in clean_core.
- No generated app files in clean_core public API.

## clean_core May Own

- Route intent contracts.
- Text identifier contracts.
- Asset intent contracts.
- Review-required markers.
- Blocked/fallback markers.
- Governance and audit references.

## Host App Must Own

- Rendering.
- Navigation.
- Theme.
- Dialogs.
- Snackbars.
- Scaffolds.
- Generated localization.
- Asset resolution.
- Platform integration.

## Failure Rules

- Fail closed for governance-sensitive routes.
- Preserve review-required states.
- Do not navigate around backend/governance blocks.
- Do not activate runtime/provider systems due to app-shell failure.

## Explicit Non-Action

No app-shell files were changed.
