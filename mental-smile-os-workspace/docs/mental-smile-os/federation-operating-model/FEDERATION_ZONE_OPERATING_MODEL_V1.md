# FEDERATION_ZONE_OPERATING_MODEL_V1

## Purpose

Define how Generation 1 zones operate as sovereign units inside the federation.

## Operating Rule

Each zone owns its internal runtime, cards, signals, reports, registries, memory, and local authority boundaries.

## Active Zones

| Zone | Operating Role | External Communication |
| --- | --- | --- |
| APP_ZONE | App screens and rooms. | APP_ROOM_ZONE_GATEWAY |
| LIBRARY_WEB_ZONE | Knowledge and resource districts. | LIBRARY_WEB_ZONE_GATEWAY |
| PROVIDER_REGISTRATION_WEB_ZONE | Provider onboarding. | PROVIDER_REGISTRATION_WEB_ZONE_GATEWAY |
| PROVIDER_PUBLIC_WEB_ZONE | Provider public discovery. | PROVIDER_PUBLIC_WEB_ZONE_GATEWAY |
| CENTER_REGISTRATION_WEB_ZONE | Center onboarding and partnership preparation. | CENTER_REGISTRATION_WEB_ZONE_GATEWAY |
| CENTER_PUBLIC_WEB_ZONE | Center public discovery. | CENTER_PUBLIC_WEB_ZONE_GATEWAY |
| OWNER_ZONE | Constitutional authority. | OWNER_ZONE_GATEWAY |
| MONITORING_ZONE | Observability and escalation visibility. | MONITORING_ZONE_GATEWAY |
| STRATEGIC_INTELLIGENCE_ZONE | Strategic analysis and recommendations. | STRATEGIC_INTELLIGENCE_ZONE_GATEWAY |
| SMART_ARCHIVE_ZONE | Archive, snapshots, recovery assets. | SMART_ARCHIVE_ZONE_GATEWAY |

## Forbidden

- No zone mutates another zone directly.
- No zone bypasses its gateway.
- No zone absorbs another zone authority.
- No zone treats runtime convenience as constitutional authority.

## Survival Principle

Each zone must remain independently replaceable. Zone failure does not equal federation failure.
