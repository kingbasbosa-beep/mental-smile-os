# App Splash Signal Card V1

Card ID: APP_SPLASH_SIGNAL_CARD_V1
Card Type: SIGNAL_CARD
Surface: App Surface
Screen: Splash
Birth Prompt: PROMPT_ASSET_015
Status: ACTIVE_UI_SIGNAL_MODEL
Lineage Status: LINEAGE_ESTABLISHED
Validation Status: MEMORY_VALIDATED

## Signals

| Signal ID | Signal Name | Source | Consumer | Trigger Condition | Expected Outcome | Boundary |
| --- | --- | --- | --- | --- | --- | --- |
| APP_SPLASH_SIGNAL_001 | SPLASH_LOADED | Splash Preview | App Surface | Splash preview renders. | UI state is visible. | No login, no Firebase. |
| APP_SPLASH_SIGNAL_002 | SPLASH_CONTINUE_SELECTED | Continue Button | Future Home / Menu placeholder | Owner/user selects continue. | Future navigation intent recorded. | Does not authorize route implementation. |
| APP_SPLASH_SIGNAL_003 | LANGUAGE_TOGGLE_SELECTED | Language Toggle Placeholder | Localization Memory | Language option selected. | UI language intent recorded. | Does not persist settings. |
| APP_SPLASH_SIGNAL_004 | APP_SURFACE_ENTRY_READY | Splash Screen | App Surface Build Order | Splash is ready for future build review. | App Surface first screen can enter review. | Does not build Home / Menu. |

## Rule

Splash signals are UI-state signals only.

They do not authorize login, registration, routing, Firebase, identity, or future domain creation.
