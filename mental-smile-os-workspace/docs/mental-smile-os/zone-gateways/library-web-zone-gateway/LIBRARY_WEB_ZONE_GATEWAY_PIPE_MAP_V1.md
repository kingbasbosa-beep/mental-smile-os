# Library Web Zone Gateway Pipe Map V1

Status: ACTIVE_PIPE_MAP
Gateway ID: LIBRARY_WEB_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_035

## Pipe Governance

LIBRARY_WEB_ZONE_GATEWAY communicates externally only through approved Signal Pipes and target Zone Gateways.

## Constitutional Pipe Directions

| Direction | Gateway | Purpose | Boundary |
| --- | --- | --- | --- |
| Inbound | APP_ROOM_ZONE_GATEWAY -> LIBRARY_WEB_ZONE_GATEWAY | Receive app-originated discovery signals. | Ownership remains source zone. |
| Outbound | LIBRARY_WEB_ZONE_GATEWAY -> APP_ROOM_ZONE_GATEWAY | Send eligible content candidate packages. | No recommendation engine. |
| Outbound | LIBRARY_WEB_ZONE_GATEWAY -> SMART_ARCHIVE_ZONE_GATEWAY | Send detail reports and lineage-relevant packages. | Archive does not govern. |
| Outbound | LIBRARY_WEB_ZONE_GATEWAY -> ADMIN_OWNER_ZONE_GATEWAY | Send human summaries or review-required packages. | Gateway does not authorize. |

