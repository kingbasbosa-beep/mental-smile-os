# App Home Signal Card V1

Card ID: APP_HOME_SIGNAL_CARD_V1
Card Type: SIGNAL_CARD
Surface: App Surface
Screen: Home
Birth Prompt: PROMPT_ASSET_018
Status: ACTIVE_UI_SIGNAL_MODEL
Lineage Status: LINEAGE_ESTABLISHED
Validation Status: MEMORY_VALIDATED

## Signals

| Signal ID | Signal Name | Source | Consumer | Trigger Condition | Expected Outcome | Boundary |
| --- | --- | --- | --- | --- | --- | --- |
| APP_HOME_SIGNAL_001 | HOME_LOADED | Home Screen | App Surface | Home screen becomes visible. | UI state visible. | No identity, no Firebase. |
| APP_HOME_SIGNAL_002 | HOME_PROFILE_SELECTED | Profile Button | Future profile or registration flow | Profile area selected. | Navigation intent recorded. | Does not authorize identity or login. |
| APP_HOME_SIGNAL_003 | HOME_NAVIGATION_SELECTED | Home Navigation Button | Future App Surface screens | Internal app destination selected. | Navigation intent recorded. | Does not build target screen. |
| APP_HOME_SIGNAL_004 | HOME_EXTERNAL_LINK_SELECTED | Home External Link | Library or Public Profiles Surface | Cross-surface link selected. | Surface Link intent recorded. | Does not merge routing systems. |
| APP_HOME_SIGNAL_005 | HOME_READY | Home Package | App Screen Registry | Home package is prepared for future closure. | Screen may enter closure review. | Does not mark READY yet. |

## Rule

Home signals are UI-state and navigation-intent signals only.
