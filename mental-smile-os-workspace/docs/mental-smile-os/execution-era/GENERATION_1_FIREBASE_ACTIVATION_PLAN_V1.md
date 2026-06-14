# Generation 1 Firebase Activation Plan V1

Status: FIREBASE_ACTIVATION_PLAN_CREATED
Prompt Asset: PROMPT_ASSET_065

## Purpose

Define the approved Firebase activation path for Generation 1.

## Source Authorities

- GENERATION_1_FIREBASE_IMPLEMENTATION_TARGET_V1.
- GENERATION_1_FIREBASE_TARGET_MODEL_V1.
- GENERATION_1_APPROVED_COLLECTION_REGISTRY_V1.
- GENERATION_1_FORBIDDEN_FIREBASE_COMPONENTS_V1.
- FIRESTORE_COLLECTION_AUTHORITY_MATRIX_V1.
- FIREBASE_CUSTOM_CLAIMS_MODEL_V1.
- FIREBASE_STORAGE_BOUNDARY_MODEL_V1.

## Collections To Implement

| Collection Family | Zone | Activation Status |
| --- | --- | --- |
| app_screen_state | APP_ROOM_ZONE | READY_FOR_CREATION |
| app_room_signals | APP_ROOM_ZONE | READY_FOR_CREATION |
| library_cards | LIBRARY_WEB_ZONE | READY_FOR_CREATION |
| provider_registration_records | PROVIDER_REGISTRATION_WEB_ZONE | READY_FOR_CREATION |
| provider_public_profiles | PROVIDER_PUBLIC_WEB_ZONE | READY_FOR_CREATION |
| center_registration_records | CENTER_REGISTRATION_WEB_ZONE | READY_FOR_CREATION |
| center_public_profiles | CENTER_PUBLIC_WEB_ZONE | READY_FOR_CREATION |
| owner_authority_records | OWNER_ZONE | READY_FOR_CREATION |
| monitoring_reports | MONITORING_ZONE | READY_FOR_CREATION |
| strategic_reports | STRATEGIC_INTELLIGENCE_ZONE | READY_FOR_CREATION |
| archive_snapshots | SMART_ARCHIVE_ZONE | READY_FOR_CREATION |

## Claims To Implement

| Claim | Purpose | Status |
| --- | --- | --- |
| owner | Owner authority | READY |
| provider | Provider identity | READY |
| center | Center identity | READY |
| client | Client identity | READY |
| monitoring | Monitoring observer | READY |
| archive | Smart Archive custody | READY |
| strategic | Strategic Intelligence analysis | READY |

## Rules To Implement

Rules must enforce:

- Zone sovereignty.
- Collection ownership.
- Gateway-only signal routing.
- No direct cross-zone mutation.
- No admin god mode.
- No booking, session, or payment authority.
- Archive read/write separation.
- Owner authority through doctrine only.

## Storage Boundaries To Implement

| Storage Boundary | Owner |
| --- | --- |
| app-zone-assets | APP_ZONE |
| library-zone-assets | LIBRARY_WEB_ZONE |
| provider-registration-assets | PROVIDER_REGISTRATION_WEB_ZONE |
| provider-public-assets | PROVIDER_PUBLIC_WEB_ZONE |
| center-registration-assets | CENTER_REGISTRATION_WEB_ZONE |
| center-public-assets | CENTER_PUBLIC_WEB_ZONE |
| governance-assets | GOVERNANCE_ZONES |
| archive-snapshots | SMART_ARCHIVE_ZONE |

## Indexes To Prepare

Indexes must support:

- Zone-scoped reads.
- Status filtering.
- Signal package timestamp ordering.
- Archive snapshot timestamp ordering.
- Public profile discovery.
- Registration status tracking.

No legacy booking, session, payment, or admin indexes may enter Generation 1.

## Signal Collections

Signal collections must preserve:

- Source zone.
- Source gateway.
- Signal family.
- Target gateway.
- Target zone.
- Created timestamp.
- Routing status.
- Archive status.

## Activation Gate

Firebase may be activated only after owner review of this plan and rule drafting against the approved authority matrix.

