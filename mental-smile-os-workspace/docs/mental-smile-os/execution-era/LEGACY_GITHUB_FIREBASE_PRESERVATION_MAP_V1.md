# Legacy GitHub Firebase Preservation Map V1

Status: LEGACY_PRESERVATION_MAP_CREATED
Prompt Asset: PROMPT_ASSET_063

## Purpose

Map legacy GitHub and Firebase materials to historical preservation categories.

## Preservation Map

| Legacy Surface | Examples | Classification | Rule |
| --- | --- | --- | --- |
| Old GitHub repositories | Previous Mental Smile repositories | HISTORICAL_EVIDENCE / SOURCE_REPOSITORY | Keep online as evidence. |
| Old Firebase projects | Existing Firebase projects such as mental-smile-app-clean | HISTORICAL_EVIDENCE / ARCHIVE_REFERENCE | Keep online; do not use as active runtime. |
| Old rule files | firestore.rules, storage.rules, firebase_rules variants | HISTORICAL_EVIDENCE | Preserve; do not deploy as Generation 1. |
| Old deployments | Prior hosted/runtime deployments if any | ARCHIVE_REFERENCE | Preserve as historical proof only. |
| Old historical configurations | firebase.json, .firebaserc, indexes, function configs | HISTORICAL_EVIDENCE | Preserve for lineage and audit. |

## Forbidden Use

Legacy online resources must not be:

- Deleted without archive classification.
- Used as Generation 1 runtime.
- Deployed from.
- Evolved as the active product.
- Used to restore admin/booking/session/payment authority.

