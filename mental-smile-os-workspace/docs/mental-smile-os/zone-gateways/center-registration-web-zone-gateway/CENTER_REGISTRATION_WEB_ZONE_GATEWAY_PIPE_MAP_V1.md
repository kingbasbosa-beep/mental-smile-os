# Center Registration Web Zone Gateway Pipe Map V1

Status: ACTIVE_PIPE_MAP
Gateway ID: CENTER_REGISTRATION_WEB_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_042

| Direction | Target Gateway | Purpose | Boundary |
| --- | --- | --- | --- |
| Outbound | CENTER_PUBLIC_WEB_ZONE_GATEWAY | Send approved public center profile/service/trust packages. | No private documents. |
| Outbound | ADMIN_OWNER_ZONE_GATEWAY | Send review-required summaries. | Gateway does not authorize. |
| Outbound | SMART_ARCHIVE_ZONE_GATEWAY | Send detail reports and lineage packages. | Archive does not govern. |

