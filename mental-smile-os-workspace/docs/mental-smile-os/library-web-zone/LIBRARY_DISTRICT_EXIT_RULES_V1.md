# Library District Exit Rules V1

Status: ACTIVE_GATEWAY_EXIT_RULES
Zone ID: LIBRARY_WEB_ZONE
Gateway ID: LIBRARY_WEB_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_037

## Exit Rules

LIBRARY_WEB_ZONE_GATEWAY may forward only through approved federation pipes.

No direct district-to-zone communication.

## Allowed Exit Path

District -> LIBRARY_WEB_ZONE_GATEWAY -> Approved Federation Pipe -> Target Zone Gateway.

## Forbidden

- District -> App Room Zone direct.
- District -> Client Room direct.
- District -> Provider Room direct.
- District -> Center Room direct.
- District -> Smart Archive direct.
- District -> Admin Owner direct.

