# App Login Screen Guide V1

Status: READY
Screen ID: APP_LOGIN_SCREEN
Surface: App Surface
Prompt Asset: PROMPT_ASSET_047

## Purpose

APP_LOGIN_SCREEN provides the clean identity entry point between Splash and Home.

It allows returning users to enter Mental Smile OS without mixing login with registration, room behavior, Firebase implementation, or legacy routing.

## Fields And Actions

- email_or_phone.
- password.
- Login Button.
- Language Toggle.
- Create Account Link.
- Forgot Password Link.

## Rules

- Login is an identity entry screen only.
- Login does not collect profile data.
- Login does not select tools.
- Login does not contain recommendations.
- Login does not expose admin tools.
- Login does not implement Firebase in this package.

## Boundary

Documentation only.

No runtime, Firebase, UI implementation, routing implementation, or authentication logic is created.

