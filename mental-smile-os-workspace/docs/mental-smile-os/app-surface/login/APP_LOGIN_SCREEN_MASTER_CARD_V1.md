# App Login Screen Master Card V1

Card ID: APP_LOGIN_SCREEN_MASTER_CARD_V1
Card Type: SCREEN_MASTER_CARD
Screen ID: APP_LOGIN_SCREEN
Screen Name: Login
Surface: App Surface
Status: READY
Birth Prompt: PROMPT_ASSET_047
Lineage Status: LINEAGE_ESTABLISHED
Validation Status: MEMORY_VALIDATED

## Screen Purpose

Provide a calm, minimal, Arabic-first identity entry point after Splash.

## Dependencies

- APP_SPLASH_SCREEN.
- APP_HOME_SCREEN.
- APP_CLIENT_REGISTRATION_SCREEN.
- App Surface localization rules.
- App Surface signal rules.

## Fields

| Field | Purpose | Status |
| --- | --- | --- |
| email_or_phone | Identity lookup input | REGISTERED |
| password | Secret credential input | REGISTERED |
| Login Button | Login action placeholder | REGISTERED |
| Language Toggle | Arabic/English switch placeholder | REGISTERED |
| Create Account Link | Alternative path to registration | REGISTERED |
| Forgot Password Link | Recovery path placeholder | REGISTERED |

## Connected Screens

- Previous: APP_SPLASH_SCREEN.
- Next: APP_HOME_SCREEN.
- Alternative: APP_CLIENT_REGISTRATION_SCREEN.

## Forbidden

- No Firebase implementation.
- No credential storage.
- No profile collection.
- No tool selection.
- No recommendation logic.
- No legacy login migration.

