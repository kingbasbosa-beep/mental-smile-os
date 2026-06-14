# App Room Signal Isolation Rules V1

Status: ACTIVE_INTERNAL_SIGNAL_ISOLATION_RULES
Zone ID: APP_ROOM_ZONE
Gateway ID: APP_ROOM_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_032

## Forbidden Signal Routing

CLIENT_ROOM X LIBRARY_WEB_ZONE.

CLIENT_ROOM X PROVIDER_WEB_ZONE.

CLIENT_ROOM X CENTER_WEB_ZONE.

PROVIDER_ROOM X SMART_ARCHIVE_ZONE.

CENTER_ROOM X ADMIN_OWNER_ZONE.

## Required Routing

All routing must pass through:

APP_ROOM_ZONE_GATEWAY.

## Isolation Rule

No App Zone surface may talk directly to another zone, target gateway, Library section, public profile section, Admin Owner room, Smart Archive record, tool registry, or Firebase model.

