# Client Registration Signal Card V1

Status: ACTIVE_SIGNAL_CARD
Screen: CLIENT_REGISTRATION_SCREEN
Prompt Asset: PROMPT_ASSET_022

## Signals

| Signal ID | Signal Name | Source | Consumer | Trigger Condition | Expected Outcome | Boundary |
| --- | --- | --- | --- | --- | --- | --- |
| CLIENT_REG_SIGNAL_001 | REGISTRATION_SCREEN_LOADED | Client Registration Screen | App Surface | Screen becomes visible. | UI state visible. | No Firebase. |
| CLIENT_REG_SIGNAL_002 | REGISTRATION_CTA_SELECTED | CTA Button | Registration package | User selects `lets_go`. | Identity creation intent. | No runtime auth. |
| CLIENT_REG_SIGNAL_003 | LANGUAGE_SWITCH_SELECTED | Language Switch | Localization package | Language switch selected. | Language intent. | No persistence. |
| CLIENT_REG_SIGNAL_004 | REGISTRATION_IDENTITY_READY | Registration Form | Client Room topology | Approved fields are conceptually complete. | Future transition intent to Client Room. | Does not build Client Room. |

## Rule

Signals are UI-state and package-intent signals only.
