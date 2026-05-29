# GROUNDING-W5 Assign Clinician Shadow Wrapper Plan

Mental Smile - Grounding Era

Source documents:

- `docs/GROUNDING_W1_RUNTIME_INVENTORY_AUTHORITY_MAP.md`
- `docs/GROUNDING_W2_LEGACY_FREEZER_REGISTRY.md`
- `docs/GROUNDING_W3_ADMIN_BOOKING_COMMAND_WRAPPER_SPEC.md`
- `docs/GROUNDING_W4_BOOKING_COMMAND_AUDIT_ARTIFACT_SPEC.md`

Status: implementation plan only. No code was implemented, no booking behavior changed, no Firebase rules or custom claims changed, no backend functions or audit collections were created, and `AdminBookingDecisionAdapter` was not modified.

## 1. Executive Summary

W5 plans the first possible code-level grounding step after the W1-W4 documentation chain.

Target:

```text
AdminBookingDecisionAdapter.assignClinician
```

The proposed move is passive shadow mode only:

- Generate a command envelope for diagnostics/logging first.
- Compute validation warnings only.
- Do not block the current flow.
- Do not write audit collections.
- Do not change booking payloads.
- Do not change Firestore writes.
- Existing `AdminBookingDecisionAdapter` remains the source of behavior and continues to perform the real mutation.

W5 is not implementation authorization. It is a plan for the smallest safe implementation if later approved.

## 2. Current Method Contract

Current method:

```dart
Future<AdminAssignClinicianResult> assignClinician({
  required String requestId,
  required String adminUid,
})
```

| Input | Source | Required? | Current Behavior |
| ----- | ------ | --------- | ---------------- |
| `requestId` | Admin booking queue caller | Yes | Used to read `booking_requests/{requestId}` and later update the same document through `updateRequestEverywhere`. |
| `adminUid` | Admin booking queue caller, current admin identity | Yes | Written into `adminAssignedBy`, `adminDecisionBy`, and used in debug trace output. |

Current return type:

```dart
AdminAssignClinicianResult
```

Fields:

- `alreadyAssigned`: true when current `status` or `workflowStage` is already `assigned_clinician`.
- `clinicianName`: assigned clinician name on successful assignment; empty string for already-assigned skip.

Current success behavior:

- Reads `booking_requests/{requestId}`.
- If already assigned, logs `assign_skip_already_assigned` and returns `AdminAssignClinicianResult(alreadyAssigned: true, clinicianName: '')`.
- If requested clinician fields exist, updates `booking_requests/{requestId}` with:
  - `status: assigned_clinician`
  - `workflowStage: assigned_clinician`
  - admin flags and decision fields
  - assigned clinician fields
  - payment/session/review/payout reset fields
- Returns `AdminAssignClinicianResult(alreadyAssigned: false, clinicianName: clinicianName)`.

Current failure behavior:

- Throws `Exception('Booking request not found')` when the booking document does not exist.
- Throws `Exception('Requested clinician target is missing')` when `clinicianId`, `clinicianName`, or `clinicianUid` is missing or empty.
- Rethrows Firestore update failures from `updateRequestEverywhere`.
- Existing caller/UI behavior must remain unchanged.

## 3. Proposed Passive Classes

Current verified data folder structure:

```text
lib/features/admin_surface/data/services/
```

Suggested future isolated location:

```text
lib/features/admin_surface/data/commands/
```

Planned classes/files, not implemented in W5:

| Planned File | Planned Class | Purpose |
| ------------ | ------------- | ------- |
| `lib/features/admin_surface/data/commands/booking_command_envelope.dart` | `BookingCommandEnvelope` | Passive command metadata object for shadow diagnostics. |
| `lib/features/admin_surface/data/commands/booking_command_result.dart` | `BookingCommandResult` | Shadow wrapper diagnostic result; must not replace `AdminAssignClinicianResult`. |
| `lib/features/admin_surface/data/commands/booking_command_risk_tier.dart` | `BookingCommandRiskTier` | Enum-like model for `INFO`, `HIGH_RISK`, `CRITICAL`, `SOVEREIGN_CRITICAL`. |
| `lib/features/admin_surface/data/commands/booking_command_validation_warning.dart` | `BookingCommandValidationWarning` | Non-blocking warning object for shadow validation. |
| `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart` | `AdminBookingCommandWrapper` | Passive wrapper that delegates to `AdminBookingDecisionAdapter`. |

Design constraint:

These classes must be isolated and unused until explicitly wired. If implemented later, the first version should have no runtime route or Firestore behavior change unless the specific W5A implementation is authorized.

## 4. Shadow Wrapper Flow

Exact future flow:

```text
AdminBookingCommandWrapper.assignClinician(...)
  -> read previous booking snapshot if available
  -> build BookingCommandEnvelope
  -> compute validation warnings only
  -> log/debug diagnostics only
  -> call AdminBookingDecisionAdapter.assignClinician(...)
  -> return original result type unchanged
```

Detailed flow:

1. Receive the same inputs:
   - `requestId`
   - `adminUid`
2. Attempt to read `booking_requests/{requestId}` for shadow envelope context.
3. Build `BookingCommandEnvelope` with `dryRun = true` and `shadowMode = true`.
4. Compute warnings:
   - Missing snapshot.
   - Missing requested clinician fields.
   - Already assigned.
   - Unexpected status.
   - Missing admin UID.
5. Emit debug/diagnostic log only.
6. Call the existing `AdminBookingDecisionAdapter.assignClinician`.
7. Return the original `AdminAssignClinicianResult` unchanged.
8. If existing adapter throws, the wrapper must allow the same exception behavior to reach the caller.

Hard constraints:

- No blocking.
- No field mutation changes.
- No changed payload.
- No new Firestore writes except existing adapter behavior.
- No audit collection writes.
- No change to snackbar/result handling.

## 5. Command Envelope Fields For assignClinician

Minimal shadow envelope fields:

| Field | Value / Source | Notes |
| ----- | -------------- | ----- |
| `commandName` | `booking.assign_clinician` | Fixed. |
| `commandVersion` | `v1` | Fixed initial command version. |
| `riskTier` | `CRITICAL` | Matches W3/W4 classification. |
| `requestedByUid` | `adminUid` | Must not be empty; warning only in shadow. |
| `requestedByRole` | `admin` | Compatibility role only, not future authority model. |
| `targetCollection` | `booking_requests` | Current source truth. |
| `targetDocId` | `requestId` | Current booking request ID. |
| `targetClinicianId` | Snapshot `clinicianId` if available | Warning if missing. |
| `sourceAdapter` | `AdminBookingDecisionAdapter` | Legacy behavior source. |
| `sourceRoute` | `/admin/booking-queue` | Default source route for current caller. |
| `dryRun` | `true` | Shadow only. |
| `shadowMode` | `true` | Non-authoritative. |
| `createdAt` | Local current time | Not a server audit timestamp. |
| `correlationId` | Generated local ID | Used only for diagnostics at first. |
| `idempotencyKey` | Derived from command name + request ID + admin UID + target clinician ID | Diagnostic only initially. |
| `previousStateSummary` | Minimal state summary | Include status, workflowStage, requestKind, clinician fields only. |
| `requestedPatchSummary` | Intended assignment patch summary | Do not include sensitive notes/payment data. |

Suggested `previousStateSummary` fields:

- `status`
- `workflowStage`
- `requestKind`
- `clinicianId`
- `clinicianNamePresent`
- `clinicianUidPresent`
- `assignedClinicianId`
- `adminForwarded`

Suggested `requestedPatchSummary` fields:

- `status: assigned_clinician`
- `workflowStage: assigned_clinician`
- `adminApproved: true`
- `adminForwarded: true`
- `assignedClinicianId`
- `assignedClinicianNamePresent`
- `paymentStatus: not_started`
- `sessionStatus: not_created`
- `reviewStatus: not_started`
- `payoutStatus: blocked`

## 6. Validation Warnings Only

All warnings are diagnostic only. They must not block mutation or change the adapter result.

| Warning | Trigger | Shadow Behavior |
| ------- | ------- | --------------- |
| `missing_booking_snapshot` | Snapshot read fails or document does not exist. | Log warning; existing adapter still determines final behavior. |
| `missing_requested_clinician_id` | `clinicianId` missing or empty in snapshot. | Log warning only. |
| `missing_requested_clinician_name` | `clinicianName` missing or empty in snapshot. | Log warning only. |
| `missing_requested_clinician_uid` | `clinicianUid` missing or empty in snapshot. | Log warning only, even though W5 prompt lists ID/name as primary. |
| `booking_already_assigned` | `status` or `workflowStage` is `assigned_clinician`. | Log warning/info; existing adapter returns alreadyAssigned. |
| `booking_status_not_expected` | Status is not known/expected for assignment. | Log warning only; do not block. |
| `missing_admin_uid` | `adminUid` is empty. | Log warning only; do not change behavior. |
| `target_clinician_active_status_unknown` | Wrapper has no approved/active clinician lookup. | Log warning only; do not add new read unless authorized. |
| `possible_duplicate_command` | Same diagnostic idempotency key observed in local/session scope if available. | Log warning only. |
| `missing_source_route` | Source route not supplied and default unavailable. | Use `/admin/booking-queue`; log warning only if still missing. |

No warning may call Firestore writes, modify the patch, or replace current exception behavior.

## 7. Logging Policy

Use existing logging/debug style if present:

- `debugPrint(...)` is already used in `AdminBookingDecisionAdapter`.
- Existing `logFirestore` callback exists for admin booking traces.

Shadow wrapper logging should be diagnostic and minimal.

Allowed log fields:

- `commandName`
- `requestId`
- `correlationId`
- `warningCount`
- `resultStatus`
- `alreadyAssigned`
- `sourceAdapter`
- `sourceRoute`

Forbidden log fields:

- Sensitive full profile data.
- Full clinical notes.
- Payment amounts or evidence details.
- Raw payment evidence files.
- Full chat message content.
- Tokens, credentials, auth headers, secrets.
- Full previous booking snapshot.

Suggested diagnostic line:

```text
BOOKING_COMMAND_SHADOW command=booking.assign_clinician requestId=<id> correlationId=<id> warnings=<n> result=<status>
```

## 8. Compatibility Requirements

The future wrapper must preserve:

- Current method inputs: `requestId`, `adminUid`.
- Current return type: `Future<AdminAssignClinicianResult>`.
- Current thrown exceptions.
- Current Firestore writes.
- Current status/workflow field values.
- Current assignment payload.
- Current UI caller behavior.
- Current snackbar/result handling.
- Current adapter availability.
- Current `refreshAuthContextForFirestore` behavior.
- Current `logFirestore` behavior.
- Current ability to call `AdminBookingDecisionAdapter` directly as rollback.

The future wrapper must not:

- Add validation enforcement.
- Add audit collection writes.
- Modify `booking_requests` outside the existing adapter call.
- Swallow exceptions.
- Change already-assigned result behavior.
- Add payment/payout/accounting/archive behavior.

## 9. Test Plan

Checks before and after any future W5A implementation:

| Check | Expected Result |
| ----- | --------------- |
| Existing admin assignment still works | Booking moves to `assigned_clinician` exactly as before. |
| Already-assigned branch still works | Returns `alreadyAssigned: true` and no new mutation behavior is introduced. |
| Missing requested clinician still behaves the same | Throws `Exception('Requested clinician target is missing')`. |
| Missing booking still behaves the same | Throws `Exception('Booking request not found')`. |
| Wrapper disabled path works | Admin queue can call `AdminBookingDecisionAdapter.assignClinician` directly. |
| Wrapper enabled path returns same result | Returns `AdminAssignClinicianResult` with the same field values. |
| No extra Firestore writes | Only existing adapter writes occur; no audit/command collections are written. |
| No rules/claims changes | Firebase rules and custom claims remain untouched. |
| Logs appear only in debug/diagnostic mode | Shadow logs do not become user-facing behavior. |
| Sensitive data is not logged | No payment data, clinical notes, full profile snapshots, or secrets. |
| UI behavior preserved | Existing admin queue buttons, busy state, snackbar/result behavior remain unchanged. |

Recommended verification style if implementation is later authorized:

- Unit test wrapper envelope creation with fake snapshot data.
- Unit test warning generation with missing clinician fields.
- Mock adapter call to prove delegation and return type preservation.
- Manual QA assignment path in admin booking queue.
- Firestore write observation to confirm no new collections/writes.

## 10. Rollback Plan

Rollback must be simple:

- Admin queue can switch back to direct adapter call.
- Wrapper file can remain unused.
- No data migration required.
- No collection cleanup required.
- No Firebase rollback required.
- No route rollback required.
- No claim rollback required.
- Existing `AdminBookingDecisionAdapter` remains intact and callable.

If W5A implementation causes any diagnostic or runtime concern, disable wrapper wiring and call the existing adapter directly.

## 11. Implementation Authorization Checklist

Before code implementation, confirm:

- [ ] W5 plan reviewed.
- [ ] Only `assignClinician` scope approved.
- [ ] Shadow-only approved.
- [ ] No audit writes approved.
- [ ] No validation enforcement approved.
- [ ] No route changes approved.
- [ ] No Firestore rules changes approved.
- [ ] No custom claims changes approved.
- [ ] No payment/payout/accounting/archive scope approved.
- [ ] Rollback path accepted.
- [ ] Logging privacy rules accepted.

## 12. Final Recommendation

Recommended next step:

```text
GROUNDING-W5A - Implement Passive Shadow Wrapper for assignClinician
```

W5A is safe only if explicitly authorized and kept narrow:

- Add isolated passive classes.
- Keep wrapper disabled or minimally wired behind a local/internal switch.
- Generate command envelope diagnostics only.
- Compute warnings only.
- Delegate to `AdminBookingDecisionAdapter.assignClinician`.
- Preserve original return type and exceptions.
- Do not persist audit.
- Do not enforce validation.
- Do not touch payment, payout, accounting, archive, routes, rules, claims, or backend.

If implementation is not authorized, the next best step is another spec:

```text
GROUNDING-W6 - Passive Booking Command Model Test Strategy
```

That would define tests and fixtures before code exists.

