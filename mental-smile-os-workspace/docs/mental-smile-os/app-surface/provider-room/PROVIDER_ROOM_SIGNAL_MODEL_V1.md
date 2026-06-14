# Provider Room Signal Model V1

Status: CONCEPTUAL_SIGNAL_MODEL
Screen: APP_PROVIDER_ROOM_SCREEN
Prompt Asset: PROMPT_ASSET_028

## Signal Inventory

| Signal ID | Signal Name | Source Component | Consumer | Trigger Condition | Expected Outcome | Boundary |
| --- | --- | --- | --- | --- | --- | --- |
| PROVIDER_ROOM_SIGNAL_001 | PROVIDER_TOOL_SELECTED | PROVIDER_TOOL_BOARD | Future professional tool memory | Provider selects a tool. | Tool selection may be known later. | No execution or recommendation logic. |
| PROVIDER_ROOM_SIGNAL_002 | PROVIDER_NOTIFICATION_VIEWED | PROVIDER_NOTIFICATION_PANEL | Future notification memory | Provider views notification panel. | Display state may be known later. | No runtime tracking in this step. |
| PROVIDER_ROOM_SIGNAL_003 | PROVIDER_AI_ASSISTANT_REQUESTED | PROVIDER_AI_ASSISTANT | Future AI governance layer | Provider invokes assistant concept. | Assistant scope may be evaluated later. | No AI implementation. |
| PROVIDER_ROOM_SIGNAL_004 | PROVIDER_RESEARCH_DESK_OPENED | PROVIDER_RESEARCH_DESK | Future workspace memory | Provider opens research desk concept. | Workspace intent may be known later. | No calendar/tasks implementation. |
| PROVIDER_ROOM_SIGNAL_005 | PROVIDER_PUBLIC_PROFILE_SELECTED | PROVIDER_PUBLIC_PROFILE_SHORTCUT | PUBLIC_PROFILES_WEB_ZONE | Provider selects profile shortcut. | Public profile intent may be known later. | No runtime navigation. |
| PROVIDER_ROOM_SIGNAL_006 | PROVIDER_ROOM_EXIT_SELECTED | PROVIDER_EXIT_ACTION | App topology | Provider exits room. | Exit intent. | Exit only. |

## Rule

Signals are conceptual only and must not be implemented in this step.

