# Library District Gateway Mapping V1

Status: ACTIVE_DISTRICT_GATEWAY_MAPPING
Zone ID: LIBRARY_WEB_ZONE
Gateway ID: LIBRARY_WEB_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_037
Parent Prompt: PROMPT_ASSET_036

## 1. Purpose

Map every Library District to LIBRARY_WEB_ZONE_GATEWAY.

All districts communicate externally only through LIBRARY_WEB_ZONE_GATEWAY.

## 2. District Gateway Mapping

| District ID | Primary Signal Family | Required Gateway | Inbound Signals | Outbound Signals | Allowed Routing | Forbidden Routing |
| --- | --- | --- | --- | --- | --- | --- |
| KNOWLEDGE_DISTRICT | CONTENT_DISCOVERY_SIGNALS | LIBRARY_WEB_ZONE_GATEWAY | Knowledge/content discovery packages. | Knowledge summary packages. | Internal districts, Library Gateway. | Direct APP_ROOM_ZONE_GATEWAY. |
| TOOLS_DISTRICT | TOOL_DISCOVERY_SIGNALS | LIBRARY_WEB_ZONE_GATEWAY | Tool discovery packages. | Tool discovery summary packages. | Internal districts, Library Gateway. | Direct CLIENT_ROOM. |
| RESEARCH_DISTRICT | RESEARCH_DISCOVERY_SIGNALS | LIBRARY_WEB_ZONE_GATEWAY | Research discovery packages. | Research summary packages. | Internal districts, Library Gateway. | Direct PROVIDER_ROOM. |
| ASSESSMENT_DISTRICT | ASSESSMENT_DISCOVERY_SIGNALS | LIBRARY_WEB_ZONE_GATEWAY | Assessment discovery packages. | Assessment summary packages. | Internal districts, Library Gateway. | Direct external zone communication. |
| VR_DISTRICT | VR_DISCOVERY_SIGNALS | LIBRARY_WEB_ZONE_GATEWAY | VR discovery packages. | VR summary packages. | Internal districts, Library Gateway. | Direct CENTER_ROOM. |
| RECOVERY_DISTRICT | RECOVERY_DISCOVERY_SIGNALS | LIBRARY_WEB_ZONE_GATEWAY | Recovery discovery packages. | Recovery summary packages. | Internal districts, Library Gateway. | Direct external zone communication. |
| FAMILY_DISTRICT | FAMILY_DISCOVERY_SIGNALS | LIBRARY_WEB_ZONE_GATEWAY | Family discovery packages. | Family summary packages. | Internal districts, Library Gateway. | Direct external zone communication. |
| ACCESSIBILITY_DISTRICT | ACCESSIBILITY_DISCOVERY_SIGNALS | LIBRARY_WEB_ZONE_GATEWAY | Accessibility discovery packages. | Accessibility summary packages. | Internal districts, Library Gateway. | Direct external zone communication. |
| RESOURCE_DISTRICT | RESOURCE_DISCOVERY_SIGNALS | LIBRARY_WEB_ZONE_GATEWAY | Resource discovery packages. | Resource summary packages. | Internal districts, Library Gateway. | Direct external zone communication. |

## 3. Routing Rule

District -> Signal Package -> LIBRARY_WEB_ZONE_GATEWAY.

No district may send directly to an external zone, room, or gateway.

