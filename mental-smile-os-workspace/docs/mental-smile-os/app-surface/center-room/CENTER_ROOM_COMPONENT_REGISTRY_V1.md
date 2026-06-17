# Center Room Component Registry V1

Status: ACTIVE_COMPONENT_REGISTRY
Screen: APP_CENTER_ROOM_SCREEN
Prompt Asset: PROMPT_ASSET_028

## Registered Components

| Component ID | Purpose | Description | Allowed Actions | Forbidden Actions | Ownership | Dependencies | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CENTER_TOOL_BOARD | Center tool selection surface | Board with capacity for 8 tool slots. | Display selected center tools conceptually. | Tool execution, matching, recommendation logic, scoring. | Center owns selections; OS owns board package. | Future approved tool doctrine. | DEFINED |
| CENTER_NOTIFICATION_PANEL | Center notification screen | Display surface for updates, alerts, and institutional notices. | Display approved center notices later. | Diagnosis, treatment promises, automated clinical decisions. | OS owns panel package; content ownership remains separate. | Future content governance. | DEFINED |
| CENTER_AI_ASSISTANT | Mental health assistant scope | Mental-health-scoped assistant boundary for center context. | Conceptual mental health support scope only. | General-purpose assistant, diagnosis, treatment automation, clinical decision replacement. | OS owns assistant boundary; center owns usage context later. | Future AI governance. | DEFINED |
| CENTER_WORKSPACE_DESK | Institutional workspace | Operational workspace desk concept. | Organize center workspace concepts. | Runtime operations, Firebase models, staff/patient record systems. | Center workspace ownership; OS owns room package. | Future workspace governance. | DEFINED |
| CENTER_PUBLIC_PROFILE_SHORTCUT | Public profile connection | Shortcut to center public profile surface. | Link conceptually to public profile. | Runtime navigation, publishing, profile mutation. | Center owns public identity; OS owns shortcut concept. | PUBLIC_PROFILES_WEB_ZONE. | DEFINED |
| CENTER_EXIT_ACTION | Room exit action | Exit object/action for leaving Center Room. | Exit room only after future runtime authorization. | Logout, account deletion, emergency action, admin action. | OS owns control package. | App topology. | DEFINED |

## Rule

No component may import old Center Room UI or create runtime behavior.

