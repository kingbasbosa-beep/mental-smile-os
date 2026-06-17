# ANDROID_APPLICATION_ID_DECISION_V1

## Purpose

Record the Android applicationId decision before any modification.

## Current Application ID

`com.mentalkey.app.flutterprojects`

## Recommended Target

`com.mentalsmile.os`

## Options

| Option | Meaning | Recommendation |
| --- | --- | --- |
| KEEP_CURRENT_FOR_PLAY_CONTINUITY | Keep current app identity to preserve installed app / store continuity. | Not preferred for clean OS identity, but safest if app already has store history. |
| CHANGE_TO_COM_MENTALSMILE_OS | Change now to clean OS identity. | Cleanest identity, highest Firebase/Play Store impact. |
| DEFER_UNTIL_STORE_READY | Change namespace now, defer applicationId until store/Firebase readiness decision. | RECOMMENDED |

## Recommended Decision

DEFER_UNTIL_STORE_READY.

## Reason

Changing applicationId affects:

- Installed app continuity.
- Firebase Android app registration.
- `google-services.json`.
- Google Play identity.
- Potential signing/release continuity.

## Required Owner Decision

Owner must explicitly approve before changing `applicationId`.
