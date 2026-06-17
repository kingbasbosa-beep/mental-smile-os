# Library District Registry V1

Status: ACTIVE_DISTRICT_REGISTRY
Zone ID: LIBRARY_WEB_ZONE
Prompt Asset: PROMPT_ASSET_035
Latest District Constitution Prompt: PROMPT_ASSET_036
Latest District Gateway Mapping Prompt: PROMPT_ASSET_037
Latest Internal Neural Network Prompt: PROMPT_ASSET_038

## Registered Districts

| District ID | Purpose | Primary Signal Family | Status |
| --- | --- | --- | --- |
| KNOWLEDGE_DISTRICT | Educational knowledge, awareness, understanding, mental health learning. | CONTENT_DISCOVERY_SIGNALS | CONSTITUTION_DEFINED |
| TOOLS_DISTRICT | Tool discovery, tool catalog, tool classification. | TOOL_DISCOVERY_SIGNALS | CONSTITUTION_DEFINED |
| RESEARCH_DISTRICT | Research, studies, academic content, evidence sources. | RESEARCH_DISCOVERY_SIGNALS | CONSTITUTION_DEFINED |
| ASSESSMENT_DISTRICT | Assessments, scales, screening resources, evaluation references. | ASSESSMENT_DISCOVERY_SIGNALS | CONSTITUTION_DEFINED |
| VR_DISTRICT | VR experiences, therapeutic simulations, immersive learning. | VR_DISCOVERY_SIGNALS | CONSTITUTION_DEFINED |
| RECOVERY_DISTRICT | Recovery support, recovery knowledge, recovery resources. | RECOVERY_DISCOVERY_SIGNALS | CONSTITUTION_DEFINED |
| FAMILY_DISTRICT | Family support, parent guidance, relationship resources. | FAMILY_DISCOVERY_SIGNALS | CONSTITUTION_DEFINED |
| ACCESSIBILITY_DISTRICT | Accessibility, disability support, inclusion resources. | ACCESSIBILITY_DISCOVERY_SIGNALS | CONSTITUTION_DEFINED |
| RESOURCE_DISTRICT | Directories, external resources, support services, reference resources. | RESOURCE_DISCOVERY_SIGNALS | CONSTITUTION_DEFINED |

## District Rule

Districts may communicate internally.

Districts may not communicate directly with external zones.

All external communication passes through LIBRARY_WEB_ZONE_GATEWAY.

## Card Ownership Rule

Every future Library card must belong to exactly one primary district.

A card may be referenced by multiple districts, but ownership remains with the primary district.

No orphan cards are allowed.

## Gateway Mapping Rule

Each registered district maps to LIBRARY_WEB_ZONE_GATEWAY for all external communication.

Districts may communicate internally, but no district may communicate directly with external zones.

## Internal Neural Network Rule

All registered districts are producers and consumers of internal Library references and card relationships.

All external signal traffic must terminate at LIBRARY_WEB_ZONE_GATEWAY.
