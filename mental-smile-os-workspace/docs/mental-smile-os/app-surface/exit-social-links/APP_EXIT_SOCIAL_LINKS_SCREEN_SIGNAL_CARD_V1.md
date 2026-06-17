# App Exit Social Links Screen Signal Card V1

Card ID: APP_EXIT_SOCIAL_LINKS_SCREEN_SIGNAL_CARD_V1
Card Type: SIGNAL_CARD
Screen ID: APP_EXIT_SOCIAL_LINKS_SCREEN
Status: READY

## Signals

| Signal ID | Name | Purpose | Boundary |
| --- | --- | --- | --- |
| APP_EXIT_SIGNAL_001 | EXIT_SOCIAL_LINKS_SCREEN_LOADED | Exit screen visibility | UI-state only |
| APP_EXIT_SIGNAL_002 | OFFICIAL_LINK_SELECTED | Public official link selected | No external integration |
| APP_EXIT_SIGNAL_003 | RETURN_HOME_SELECTED | Return Home option selected | Navigation intent only |
| APP_EXIT_SIGNAL_004 | RETURN_LOGIN_SELECTED | Login option selected | Navigation intent only |

## Gateway Rule

Future Exit Social Links signals terminate at APP_ROOM_ZONE_GATEWAY.

No direct cross-zone mutation is permitted.

