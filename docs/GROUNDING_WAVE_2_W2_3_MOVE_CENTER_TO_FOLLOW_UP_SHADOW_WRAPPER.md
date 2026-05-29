# GROUNDING-WAVE-2 / W2-3 Move Center To Follow Up Shadow Wrapper

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

## 1. Scope

GROUNDING-WAVE-2 / W2-3 expands the existing passive shadow wrapper pattern to one method only:

```text
AdminBookingDecisionAdapter.moveCenterToFollowUp
```

The new passive command name is:

```text
center_request.move_to_follow_up
```

No wrapper was added for any other method.

## 2. Files Modified

| File | Change |
| ---- | ------ |
| `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart` | Added passive `moveCenterToFollowUp` wrapper support, diagnostic envelope creation, non-blocking warnings, and minimal shadow logs. |
| `lib/features/admin_surface/pages/admin_booking_queue_page.dart` | Wired only `_moveCenterToFollowUp` to call `_bookingCommandWrapper.moveCenterToFollowUp(...)` instead of `_bookingDecisionAdapter.moveCenterToFollowUp(...)`. |

## 3. Files Created

| File | Purpose |
| ---- | ------- |
| `docs/GROUNDING_WAVE_2_W2_3_MOVE_CENTER_TO_FOLLOW_UP_SHADOW_WRAPPER.md` | Documents W2-3 implementation scope, behavior guarantee, manual commands, rollback, and verification status. |

## 4. Confirmation

Only `moveCenterToFollowUp` was wrapped in W2-3.

Existing passive wrappers remain:

- `assignClinician`
- `rejectRequest`
- `returnToPending`
- `approveCenterRequest`
- `returnCenterRequestToClient`
- `openCenterIntakeStep`

No additional method was wrapped.

## 5. Behavior Guarantee

No behavior changes are intended.

The wrapper:

- Attempts a diagnostic read of `booking_requests/{requestId}`.
- Builds a shadow-only `BookingCommandEnvelope`.
- Computes diagnostic warnings only.
- Logs minimal `BOOKING_COMMAND_SHADOW` output.
- Delegates to `AdminBookingDecisionAdapter.moveCenterToFollowUp`.
- Preserves current exceptions and UI behavior.

The wrapper does not:

- Enforce validation.
- Block center follow-up.
- Write audit collections.
- Write command collections.
- Change Firestore rules.
- Add custom claims.
- Add backend functions.
- Change center follow-up payloads.
- Touch payment, payout, accounting, archive, session, or route behavior.

## 6. New Command Envelope

The new shadow envelope uses:

```text
commandName = center_request.move_to_follow_up
commandVersion = v1
riskTier = HIGH_RISK
requestedByUid = adminUid
requestedByRole = admin
targetCollection = booking_requests
targetDocId = requestId
sourceAdapter = AdminBookingDecisionAdapter
sourceRoute = /admin/booking-queue
dryRun = true
shadowMode = true
```

The requested patch summary reflects the existing adapter follow-up payload only as diagnostics:

- `status = center_follow_up`
- `workflowStage = center_follow_up`
- `adminApproved = false`
- `adminRejected = false`
- `adminForwarded = false`
- `adminDecisionType = center_follow_up`

## 7. Warnings Added

Warnings are diagnostic only and never block.

Implemented warning categories:

- `missing_booking_snapshot`
- `missing_admin_uid`
- `follow_up_from_unexpected_status`
- `request_is_not_center_request`
- `missing_center_id`
- `missing_center_feedback`
- `payment_already_finalized`
- `session_already_created_or_completed`
- `payout_already_confirmed`
- `missing_source_route`

No warning is used for enforcement.

## 8. Manual Commands Required

Manual operator commands:

```powershell
dart format lib\features\admin_surface\data\commands\admin_booking_command_wrapper.dart lib\features\admin_surface\pages\admin_booking_queue_page.dart
```

```powershell
flutter analyze
```

## 9. Rollback Path

Rollback is local and simple.

In `lib/features/admin_surface/pages/admin_booking_queue_page.dart`, change `_moveCenterToFollowUp` wiring from:

```dart
await _bookingCommandWrapper.moveCenterToFollowUp(
  requestId: requestId,
  adminUid: adminUid,
);
```

back to:

```dart
await _bookingDecisionAdapter.moveCenterToFollowUp(
  requestId: requestId,
  adminUid: adminUid,
);
```

The wrapper method can remain unused. No data migration, collection cleanup, Firebase rollback, route rollback, or claim rollback is required.

