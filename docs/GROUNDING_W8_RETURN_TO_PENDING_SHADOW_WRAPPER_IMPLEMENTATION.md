# GROUNDING-W8 Return To Pending Shadow Wrapper Implementation

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

## 1. Scope

GROUNDING-W8 expands the existing passive shadow wrapper pattern to one method only:

```text
AdminBookingDecisionAdapter.returnToPending
```

No wrapper was added for `approveCenterRequest`, payment, payout, accounting, archive, session, or center approval logic.

## 2. Files Modified

| File | Change |
| ---- | ------ |
| `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart` | Added passive `returnToPending` wrapper support, diagnostic envelope creation, non-blocking warnings, and minimal shadow logs. |
| `lib/features/admin_surface/pages/admin_booking_queue_page.dart` | Wired only `_returnToPending` to call `_bookingCommandWrapper.returnToPending(...)` instead of `_bookingDecisionAdapter.returnToPending(...)`. |

## 3. Files Created

| File | Purpose |
| ---- | ------- |
| `docs/GROUNDING_W8_RETURN_TO_PENDING_SHADOW_WRAPPER_IMPLEMENTATION.md` | Documents W8 implementation scope, behavior guarantee, manual commands, rollback, and verification status. |

## 4. Confirmation

Only `returnToPending` was wrapped in W8.

Existing passive wrappers remain:

- `assignClinician`
- `rejectRequest`

No additional method was wrapped.

## 5. Behavior Guarantee

No behavior changes are intended.

The wrapper:

- Attempts a diagnostic read of `booking_requests/{requestId}`.
- Builds a shadow-only `BookingCommandEnvelope`.
- Computes diagnostic warnings only.
- Logs minimal `BOOKING_COMMAND_SHADOW` output.
- Delegates to `AdminBookingDecisionAdapter.returnToPending`.
- Preserves current exceptions and UI behavior.

The wrapper does not:

- Enforce validation.
- Block return-to-pending.
- Write audit collections.
- Write command collections.
- Change Firestore rules.
- Add custom claims.
- Add backend functions.
- Change return-to-pending payloads.
- Touch payment, payout, accounting, archive, session, center approval, or route behavior.

## 6. New Command Envelope

The new shadow envelope uses:

```text
commandName = booking.return_to_pending
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

The requested patch summary reflects the existing adapter return-to-pending payload only as diagnostics:

- `status = pending_admin`
- `workflowStage = pending_admin`
- `adminApproved = false`
- `adminRejected = false`
- `adminForwarded = false`
- assignment and clinician fields reset
- `paymentStatus = not_started`
- `sessionStatus = not_created`
- `reviewStatus = not_started`
- `payoutStatus = blocked`

## 7. Warnings Added

Warnings are diagnostic only and never block.

Implemented warning categories:

- `missing_booking_snapshot`
- `missing_admin_uid`
- `return_from_unexpected_status`
- `payment_already_finalized`
- `session_already_completed`
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

In `lib/features/admin_surface/pages/admin_booking_queue_page.dart`, change `_returnToPending` wiring from:

```dart
await _bookingCommandWrapper.returnToPending(
  requestId: requestId,
  adminUid: adminUid,
);
```

back to:

```dart
await _bookingDecisionAdapter.returnToPending(
  requestId: requestId,
  adminUid: adminUid,
);
```

The wrapper method can remain unused. No data migration, collection cleanup, Firebase rollback, route rollback, or claim rollback is required.

