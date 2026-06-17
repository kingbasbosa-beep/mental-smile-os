# App Login Screen Signal Card V1

Card ID: APP_LOGIN_SCREEN_SIGNAL_CARD_V1
Card Type: SIGNAL_CARD
Screen ID: APP_LOGIN_SCREEN
Status: READY

## Signals

| Signal ID | Name | Purpose | Boundary |
| --- | --- | --- | --- |
| APP_LOGIN_SIGNAL_001 | LOGIN_SCREEN_LOADED | Login screen visibility signal | UI-state only |
| APP_LOGIN_SIGNAL_002 | LOGIN_SELECTED | Login button selected | No authentication implementation |
| APP_LOGIN_SIGNAL_003 | CREATE_ACCOUNT_SELECTED | Registration link selected | Navigation intent only |
| APP_LOGIN_SIGNAL_004 | FORGOT_PASSWORD_SELECTED | Recovery link selected | No recovery implementation |
| APP_LOGIN_SIGNAL_005 | LOGIN_LANGUAGE_TOGGLE_SELECTED | Language toggle selected | UI-state only |

## Gateway Rule

Future Login signals terminate at APP_ROOM_ZONE_GATEWAY.

No direct cross-zone signal route is permitted.

