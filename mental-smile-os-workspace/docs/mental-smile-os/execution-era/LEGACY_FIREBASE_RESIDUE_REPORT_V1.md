# Legacy Firebase Residue Report V1

Status: FIREBASE_RESIDUE_REPORTED
Prompt Asset: PROMPT_ASSET_059

## Identified Firebase Residue

| Residue Type | Location | Disposition |
| --- | --- | --- |
| Firebase project config | firebase.json, .firebaserc | KEEP_AS_HISTORICAL_EVIDENCE |
| Firestore rules | firestore.rules | KEEP_AS_HISTORICAL_EVIDENCE |
| Storage rules | storage.rules | KEEP_AS_HISTORICAL_EVIDENCE |
| Firestore indexes | firestore.indexes.json | KEEP_AS_HISTORICAL_EVIDENCE |
| Rules variants | firebase_rules | KEEP_AS_HISTORICAL_EVIDENCE |
| Booking-era rules variant | firebase_rules/firestore.rules.DEV_BOOKING | KEEP_AS_HISTORICAL_EVIDENCE |

## Legacy Authority Risks

The following must not enter Generation 1 Firebase implementation unless rebuilt from doctrine:

- Legacy collections.
- Legacy permissions.
- Legacy booking authority.
- Legacy session authority.
- Legacy payment authority.
- Legacy admin authority.

## Required Before Wave 02

Wave 02 must inspect rule contents and map every collection/permission to FIRESTORE_IMPLEMENTATION_BLUEPRINT_V1 and FORBIDDEN_FIREBASE_COMPONENTS_V1.

