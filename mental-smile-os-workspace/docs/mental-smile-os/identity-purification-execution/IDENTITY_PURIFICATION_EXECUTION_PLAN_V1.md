# IDENTITY_PURIFICATION_EXECUTION_PLAN_V1

## Purpose

Prepare the execution-only cleanup plan for remaining legacy technical identity residue.

## Source

This plan uses STEP 047 findings:

- `flutterprojects` remains active Dart package name.
- 74 files contain `package:flutterprojects` imports.
- `mental_smile_clean_core` remains active local dependency.
- Android namespace/applicationId remains `com.mentalkey.app.flutterprojects`.
- Windows metadata contains `flutterprojects` and `com.mentalkey.app`.

## Recommended Identity Decisions

| Decision | Recommendation | Status |
| --- | --- | --- |
| Target Dart package name | `mental_smile_os` | RECOMMENDED |
| Target Android namespace | `com.mentalsmile.os` | RECOMMENDED |
| Android applicationId timing | `DEFER_UNTIL_STORE_READY` | RECOMMENDED |
| `mental_smile_clean_core` fate | `KEEP_TEMPORARY_WITH_EXPLICIT_EXPIRY`, then `REMOVE_AFTER_EXTRACTION` | RECOMMENDED |

## Execution Rule

No actual rename happens in this plan.

Execution requires Owner approval, scoped patch, validation commands, and rollback point.

## Phases

1. Package identity decision.
2. Dart import rewrite.
3. Android namespace migration.
4. Android applicationId decision.
5. Core dependency extraction.
6. Windows metadata cleanup if Windows target survives.
7. Validation.
8. Owner review.
