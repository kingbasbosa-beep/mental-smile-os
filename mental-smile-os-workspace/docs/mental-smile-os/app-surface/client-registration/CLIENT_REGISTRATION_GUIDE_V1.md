# Client Registration Guide V1

Status: ACTIVE_SCREEN_GUIDE
Screen: CLIENT_REGISTRATION_SCREEN
App Registry ID: APP_CLIENT_REGISTRATION_SCREEN
Prompt Asset: PROMPT_ASSET_022
Parent Prompt: PROMPT_ASSET_020

## 1. Purpose

Client Registration creates identity only.

It does not collect profile data, preferences, tool choices, recommendations, diagnosis, or room personalization.

## 2. Approved Form Model

Approved fields:

- email_or_phone.
- password.
- confirm_password.

Forbidden fields:

- Name.
- Age.
- Gender.
- Avatar.
- Interests.
- Questions.
- Tool selection.
- Recommendation selection.
- Profile data.

## 3. Approved Visible Elements

- Registration Background: MS_OS_CLIENT_REGISTRATION_BG_V1.
- Registration Form Panel: MS_OS_CLIENT_REGISTRATION_PANEL_V1.
- Primary CTA Button: MS_OS_CLIENT_REGISTRATION_CTA_V1.
- Language Switch: MS_OS_LANG_SWITCH_V1.
- Registration Room Features Area: MS_OS_CLIENT_ROOM_FEATURES_PANEL_V1.

## 4. Visible Feature Cards

- TV Notification Screen.
- Tool Selection Board.
- Personal Picture Frame.
- Motivation Note.
- Private Personal Space.

## 5. Post Registration Doctrine

Tool selection happens inside Client Room.

Client Room handles:

- Tool Board Selection.
- Picture Upload.
- Motivation Note.
- Recommendations.
- Signals.
- Preferences.

## 6. Boundary

This guide does not build runtime, Flutter code, Firebase, Client Room, tool systems, or recommendation systems.
