# GROUNDING-WAVE-2 / W2-2 Open Center Intake Step Shadow Wrapper

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

## 1. Scope

GROUNDING-WAVE-2 / W2-2 expands the existing passive shadow wrapper pattern to one method only:

```text
AdminBookingDecisionAdapter.openCenterIntakeStep
```

The new passive command name is:

```text
center_request.open_intake_step
```

No wrapper was added for `moveCenterToFollowUp`, payment, payout, accounting, archive, session, or any enforcement flow.

## 2. Files Modified

| File | Change |
| ---- | ------ |
| `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart` | Added passive `openCenterIntakeStep` wrapper support, diagnostic envelope creation, non-blocking warnings, and minimal shadow logs. |
| `lib/features/admin_surface/pages/admin_booking_queue_page.dart` | Wired only `_openCenterIntakeStep` to call `_bookingCommandWrapper.openCenterIntakeStep(...)` instead of `_bookingDecisionAdapter.openCenterIntakeStep(...)`. |

## 3. Files Created

| File | Purpose |
| ---- | ------- |
| `docs/GROUNDING_WAVE_2_W2_2_OPEN_CENTER_INTAKE_STEP_SHADOW_WRAPPER.md` | Documents W2-2 implementation scope, behavior guarantee, manual commands, rollback, and verification status. |

## 4. Confirmation

Only `openCenterIntakeStep` was wrapped in W2-2.

Existing passive wrappers remain:

- `assignClinician`
- `rejectRequest`
- `returnToPending`
- `approveCenterRequest`
- `returnCenterRequestToClient`

No additional method was wrapped.

## 5. Behavior Guarantee

No behavior changes are intended.

The wrapper:

- Attempts a diagnostic read of `booking_requests/{requestId}`.
- Builds a shadow-only `BookingCommandEnvelope`.
- Computes diagnostic warnings only.
- Logs minimal `BOOKING_COMMAND_SHADOW` output.
- Delegates to `AdminBookingDecisionAdapter.openCenterIntakeStep`.
- Preserves current exceptions and UI behavior.

The wrapper does not:

- Enforce validation.
- Block opening center intake.
- Write audit collections.
- Write command collections.
- Change Firestore rules.
- Add custom claims.
- Add backend functions.
- Change open-intake payloads.
- Touch payment, payout, accounting, archive, session, `moveCenterToFollowUp`, or route behavior.

## 6. New Command Envelope

The new shadow envelope uses:

```text
commandName = center_request.open_intake_step
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

The requested patch summary reflects the existing adapter open-intake payload only as diagnostics:

- `status = center_intake_pending`
- `workflowStage = center_intake_pending`
- `adminDecisionType = center_intake_opened`

## 7. Warnings Added

Warnings are diagnostic only and never block.

Implemented warning categories:

- `missing_booking_snapshot`
- `missing_admin_uid`
- `open_intake_from_unexpected_status`
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

In `lib/features/admin_surface/pages/admin_booking_queue_page.dart`, change `_openCenterIntakeStep` wiring from:

```dart
await _bookingCommandWrapper.openCenterIntakeStep(
  requestId: requestId,
  adminUid: adminUid,
);
```

back to:

```dart
await _bookingDecisionAdapter.openCenterIntakeStep(
  requestId: requestId,
  adminUid: adminUid,
);
```

The wrapper method can remain unused. No data migration, collection cleanup, Firebase rollback, route rollback, or claim rollback is required.

