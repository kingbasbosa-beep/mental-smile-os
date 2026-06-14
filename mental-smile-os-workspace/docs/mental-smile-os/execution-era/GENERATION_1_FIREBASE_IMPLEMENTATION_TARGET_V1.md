# Generation 1 Firebase Implementation Target V1

Status: FIREBASE_IMPLEMENTATION_TARGET_GENERATED
Prompt Asset: PROMPT_ASSET_064

## Source Inputs

- GENERATION_1_FIREBASE_TARGET_MODEL_V1.
- GENERATION_1_APPROVED_COLLECTION_REGISTRY_V1.
- GENERATION_1_FORBIDDEN_FIREBASE_COMPONENTS_V1.
- FIRESTORE_COLLECTION_AUTHORITY_MATRIX_V1.
- FIREBASE_CUSTOM_CLAIMS_MODEL_V1.
- FIREBASE_STORAGE_BOUNDARY_MODEL_V1.

## Approved Collections

| Collection Family | Zone | Status |
| --- | --- | --- |
| app_screen_state | APP_ROOM_ZONE | APPROVED_TARGET |
| app_room_signals | APP_ROOM_ZONE | APPROVED_TARGET |
| library_cards | LIBRARY_WEB_ZONE | APPROVED_TARGET |
| provider_registration_records | PROVIDER_REGISTRATION_WEB_ZONE | APPROVED_TARGET |
| provider_public_profiles | PROVIDER_PUBLIC_WEB_ZONE | APPROVED_TARGET |
| center_registration_records | CENTER_REGISTRATION_WEB_ZONE | APPROVED_TARGET |
| center_public_profiles | CENTER_PUBLIC_WEB_ZONE | APPROVED_TARGET |
| owner_authority_records | OWNER_ZONE | APPROVED_TARGET |
| monitoring_reports | MONITORING_ZONE | APPROVED_TARGET |
| strategic_reports | STRATEGIC_INTELLIGENCE_ZONE | APPROVED_TARGET |
| archive_snapshots | SMART_ARCHIVE_ZONE | APPROVED_TARGET |

## Approved Claims

| Claim | Status |
| --- | --- |
| owner | APPROVED |
| provider | APPROVED |
| center | APPROVED |
| client | APPROVED |
| monitoring | APPROVED |
| archive | APPROVED |
| strategic | APPROVED |

## Approved Storage Boundaries

| Boundary | Owner |
| --- | --- |
| app-zone-assets | APP_ZONE |
| library-zone-assets | LIBRARY_WEB_ZONE |
| provider-registration-assets | PROVIDER_REGISTRATION_WEB_ZONE |
| provider-public-assets | PROVIDER_PUBLIC_WEB_ZONE |
| center-registration-assets | CENTER_REGISTRATION_WEB_ZONE |
| center-public-assets | CENTER_PUBLIC_WEB_ZONE |
| governance-assets | GOVERNANCE_ZONES |
| archive-snapshots | SMART_ARCHIVE_ZONE |

## Approved Authority Paths

Authority paths must derive only from:

- Federation Data Authority Doctrine.
- Zone Sovereignty Model.
- Gateway Authority Model.
- Signal Authority Model.
- Archive Authority Model.
- Owner Authority Model.

## Forbidden Authority

- admin.
- super_admin.
- god_mode.
- hidden_owner.
- wildcard authority.
- legacy booking authority.
- legacy session authority.
- legacy payment authority.
- direct cross-zone mutation.

