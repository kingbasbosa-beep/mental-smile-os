# Firestore Collection Authority Matrix V1

Status: AUTHORITY_MATRIX_CREATED
Prompt Asset: PROMPT_ASSET_053

## Purpose

Define who may read, write, archive, observe, and never access each approved collection family.

## Authority Matrix

| Collection | May Read | May Write | May Archive | May Observe | May Never Access |
| --- | --- | --- | --- | --- | --- |
| app_screen_state | APP_ROOM_ZONE, APP_ROOM_ZONE_GATEWAY | APP_ROOM_ZONE | SMART_ARCHIVE_ZONE | MONITORING_ZONE | Foreign zones directly |
| app_room_signals | APP_ROOM_ZONE_GATEWAY, MONITORING_ZONE, SMART_ARCHIVE_ZONE | APP_ROOM_ZONE_GATEWAY | SMART_ARCHIVE_ZONE | MONITORING_ZONE | Direct Library/Commercial writes |
| library_cards | LIBRARY_WEB_ZONE, approved consumers | LIBRARY_WEB_ZONE districts | SMART_ARCHIVE_ZONE | MONITORING_ZONE | App direct mutation |
| provider_registration_records | PROVIDER_REGISTRATION_WEB_ZONE, Owner audit | PROVIDER_REGISTRATION_WEB_ZONE | SMART_ARCHIVE_ZONE | MONITORING_ZONE | Provider Public direct document access |
| provider_public_profiles | PROVIDER_PUBLIC_WEB_ZONE, public approved readers | PROVIDER_PUBLIC_WEB_ZONE | SMART_ARCHIVE_ZONE | MONITORING_ZONE | Provider Registration direct publish |
| center_registration_records | CENTER_REGISTRATION_WEB_ZONE, Owner audit | CENTER_REGISTRATION_WEB_ZONE | SMART_ARCHIVE_ZONE | MONITORING_ZONE | Center Public direct document access |
| center_public_profiles | CENTER_PUBLIC_WEB_ZONE, public approved readers | CENTER_PUBLIC_WEB_ZONE | SMART_ARCHIVE_ZONE | MONITORING_ZONE | Center Registration direct publish |
| owner_authority_records | OWNER_ZONE, audited governance readers | OWNER_ZONE | SMART_ARCHIVE_ZONE | MONITORING_ZONE | Any hidden admin path |
| monitoring_reports | MONITORING_ZONE, OWNER_ZONE, SMART_ARCHIVE_ZONE | MONITORING_ZONE | SMART_ARCHIVE_ZONE | MONITORING_ZONE | Runtime mutation actors |
| strategic_reports | STRATEGIC_INTELLIGENCE_ZONE, OWNER_ZONE, SMART_ARCHIVE_ZONE | STRATEGIC_INTELLIGENCE_ZONE | SMART_ARCHIVE_ZONE | MONITORING_ZONE | Runtime mutation actors |
| archive_snapshots | SMART_ARCHIVE_ZONE, approved Owner reads | SMART_ARCHIVE_ZONE | SMART_ARCHIVE_ZONE | MONITORING_ZONE | Source zones writing archive directly |

## Rule

Read, write, archive, and observe authority must remain separated.

Forwarding a signal does not transfer ownership.

