# Library Internal Routing Model V1

Status: ACTIVE_INTERNAL_ROUTING_MODEL
Zone ID: LIBRARY_WEB_ZONE
Gateway ID: LIBRARY_WEB_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_038

## Routing Rules

| Source District | Allowed Internal Communications | Restricted Communications | External Exit |
| --- | --- | --- | --- |
| KNOWLEDGE_DISTRICT | Research, Resource, Accessibility, Recovery, Family | Direct external zones | LIBRARY_WEB_ZONE_GATEWAY |
| TOOLS_DISTRICT | Knowledge, Resource, Accessibility | Direct Client Room, direct App Zone | LIBRARY_WEB_ZONE_GATEWAY |
| RESEARCH_DISTRICT | Knowledge, Assessment, Resource, Accessibility | Direct Provider Room | LIBRARY_WEB_ZONE_GATEWAY |
| ASSESSMENT_DISTRICT | Research, Knowledge, Resource | Direct scoring runtime or external zones | LIBRARY_WEB_ZONE_GATEWAY |
| VR_DISTRICT | Knowledge, Recovery, Accessibility, Resource | Direct Center Room or VR runtime | LIBRARY_WEB_ZONE_GATEWAY |
| RECOVERY_DISTRICT | Knowledge, Family, Resource, Accessibility | Direct App Zone or treatment claim | LIBRARY_WEB_ZONE_GATEWAY |
| FAMILY_DISTRICT | Knowledge, Recovery, Resource | Direct external zones or legal/clinical directives | LIBRARY_WEB_ZONE_GATEWAY |
| ACCESSIBILITY_DISTRICT | All Library districts | Direct runtime implementation | LIBRARY_WEB_ZONE_GATEWAY |
| RESOURCE_DISTRICT | All Library districts | Direct external service control | LIBRARY_WEB_ZONE_GATEWAY |

## Forbidden Communication

District X APP_ROOM_ZONE_GATEWAY.

District X CLIENT_ROOM.

District X PROVIDER_ROOM.

District X CENTER_ROOM.

District X SMART_ARCHIVE_ZONE.

Direct communication is prohibited.

