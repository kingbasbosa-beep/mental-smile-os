# Active Runtime Collection Registry V1

Status: COLLECTION_REGISTRY_DEFINED
Prompt Asset: PROMPT_ASSET_052
Latest Firebase Implementation Plan Prompt: PROMPT_ASSET_053

## Purpose

Define approved future collection families conceptually.

No Firebase, Firestore, backend, or schema is implemented.

## Collection Families

| Collection Family | Zone | Owner | Read Scope | Write Scope | Signal Scope | Archive Scope |
| --- | --- | --- | --- | --- | --- | --- |
| app_screen_state | APP_ROOM_ZONE | App Room Zone | Local app zone and gateway summaries | App zone only | App UI-state signals | Smart Archive snapshots |
| app_room_signals | APP_ROOM_ZONE | App Room Zone | App gateway, Monitoring, Archive | App gateway only | App signal families | Detail reports |
| library_cards | LIBRARY_WEB_ZONE | Library Web Zone | Library, approved consumers | Library districts only | Discovery signals | Library snapshots |
| provider_registration_records | PROVIDER_REGISTRATION_WEB_ZONE | Provider Registration Zone | Registration, review, Owner audit | Registration zone only | Onboarding/status signals | Private archive packages |
| provider_public_profiles | PROVIDER_PUBLIC_WEB_ZONE | Provider Public Zone | Public zone and approved public readers | Public zone only | Public discovery signals | Public profile snapshots |
| center_registration_records | CENTER_REGISTRATION_WEB_ZONE | Center Registration Zone | Registration, review, Owner audit | Registration zone only | Onboarding/status signals | Private archive packages |
| center_public_profiles | CENTER_PUBLIC_WEB_ZONE | Center Public Zone | Public zone and approved public readers | Public zone only | Public discovery signals | Public profile snapshots |
| owner_authority_records | OWNER_ZONE | Owner Zone | Owner and audited governance readers | Owner authority only | Owner authority signals | Permanent archive |
| monitoring_reports | MONITORING_ZONE | Monitoring Zone | Monitoring, Owner, Archive | Monitoring zone only | Monitoring signals | Detail reports |
| strategic_reports | STRATEGIC_INTELLIGENCE_ZONE | Strategic Intelligence Zone | Strategic, Owner, Archive | Strategic zone only | Strategic summary signals | Strategic snapshots |
| archive_snapshots | SMART_ARCHIVE_ZONE | Smart Archive Zone | Archive and approved Owner reads | Smart Archive only | Archive integrity signals | Permanent archive |

## Forbidden Collections

- Unknown legacy collections.
- Booking collections.
- Payment collections.
- Session collections.
- Hidden owner collections.
- Wildcard admin collections.

## Firebase Implementation Link

FIRESTORE_IMPLEMENTATION_BLUEPRINT_V1 and FIRESTORE_COLLECTION_AUTHORITY_MATRIX_V1 translate these collection families into implementation architecture.

No collections are created by this link.
