# Clean Core Adapter Boundary Matrix

Draft adapter matrix for future extraction. No adapters were implemented.

| Boundary | clean_core Role | Host/Backend Role | Export Guidance |
| --- | --- | --- | --- |
| Firebase access | Define safe contracts | Initialize Firebase and perform runtime access | Adapter contract only |
| Auth identity/session | Define identity references | Own auth/session runtime | Adapter contract only |
| Routing intents/navigation | Define route intents if needed | Own navigation and route tables | Adapter contract only |
| Localization/text | Define copy contracts where stable | Own generated localization | Adapter contract only |
| Environment/config | Define config shapes and fail-closed defaults | Load actual environment runtime | Adapter contract only |
| Observability bridges | Define sanitized observation/audit shapes | Own telemetry pipelines | Adapter contract only |
| Analytics bridges | Define privacy-safe event contracts | Own analytics SDK/runtime | Adapter contract only |
| Provider bridges | Define provider governance/capability contracts | Own SDKs, keys, calls, networking | Adapter contract only |
| Backend bridges | Define trusted operation contracts | Own Cloud Functions/backend runtime | Adapter contract only |
| Deployment/release bridges | Define release governance contracts | Own deployment/store release | Adapter contract only |
| Emulator/test bridges | Define fixtures and test expectations | Own emulator startup and test harness | Adapter contract only |

## Adapter Rules

- Contract-first.
- Implementation-free inside clean_core.
- Backend/host owned.
- No runtime SDK setup inside clean_core.
- No networking inside clean_core.
- No provider execution inside clean_core.
- No generated file ownership inside clean_core.
- Preserve fail-closed defaults.

## Adapter Anti-Patterns

- Importing Firebase directly into reusable contracts.
- Importing app router files into core models.
- Importing generated localization into pure contracts.
- Creating SDK clients inside clean_core.
- Treating adapter contracts as runtime activation.

## Explicit Non-Action

No adapter interfaces or implementations were created in code.
