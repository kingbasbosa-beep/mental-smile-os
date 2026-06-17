# Firebase Deployment Surface Report V1

Status: DEPLOYMENT_SURFACES_INVENTORIED
Prompt Asset: PROMPT_ASSET_061

## Deployment Surfaces

| Surface | Reality | Classification |
| --- | --- | --- |
| Hosting | Not declared in firebase.json | NOT_PRESENT |
| Firestore | Declared with firestore.rules and firestore.indexes.json | PRESENT_LEGACY_REFERENCE |
| Storage | Declared with storage.rules | PRESENT_LEGACY_REFERENCE |
| Functions | Declared with source functions | PRESENT_LEGACY_REFERENCE |
| Extensions | Not declared | NOT_PRESENT |
| Emulators | Not declared | NOT_PRESENT |
| Flutter config | Declared for android and dart/firebase_options.dart | PRESENT_LEGACY_REFERENCE |

## Functions Surface

Function export detected: writeAnalyticsSummariesHourly.

Function collection write detected: analytics_summaries.

## Boundary

No deployment occurred.

