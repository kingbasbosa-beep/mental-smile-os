# App Room Zone Gateway Pipe Map V1

Status: ACTIVE_PIPE_MAP
Gateway ID: APP_ROOM_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_031

## Approved Outbound Pipes

| Pipe ID | Source Gateway | Target Gateway | Allowed Purpose | Forbidden Use | Status |
| --- | --- | --- | --- | --- | --- |
| PIPE_TO_LIBRARY_WEB_ZONE | APP_ROOM_ZONE_GATEWAY | LIBRARY_WEB_ZONE_GATEWAY | Send app-room signal packages relevant to Library and tools ecosystem. | Direct content decision, direct recommendation. | APPROVED |
| PIPE_TO_PROVIDER_WEB_ZONE | APP_ROOM_ZONE_GATEWAY | PROVIDER_WEB_ZONE_GATEWAY | Send app-room packages relevant to provider public discovery. | Direct provider action, provider scoring. | APPROVED |
| PIPE_TO_CENTER_WEB_ZONE | APP_ROOM_ZONE_GATEWAY | CENTER_WEB_ZONE_GATEWAY | Send app-room packages relevant to center public discovery. | Direct center action, center scoring. | APPROVED |
| PIPE_TO_ADMIN_OWNER_ZONE | APP_ROOM_ZONE_GATEWAY | ADMIN_OWNER_ZONE_GATEWAY | Send human summaries and owner-review packages. | Governance or authorization by gateway. | APPROVED |
| PIPE_TO_SMART_ARCHIVE_ZONE | APP_ROOM_ZONE_GATEWAY | SMART_ARCHIVE_ZONE_GATEWAY | Send structured detail reports and lineage-relevant packages. | AI analysis or archive mutation outside Memory rules. | APPROVED |

## Pipe Rule

No additional outbound pipes are approved for APP_ROOM_ZONE_GATEWAY.

