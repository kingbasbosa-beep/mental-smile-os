# GROUNDING-W9 Approve Center Request Shadow Wrapper Implementation

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

## 1. Scope

GROUNDING-W9 expands the existing passive shadow wrapper pattern to one method only:

```text
AdminBookingDecisionAdapter.approveCenterRequest
```

The new passive command name is:

```text
center_request.approve
```

No wrapper was added for accounting, payout, payment, archive, session, or any additional center approval flow.

## 2. Files Modified

| File | Change |
| ---- | ------ |
| `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart` | Added passive `approveCenterRequest` wrapper support, diagnostic envelope creation, non-blocking warnings, and minimal shadow logs. |
| `lib/features/admin_surface/pages/admin_booking_queue_page.dart` | Wired only `_approveCenterRequest` to call `_bookingCommandWrapper.approveCenterRequest(...)` instead of `_bookingDecisionAdapter.approveCenterRequest(...)`. |

## 3. Files Created

| File | Purpose |
| ---- | ------- |
| `docs/GROUNDING_W9_APPROVE_CENTER_REQUEST_SHADOW_WRAPPER_IMPLEMENTATION.md` | Documents W9 implementation scope, behavior guarantee, manual commands, rollback, and verification status. |

## 4. Confirmation

Only `approveCenterRequest` was wrapped in W9.

Existing passive wrappers remain:

- `assignClinician`
- `rejectRequest`
- `returnToPending`

No additional method was wrapped.

## 5. Behavior Guarantee

No behavior changes are intended.

The wrapper:

- Attempts a diagnostic read of `booking_requests/{requestId}`.
- Builds a shadow-only `BookingCommandEnvelope`.
- Computes diagnostic warnings only.
- Logs minimal `BOOKING_COMMAND_SHADOW` output.
- Delegates to `AdminBookingDecisionAdapter.approveCenterRequest`.
- Preserves current exceptions and UI behavior.

The wrapper does not:

- Enforce validation.
- Block center approval.
- Write audit collections.
- Write command collections.
- Change Firestore rules.
- Add custom claims.
- Add backend functions.
- Change center approval payloads.
- Touch payment, payout, accounting, archive, session, or route behavior.

## 6. New Command Envelope

The new shadow envelope uses:

```text
commandName = center_request.approve
commandVersion = v1
riskTier = CRITICAL
requestedByUid = adminUid
requestedByRole = admin
targetCollection = booking_requests
targetDocId = requestId
sourceAdapter = AdminBookingDecisionAdapter
sourceRoute = /admin/booking-queue
dryRun = true
shadowMode = true
```

The requested patch summary reflects the existing adapter approval payload only as diagnostics:

- `status = session_setup_pending`
- `workflowStage = session_setup_pending`
- `adminApproved = true`
- `adminRejected = false`
- `adminForwarded = false`
- `adminDecisionType = approved`
- `paymentStatus = pending_client_transfer`
- `sessionStatus = not_created`
- `reviewStatus = not_started`
- `payoutStatus = blocked`
- clinician assignment fields reset

## 7. Warnings Added

Warnings are diagnostic only and never block.

Implemented warning categories:

- `missing_booking_snapshot`
- `missing_admin_uid`
- `approval_from_unexpected_status`
- `request_is_not_center_request`
- `missing_center_id`
- `missing_center_name`
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

In `lib/features/admin_surface/pages/admin_booking_queue_page.dart`, change `_approveCenterRequest` wiring from:

```dart
await _bookingCommandWrapper.approveCenterRequest(
  requestId: requestId,
  adminUid: adminUid,
);
```

back to:

```dart
await _bookingDecisionAdapter.approveCenterRequest(
  requestId: requestId,
  adminUid: adminUid,
);
```

The wrapper method can remain unused. No data migration, collection cleanup, Firebase rollback, route rollback, or claim rollback is required.

