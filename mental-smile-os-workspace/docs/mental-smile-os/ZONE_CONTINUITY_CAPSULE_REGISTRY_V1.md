# Zone Continuity Capsule Registry V1

Status: ACTIVE_CONTINUITY_CAPSULE_REGISTRY
Prompt Asset: PROMPT_ASSET_034

## Capsule Registry

| Gateway ID | Capsule ID | Capsule Owner | Purpose | Status |
| --- | --- | --- | --- | --- |
| APP_ROOM_ZONE_GATEWAY | APP_ROOM_CONTINUITY_CAPSULE | APP_ROOM_ZONE_GATEWAY | Temporary App Room signal preservation and replay. | DEFINED |
| LIBRARY_WEB_ZONE_GATEWAY | LIBRARY_CONTINUITY_CAPSULE | LIBRARY_WEB_ZONE_GATEWAY | Temporary Library signal preservation and replay. | DEFINED |
| PROVIDER_WEB_ZONE_GATEWAY | PROVIDER_CONTINUITY_CAPSULE | PROVIDER_WEB_ZONE_GATEWAY | Temporary Provider zone signal preservation and replay. | DEFINED |
| CENTER_WEB_ZONE_GATEWAY | CENTER_CONTINUITY_CAPSULE | CENTER_WEB_ZONE_GATEWAY | Temporary Center zone signal preservation and replay. | DEFINED |
| ADMIN_OWNER_ZONE_GATEWAY | OWNER_CONTINUITY_CAPSULE | ADMIN_OWNER_ZONE_GATEWAY | Temporary Owner/Admin signal preservation and replay. | DEFINED |
| SMART_ARCHIVE_ZONE_GATEWAY | ARCHIVE_CONTINUITY_CAPSULE | SMART_ARCHIVE_ZONE_GATEWAY | Temporary Smart Archive signal preservation and replay. | DEFINED |

## Rule

Each Zone Gateway owns one Continuity Capsule.

No foreign zone may read or write directly to another gateway capsule.

