# Infrastructure Cutover Decision Card V1

## Card Identity

Card ID: INFRA_CUTOVER_DECISION_CARD_V1

Purpose: Record whether cutover can proceed.

Status: READY_FOR_OWNER_ACTION

## Decision

Local cutover cannot be completed yet because the new Firebase project/app/config is not present in the workspace.

## Allowed Next Step

Owner manual action:

- Create/confirm Firebase project `mental-smile-platform`.
- Register Android app `com.mentalsmile.app`.
- Register web app/hosting.
- Download new `android/app/google-services.json`.

## Not Performed

- No Android applicationId update.
- No Firebase config update.
- No `.firebaserc` update.
- No `firebase.json` update.
- No `google-services.json` replacement.
- No deploy.
- No push.
- No commit.

## Decision Output

INFRASTRUCTURE_CUTOVER_READY_FOR_OWNER_ACTION
