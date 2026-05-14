# Firestore Rules Batch 4 Notes

Date: 2026-05-14  
Target: Mental Smile `clean_core`  
Batch: `booking_requests` participant access and narrow actor updates

## Read Rules Opened

`booking_requests/{requestId}` reads are now allowed only for:

- admin helper access
- signed-in client where `clientId == request.auth.uid`
- signed-in center where `centerId == request.auth.uid`
- signed-in clinician where any of these match `request.auth.uid`:
  - `clinicianId`
  - `clinicianUid`
  - `assignedClinicianId`
  - `assignedClinicianUid`

No public booking reads were opened.

## Create Rules Opened

Client-owned create is allowed only when:

- signed in
- `request.resource.data.clientId == request.auth.uid`
- `requestKind` is `clinician` or `center`
- initial `status` is one of:
  - `assigned_clinician`
  - `pending_admin`
- top-level fields are limited to `bookingCreateAllowedFields()`
- no fields from `bookingForbiddenOnCreateFields()` are present

## Client Update Fields Allowed

Client updates are limited to:

- `threadId`
- `note`
- client check-in/arrival confirmation fields
- client review submitted/score fields
- `updatedAt`

Client updates cannot change:

- participant ids
- payment fields
- session links
- admin/lifecycle fields
- safety/risk fields
- provider response fields

## Center Update Fields Allowed

Center updates are limited to:

- `centerAvailabilityStatus`
- `centerAvailabilityNote`
- `centerAvailabilityRespondedAt`
- `centerAvailabilityRespondedBy`
- center suggested alternative fields
- center arrival confirmation fields
- center recommendation fields
- center review submitted/score fields
- `updatedAt`

Center updates cannot change:

- client id
- clinician ids
- payment fields
- session links
- admin/lifecycle fields
- safety/risk fields

## Clinician Update Fields Allowed

Clinician updates are limited to:

- clinician accept/reject/completion booleans
- clinician response fields
- clinician review submitted/score fields
- clinician session notes
- `completedAt`
- `updatedAt`

Clinician updates cannot change:

- client id
- center id
- payment fields
- session links
- admin/lifecycle fields
- safety/risk fields
- assignment fields

## Fields Still Denied

The following remain denied to non-admin/non-server actors:

- `paymentStatus`
- `payment_confirmed`
- `paymentConfirmed`
- `paymentVerifiedAt`
- `paymentVerifiedBy`
- `paymentProofApproved`
- `paymentReceiptFileName`
- `paymentReceiptUrl`
- `paymentSubmittedAt`
- `assignedAdminUid`
- `assignedAdminId`
- `adminNotes`
- `adminApproved`
- `adminRejected`
- `adminForwarded`
- `adminDecisionType`
- `adminDecisionBy`
- `adminDecisionAt`
- `adminAssignedBy`
- `adminAssignedAt`
- `targetAdminIds`
- `targetAdminNames`
- `sessionLink`
- `meetingUrl`
- `zoomUrl`
- `meetUrl`
- `riskScore`
- `riskLevel`
- `safetyState`
- `strategyMode`
- `handoffState`
- `lifecycleState`

`status`, `workflowStage`, `sessionStatus`, and `reviewStatus` are treated as lifecycle/admin-sensitive for updates in this batch.

## Risky Writes / App-Code Conflicts Noticed

Batch 4 intentionally prioritizes safety over current app convenience.

Known likely conflicts:

- `center_booking_request_page.dart` create payload currently includes payment/admin fields such as:
  - `paymentStatus`
  - `sessionStatus`
  - `reviewStatus`
  - `payoutStatus`
  - `adminApproved`
  - `adminRejected`
  - `adminForwarded`
  - `adminDecision*`
  - `targetAdminIds`
  - `targetAdminNames`

  These are denied by Batch 4. They should move to Cloud Functions/admin initialization or be removed from client create payload later.

- `center_booking_request_page.dart` resubmission update changes lifecycle fields such as:
  - `status`
  - `workflowStage`
  - admin approval helper flags

  These are denied by Batch 4.

- `center_residencies_page.dart` updates can change:
  - `status`
  - `workflowStage`
  - `sessionStatus`
  - `residencyStatus`

  These lifecycle updates are denied by Batch 4 and should move to server/admin-controlled transitions or a later explicit transition model.

- `client_sessions_page.dart` can change:
  - `status`
  - `workflowStage`
  - `sessionStatus`
  - `residencyStatus`

  These lifecycle updates are denied by Batch 4.

- `clinician_operations_page.dart` can change:
  - `status`
  - `sessionStatus`
  - `reviewStatus`
  - `payment_confirmed`

  These are denied by Batch 4. Clinician accept/reject/completion booleans are allowed, but lifecycle/payment gates are not.

- `booking_request_page.dart` updates `threadId` after chat thread creation. This is allowed, but the underlying `chat_threads/messages` writes remain denied until a future chat/server batch.

## Collections Still Denied

Still denied:

- `bookingRequests` legacy fallback
- `chat_threads`
- `chat_threads/{threadId}/messages`
- `support_requests`
- `sessionRatings`
- `clinician_profile_change_requests`
- `center_profile_change_requests`
- `chat_escalations`
- all AI Safety collections
- `legalConsents`
- admin approval/write flows
- payment proof flows

## Next Recommended Batch 5

Batch 5 should focus on one of these, not all at once:

1. profile change requests and support requests, or
2. session ratings with participant-only writes and aggregate-read strategy, or
3. chat thread restrictions and Cloud Function boundary design.

Recommended order:

- profile change requests
- support requests
- session ratings
- chat thread/server boundary

Do not open AI safety/legal collections until the policy/legal phase.

