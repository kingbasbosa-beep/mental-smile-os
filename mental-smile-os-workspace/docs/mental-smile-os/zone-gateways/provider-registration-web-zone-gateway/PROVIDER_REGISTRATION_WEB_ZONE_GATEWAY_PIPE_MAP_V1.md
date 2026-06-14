# Provider Registration Web Zone Gateway Pipe Map V1

Status: ACTIVE_PIPE_MAP
Gateway ID: PROVIDER_REGISTRATION_WEB_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_040

## Pipe Map

| Direction | Target Gateway | Purpose | Boundary |
| --- | --- | --- | --- |
| Outbound | PROVIDER_PUBLIC_WEB_ZONE_GATEWAY | Send approved public profile packages only. | No private documents. |
| Outbound | ADMIN_OWNER_ZONE_GATEWAY | Send review-required summaries. | Gateway does not authorize. |
| Outbound | SMART_ARCHIVE_ZONE_GATEWAY | Send detail reports and lineage packages. | Archive does not govern. |
| Inbound | PROVIDER_PUBLIC_WEB_ZONE_GATEWAY | Receive public presentation feedback packages. | No mutation of registration records. |

