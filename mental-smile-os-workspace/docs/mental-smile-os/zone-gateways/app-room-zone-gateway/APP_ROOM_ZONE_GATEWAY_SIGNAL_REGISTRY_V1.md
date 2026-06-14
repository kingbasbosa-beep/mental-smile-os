# App Room Zone Gateway Signal Registry V1

Status: ACTIVE_GATEWAY_SIGNAL_REGISTRY
Gateway ID: APP_ROOM_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_031
Internal Network Prompt: PROMPT_ASSET_032

## 1. Inbound Sources

| Source ID | Source Type | Zone | Gateway Rule | Status |
| --- | --- | --- | --- | --- |
| APP_SPLASH_SCREEN | App Screen | APP_ROOM_ZONE | Signals terminate at APP_ROOM_ZONE_GATEWAY. | REGISTERED |
| APP_HOME_SCREEN | App Screen | APP_ROOM_ZONE | Signals terminate at APP_ROOM_ZONE_GATEWAY. | REGISTERED |
| APP_CLIENT_REGISTRATION_SCREEN | App Screen | APP_ROOM_ZONE | Signals terminate at APP_ROOM_ZONE_GATEWAY. | REGISTERED |
| APP_CLIENT_ROOM_SCREEN | App Screen | APP_ROOM_ZONE | Signals terminate at APP_ROOM_ZONE_GATEWAY. | REGISTERED |
| APP_PROVIDER_ROOM_SCREEN | App Screen | APP_ROOM_ZONE | Signals terminate at APP_ROOM_ZONE_GATEWAY. | REGISTERED |
| APP_CENTER_ROOM_SCREEN | App Screen | APP_ROOM_ZONE | Signals terminate at APP_ROOM_ZONE_GATEWAY. | REGISTERED |

## 2. Gateway Signal Package Fields

- Package ID.
- Source Screen.
- Signal Family.
- Signal Count.
- Signal Category.
- Destination Gateway.
- Classification.
- Human Summary Reference.
- Detail Report Reference.
- Buffer Status.
- Forwarding Status.

## 3. Boundary

This registry defines signal package custody only. It does not execute signals, create queues, or store runtime data.

## 4. Registered Signal Families

| Signal Family | Status |
| --- | --- |
| REGISTRATION_SIGNALS | REGISTERED |
| ROOM_ACTIVITY_SIGNALS | REGISTERED |
| TOOL_SELECTION_SIGNALS | REGISTERED |
| NOTIFICATION_SIGNALS | REGISTERED |
| PROFILE_SHORTCUT_SIGNALS | REGISTERED |
| RESEARCH_DESK_SIGNALS | REGISTERED |
| MOTIVATION_NOTE_SIGNALS | REGISTERED |
| EXIT_ACTION_SIGNALS | REGISTERED |
| ASSISTANT_USAGE_SIGNALS | REGISTERED |

## 5. Internal Routing Rule

Every registered source sends signal packages to APP_ROOM_ZONE_GATEWAY only.

Direct cross-zone routing is forbidden.
