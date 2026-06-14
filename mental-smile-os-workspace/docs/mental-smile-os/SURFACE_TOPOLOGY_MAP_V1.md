# Surface Topology Map V1

Status: ACTIVE_TOPOLOGY_MAP
Scope: Mental Smile OS surfaces
Prompt Asset: PROMPT_ASSET_013

## 1. Purpose

Surface Topology Map defines the clean separation between Mental Smile OS app and web surfaces before screen construction begins.

Each surface is treated as a semi-independent application with its own logic boundary, navigation boundary, and constitutional purpose.

## 2. Active And Future Surfaces

| Surface | Status | Purpose |
| --- | --- | --- |
| App Surface | FUTURE_BUILD_SURFACE | Primary mobile and app experience. |
| Library Web Surface | FUTURE_WEB_SURFACE | Content, tools ecosystem, and tool selection source. |
| Public Profiles Web Surface | FUTURE_WEB_SURFACE | External discovery for centers, providers, and public services. |
| Admin Owner Web Surface | ACTIVE_OWNER_SURFACE | Owner OS, planning, construction, and future governance workspace. |
| Smart Archive Web Surface | FUTURE_MEMORY_SURFACE | Memory, archive, lineage, records, and future archive intelligence. |

## 3. Separation Rule

Surfaces may link to each other, but they must not collapse into one mixed navigation system.

Forbidden:

- One giant global menu.
- Random cross-surface navigation.
- Shared route logic between unrelated surfaces.
- Copying old menu structures.
- Merging public app navigation with Owner OS navigation.

## 4. Connection Model

Surfaces communicate only through:

- Surface Link.
- Signal Pipe.
- Card Package.

These connection types are defined in:

- SURFACE_LINK_MODEL_V1.
- SIGNAL_PIPE_MODEL_V1.
- CARD_PACKAGE_TRANSFER_MODEL_V1.

## 4A. Zone Gateway Doctrine

No internal component may send signals directly to another zone.

All cross-zone signals must pass through:

Local Zone Gateway -> Signal Pipe -> Target Zone Gateway.

Approved primary zone gateways:

- APP_ROOM_ZONE_GATEWAY.
- LIBRARY_WEB_ZONE_GATEWAY.
- PROVIDER_WEB_ZONE_GATEWAY.
- CENTER_WEB_ZONE_GATEWAY.
- ADMIN_OWNER_ZONE_GATEWAY.
- SMART_ARCHIVE_ZONE_GATEWAY.

APP_ROOM_ZONE_GATEWAY is the first foundational cloneable gateway and parent template for future gateway packages.

The App Room internal signal network connects these App Surface screens to APP_ROOM_ZONE_GATEWAY:

- APP_SPLASH_SCREEN.
- APP_HOME_SCREEN.
- APP_CLIENT_REGISTRATION_SCREEN.
- APP_CLIENT_ROOM_SCREEN.
- APP_PROVIDER_ROOM_SCREEN.
- APP_CENTER_ROOM_SCREEN.

Defined by:

- ZONE_GATEWAY_DOCTRINE_V1.
- ZONE_GATEWAY_REGISTRY_V1.
- SIGNAL_PIPE_GOVERNANCE_V1.
- ZONE_SIGNAL_ISOLATION_RULES_V1.
- APP_ROOM_ZONE_GATEWAY_CLONE_TEMPLATE_V1.
- APP_ROOM_INTERNAL_SIGNAL_NETWORK_V1.

## 5. First Screen Boundary

Splash is the first future App Surface screen and must be rebuilt cleanly from purified assets, approved localization terms, and constitutional welcome language.

No old splash layer may be copied directly.

## 6. Federation Authority Boundary

Surface topology is governed by FEDERATION_DATA_AUTHORITY_DOCTRINE_V1.

Each surface/zone remains sovereign, replaceable, and independently recoverable.

Zone Failure does not equal Federation Failure.

Firebase and backend boundaries are constitutional only until separately implemented.

## 7. Library Web Zone

LIBRARY_WEB_ZONE is the first independent Web Zone.

It is not part of App Room Zone.

It owns its own gateway, districts, content cards, tool cards, research cards, resource cards, and internal signal network.

All external communication passes through LIBRARY_WEB_ZONE_GATEWAY.

Library Web Zone Status: READY.

Closure Package: LIBRARY_WEB_ZONE_PACKAGE_MASTER_CARD_V1.

## 8. Provider Web Federation Split

Provider Registration Web Zone and Provider Public Web Zone are independent.

Provider registration and provider public display must not live in one mixed operational zone.

Registration failure must not break public profiles.

Public profile redesign must not affect provider onboarding.

All transfer between these zones must pass through their zone gateways and approved card packages.

## 10. Commercial Web Zones Closure

The commercial web layer contains four READY independent zones:

- PROVIDER_REGISTRATION_WEB_ZONE.
- PROVIDER_PUBLIC_WEB_ZONE.
- CENTER_REGISTRATION_WEB_ZONE.
- CENTER_PUBLIC_WEB_ZONE.

No commercial registration/public presentation zone may collapse back into a mixed operational zone.

## 11. Governance Federation Layer

Governance Federation Layer is independent from APP_ZONE, LIBRARY_WEB_ZONE, and COMMERCIAL_ZONES.

It contains OWNER_ZONE, MONITORING_ZONE, STRATEGIC_INTELLIGENCE_ZONE, and SMART_ARCHIVE_ZONE.

Governance may observe, audit, archive, strategize, and protect continuity and constitutional evolution.

Governance may not operate platform runtime.

## 9. Center Web Federation Split

Center Registration Web Zone and Center Public Web Zone are independent.

Center onboarding, partnership, contract preparation, and public presentation must not live in one mixed operational zone.

Center registration failures must not break public profiles.

Public profile redesign must not affect center onboarding, partnership workflows, or contract preparation.

All transfer between these zones must pass through their zone gateways and approved card packages.
