# Firebase Rules Reality Report V1

Status: RULES_REALITY_REPORTED
Prompt Asset: PROMPT_ASSET_061

## Active Rule Sets

| Rule Set | Location | Reality |
| --- | --- | --- |
| Firestore rules | firestore.rules | Active local rules target in firebase.json |
| Storage rules | storage.rules | Active local storage rules target in firebase.json |

## Historical Rule Sets

| Rule Variant | Location | Classification |
| --- | --- | --- |
| DEV | firebase_rules/firestore.rules.DEV | HISTORICAL_EVIDENCE |
| DEV_BOOKING | firebase_rules/firestore.rules.DEV_BOOKING | BOOKING_RESIDUE |
| MIN_SAFE | firebase_rules/firestore.rules.MIN_SAFE | HISTORICAL_EVIDENCE |
| MIN_SAFE_STAGE2 | firebase_rules/firestore.rules.MIN_SAFE_STAGE2 | HISTORICAL_EVIDENCE |
| PROD | firebase_rules/firestore.rules.PROD | HISTORICAL_EVIDENCE |

## Authority Residue

| Residue | Location | Classification |
| --- | --- | --- |
| admin role | storage.rules | FORBIDDEN_GENERATION_1_COMPONENT |
| admins collection fallback | storage.rules | FORBIDDEN_GENERATION_1_COMPONENT |
| clinician role | firestore.rules, storage.rules | LEGACY_PROVIDER_ROLE |
| monitoring_operator role | firestore.rules | LEGACY_MONITORING_ROLE |
| registry_steward role | firestore.rules | LEGACY_GOVERNANCE_ROLE |
| declaration_reviewer role | firestore.rules | LEGACY_REVIEW_ROLE |
| support_observer role | firestore.rules | LEGACY_SUPPORT_ROLE |
| DEV_BOOKING rules variant | firebase_rules | BOOKING_RESIDUE |

## Session / Payment Residue

No explicit session or payment match discovered in primary local rules by text scan.

## Rule

Existing rules must not be deployed as Generation 1 pure rules.

