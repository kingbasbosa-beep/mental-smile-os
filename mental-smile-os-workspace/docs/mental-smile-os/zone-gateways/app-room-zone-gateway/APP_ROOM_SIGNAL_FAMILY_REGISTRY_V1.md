# App Room Signal Family Registry V1

Status: ACTIVE_SIGNAL_FAMILY_REGISTRY
Zone ID: APP_ROOM_ZONE
Gateway ID: APP_ROOM_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_032

## Approved Signal Families

| Signal Family | Description | Example Sources | Classification Status |
| --- | --- | --- | --- |
| REGISTRATION_SIGNALS | Signals from identity creation and registration flow. | APP_CLIENT_REGISTRATION_SCREEN | REGISTERED |
| ROOM_ACTIVITY_SIGNALS | Signals describing room activity presence and interaction. | APP_CLIENT_ROOM_SCREEN, APP_PROVIDER_ROOM_SCREEN, APP_CENTER_ROOM_SCREEN | REGISTERED |
| TOOL_SELECTION_SIGNALS | Signals related to selecting, replacing, or removing tools. | CLIENT_TOOL_BOARD, PROVIDER_TOOL_BOARD, CENTER_TOOL_BOARD | REGISTERED |
| NOTIFICATION_SIGNALS | Signals related to viewing or receiving notification panel content. | Client, Provider, and Center notification panels | REGISTERED |
| PROFILE_SHORTCUT_SIGNALS | Signals related to public profile shortcuts. | PROVIDER_PUBLIC_PROFILE_SHORTCUT, CENTER_PUBLIC_PROFILE_SHORTCUT | REGISTERED |
| RESEARCH_DESK_SIGNALS | Signals related to provider research desk usage. | PROVIDER_RESEARCH_DESK | REGISTERED |
| MOTIVATION_NOTE_SIGNALS | Signals related to motivation note activity. | CLIENT_NOTE_WIDGET | REGISTERED |
| EXIT_ACTION_SIGNALS | Signals related to room exits. | Client, Provider, and Center exit actions | REGISTERED |
| ASSISTANT_USAGE_SIGNALS | Signals related to assistant surface usage. | PROVIDER_AI_ASSISTANT, CENTER_AI_ASSISTANT | REGISTERED |

## Rule

Signal families are constitutional classifications only.

They do not create runtime behavior, signal execution, data storage, or analytics.

