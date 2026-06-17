# App Room Gateway Exit Rules V1

Status: ACTIVE_GATEWAY_EXIT_RULES
Gateway ID: APP_ROOM_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_032

## 1. Approved Exit Pipes

APP_ROOM_ZONE_GATEWAY forwards only through:

- PIPE_TO_LIBRARY_WEB_ZONE.
- PIPE_TO_PROVIDER_WEB_ZONE.
- PIPE_TO_CENTER_WEB_ZONE.
- PIPE_TO_ADMIN_OWNER_ZONE.
- PIPE_TO_SMART_ARCHIVE_ZONE.

## 2. Exit Rule

No package may exit App Room Zone except through an approved pipe.

No internal App Surface may send directly to another zone.

## 3. Forbidden Exit Behavior

- Direct Client Room to Library Web Zone.
- Direct Client Room to Provider Web Zone.
- Direct Client Room to Center Web Zone.
- Direct Provider Room to Smart Archive Zone.
- Direct Center Room to Admin Owner Zone.
- Any runtime signal execution.

