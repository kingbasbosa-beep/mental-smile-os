# FIREBASE_REMAINING_MISMATCHES_V1

## Purpose

Record remaining mismatches between Generation 1 Firebase constitution and actual Firebase state.

## Mismatch Matrix

| ID | Mismatch | Actual State | Expected / Doctrine | Severity |
| --- | --- | --- | --- | --- |
| FB_MISMATCH_001 | Approved collection registry file missing | `GENERATION_1_APPROVED_COLLECTION_REGISTRY_V1.md` not found | Dedicated approved collection registry expected from prior doctrine | HIGH |
| FB_MISMATCH_002 | Conceptual collection names differ from runtime collection names | Runtime uses `clients`, `clinicians`, `centers`, `support_requests`, `signal_events`, etc. | Blueprint defines conceptual families like `app_room_signals`, `provider_registration_records` | HIGH |
| FB_MISMATCH_003 | Duplicate Firestore helper | `isMonitoringOperator()` appears twice in `firestore.rules` | One helper definition | MEDIUM |
| FB_MISMATCH_004 | Storage mixed authority model | `isClinician()` and `isCenter()` allow token role OR Firestore role document fallback | Pure claim authority preferred | MEDIUM |
| FB_MISMATCH_005 | Functions collection not covered by client rules | Function writes `analytics_summaries`; Firestore rules catch-all denies client access | Decide archive/monitoring read policy if runtime needs it | MEDIUM |
| FB_MISMATCH_006 | Claims naming drift | Constitution lists `provider`, actual runtime/rules use `clinician` | Align doctrine or claims model before final production | MEDIUM |
| FB_MISMATCH_007 | `.firebaserc` project identity contains `mental-smile-app-clean` | Current default project is legacy-clean named | Accept as existing Firebase project or migrate later | MEDIUM |

## Non-Mismatches

| Area | Reason |
| --- | --- |
| Firebase Admin SDK in Functions | Technical server SDK dependency, not client admin authority. |
| `role` fields in documents | Runtime data fields; Firestore authority relies on custom claims for privileged access. |
| Public Storage asset reads | Public asset paths are intentionally readable. |

## Result

Mismatches require cleanup or explicit acceptance before irreversible production deployment, but they do not block activation preparation.
