# GROUNDING-WAVE-2 / W2-1 Return Center Request To Client Shadow Wrapper

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

## 1. Scope

GROUNDING-WAVE-2 / W2-1 expands the existing passive shadow wrapper pattern to one method only:

```text
AdminBookingDecisionAdapter.returnCenterRequestToClient
```

The new passive command name is:

```text
center_request.return_to_client
```

No wrapper was added for `openCenterIntakeStep`, `moveCenterToFollowUp`, payment, payout, accounting, archive, session, or any enforcement flow.

## 2. Files Modified

| File | Change |
| ---- | ------ |
| `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart` | Added passive `returnCenterRequestToClient` wrapper support, diagnostic envelope creation, non-blocking warnings, and minimal shadow logs. |
| `lib/features/admin_surface/pages/admin_booking_queue_page.dart` | Wired only `_returnCenterRequestToClient` to call `_bookingCommandWrapper.returnCenterRequestToClient(...)` instead of `_bookingDecisionAdapter.returnCenterRequestToClient(...)`. |

## 3. Files Created

| File | Purpose |
| ---- | ------- |
| `docs/GROUNDING_WAVE_2_W2_1_RETURN_CENTER_REQUEST_TO_CLIENT_SHADOW_WRAPPER.md` | Documents W2-1 implementation scope, behavior guarantee, manual commands, rollback, and verification status. |

## 4. Confirmation

Only `returnCenterRequestToClient` was wrapped in W2-1.

Existing passive wrappers remain:

- `assignClinician`
- `rejectRequest`
- `returnToPending`
- `approveCenterRequest`

No additional method was wrapped.

## 5. Behavior Guarantee

No behavior changes are intended.

The wrapper:

- Attempts a diagnostic read of `booking_requests/{requestId}`.
- Builds a shadow-only `BookingCommandEnvelope`.
- Computes diagnostic warnings only.
- Logs minimal `BOOKING_COMMAND_SHADOW` output.
- Delegates to `AdminBookingDecisionAdapter.returnCenterRequestToClient`.
- Preserves current exceptions and UI behavior.

The wrapper does not:

- Enforce validation.
- Block return-to-client.
- Write audit collections.
- Write command collections.
- Change Firestore rules.
- Add custom claims.
- Add backend functions.
- Change return-to-client payloads.
- Touch payment, payout, accounting, archive, session, `openCenterIntakeStep`, `moveCenterToFollowUp`, or route behavior.

## 6. New Command Envelope

The new shadow envelope uses:

```text
commandName = center_request.return_to_client
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

The requested patch summary reflects the existing adapter return-to-client payload only as diagnostics:

- `status = client_update_required`
- `workflowStage = client_update_required`
- center feedback snapshot fields summarized
- revision context summarized
- `adminCanApproveWithoutCenterRecheck = false`
- `adminDecisionType = returned_to_client`

## 7. Warnings Added

Warnings are diagnostic only and never block.

Implemented warning categories:

- `missing_booking_snapshot`
- `missing_admin_uid`
- `return_to_client_from_unexpected_status`
- `request_is_not_center_request`
- `missing_center_id`
- `missing_center_feedback_snapshot`
- `missing_client_update_revision_context`
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

In `lib/features/admin_surface/pages/admin_booking_queue_page.dart`, change `_returnCenterRequestToClient` wiring from:

```dart
await _bookingCommandWrapper.returnCenterRequestToClient(
  requestId: requestId,
  data: data,
  adminUid: adminUid,
);
```

back to:

```dart
await _bookingDecisionAdapter.returnCenterRequestToClient(
  requestId: requestId,
  data: data,
  adminUid: adminUid,
);
```

The wrapper method can remain unused. No data migration, collection cleanup, Firebase rollback, route rollback, or claim rollback is required.

