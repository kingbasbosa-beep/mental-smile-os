# Pure Asset YAML Map V1

Status: ASSET_YAML_MAP
Prompt Asset: PROMPT_ASSET_045

## Purpose

Define the future mapping model for OS asset paths before YAML implementation.

## Asset YAML Entry Model

| Field | Requirement |
| --- | --- |
| YAML Asset ID | Required |
| Future OS Path | Required |
| Asset Card | Required |
| Ownership Card | Required |
| Recreation Prompt | Required |
| Zone | Required |
| Screen or District | Required |
| Status | Required |
| Legacy Source Evidence | Optional and never active path |

## Registered Asset Families

| Asset Family | Zone | Status |
| --- | --- | --- |
| Splash assets | APP_ROOM_ZONE | REGISTERED_FOR_FUTURE_YAML |
| Home assets | APP_ROOM_ZONE | REGISTERED_FOR_FUTURE_YAML |
| Client Registration assets | APP_ROOM_ZONE | REGISTERED_FOR_FUTURE_YAML |
| Client Room assets | APP_ROOM_ZONE | REGISTERED_FOR_FUTURE_YAML |
| Provider Room assets | APP_ROOM_ZONE | REGISTERED_FOR_FUTURE_YAML |
| Center Room assets | APP_ROOM_ZONE | REGISTERED_FOR_FUTURE_YAML |
| Library content assets | LIBRARY_WEB_ZONE | FUTURE_DISTRICT_BOUNDARY |
| Provider public assets | PROVIDER_PUBLIC_WEB_ZONE | FUTURE_PUBLIC_BOUNDARY |
| Center public assets | CENTER_PUBLIC_WEB_ZONE | FUTURE_PUBLIC_BOUNDARY |

## Forbidden YAML Asset Entries

- Old names without OS rename.
- Old paths as active runtime paths.
- Asset without card.
- Asset without ownership.
- Asset without recreation prompt.
- Asset without zone.

