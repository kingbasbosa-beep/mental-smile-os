# Active Runtime Dependency Map V1

Status: DEPENDENCY_MAP_DEFINED
Prompt Asset: PROMPT_ASSET_052

## Allowed Dependency Pattern

Screen -> Zone.

Zone -> Gateway.

Gateway -> Pipe.

Pipe -> Target Gateway.

Target Gateway -> Target Zone.

## Forbidden Dependency Pattern

Screen -> Foreign Zone.

Room -> Library directly.

Tool -> Provider directly.

Content -> Client directly.

Zone -> Foreign collection directly.

Admin -> God mode.

## Dependency Examples

| Source | Allowed Path | Forbidden |
| --- | --- | --- |
| APP_CLIENT_ROOM_SCREEN | APP_ROOM_ZONE -> APP_ROOM_ZONE_GATEWAY -> PIPE_TO_LIBRARY_WEB_ZONE -> LIBRARY_WEB_ZONE_GATEWAY | Direct Client Room to Library write |
| LIBRARY_WEB_ZONE | LIBRARY_WEB_ZONE_GATEWAY -> approved pipes | Direct content-to-client mutation |
| PROVIDER_REGISTRATION_WEB_ZONE | Provider Registration Gateway -> approved public-ready package | Direct public profile publish |
| SMART_ARCHIVE_ZONE | Archive Gateway -> integrity package | Runtime mutation |

