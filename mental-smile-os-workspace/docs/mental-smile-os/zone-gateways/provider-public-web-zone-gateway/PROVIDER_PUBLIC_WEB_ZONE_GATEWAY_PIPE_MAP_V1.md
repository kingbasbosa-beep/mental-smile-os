# Provider Public Web Zone Gateway Pipe Map V1

Status: ACTIVE_PIPE_MAP
Gateway ID: PROVIDER_PUBLIC_WEB_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_040

## Pipe Map

| Direction | Target Gateway | Purpose | Boundary |
| --- | --- | --- | --- |
| Inbound | PROVIDER_REGISTRATION_WEB_ZONE_GATEWAY | Receive approved public profile packages only. | No private documents. |
| Outbound | APP_ROOM_ZONE_GATEWAY | Send provider discovery/public profile signal packages. | No direct room mutation. |
| Outbound | SMART_ARCHIVE_ZONE_GATEWAY | Send detail reports and lineage packages. | Archive does not govern. |
| Outbound | ADMIN_OWNER_ZONE_GATEWAY | Send human summaries or review-required packages. | Gateway does not authorize. |

