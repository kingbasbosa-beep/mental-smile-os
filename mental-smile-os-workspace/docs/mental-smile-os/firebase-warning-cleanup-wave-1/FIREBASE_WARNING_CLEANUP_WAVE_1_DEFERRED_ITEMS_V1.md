# FIREBASE_WARNING_CLEANUP_WAVE_1_DEFERRED_ITEMS_V1

## Purpose

Record Firebase warning cleanup items deferred because changing them could affect active access behavior.

## Deferred Items

| ID | Item | Reason | Required Before Change |
| --- | --- | --- | --- |
| FB_DEFER_001 | Remove clinician Firestore document fallback from `storage.rules` | Could block clinician uploads if claims are missing | Confirm clinician custom claims are complete |
| FB_DEFER_002 | Remove center Firestore document fallback from `storage.rules` | Could block center uploads if claims are missing | Confirm center custom claims are complete |

## Not Deferred

The duplicate `isMonitoringOperator()` helper in `firestore.rules` was safe to remove because the duplicate implementation was behavior-identical.

## Boundary

No Storage rule behavior was changed in this wave.

