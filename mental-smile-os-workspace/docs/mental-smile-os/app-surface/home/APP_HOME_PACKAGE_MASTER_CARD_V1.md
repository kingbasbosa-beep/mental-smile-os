# App Home Package Master Card V1

Card ID: APP_HOME_PACKAGE_MASTER_CARD_V1
Card Type: SCREEN_PACKAGE_MASTER_CARD
Screen ID: APP_HOME_SCREEN
Screen Name: Home
Screen Purpose: First operational gateway of Mental Smile City
Surface: App Surface
Zone Role: APP_ROOM_ZONE gateway with controlled links to Library, Provider, and Center web zones
Birth Prompt: PROMPT_ASSET_020
Parent Prompt: PROMPT_ASSET_019
Status: READY
Lineage Status: LINEAGE_ESTABLISHED
Validation Status: MEMORY_VALIDATED

## 1. Dependencies

- APP_SPLASH_SCREEN READY.
- APP_HOME_MASTER_CARD_V1.
- APP_HOME_GATEWAY_MASTER_CARD_V1.
- APP_HOME_VISIBLE_ASSET_CARDS_V1.
- APP_HOME_LOCALIZATION_CARDS_V1.
- APP_HOME_OWNERSHIP_CARDS_V1.
- APP_HOME_RECREATION_PROMPTS_V1.
- APP_HOME_SIGNAL_CARD_V1.
- APP_HOME_TOPOLOGY_CARD_V1.
- APP_HOME_SCREEN_SNAPSHOT_V1.
- CITY_ZONE_REGISTRY_V1.
- HOME_TO_ZONE_LINK_MAP_V1.

## 2. Connected Screens

- Previous: APP_SPLASH_SCREEN.
- Current: APP_HOME_SCREEN.
- Next: CLIENT_REGISTRATION.
- Next: CLIENT_ROOM.
- Next: CENTER_ROOM.
- Next: PROVIDER_ROOM.

## 3. Connected Zones

- APP_ROOM_ZONE.
- LIBRARY_WEB_ZONE.
- PROVIDER_WEB_ZONE.
- CENTER_WEB_ZONE.
- ADMIN_OWNER_ZONE.
- SMART_ARCHIVE_ZONE.

Home may link only to APP_ROOM_ZONE, LIBRARY_WEB_ZONE, PROVIDER_WEB_ZONE, and CENTER_WEB_ZONE.

ADMIN_OWNER_ZONE and SMART_ARCHIVE_ZONE are registered for city context only and are forbidden Home links.

## 4. Assets

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

## 5. Localization

Bound localization:

- Library.
- Providers.
- Centers.
- Family Support.
- Recovery Support.
- Profile.
- Home.
- Arabic.
- English.
- All approved Home labels in APP_HOME_LOCALIZATION_CARDS_V1.

## 6. Signals

- APP_HOME_SIGNAL_001 HOME_LOADED.
- APP_HOME_SIGNAL_002 HOME_PROFILE_SELECTED.
- APP_HOME_SIGNAL_003 HOME_NAVIGATION_SELECTED.
- APP_HOME_SIGNAL_004 HOME_EXTERNAL_LINK_SELECTED.
- APP_HOME_SIGNAL_005 HOME_READY.

## 7. Ownership

- APP_HOME_OWNERSHIP_CARD_V1.
- APP_HOME_OWNERSHIP_CARDS_V1.
- OWNERSHIP_HOME_BACKGROUND.
- OWNERSHIP_HOME_PROFILE_BUTTON.
- OWNERSHIP_HOME_AVATAR_FRAME.
- OWNERSHIP_HOME_LIBRARY_BUTTON.
- OWNERSHIP_HOME_PROVIDER_BUTTON.
- OWNERSHIP_HOME_CENTER_BUTTON.
- OWNERSHIP_HOME_FAMILY_SUPPORT_BUTTON.
- OWNERSHIP_HOME_RECOVERY_SUPPORT_BUTTON.
- OWNERSHIP_HOME_FOOTER_FEATURE_BAR.
- OWNERSHIP_HOME_CORE_BRANDMARK.

## 8. Recreation Prompts

- RP-HOME-BACKGROUND.
- RP-HOME-CIRCULAR-NAV-BUTTONS.
- RP-HOME-PROFILE-BUTTON.
- RP-HOME-AVATAR-FRAME.
- RP-HOME-FOOTER-BAR.
- RP-HOME-CORE-BRANDMARK.

## 9. Topology

APP_SPLASH_SCREEN -> APP_HOME_SCREEN -> CLIENT_REGISTRATION / CLIENT_ROOM / CENTER_ROOM / PROVIDER_ROOM.

External zone links:

- LIBRARY_WEB_ZONE.
- PROVIDER_WEB_ZONE.
- CENTER_WEB_ZONE.

## 10. Future Upgrade Notes

- Future runtime implementation must use OS asset names only.
- Future Library, Provider, and Center transitions must use Surface Link boundaries.
- Future Home changes must preserve forbidden links to ADMIN_OWNER_ZONE and SMART_ARCHIVE_ZONE.
- Future screen package closure may add runtime references only after implementation authorization.

## 11. Boundary

This package does not build Registration, Client Room, Provider Room, Center Room, Firebase, runtime, or old Home code.
