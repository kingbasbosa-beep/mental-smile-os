# App Home Master Card V1

Card ID: APP_HOME_MASTER_CARD_V1
Card Type: SCREEN_MASTER_CARD
Screen ID: APP_HOME_SCREEN
Screen Name: Home
Surface: App Surface
Birth Prompt: PROMPT_ASSET_018
Parent Prompt: PROMPT_ASSET_017
Parent Guide: APP_HOME_GUIDE_V1
Current Status: IN_CONSTRUCTION
Lineage Status: LINEAGE_ESTABLISHED
Validation Status: MEMORY_VALIDATED

## 1. Screen Purpose

Home is the clean OS-native navigation hub for the App Surface.

It connects Splash to future app destinations and web surfaces without migrating old routing or old Flutter widgets.

## 2. Dependencies

- APP_SPLASH_SCREEN = READY.
- APP_SURFACE_CARD.
- APP_SURFACE_BUILD_ORDER_V1.
- SURFACE_LINK_MODEL_V1.
- CARD_PACKAGE_TRANSFER_MODEL_V1.

## 3. Connected Screens And Surfaces

| Relationship | Target |
| --- | --- |
| Previous Screen | APP_SPLASH_SCREEN |
| Current Screen | APP_HOME_SCREEN |
| Next Screen | CLIENT_REGISTRATION |
| Next Screen | CLIENT_ROOM |
| Next Screen | CENTER_ROOM |
| Next Screen | PROVIDER_ROOM |
| External Link | LIBRARY_WEB_SURFACE |
| External Link | PUBLIC_PROFILES_WEB_SURFACE |

## 4. Assets

| Asset ID | OS Asset Name | Classification | Status |
| --- | --- | --- | --- |
| HOME_BACKGROUND | ms_os_home_bg_v1 | USE_AFTER_PURIFICATION | NOT_RUNTIME_READY |
| HOME_PROFILE_BUTTON | ms_os_home_profile_button_v1 | REBUILD_FROM_SCRATCH | NOT_RUNTIME_READY |
| HOME_AVATAR_FRAME | ms_os_home_avatar_frame_v1 | REBUILD_FROM_SCRATCH | NOT_RUNTIME_READY |
| HOME_LIBRARY_BUTTON | ms_os_home_library_button_v1 | REBUILD_FROM_SCRATCH | NOT_RUNTIME_READY |
| HOME_PROVIDER_BUTTON | ms_os_home_provider_button_v1 | REBUILD_FROM_SCRATCH | NOT_RUNTIME_READY |
| HOME_CENTER_BUTTON | ms_os_home_center_button_v1 | REBUILD_FROM_SCRATCH | NOT_RUNTIME_READY |
| HOME_FAMILY_SUPPORT_BUTTON | ms_os_home_family_support_button_v1 | REBUILD_FROM_SCRATCH | NOT_RUNTIME_READY |
| HOME_RECOVERY_SUPPORT_BUTTON | ms_os_home_recovery_support_button_v1 | REBUILD_FROM_SCRATCH | NOT_RUNTIME_READY |
| HOME_FOOTER_FEATURE_BAR | ms_os_home_footer_bar_v1 | REBUILD_FROM_SCRATCH | NOT_RUNTIME_READY |
| HOME_CORE_BRANDMARK | ms_os_home_core_brandmark_v1 | USE_AFTER_PURIFICATION | NOT_RUNTIME_READY |

## 5. Localization Assets

- APP_HOME_LOCALIZATION_CARD_V1.

## 6. Signals

- APP_HOME_SIGNAL_001 HOME_LOADED.
- APP_HOME_SIGNAL_002 HOME_PROFILE_SELECTED.
- APP_HOME_SIGNAL_003 HOME_NAVIGATION_SELECTED.
- APP_HOME_SIGNAL_004 HOME_EXTERNAL_LINK_SELECTED.
- APP_HOME_SIGNAL_005 HOME_READY.

## 7. Ownership Assets

- APP_HOME_OWNERSHIP_CARD_V1.

## 8. Recreation Prompts

- APP_HOME_RECREATION_PROMPT_CARD_V1.

## 9. Future Upgrade Notes

- Convert IN_CONSTRUCTION to READY only after Home assets, localization, ownership, and topology pass package closure.
- Future runtime must use OS asset names only.
- Future links to Library and Public Profiles must use Surface Link, not mixed app routing.

## 10. Boundary

This card does not build Registration, Client Room, Provider Room, Center Room, Firebase, old Home code, old Menu code, or runtime routes.
