# Firebase Claims Reality Report V1

Status: CLAIMS_REALITY_REPORTED
Prompt Asset: PROMPT_ASSET_061

## Generation 1 Approved Claims

- owner.
- provider.
- center.
- client.
- monitoring.
- archive.
- strategic.

## Claims / Roles Detected In Local Rules

| Claim Or Role | Source | Classification |
| --- | --- | --- |
| owner | firestore.rules | MATCH |
| client | firestore.rules | MATCH |
| center | firestore.rules, storage.rules | MATCH |
| clinician | firestore.rules, storage.rules | LEGACY_PROVIDER_ROLE |
| monitoring_operator | firestore.rules | PARTIAL_MATCH |
| registry_steward | firestore.rules | LEGACY_GOVERNANCE_ROLE |
| declaration_reviewer | firestore.rules | LEGACY_REVIEW_ROLE |
| support_observer | firestore.rules | LEGACY_SUPPORT_ROLE |
| admin | storage.rules | FORBIDDEN_GENERATION_1_CLAIM |

## Unknown Claims

Live Firebase Auth custom claims were not queried.

## Required Future Action

Wave 02 must replace legacy claim vocabulary with FIREBASE_CUSTOM_CLAIMS_MODEL_V1 before implementation.

