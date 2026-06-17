# Legacy Infrastructure Retirement Card V1

Status: LEGACY_INFRASTRUCTURE_RETIREMENT_PARTIAL

## Retired Identity

| Component | Legacy Value | Current Fate |
| --- | --- | --- |
| Firebase project | mental-smile-app-clean | Retired from `.firebaserc`; still present in FlutterFire/runtime references |
| Android applicationId | com.mentalkey.app.flutterprojects | Replaced in Android build config; preserved in rollback cards |
| Firebase Android package | com.mentalkey.app.flutterprojects | Replaced by current `google-services.json`; preserved in backup/evidence |
| Hosting URL | mental-smile-app-clean.web.app | Still referenced by app exit link; needs Owner decision |

## Retirement Principle

Legacy infrastructure must remain available only as rollback evidence, source history, or historical proof. It must not remain an active deploy or runtime target.

## Current Violations

1. Runtime Firebase options still point to legacy Firebase project.
2. GitHub Actions still deploy to legacy Firebase project.
3. One app-facing official link still points to legacy hosting URL.

## Rollback Evidence To Preserve

- `android/app/google-services.json.backup-before-mental-smile-platform-cutover`
- Existing rollback cards in this folder
- Existing old infrastructure evidence cards

## Retirement Decision

Legacy infrastructure is not fully retired until the active blockers listed in `FINAL_INFRASTRUCTURE_CUTOVER_CLEANUP_REPORT_V1.md` are resolved.

Result: LEGACY_RETIREMENT_INCOMPLETE
