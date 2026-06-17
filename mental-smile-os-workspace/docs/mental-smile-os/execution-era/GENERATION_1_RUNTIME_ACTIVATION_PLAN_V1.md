# Generation 1 Runtime Activation Plan V1

Status: RUNTIME_ACTIVATION_PLAN_CREATED
Prompt Asset: PROMPT_ASSET_065

## Purpose

Define the approved runtime activation path for Generation 1.

## Source Authorities

- GENERATION_1_RUNTIME_IMPLEMENTATION_PACKAGE_V1.
- GENERATION_1_RUNTIME_TARGET_STRUCTURE_V1.
- PURE_RUNTIME_TARGET_V1.
- ACTIVE_RUNTIME_BLUEPRINT_V1.
- RUNTIME_RECONNECTION_TOPOLOGY_V1.

## Routes To Implement

| Runtime Route | Screen Or Zone | Status |
| --- | --- | --- |
| /app/splash | APP_SPLASH_SCREEN | READY |
| /app/login | APP_LOGIN_SCREEN | READY |
| /app/home | APP_HOME_SCREEN | READY |
| /app/client-registration | APP_CLIENT_REGISTRATION_SCREEN | READY |
| /app/client-room | APP_CLIENT_ROOM_SCREEN | READY |
| /app/provider-room | APP_PROVIDER_ROOM_SCREEN | READY |
| /app/center-room | APP_CENTER_ROOM_SCREEN | READY |
| /app/exit-social-links | APP_EXIT_SOCIAL_LINKS_SCREEN | READY |
| /library | LIBRARY_WEB_ZONE | READY |
| /providers/register | PROVIDER_REGISTRATION_WEB_ZONE | READY |
| /providers | PROVIDER_PUBLIC_WEB_ZONE | READY |
| /centers/register | CENTER_REGISTRATION_WEB_ZONE | READY |
| /centers | CENTER_PUBLIC_WEB_ZONE | READY |
| /owner | OWNER_ZONE | READY |
| /monitoring | MONITORING_ZONE | READY |
| /strategic-intelligence | STRATEGIC_INTELLIGENCE_ZONE | READY |
| /smart-archive | SMART_ARCHIVE_ZONE | READY |

## Screens To Implement

- Splash.
- Login.
- Home.
- Client Registration.
- Client Room.
- Provider Room.
- Center Room.
- Exit Social Links.

## Gateways To Implement

- APP_ROOM_ZONE_GATEWAY.
- LIBRARY_WEB_ZONE_GATEWAY.
- PROVIDER_REGISTRATION_WEB_ZONE_GATEWAY.
- PROVIDER_PUBLIC_WEB_ZONE_GATEWAY.
- CENTER_REGISTRATION_WEB_ZONE_GATEWAY.
- CENTER_PUBLIC_WEB_ZONE_GATEWAY.
- OWNER_ZONE_GATEWAY.
- MONITORING_ZONE_GATEWAY.
- STRATEGIC_INTELLIGENCE_ZONE_GATEWAY.
- SMART_ARCHIVE_ZONE_GATEWAY.

## Signals To Implement

Runtime signal execution must be limited to registered Generation 1 signal families.

Signal routing must follow:

```text
Surface or District
  -> Local Gateway
  -> Approved Pipe
  -> Target Gateway
  -> Target Zone
```

## Models To Implement

- Zone model.
- Gateway model.
- Signal package model.
- Screen state model.
- Card model.
- Registry model.
- Archive snapshot model.

## Collections To Connect

Runtime may connect only to approved Generation 1 collection families.

## Activation Gate

Runtime activation may begin after YAML assets and Firebase rules are reviewed against the launch preparation pack.

