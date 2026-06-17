# Firebase Component Inventory V1

Status: FIREBASE_COMPONENTS_INVENTORIED
Prompt Asset: PROMPT_ASSET_061

## Local Firebase Components

| Component | Location | Reality | Initial Classification |
| --- | --- | --- | --- |
| Firebase project config | firebase.json | EXISTS | LEGACY_FIREBASE_REFERENCE |
| Firebase project alias | .firebaserc | EXISTS | LEGACY_PROJECT_REFERENCE |
| Firestore rules | firestore.rules | EXISTS | LEGACY_RULESET_REFERENCE |
| Storage rules | storage.rules | EXISTS | LEGACY_STORAGE_RULESET_REFERENCE |
| Firestore indexes | firestore.indexes.json | EXISTS | LEGACY_INDEX_REFERENCE |
| Functions source | functions/index.js | EXISTS | LEGACY_FUNCTIONS_REFERENCE |
| Functions package | functions/package.json | EXISTS | LEGACY_FUNCTIONS_CONFIG |
| Firebase rule variants | firebase_rules | EXISTS | HISTORICAL_RULE_VARIANTS |

## firebase.json Reality

| Surface | Reality |
| --- | --- |
| Functions | source: functions |
| Firestore rules | firestore.rules |
| Firestore indexes | firestore.indexes.json |
| Storage rules | storage.rules |
| Flutter app config | projectId: mental-smile-app-clean |
| Hosting | NOT_DECLARED |
| Emulators | NOT_DECLARED |
| Extensions | NOT_DECLARED |

## Project Reference

Default Firebase project: mental-smile-app-clean.

## Functions Reality

Functions package uses Node 20 and depends on firebase-admin, firebase-functions, and BigQuery client.

Detected function export: writeAnalyticsSummariesHourly.

Detected write collection: analytics_summaries.

## Classification Link

GENERATION_1_FIREBASE_TARGET_MODEL_V1 and FIREBASE_COLLECTION_DECISION_MATRIX_V1 classify this inventory for Generation 1.

Archive and removal candidates are registered separately.
