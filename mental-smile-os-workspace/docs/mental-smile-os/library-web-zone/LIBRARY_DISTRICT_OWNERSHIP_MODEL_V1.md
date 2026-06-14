# Library District Ownership Model V1

Status: ACTIVE_DISTRICT_OWNERSHIP_MODEL
Zone ID: LIBRARY_WEB_ZONE
Prompt Asset: PROMPT_ASSET_036

## 1. District Ownership Rule

Each Card belongs to exactly one primary district.

A card may be referenced by multiple districts.

Ownership remains with the primary district.

No orphan cards are allowed.

## 2. Ownership Matrix

| District ID | Owns Primary Card Types | May Reference | Ownership Boundary |
| --- | --- | --- | --- |
| KNOWLEDGE_DISTRICT | Knowledge, Guide, Educational Cards | Research, Resource, Accessibility Cards | Knowledge owns learning context. |
| TOOLS_DISTRICT | Tool, Tool Category, Tool Discovery Cards | Resource, Knowledge, Accessibility Cards | Tools owns tool classification only. |
| RESEARCH_DISTRICT | Research, Study, Reference Cards | Assessment, Knowledge, Resource Cards | Research owns evidence context. |
| ASSESSMENT_DISTRICT | Assessment, Scale, Reference Cards | Research, Knowledge, Resource Cards | Assessment owns assessment reference context only. |
| VR_DISTRICT | VR, VR Resource Cards | Recovery, Knowledge, Accessibility Cards | VR owns immersive learning classification only. |
| RECOVERY_DISTRICT | Recovery, Recovery Resource Cards | Knowledge, Family, Resource Cards | Recovery owns recovery support knowledge context. |
| FAMILY_DISTRICT | Family, Guidance Cards | Knowledge, Recovery, Resource Cards | Family owns family support context. |
| ACCESSIBILITY_DISTRICT | Accessibility, Accessibility Resource Cards | Any district card needing accessibility context | Accessibility owns inclusion context. |
| RESOURCE_DISTRICT | Resource, Directory, Reference Cards | Any district needing external/resource reference | Resource owns directory and support-service context. |

