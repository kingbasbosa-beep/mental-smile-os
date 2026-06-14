# Firebase Signal Collection Map V1

Status: SIGNAL_COLLECTION_MAP_CREATED
Prompt Asset: PROMPT_ASSET_053

## Purpose

Define signal families, ownership, retention, routing ownership, and archive policy.

No signal collections are created by this document.

## Signal Collection Map

| Signal Family | Owner Zone | Routing Owner | Retention | Archive Policy |
| --- | --- | --- | --- | --- |
| SPLASH_UI_SIGNALS | APP_ROOM_ZONE | APP_ROOM_ZONE_GATEWAY | Short-term summary | Archive aggregate only |
| LOGIN_UI_SIGNALS | APP_ROOM_ZONE | APP_ROOM_ZONE_GATEWAY | Short-term summary | Archive aggregate only |
| HOME_NAVIGATION_SIGNALS | APP_ROOM_ZONE | APP_ROOM_ZONE_GATEWAY | Short-term summary | Archive aggregate only |
| REGISTRATION_SIGNALS | APP_ROOM_ZONE | APP_ROOM_ZONE_GATEWAY | Lifecycle summary | Archive detail reports |
| ROOM_ACTIVITY_SIGNALS | APP_ROOM_ZONE | APP_ROOM_ZONE_GATEWAY | Short-term summary | Archive aggregate only |
| TOOL_SELECTION_SIGNALS | APP_ROOM_ZONE | APP_ROOM_ZONE_GATEWAY | Discovery lifecycle | Archive detail reports |
| LIBRARY_DISCOVERY_SIGNALS | LIBRARY_WEB_ZONE | LIBRARY_WEB_ZONE_GATEWAY | Discovery lifecycle | Archive summaries |
| PROVIDER_ONBOARDING_SIGNALS | PROVIDER_REGISTRATION_WEB_ZONE | PROVIDER_REGISTRATION_WEB_ZONE_GATEWAY | Onboarding lifecycle | Private archive |
| PROVIDER_DISCOVERY_SIGNALS | PROVIDER_PUBLIC_WEB_ZONE | PROVIDER_PUBLIC_WEB_ZONE_GATEWAY | Public discovery lifecycle | Public summary archive |
| CENTER_ONBOARDING_SIGNALS | CENTER_REGISTRATION_WEB_ZONE | CENTER_REGISTRATION_WEB_ZONE_GATEWAY | Onboarding lifecycle | Private archive |
| CENTER_DISCOVERY_SIGNALS | CENTER_PUBLIC_WEB_ZONE | CENTER_PUBLIC_WEB_ZONE_GATEWAY | Public discovery lifecycle | Public summary archive |
| OWNER_AUTHORITY_SIGNALS | OWNER_ZONE | OWNER_ZONE_GATEWAY | Permanent governance | Permanent archive |
| MONITORING_SIGNALS | MONITORING_ZONE | MONITORING_ZONE_GATEWAY | Monitoring lifecycle | Detail archive |
| STRATEGIC_SUMMARY_SIGNALS | STRATEGIC_INTELLIGENCE_ZONE | STRATEGIC_INTELLIGENCE_ZONE_GATEWAY | Strategic lifecycle | Strategic archive |
| ARCHIVE_SIGNALS | SMART_ARCHIVE_ZONE | SMART_ARCHIVE_ZONE_GATEWAY | Permanent archive lifecycle | Permanent archive |

## Signal Rule

Signal ownership remains attached to the source zone.

Routing does not transfer ownership.

