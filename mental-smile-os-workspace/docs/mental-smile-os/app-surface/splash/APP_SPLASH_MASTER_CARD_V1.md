# App Splash Master Card V1

Card ID: APP_SPLASH_MASTER_CARD_V1
Card Type: SCREEN_MASTER_CARD
Screen ID: APP_SPLASH_SCREEN
Screen Name: Splash
Surface: App Surface
Birth Prompt: PROMPT_ASSET_017
Parent Prompt: PROMPT_ASSET_016
Parent Guide: APP_SPLASH_GUIDE_V1
Current Status: READY
Lineage Status: LINEAGE_ESTABLISHED
Validation Status: MEMORY_VALIDATED

## 1. Screen Purpose

Introduce Mental Smile OS App Surface with calm identity, Arabic-first welcome, and a clean visual entry.

Splash is reusable, traceable, cloneable, and upgradable as the first complete App Surface screen package.

## 2. Dependencies

- APP_SURFACE_CARD
- APP_SPLASH_GUIDE_V1
- APP_SPLASH_SCREEN_CARD_V1
- APP_SPLASH_LOCALIZATION_CARD_V1
- APP_SPLASH_VISUAL_ASSET_CARD_V1
- APP_SPLASH_SIGNAL_CARD_V1
- APP_SPLASH_OWNERSHIP_CARD_V1
- APP_SPLASH_RECREATION_PROMPT_CARD_V1
- APP_SPLASH_SOURCE_CLASSIFICATION_V1
- APP_SPLASH_ASSET_MIGRATION_PLAN_V1
- SPLASH_ASSET_OWNERSHIP_CARDS
- SPLASH_ASSET_RECREATION_PROMPTS

## 3. Connected Screens

| Relationship | Screen |
| --- | --- |
| Previous Screen | NONE |
| Current Screen | Splash |
| Next Screen | Home / Menu |

## 4. Assets

| Asset ID | OS Asset Name | Source Card | Status |
| --- | --- | --- | --- |
| SPLASH_BACKGROUND_MOBILE | ms_os_splash_bg_mobile_v1 | SPLASH_BACKGROUND_MOBILE_CARD | USE_AFTER_PURIFICATION_NOT_RUNTIME_READY |
| SPLASH_BACKGROUND_TABLET | ms_os_splash_bg_tablet_v1 | SPLASH_BACKGROUND_TABLET_CARD | USE_AFTER_PURIFICATION_NOT_RUNTIME_READY |
| SPLASH_BACKGROUND_DESKTOP | ms_os_splash_bg_desktop_v1 | SPLASH_BACKGROUND_DESKTOP_CARD | USE_AFTER_PURIFICATION_NOT_RUNTIME_READY |
| SPLASH_LANGUAGE_BUTTON | ms_os_lang_toggle_gold_v1 | SPLASH_LANGUAGE_BUTTON_CARD | USE_AFTER_PURIFICATION_NOT_RUNTIME_READY |

## 5. Localization Assets

| Localization Asset | Bound Terms |
| --- | --- |
| APP_SPLASH_LOCALIZATION_CARD_V1 | Arabic, English, Welcome Text, Continue Text, Loading Text, Language Text |

Approved Arabic-first terms:

- أهلا بك في Mental Smile
- مساحة هادئة للدعم والاكتشاف
- متابعة
- العربية
- English
- جاري التحضير
- اللغة
- تغيير اللغة

## 6. Signals

- APP_SPLASH_SIGNAL_001 SPLASH_LOADED
- APP_SPLASH_SIGNAL_002 SPLASH_CONTINUE_SELECTED
- APP_SPLASH_SIGNAL_003 LANGUAGE_TOGGLE_SELECTED
- APP_SPLASH_SIGNAL_004 APP_SURFACE_ENTRY_READY

Signals are UI-state signals only.

## 7. Ownership Assets

- APP_SPLASH_OWNERSHIP_CARD_V1
- SPLASH_ASSET_OWNERSHIP_CARDS
- OWNERSHIP_SPLASH_BACKGROUND_MOBILE
- OWNERSHIP_SPLASH_BACKGROUND_TABLET
- OWNERSHIP_SPLASH_BACKGROUND_DESKTOP
- OWNERSHIP_SPLASH_LANGUAGE_BUTTON

## 8. Recreation Prompts

- APP_SPLASH_RECREATION_PROMPT_CARD_V1
- RP-SPLASH-BACKGROUND-MOBILE
- RP-SPLASH-BACKGROUND-TABLET
- RP-SPLASH-BACKGROUND-DESKTOP
- RP-SPLASH-LANGUAGE-BUTTON

## 9. Future Upgrade Notes

- Upgrade assets only through the OS asset names, not legacy source names.
- Future YAML references must use `ms_os_*` names only.
- Home / Menu is the next screen but is not built by this package.
- Runtime preview may reference the package as documentation, but no runtime modification is performed in this step.

## 10. Boundary

This master card does not build Home, Registration, Client Room, Firebase, runtime, or old app routes.
