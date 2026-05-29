# GROUNDING-W5A Assign Clinician Shadow Wrapper Implementation

Mental Smile - Grounding Era

Status: narrow passive shadow implementation. No Firebase rules, custom claims, backend functions, audit collections, command collections, route migrations, payment/payout/accounting/archive/session/center approval logic, or booking lifecycle payloads were changed.

## 1. Files Created

| File | Purpose |
| ---- | ------- |
| `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart` | Adds passive shadow command classes and `AdminBookingCommandWrapper` for `booking.assign_clinician` only. |
| `docs/GROUNDING_W5A_ASSIGN_CLINICIAN_SHADOW_WRAPPER_IMPLEMENTATION.md` | Documents implementation scope, wiring, behavior guarantees, verification status, rollback, and follow-up commands. |

## 2. Files Modified

| File | Change |
| ---- | ------ |
| `lib/features/admin_surface/pages/admin_booking_queue_page.dart` | Imports the shadow wrapper, initializes it with the existing `AdminBookingDecisionAdapter`, and wires only `_assignToClinician` to call the wrapper. |

No other production files were intentionally modified.

## 3. Wrapper Wiring Status

The admin booking queue assignment action was wired narrowly:

```text
_assignToClinician
  -> _bookingCommandWrapper.assignClinician(...)
  -> AdminBookingDecisionAdapter.assignClinician(...)
```

Only `assignClinician` was wired.

No other `AdminBookingDecisionAdapter` method was routed through the wrapper.

## 4. Exact Behavior Guarantee

The wrapper is passive shadow-only:

- It attempts one diagnostic read of `booking_requests/{requestId}`.
- It builds a `BookingCommandEnvelope` with:
  - `commandName = booking.assign_clinician`
  - `commandVersion = v1`
  - `riskTier = critical`
  - `requestedByRole = admin`
  - `targetCollection = booking_requests`
  - `sourceAdapter = AdminBookingDecisionAdapter`
  - `sourceRoute = /admin/booking-queue`
  - `dryRun = true`
  - `shadowMode = true`
- It computes non-blocking validation warnings.
- It logs only minimal diagnostic output with prefix `BOOKING_COMMAND_SHADOW`.
- It delegates to the existing `AdminBookingDecisionAdapter.assignClinician`.
- It returns the original `AdminAssignClinicianResult`.
- It preserves existing exceptions by rethrowing adapter failures.

No validation is enforced.

No audit or command collection is written.

No booking payload is changed.

No payment, payout, accounting, archive, session, or center approval logic is touched.

## 5. Passive Classes Implemented

| Class | Role |
| ----- | ---- |
| `BookingCommandEnvelope` | Holds passive shadow command metadata. |
| `BookingCommandRiskTier` | Defines risk tier values used by the envelope. |
| `BookingCommandValidationWarning` | Holds non-blocking diagnostic warning metadata. |
| `AdminBookingCommandWrapper` | Builds the shadow envelope/warnings/logs, then delegates to the existing adapter. |

`BookingCommandResult` was not added because the wrapper preserves and returns the existing `AdminAssignClinicianResult`.

## 6. Warning Behavior

Warnings are diagnostic only and never block execution.

Implemented warning categories:

- `missing_booking_snapshot`
- `missing_requested_clinician_id`
- `missing_requested_clinician_name`
- `missing_requested_clinician_uid`
- `already_assigned`
- `unexpected_booking_status`
- `missing_admin_uid`
- `target_clinician_active_status_unknown`
- `possible_duplicate_command`
- `missing_source_route`

## 7. Logging Behavior

Diagnostic logs use:

```text
BOOKING_COMMAND_SHADOW
```

Allowed logged fields:

- `commandName`
- `requestId`
- `correlationId`
- `warningCount`
- `resultStatus`
- `alreadyAssigned`
- `sourceAdapter`
- `sourceRoute`

The wrapper does not log full booking snapshots, full profile data, payment data, clinical notes, chat messages, secrets, tokens, or credentials.

## 8. Verification Results

Automated verification was not completed in this turn.

Reason:

- `dart format` was started for the touched Dart files but was interrupted by the user before completion.
- After interruption, the user requested stopping commands and finishing the task/report instead.
- `flutter analyze` was not run.
- No tests were run.

Manual code-level review performed:

- Wrapper delegates to `AdminBookingDecisionAdapter.assignClinician`.
- Wrapper does not write audit/command collections.
- Wrapper does not modify Firestore rules/claims/backend.
- Wrapper does not change assignment payloads.
- Wrapper rethrows adapter exceptions.
- Admin queue wiring is limited to assignment only.

## 9. Rollback Instructions

Rollback is intentionally simple.

In `lib/features/admin_surface/pages/admin_booking_queue_page.dart`, change the assignment call back from:

```dart
final result = await _bookingCommandWrapper.assignClinician(
  requestId: requestId,
  adminUid: adminUid,
);
```

to:

```dart
final result = await _bookingDecisionAdapter.assignClinician(
  requestId: requestId,
  adminUid: adminUid,
);
```

Then remove the unused wrapper field/import if desired.

No data migration is required.

No Firestore cleanup is required.

No Firebase rollback is required.

No route rollback is required.

## 10. Remaining Risks

- The wrapper adds one extra diagnostic read before delegation.
- Formatting/analyzer checks have not been completed yet.
- The local duplicate-command detector is in-memory only and diagnostic-only.
- `target_clinician_active_status_unknown` is always a warning because the wrapper intentionally does not add a clinician approval/active lookup.
- The wrapper is passive and does not provide real audit immutability or backend validation yet.

## 11. Follow-Up Needed

Before considering this done for production QA:

- Run formatter.
- Run analyzer.
- Run any available tests for admin booking queue or admin booking adapters.
- Manually verify assignment behavior in the admin booking queue.
- Confirm no new Firestore writes except the existing adapter write.
- Confirm no audit/command collections are written.

## 12. Notes: Required Commands To Run Later

Recommended commands:

```powershell
dart format lib\features\admin_surface\data\commands\admin_booking_command_wrapper.dart lib\features\admin_surface\pages\admin_booking_queue_page.dart
```

```powershell
flutter analyze
```

Optional targeted searches after formatting/analyze:

```powershell
rg "BOOKING_COMMAND_SHADOW|AdminBookingCommandWrapper|booking.assign_clinician" lib docs
```

If tests exist for this area, run the relevant targeted test command used by the repo. Do not run broad migrations, deploys, Firebase commands, or destructive cleanup.

