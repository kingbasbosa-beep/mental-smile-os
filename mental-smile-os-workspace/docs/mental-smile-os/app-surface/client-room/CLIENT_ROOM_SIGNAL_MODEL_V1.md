# Client Room Signal Model V1

Status: CONCEPTUAL_SIGNAL_MODEL
Screen: CLIENT_ROOM_SCREEN
Prompt Asset: PROMPT_ASSET_024
Latest Dynamic Governance Prompt: PROMPT_ASSET_026

## 1. Purpose

Define conceptual Client Room signals without implementing a signal engine.

## 2. Signal Inventory

| Signal Family | Signal ID | Signal Name | Source Component | Consumer | Trigger Condition | Expected Outcome | Boundary |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Tool Selection Signals | CLIENT_ROOM_SIGNAL_001 | TOOL_SELECTED | CLIENT_TOOL_BOARD | Preference memory / future compatible content | Client selects a tool. | Preference signal can be recorded later. | No matching, no recommendation storage. |
| Tool Selection Signals | CLIENT_ROOM_SIGNAL_002 | TOOL_DESELECTED | CLIENT_TOOL_BOARD | Preference memory | Client deselects a tool. | Preference signal can be updated later. | No matching. |
| Notification Signals | CLIENT_ROOM_SIGNAL_003 | TV_PANEL_VIEWED | CLIENT_TV_PANEL | Notification memory | Client views panel. | Display state may be tracked later. | No clinical claims. |
| Notification Signals | CLIENT_ROOM_SIGNAL_004 | RECOMMENDATION_VIEWED | CLIENT_TV_PANEL | Recommendation display memory | Recommendation is displayed. | View signal can be recorded later. | No treatment promise. |
| Picture Update Signals | CLIENT_ROOM_SIGNAL_005 | PICTURE_UPDATED | CLIENT_PICTURE_FRAME | Personal media memory | Client updates picture. | Personal decoration updated later. | No identity verification. |
| Motivation Update Signals | CLIENT_ROOM_SIGNAL_006 | MOTIVATION_MESSAGE_UPDATED | CLIENT_NOTE_WIDGET | Motivation note memory | Preset or personal note changes. | Motivation display updated later. | No clinical advice. |
| Room Exit Signals | CLIENT_ROOM_SIGNAL_007 | ROOM_EXIT_SELECTED | CLIENT_EXIT_CUP | App topology | Exit cup selected. | Room exit intent. | Exit only. |
| Card Cycle Signals | CLIENT_ROOM_SIGNAL_008 | ROOM_CARD_CYCLED | CLIENT_LEFT_SWITCHER / CLIENT_RIGHT_SWITCHER | Room card state | Switcher selected. | Cycle visible card. | No hidden logic. |
| Tool Slot Signals | CLIENT_ROOM_SIGNAL_009 | TOOL_SLOT_OCCUPIED | CLIENT_TOOL_BOARD | Future tool-slot memory | A selected tool is assigned to a slot. | Slot occupation may be known later. | Conceptual only; no Firebase, execution, scoring, or recommendation runtime. |
| Tool Slot Signals | CLIENT_ROOM_SIGNAL_010 | TOOL_SLOT_CLEARED | CLIENT_TOOL_BOARD | Future tool-slot memory | A selected tool is removed from a slot. | Slot becomes empty later. | Conceptual only; no profile or interests system. |
| Tool Discovery Signals | CLIENT_ROOM_SIGNAL_011 | TOOL_DISCOVERY_LINK_DECLARED | CLIENT_TOOL_BOARD | Future content eligibility memory | A selected tool has declared tags compatible with library content tags. | Content may become eligible later. | No algorithm, ranking, personalization, or recommendation engine. |

## 3. Rule

Signals are conceptual only and must not be implemented in this step.

## 4. Dynamic Slot Signal Boundary

Tool slot and discovery signals describe constitutional relationships only.

They do not execute tools, modify the Library, store user profiles, configure interests, rank content, or display recommendations.
