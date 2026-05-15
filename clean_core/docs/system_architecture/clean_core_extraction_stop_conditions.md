# Clean Core Extraction Stop Conditions

Draft mandatory stop/review conditions for future extraction.

## Stop Immediately If Detected

- Parent-path imports in export candidates.
- `../lib` imports in export candidates.
- Generated-file leakage into public API.
- Firebase SDK leakage into pure contracts.
- Firebase options/config leakage into public API.
- Provider SDK leakage.
- Runtime activation.
- BuildContext contamination in export-safe areas.
- Routing ownership leakage into clean_core contracts.
- Network client construction.
- Cloud Functions runtime execution.
- AI execution.
- Privileged client writes.
- Fail-closed posture broken.
- Deny-by-default posture broken.

## Review Required If Detected

- New runtime governance markers added to public API.
- New adapter contracts without ownership documentation.
- New generated asset/localization references.
- New tests requiring app shell inside package test surface.
- New feature UI mixed with pure contract areas.
- New Firestore schema assumptions in public contracts.

## Rollback Triggers

- Host app cannot reconnect through documented adapters.
- Extracted package requires Firebase to run pure tests.
- Extracted package requires generated app files.
- Runtime/provider systems become active unintentionally.
- Security rules posture is weakened.

## Explicit Non-Action

No stop condition scan was run in this phase.
