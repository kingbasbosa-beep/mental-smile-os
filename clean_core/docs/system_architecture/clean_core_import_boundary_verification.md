# Clean Core Import Boundary Verification

Draft import boundary verification checklist.

## Import Boundary Expectations

Export candidates must not import:

- Parent paths outside clean_core.
- `../lib`.
- Legacy app package names.
- Firebase setup/options.
- Generated localization.
- Generated router/config/plugin files.
- Flutter UI/app-shell files.
- Platform setup.
- Provider SDKs.
- Networking clients.

## Separation Checks

Verify separation for:

- Firebase.
- Routing.
- Localization.
- Assets.
- Generated files.
- Platform setup.
- Runtime/provider execution.

## Stop Condition If Detected

Stop extraction if an export candidate contains:

- Parent-path leakage.
- Firebase SDK/setup leakage.
- Generated-file leakage.
- Router ownership.
- `BuildContext` contamination.
- Provider SDK imports.
- Network/runtime execution.
- Privileged client writes.

## Explicit Non-Action

No import scan or rewrite was performed.
