# Screen Reconnection Model V1

Status: SCREEN_MODEL_CREATED
Prompt Asset: PROMPT_ASSET_055

## Startup Order

| Order | Screen |
| --- | --- |
| 1 | APP_SPLASH_SCREEN |
| 2 | APP_LOGIN_SCREEN |
| 3 | APP_HOME_SCREEN |
| 4 | APP_CLIENT_REGISTRATION_SCREEN |
| 5 | APP_CLIENT_ROOM_SCREEN |
| 6 | APP_PROVIDER_ROOM_SCREEN |
| 7 | APP_CENTER_ROOM_SCREEN |
| 8 | APP_EXIT_SOCIAL_LINKS_SCREEN |

## Flow

Splash -> Login -> Home -> Registration -> Rooms.

Exit flow:

Rooms -> Exit Social Links -> Login / Home / Official Links.

## Boundary

Screen reconnection does not implement UI or routes.

