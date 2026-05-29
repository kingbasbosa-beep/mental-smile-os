# GROUNDING-W7 Reject Request Shadow Wrapper Implementation

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

## 1. Scope

GROUNDING-W7 expands the existing passive shadow wrapper pattern to one method only:

```text
AdminBookingDecisionAdapter.rejectRequest
```

No wrapper was added for `returnToPending`, `approveCenterRequest`, payment, payout, accounting, archive, session, or center approval logic.

## 2. Files Modified

| File | Change |
| ---- | ------ |
| `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart` | Added passive `rejectRequest` wrapper support, diagnostic envelope creation, non-blocking warnings, and minimal shadow logs. |
| `lib/features/admin_surface/pages/admin_booking_queue_page.dart` | Wired only `_rejectRequest` to call `_bookingCommandWrapper.rejectRequest(...)` instead of `_bookingDecisionAdapter.rejectRequest(...)`. |

## 3. Files Created

| File | Purpose |
| ---- | ------- |
| `docs/GROUNDING_W7_REJECT_REQUEST_SHADOW_WRAPPER_IMPLEMENTATION.md` | Documents W7 implementation scope, behavior guarantee, manual commands, rollback, and verification status. |

## 4. Behavior Guarantee

No behavior changes are intended.

The wrapper:

- Attempts a diagnostic read of `booking_requests/{requestId}`.
- Builds a shadow-only `BookingCommandEnvelope`.
- Computes diagnostic warnings only.
- Logs minimal `BOOKING_COMMAND_SHADOW` output.
- Delegates to `AdminBookingDecisionAdapter.rejectRequest`.
- Preserves current exceptions and UI behavior.

The wrapper does not:

- Enforce validation.
- Block rejection.
- Write audit collections.
- Write command collections.
- Change Firestore rules.
- Add custom claims.
- Add backend functions.
- Change booking rejection payloads.
- Touch payment, payout, accounting, archive, session, center approval, or route behavior.

## 5. New Command Envelope

The new shadow envelope uses:

```text
commandName = booking.reject_request
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

The requested patch summary reflects the existing adapter rejection payload only as diagnostics:

- `status = rejected_admin`
- `workflowStage = rejected_admin`
- `adminApproved = false`
- `adminRejected = true`
- `paymentStatus = blocked`
- `sessionStatus = cancelled`
- `reviewStatus = blocked`
- `payoutStatus = blocked`

## 6. Warnings Added

Warnings are diagnostic only and never block.

Implemented warning categories:

- `missing_booking_snapshot`
- `missing_admin_uid`
- `rejection_from_unexpected_status`
- `payment_already_finalized`
- `session_already_completed`
- `payout_already_confirmed`
- `missing_rejection_reason`
- `missing_source_route`

No warning is used for enforcement.

## 7. Manual Commands Required

Manual operator commands:

```powershell
dart format lib\features\admin_surface\data\commands\admin_booking_command_wrapper.dart lib\features\admin_surface\pages\admin_booking_queue_page.dart
```

```powershell
flutter analyze
```

## 8. Obvious Warnings / Info From Code Review

Potential expected info/warning category:

- Formatting may be needed because Codex did not run `dart format`.
- Analyzer may report legacy or wave-related info. Per W7 rules, warnings/info should not block progress and should be collected for final wave cleanup.

No obvious intentional behavior change was introduced by code review.

## 9. Rollback Path

Rollback is local and simple.

In `lib/features/admin_surface/pages/admin_booking_queue_page.dart`, change `_rejectRequest` wiring from:

```dart
await _bookingCommandWrapper.rejectRequest(
  requestId: requestId,
  isCenterRequest: isCenterRequest,
  adminUid: adminUid,
);
```

back to:

```dart
await _bookingDecisionAdapter.rejectRequest(
  requestId: requestId,
  isCenterRequest: isCenterRequest,
  adminUid: adminUid,
);
```

The wrapper method can remain unused. No data migration, collection cleanup, Firebase rollback, route rollback, or claim rollback is required.

