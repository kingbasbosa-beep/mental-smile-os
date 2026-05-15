# clean_core Wave 1 Go/No-Go Matrix

## GO Conditions

| Area | GO if |
| --- | --- |
| Imports | Imports remain pure Dart and package-boundary safe |
| Firebase | No Firebase, Firestore, Firebase options, or Cloud Functions imports appear |
| Flutter UI | No Flutter UI, `BuildContext`, Navigator, router, or widget dependencies appear |
| Generated files | No generated localization, router, config, or asset imports appear |
| Provider SDKs | No provider SDK imports or execution hooks appear |
| Networking | No HTTP/client/networking dependency appears |
| Runtime | No runtime execution, orchestration, activation, or bootstrap behavior appears |
| Exports | Barrels remain curated and narrow |
| Authority | Backend authority remains preserved |
| Defaults | Fail-closed and deny-by-default posture remains intact |
| Rollback | Rollback checkpoint is available before the next batch |

## NO-GO Conditions

| Area | NO-GO if |
| --- | --- |
| Firebase | Firebase, Firestore, Functions, or options coupling appears |
| Flutter UI | Flutter UI or app-shell dependency appears |
| Generated files | Generated localization/config/router/asset dependency appears |
| Provider | Provider execution or provider SDK dependency appears |
| Networking | Networking/runtime client appears |
| Exports | Barrel exports become broad or expose internal/deferred files |
| App-owned imports | App-owned imports are pulled into the package |
| Authority | Client-side trusted authority expands |
| Defaults | Fail-closed or deny-by-default behavior weakens |
| Runtime | Runtime activation or orchestration appears |

## Automatic Stop Conditions

Automatically stop if:

- Firebase import appears
- Flutter UI import appears
- generated import appears
- provider execution appears
- networking/runtime appears
- app-owned import appears
- privileged client write appears
- broad public export appears

## Manual-Review Required Conditions

Pause for review if:

- governance capability semantics are unclear
- federation surfaces appear internal-only
- policy contracts imply execution authority
- trusted backend/pipeline names imply runtime behavior
- deferred audit/legal/human-review references appear

## Rollback-Required Conditions

Rollback is required if:

- moved files introduce blocked dependencies
- host app imports break outside expected checkpoint instability
- public barrels expose internal/runtime-deferred code
- fail-closed behavior cannot be confirmed
- rollback path becomes unclear
