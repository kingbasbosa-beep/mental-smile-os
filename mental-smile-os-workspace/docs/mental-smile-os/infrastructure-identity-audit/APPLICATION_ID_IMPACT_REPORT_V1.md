# Application ID Impact Report V1

Result: APPLICATION_ID_IMPACT_REVIEW_COMPLETE

## Current Android Identity

| Layer | Current Value | Classification |
| --- | --- | --- |
| Android namespace | `com.mentalsmile.os` | NON_BLOCKING |
| Android applicationId | `com.mentalkey.app.flutterprojects` | OWNER_DECISION_REQUIRED |
| MainActivity package | `com.mentalsmile.os` | NON_BLOCKING |
| Android visible label | `Mental Smile` | NON_BLOCKING |

## Meaning

The namespace is already migrated to OS identity. The installed app identity is not.

`applicationId` is the Android package identity used by Android, Firebase app registration, and app stores. It is not equivalent to user-facing branding.

## If Application ID Is Changed

Target candidate: `com.mentalsmile.os`

Runtime impact:

- Android treats the build as a different app.
- Existing installed app continuity may break.
- App data associated with old package may not carry over automatically.
- Firebase Android app configuration must be recreated or updated.
- `google-services.json` must match the new application ID.
- Deep links, app links, and future store listing identity may need revalidation.
- Any release signing/store path must be reviewed.

Firebase impact:

- Firebase Android app ID in `firebase.json` and `google-services.json` must be regenerated.
- `lib/firebase_options.dart` Android app ID may need regeneration.
- GitHub Actions build may still pass but runtime Firebase initialization can fail if configs mismatch.

## If Application ID Is Kept

Runtime impact:

- Installed app continuity is safer.
- Firebase Android app linkage remains stable.
- Strict OS-only infrastructure identity remains blocked.
- Legacy technical identity persists internally.

## Decision Options

| Option | Classification | Recommended Use |
| --- | --- | --- |
| KEEP_CURRENT_FOR_RELEASE_CANDIDATE | NON_BLOCKING | Best for current RC stability. |
| KEEP_CURRENT_FOR_PLAY_CONTINUITY | OWNER_DECISION_REQUIRED | Useful if store continuity matters. |
| CHANGE_TO_COM_MENTALSMILE_OS | OWNER_DECISION_REQUIRED | Clean OS identity, but requires full Android/Firebase validation. |
| DEFER_UNTIL_FIREBASE_MIGRATION | OWNER_DECISION_REQUIRED | Safest if Firebase project migration is also planned. |

## Recommendation

Do not change applicationId inside a normal cleanup wave.

Treat it as an infrastructure migration requiring:

1. Owner approval.
2. Firebase Android app registration decision.
3. `google-services.json` regeneration.
4. Full Android debug/release build validation.
5. Store continuity decision.

Final applicationId status: OWNER_DECISION_REQUIRED.
