# Client Registration Master Card V1

Card ID: CLIENT_REGISTRATION_MASTER_CARD_V1
Card Type: SCREEN_MASTER_CARD
Screen ID: CLIENT_REGISTRATION_SCREEN
Registry ID: APP_CLIENT_REGISTRATION_SCREEN
Screen Name: Client Registration
Surface: App Surface
Birth Prompt: PROMPT_ASSET_022
Parent Prompt: PROMPT_ASSET_020
Status: READY_FOR_EXTRACTION
Lineage Status: LINEAGE_ESTABLISHED
Validation Status: MEMORY_VALIDATED

## 1. Screen Purpose

Create client identity only through a minimal registration form.

## 2. Dependencies

- APP_HOME_SCREEN READY.
- CLIENT_REGISTRATION_GUIDE_V1.
- APP_SCREEN_REGISTRY_V1.
- CITY_ZONE_REGISTRY_V1.

## 3. Form Model

| Field ID | Purpose | Status |
| --- | --- | --- |
| email_or_phone | Identity contact credential. | APPROVED_FOR_PACKAGE |
| password | Credential secret. | APPROVED_FOR_PACKAGE |
| confirm_password | Credential confirmation. | APPROVED_FOR_PACKAGE |

## 4. Forbidden Form Data

- Name.
- Age.
- Gender.
- Avatar.
- Interests.
- Questions.
- Tool selection.
- Recommendation selection.
- Profile data.

## 5. Assets

- MS_OS_CLIENT_REGISTRATION_BG_V1.
- MS_OS_CLIENT_REGISTRATION_PANEL_V1.
- MS_OS_CLIENT_REGISTRATION_CTA_V1.
- MS_OS_LANG_SWITCH_V1.
- MS_OS_CLIENT_ROOM_FEATURES_PANEL_V1.
- MS_OS_CLIENT_REG_FEATURE_TV_NOTIFICATION_V1.
- MS_OS_CLIENT_REG_FEATURE_TOOL_BOARD_V1.
- MS_OS_CLIENT_REG_FEATURE_PERSONAL_PICTURE_FRAME_V1.
- MS_OS_CLIENT_REG_FEATURE_MOTIVATION_NOTE_V1.
- MS_OS_CLIENT_REG_FEATURE_PRIVATE_SPACE_V1.

## 6. Localization

- lets_go: يلا بينا / Let's go.
- email_or_phone.
- password.
- confirm_password.
- Arabic.
- English.

## 7. Signals

- CLIENT_REG_SIGNAL_001 REGISTRATION_SCREEN_LOADED.
- CLIENT_REG_SIGNAL_002 REGISTRATION_CTA_SELECTED.
- CLIENT_REG_SIGNAL_003 LANGUAGE_SWITCH_SELECTED.
- CLIENT_REG_SIGNAL_004 REGISTRATION_IDENTITY_READY.

## 8. Topology

Previous: APP_HOME_SCREEN.

Current: CLIENT_REGISTRATION_SCREEN.

Next: CLIENT_ROOM_SCREEN.

External Links:

- LIBRARY_WEB_ZONE.
- PUBLIC_PROFILES_WEB_ZONE.

## 9. Boundary

No runtime, Flutter, Firebase, old screen migration, Client Room build, tool system, or recommendation engine is created.
