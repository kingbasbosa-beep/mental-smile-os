# App Home Gateway Master Card V1

Card ID: APP_HOME_GATEWAY_MASTER_CARD_V1
Card Type: SCREEN_GATEWAY_MASTER_CARD
Screen ID: APP_HOME_SCREEN
Screen Name: Home
Screen Purpose: First navigation hub of the App Surface
Surface: App Surface
City: Mental Smile City
City Zone Role: APP_ROOM_ZONE gateway with controlled links to web zones
Birth Prompt: PROMPT_ASSET_019
Parent Prompt: PROMPT_ASSET_018
Status: IN_CONSTRUCTION
Lineage Status: LINEAGE_ESTABLISHED
Validation Status: MEMORY_VALIDATED

## Visible Components

- HOME_BACKGROUND.
- HOME_PROFILE_BUTTON.
- HOME_AVATAR_FRAME.
- HOME_LIBRARY_BUTTON.
- HOME_PROVIDER_BUTTON.
- HOME_CENTER_BUTTON.
- HOME_FAMILY_SUPPORT_BUTTON.
- HOME_RECOVERY_SUPPORT_BUTTON.
- HOME_FOOTER_FEATURE_BAR.
- HOME_CORE_BRANDMARK.

## Linked App Screens

- CLIENT_REGISTRATION.
- CLIENT_ROOM.
- CENTER_ROOM.
- PROVIDER_ROOM.

## Linked Web Zones

- LIBRARY_WEB_ZONE.
- PROVIDER_WEB_ZONE.
- CENTER_WEB_ZONE.

## Forbidden Links

- ADMIN_OWNER_ZONE.
- SMART_ARCHIVE_ZONE.
- Firebase console.
- Construction Studio tools.
- Strategic Planning tools.
- Hidden legacy menu layers.
- Old role-based dashboard shortcuts.

## Signals

- APP_HOME_SIGNAL_001 HOME_LOADED.
- APP_HOME_SIGNAL_002 HOME_PROFILE_SELECTED.
- APP_HOME_SIGNAL_003 HOME_NAVIGATION_SELECTED.
- APP_HOME_SIGNAL_004 HOME_EXTERNAL_LINK_SELECTED.
- APP_HOME_SIGNAL_005 HOME_READY.

## Assets

- ms_os_home_bg_v1.
- ms_os_home_profile_button_v1.
- ms_os_home_avatar_frame_v1.
- ms_os_home_library_button_v1.
- ms_os_home_provider_button_v1.
- ms_os_home_center_button_v1.
- ms_os_home_family_support_button_v1.
- ms_os_home_recovery_support_button_v1.
- ms_os_home_footer_bar_v1.
- ms_os_home_core_brandmark_v1.

## Localization

- APP_HOME_LOCALIZATION_CARDS_V1.

## Ownership

- APP_HOME_OWNERSHIP_CARDS_V1.

## Topology Snapshot

APP_SPLASH_SCREEN -> APP_HOME_SCREEN -> CLIENT_REGISTRATION / CLIENT_ROOM / CENTER_ROOM / PROVIDER_ROOM.

APP_HOME_SCREEN may surface-link to LIBRARY_WEB_ZONE, PROVIDER_WEB_ZONE, and CENTER_WEB_ZONE.
