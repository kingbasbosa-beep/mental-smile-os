# Provider Room Component Registry V1

Status: ACTIVE_COMPONENT_REGISTRY
Screen: APP_PROVIDER_ROOM_SCREEN
Prompt Asset: PROMPT_ASSET_028

## Registered Components

| Component ID | Purpose | Description | Allowed Actions | Forbidden Actions | Ownership | Dependencies | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PROVIDER_TOOL_BOARD | Professional tool selection surface | Board with capacity for 8 tool slots. | Display selected professional tools conceptually. | Tool execution, matching, recommendation logic, scoring. | Provider owns selections; OS owns board package. | Future approved tool doctrine. | DEFINED |
| PROVIDER_NOTIFICATION_PANEL | Professional notification screen | Display surface for updates, research highlights, references, and alerts. | Display approved professional notices later. | Diagnosis, treatment promises, automated clinical decisions. | OS owns panel package; content ownership remains separate. | Future content governance. | DEFINED |
| PROVIDER_AI_ASSISTANT | Mental health assistant scope | Psychology-scoped assistant for research, references, guidance, and Library search. | Conceptual mental health support scope only. | General-purpose assistant, diagnosis, treatment automation, clinical decision replacement. | OS owns assistant boundary; provider owns usage context later. | Future AI governance. | DEFINED |
| PROVIDER_RESEARCH_DESK | Private professional workspace | Conceptually contains notes, calendar, tasks, and follow ups. | Organize professional workspace concepts. | Runtime tasks, Firebase models, patient records, clinical workflow automation. | Provider workspace ownership; OS owns room package. | Future workspace governance. | DEFINED |
| PROVIDER_PUBLIC_PROFILE_SHORTCUT | Public profile connection | Shortcut to provider public profile surface. | Link conceptually to public profile. | Runtime navigation, publishing, profile mutation. | Provider owns public identity; OS owns shortcut concept. | PUBLIC_PROFILES_WEB_ZONE. | DEFINED |
| PROVIDER_EXIT_ACTION | Room exit action | Exit object/action for leaving Provider Room. | Exit room only after future runtime authorization. | Logout, account deletion, emergency action, admin action. | OS owns control package. | App topology. | DEFINED |
| PROVIDER_DECOR_ELEMENTS | Professional atmosphere | Psychology inspirations and professional visual elements. | Decorative atmosphere only. | Functional claims, clinical authority, hidden actions. | OS owns decor package. | Future visual asset governance. | DEFINED |

## Rule

No component may import old Provider Room UI or create runtime behavior.

