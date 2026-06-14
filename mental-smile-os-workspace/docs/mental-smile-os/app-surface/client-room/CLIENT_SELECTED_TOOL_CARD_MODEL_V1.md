# Client Selected Tool Card Model V1

Status: ACTIVE_CONSTITUTIONAL_MODEL
Model ID: CLIENT_SELECTED_TOOL_CARD
Screen: APP_CLIENT_ROOM_SCREEN
Parent Component: CLIENT_TOOL_BOARD
Prompt Asset: PROMPT_ASSET_026

## 1. Purpose

CLIENT_SELECTED_TOOL_CARD represents a selected tool displayed inside one Client Room tool slot.

It is a constitutional display model only.

## 2. Allowed Fields

| Field | Purpose | Required | Boundary |
| --- | --- | --- | --- |
| tool_id | Stable selected tool identifier. | YES | No execution. |
| tool_name | User-visible tool name. | YES | No clinical claim. |
| tool_icon | Visual icon or image reference. | OPTIONAL | No runtime asset import in this step. |
| tool_classification | Constitutional tool category. | YES | No scoring. |
| linked_content_tags | Tags that content may declare compatibility with. | OPTIONAL | No recommendation engine. |

## 3. Forbidden Fields

- User profile data.
- Interest profile data.
- Recommendation score.
- Ranking score.
- Diagnosis labels.
- Treatment labels.
- Firebase document path.
- Runtime execution state.

## 4. Rule

A selected tool card is a display and linkage object. It does not execute tools, recommend content, personalize results, or store user interests.

