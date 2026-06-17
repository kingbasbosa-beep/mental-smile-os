# Library District Constitution V1

Status: ACTIVE_DISTRICT_CONSTITUTION
Zone ID: LIBRARY_WEB_ZONE
Prompt Asset: PROMPT_ASSET_036
Parent Prompt: PROMPT_ASSET_035

## 1. Purpose

Define the constitutional identity of every Library District.

Every future content card, tool card, research card, resource card, assessment card, and accessibility card must belong to a district.

No orphan cards are allowed.

## 2. District Constitution

| District ID | Purpose | Ownership | Allowed Card Types | Allowed Signal Families | Consumers | Restrictions | Inbound Signal Sources | Outbound Signal Destinations |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| KNOWLEDGE_DISTRICT | Educational knowledge, awareness, understanding, mental health learning. | Library Web Zone | Knowledge Cards, Guide Cards, Educational Cards | CONTENT_DISCOVERY_SIGNALS | App Room Zone, Library readers, Strategic summaries | No diagnosis, no treatment promises, no runtime identity ownership. | Library internal discovery, gateway packages | LIBRARY_WEB_ZONE_GATEWAY |
| TOOLS_DISTRICT | Tool discovery, tool catalog, tool classification. | Library Web Zone | Tool Cards, Tool Category Cards, Tool Discovery Cards | TOOL_DISCOVERY_SIGNALS | App Room Zone, Client Room, Provider Room, Center Room | No tool execution, no matching engine, no scoring. | Tool-related gateway packages, district references | LIBRARY_WEB_ZONE_GATEWAY |
| RESEARCH_DISTRICT | Research, studies, academic content, evidence sources. | Library Web Zone | Research Cards, Study Cards, Reference Cards | RESEARCH_DISCOVERY_SIGNALS | Provider Room, Center Room, Strategic Planning | No clinical decisions, no automated recommendations. | Research discovery packages, internal references | LIBRARY_WEB_ZONE_GATEWAY |
| ASSESSMENT_DISTRICT | Assessments, scales, screening resources, evaluation references. | Library Web Zone | Assessment Cards, Scale Cards, Reference Cards | ASSESSMENT_DISCOVERY_SIGNALS | Provider Room, Center Room, Knowledge District | No diagnosis, no scoring runtime, no user evaluation storage. | Assessment discovery packages, internal references | LIBRARY_WEB_ZONE_GATEWAY |
| VR_DISTRICT | VR experiences, therapeutic simulations, immersive learning. | Library Web Zone | VR Cards, VR Resource Cards | VR_DISCOVERY_SIGNALS | App Room Zone, Provider Room, Center Room | No VR runtime, no therapeutic claims, no device implementation. | VR discovery packages, internal references | LIBRARY_WEB_ZONE_GATEWAY |
| RECOVERY_DISTRICT | Recovery support, recovery knowledge, recovery resources. | Library Web Zone | Recovery Cards, Recovery Resource Cards | RECOVERY_DISCOVERY_SIGNALS | Client Room, Family District, Knowledge District | No treatment promises, no emergency intervention claims. | Recovery discovery packages, internal references | LIBRARY_WEB_ZONE_GATEWAY |
| FAMILY_DISTRICT | Family support, parent guidance, relationship resources. | Library Web Zone | Family Cards, Guidance Cards | FAMILY_DISCOVERY_SIGNALS | Client Room, Family readers, Knowledge District | No legal advice, no clinical directive, no profile ownership. | Family discovery packages, internal references | LIBRARY_WEB_ZONE_GATEWAY |
| ACCESSIBILITY_DISTRICT | Accessibility, disability support, inclusion resources. | Library Web Zone | Accessibility Cards, Accessibility Resource Cards | ACCESSIBILITY_DISCOVERY_SIGNALS | App Room Zone, all Library districts, Strategic summaries | No runtime accessibility implementation, no user identity ownership. | Accessibility discovery packages, internal references | LIBRARY_WEB_ZONE_GATEWAY |
| RESOURCE_DISTRICT | Directories, external resources, support services, reference resources. | Library Web Zone | Resource Cards, Directory Cards, Reference Cards | RESOURCE_DISCOVERY_SIGNALS | App Room Zone, Provider Room, Center Room, Knowledge District | No external endorsement by default, no emergency service guarantee. | Resource discovery packages, internal references | LIBRARY_WEB_ZONE_GATEWAY |

## 3. Federation Rule

Districts communicate internally.

Districts never communicate directly with external zones.

External communication only through LIBRARY_WEB_ZONE_GATEWAY.

