# Firestore Implementation Blueprint V1

Status: FIRESTORE_BLUEPRINT_CREATED
Prompt Asset: PROMPT_ASSET_053

## Purpose

Define approved Firestore collection families conceptually.

No Firestore collections, indexes, rules, or schemas are created by this blueprint.

## Approved Collection Families

| Collection Family | Zone | Owner | Read Scope | Write Scope | Archive Scope | Signal Scope | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| app_screen_state | APP_ROOM_ZONE | App Room Zone | Local app zone and gateway summaries | App zone only | Smart Archive snapshots | App UI-state signals | APPROVED_CONCEPT |
| app_room_signals | APP_ROOM_ZONE | App Room Zone | App gateway, Monitoring, Archive | App gateway only | Detail reports | App signal families | APPROVED_CONCEPT |
| library_cards | LIBRARY_WEB_ZONE | Library Web Zone | Library, approved consumers | Library districts only | Library snapshots | Discovery signals | APPROVED_CONCEPT |
| provider_registration_records | PROVIDER_REGISTRATION_WEB_ZONE | Provider Registration Zone | Registration, review, Owner audit | Registration zone only | Private archive packages | Onboarding/status signals | APPROVED_CONCEPT |
| provider_public_profiles | PROVIDER_PUBLIC_WEB_ZONE | Provider Public Zone | Public zone and approved public readers | Public zone only | Public profile snapshots | Public discovery signals | APPROVED_CONCEPT |
| center_registration_records | CENTER_REGISTRATION_WEB_ZONE | Center Registration Zone | Registration, review, Owner audit | Registration zone only | Private archive packages | Onboarding/status signals | APPROVED_CONCEPT |
| center_public_profiles | CENTER_PUBLIC_WEB_ZONE | Center Public Zone | Public zone and approved public readers | Public zone only | Public profile snapshots | Public discovery signals | APPROVED_CONCEPT |
| owner_authority_records | OWNER_ZONE | Owner Zone | Owner and audited governance readers | Owner authority only | Permanent archive | Owner authority signals | APPROVED_CONCEPT |
| monitoring_reports | MONITORING_ZONE | Monitoring Zone | Monitoring, Owner, Archive | Monitoring zone only | Detail reports | Monitoring signals | APPROVED_CONCEPT |
| strategic_reports | STRATEGIC_INTELLIGENCE_ZONE | Strategic Intelligence Zone | Strategic, Owner, Archive | Strategic zone only | Strategic snapshots | Strategic summary signals | APPROVED_CONCEPT |
| archive_snapshots | SMART_ARCHIVE_ZONE | Smart Archive Zone | Archive and approved Owner reads | Smart Archive only | Permanent archive | Archive integrity signals | APPROVED_CONCEPT |

## Rule

Each collection family must map to zone ownership, read scope, write scope, archive scope, signal scope, and authority doctrine before implementation.

