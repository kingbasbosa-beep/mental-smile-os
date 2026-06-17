# Mental Smile Platform Hosting Card V1

## Identity

Card ID: MENTAL_SMILE_PLATFORM_HOSTING_CARD_V1

Component: Firebase Hosting target.

## Active Project Target

`mental-smile-platform`

## Hosting Public Directory

`public-landing`

## Purpose

Prepare Mental Smile public landing for deployment under the clean Mental Smile Platform Firebase project.

## Files Touched

- `.firebaserc`

## Files Preserved

- `firebase.json`
- public directory remains `public-landing`

## Deployment Status

READY_FOR_OWNER_CONFIRMED_DEPLOY.

No deploy was performed in this step.

## Validation Commands

```powershell
firebase use
firebase serve --only hosting
firebase deploy --only hosting
```

## Risk Level

HIGH.

Hosting deploy publishes public content to the active Firebase project.
