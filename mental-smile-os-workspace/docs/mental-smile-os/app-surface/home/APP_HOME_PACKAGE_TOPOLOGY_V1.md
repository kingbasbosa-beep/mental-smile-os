# App Home Package Topology V1

Status: ACTIVE_PACKAGE_TOPOLOGY
Screen: APP_HOME_SCREEN
Prompt Asset: PROMPT_ASSET_020

## Topology

| Relationship | Target |
| --- | --- |
| Previous | APP_SPLASH_SCREEN |
| Current | APP_HOME_SCREEN |
| Next | CLIENT_REGISTRATION |
| Next | CLIENT_ROOM |
| Next | CENTER_ROOM |
| Next | PROVIDER_ROOM |
| External Zone | LIBRARY_WEB_ZONE |
| External Zone | PROVIDER_WEB_ZONE |
| External Zone | CENTER_WEB_ZONE |

## Zone Boundary

APP_HOME_SCREEN is an APP_ROOM_ZONE gateway.

It may surface-link to LIBRARY_WEB_ZONE, PROVIDER_WEB_ZONE, and CENTER_WEB_ZONE.

It may not link to ADMIN_OWNER_ZONE or SMART_ARCHIVE_ZONE.

## Runtime Boundary

This topology does not implement navigation, routes, Firebase, or target screens.
