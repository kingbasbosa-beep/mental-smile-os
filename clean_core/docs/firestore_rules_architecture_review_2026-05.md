# Mental Smile Clean-Core Firestore Rules Architecture Review

Date: 2026-05-14  
Target: `C:/mental_smile_workspace/app/mental-smile-app-clean2/clean_core`  
Source reference: `C:/mental_smile_workspace/app/mental-smile-app-clean2`  
Mode: Design/report only. No rules implementation.

## 1. Existing Rules Summary

### Rules File Status

The source project has an existing Firestore rules file:

- `C:/mental_smile_workspace/app/mental-smile-app-clean2/firestore.rules`

The source project also has Firestore indexes:

- `C:/mental_smile_workspace/app/mental-smile-app-clean2/firestore.indexes.json`

There is no separate clean-core `firestore.rules` reviewed as the active target in this pass. The clean-core rules implementation should be a future controlled phase.

### Current Strategy

The current source rules use:

- `rules_version = '2'`
- deny-by-default catch-all:
  - `match /{document=**} { allow read, write: if false; }`
- helper functions:
  - `signedIn()`
  - `uid()`
  - `isAdmin()`
  - `isClient()`
  - `isClinician()`
  - `isCenter()`
  - `protectedAccountFields()`
  - `noProtectedAccountFieldChange()`
  - `ownDoc(docId)`
  - `approvedActive()`
  - registration validators
  - booking ownership/update validators
  - profile-request validators
  - rating validators

The file covers major collections:

- `clients`
- `clinicians`
- `centers`
- `booking_requests`
- `bookingRequests`
- `sessionRatings`
- `clinician_profile_change_requests`
- `center_profile_change_requests`
- `support_requests`
- `chat_threads`
- `chat_threads/{threadId}/messages`
- `chat_escalations`
- `chat_escalations/{escalationId}/reports`
- `admins`
- selected system/admin collections
- AI-policy-adjacent `ai_policies`

### Deny/Default Status

The source rules are deny-by-default at the final catch-all. This is the correct baseline and should be reused conceptually.

### Major Weaknesses

1. Role helpers depend on custom claims:
   - `request.auth.token.role == 'admin'`
   - `request.auth.token.role == 'client'`
   - `request.auth.token.role == 'clinician'`
   - `request.auth.token.role == 'center'`

   Clean-core currently resolves roles from Firestore documents in:

   - `clean_core/lib/core/auth/account_access_service.dart`

   This creates a design mismatch. Either custom claims must be introduced/maintained by backend functions, or rules must check role documents directly.

2. `approvedActive()` uses `resource.data` and allows public reads for approved/active provider documents, but rules cannot filter fields. If a provider document contains private document URLs, admin notes, or private review fields, allowing read on the whole document exposes them.

3. `bookingUserUpdateValid()` allows broad user updates, including payment and review fields:

   - `paymentStatus`
   - `payment_confirmed`
   - `paymentReceiptFileName`
   - `paymentReceiptUrl`
   - review totals/percentages
   - session/review status fields

   These are too broad for production without stricter actor-specific field lists.

4. `chat_threads` create/update rules allow owner writes to thread-level fields. Current booking chat adapter writes safety/handoff fields from client-side code. This must move behind Cloud Functions or be tightly field-restricted.

5. `chat_escalations` currently allows `create` if signed in. This is too broad for future AI/safety escalation records.

6. Public approved center/clinician reads should ideally read from sanitized public profile documents or enforce that sensitive private fields are not stored on public-readable documents.

### What Can Be Reused

Reusable concepts:

- deny-by-default strategy
- `signedIn()` / `uid()` helpers
- protected account field list concept
- self-create pending registration pattern
- owner read pattern
- admin-only approval/update pattern
- legacy `bookingRequests` deny-by-default posture
- profile-change request pattern
- explicit collection-specific matches
- emulator/index awareness from `firestore.indexes.json`

### What Must Not Be Copied Blindly

Do not blindly copy:

- custom-claim role helpers unless the backend actually sets those claims.
- broad `bookingUserUpdateValid()` field list.
- public read of whole provider documents if documents contain private fields.
- `chat_threads` owner update permissions.
- signed-in create permission for `chat_escalations`.
- rules for AI/policy collections without the future AI Safety OS model.

## 2. Clean-Core Firestore Usage Inventory

Inventory source: static inspection of `clean_core/lib/**`.

### `admins`

Files:

- `lib/core/auth/account_access_service.dart`
- `lib/features/home/presentation/pages/menu_page.dart`
- `lib/features/booking/presentation/pages/center_booking_request_page.dart`

Operations:

- read `admins/{uid}` for admin detection
- read/query admin documents during routing/menu and center booking request flow

Actor role:

- signed-in user indirectly
- client booking flow

Sensitivity: Critical

Production risk:

- Admin docs must not be enumerable by normal users.
- If role detection depends on `admins/{uid}`, rules need either custom claims or very narrow self/admin read behavior.
- Admin assignment/lookup should move to backend if more than a boolean active check is needed.

### `clients`

Files:

- `lib/core/auth/account_access_service.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/booking/presentation/pages/booking_request_page.dart`

Operations:

- read own client document
- query by email fallback
- booking flow reads client data for request creation

Actor role:

- client
- route gate

Sensitivity: High

Production risk:

- Clients must not update role/block/admin/payment fields.
- Email fallback queries need careful indexing and rules design.

### `centers`

Files:

- `lib/core/auth/account_access_service.dart`
- `lib/features/centers/data/services/centers_firestore_service.dart`
- `lib/features/centers/presentation/pages/center_dashboard_page.dart`
- `lib/features/home/presentation/pages/menu_page.dart`
- `lib/features/booking/presentation/pages/center_booking_request_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_media_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_pricing_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_documents_page.dart`

Operations:

- public list/detail reads
- center owner read
- self-create during web registration
- draft/profile/media/pricing/document updates

Actor role:

- public user
- center owner
- route gate

Sensitivity: Critical

Production risk:

- Public read can expose private registration fields if stored in same document.
- Center owner currently writes draft fields plus readiness flags.
- Approval, activation, block, verification, and public publication must be admin/server-only.

### `clinicians`

Files:

- `lib/core/auth/account_access_service.dart`
- `lib/features/home/presentation/pages/menu_page.dart`
- `lib/features/booking/presentation/pages/booking_page.dart`
- `lib/features/booking/presentation/pages/booking_request_page.dart`
- `lib/features/specialists/presentation/specialists_list_page.dart`
- `lib/features/specialists/presentation/specialist_details_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_sessions_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_documents_page.dart`

Operations:

- public specialist list/detail reads
- booking page reads active clinicians
- clinician owner read
- clinician self-create during web registration
- profile/session/document draft updates

Actor role:

- public user
- client booking flow
- clinician owner

Sensitivity: Critical

Production risk:

- Public reads must not expose documents, private contact details, internal notes, or session links.
- Clinicians must not self-approve, self-activate, or self-verify.

### `booking_requests`

Files:

- `lib/features/booking/presentation/pages/booking_request_page.dart`
- `lib/features/booking/presentation/pages/center_booking_request_page.dart`
- `lib/features/booking/presentation/pages/my_bookings_page.dart`
- `lib/features/booking/data/services/center_request_inbox_service.dart`
- `lib/features/booking/presentation/pages/center_inbox_page.dart`
- `lib/features/centers/presentation/pages/center_residencies_page.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/client/presentation/pages/client_sessions_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/clinician/presentation/pages/clinician_sessions_page.dart`

Operations:

- create booking requests
- read own/assigned requests
- update center availability fields
- update clinician/session fields
- update client confirmation/review fields
- update status/lifecycle-adjacent fields in active migrated pages

Actor role:

- client
- center
- clinician
- future admin/server

Sensitivity: Critical

Production risk:

- This is the most important collection to harden.
- Rules must enforce ownership and actor-specific field changes.
- Lifecycle/payment/session links should move to Cloud Functions where possible.

### `bookingRequests` Legacy Fallback

Files:

- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`

Operations:

- legacy fallback read/update

Actor role:

- clinician

Sensitivity: High

Production risk:

- Legacy schema should not expand.
- Prefer deny-by-default or minimal compatibility until removed.

### `chat_threads`

Files:

- `lib/features/booking/data/services/booking_legacy_chat_adapter.dart`

Operations:

- query reusable booking follow-up thread
- create/update thread
- update last message/metadata/safety-adjacent fields

Actor role:

- client booking flow

Sensitivity: Critical

Production risk:

- Contains safety and handoff metadata.
- Client should not be able to control governance/risk/handoff fields.
- Strong candidate for Cloud Functions boundary.

### `chat_threads/{id}/messages`

Files:

- `lib/features/booking/data/services/booking_legacy_chat_adapter.dart`

Operations:

- read latest messages for sequence
- add booking/admin-update messages

Actor role:

- client booking flow
- future admin/server

Sensitivity: Critical

Production risk:

- Message creation must be membership-scoped.
- Sender identity/type must be server-validated.
- Admin-looking messages should not be client-written.

### `support_requests`

Files:

- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`

Operations:

- read/count support request streams

Actor role:

- client
- clinician

Sensitivity: High

Production risk:

- May contain mental-health support context.
- Owner/assignee/admin only.

### `sessionRatings`

Files:

- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/specialists/presentation/specialist_details_page.dart`

Operations:

- read rating streams/aggregates

Actor role:

- client
- clinician
- public specialist page

Sensitivity: Medium to High

Production risk:

- Public pages should use sanitized aggregate rating data.
- Raw reviewer identity/comments should be protected.

### `clinician_profile_change_requests`

Files:

- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`

Operations:

- create profile change request
- read own pending profile change requests

Actor role:

- clinician
- future admin

Sensitivity: High

Production risk:

- Good request-based pattern.
- Clinician must not approve/reject/apply own changes.

### `chat_escalations`

Files:

- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`

Operations:

- read assigned/referred escalation cases

Actor role:

- clinician
- future admin/safety

Sensitivity: Critical

Production risk:

- Requires AI/safety policy review before production.
- Do not allow broad signed-in create/write.

## 3. Future AI Safety Collections Compatibility

These collections should be reserved as placeholders for later AI Safety OS implementation. They should not be opened broadly before policy design and legal review.

### Proposed Collections

- `aiSafetyEvents`
- `aiEscalationCases`
- `aiSafetyTraces`
- `aiSafetyIncidents`
- `aiSafetySystemAlerts`
- `aiSafetyPolicyRuntimeConfig`
- `aiSafetyPolicySnapshots`
- `legalConsents`

### Rules Philosophy

- deny-by-default for all AI safety collections until implemented.
- no raw sensitive content by default.
- no broad user reads of safety traces, incidents, or policy internals.
- admin/safety-operator-only reads for logs, traces, alerts, incidents.
- user create only where absolutely necessary, for example explicit report/consent event, and only with narrow fields.
- users cannot update risk, severity, routing, policy, admin, reviewer, or governance fields.
- all AI safety incident transitions should be Cloud Function or admin-only.
- preserve sanitized audit/export compatibility by separating raw traces from redacted exports.

### Suggested Initial Posture

Before AI Safety OS:

- `aiSafetyEvents`: user may create minimal event stub only if needed; otherwise server-only.
- `aiEscalationCases`: admin/safety/server only.
- `aiSafetyTraces`: server-only.
- `aiSafetyIncidents`: server/admin-only.
- `aiSafetySystemAlerts`: admin/server-only.
- `aiSafetyPolicyRuntimeConfig`: admin/server read/write only, preferably server-managed.
- `aiSafetyPolicySnapshots`: admin read, server write.
- `legalConsents`: owner read, owner create immutable consent, admin read; no owner update/delete.

## 4. Role Model

The clean-core implementation currently resolves roles through Firestore documents, while source rules use custom claims. The future rules architecture must choose one model deliberately.

### Recommended Direction

Short term:

- Keep Firestore document role checks for compatibility.
- Use strict document ownership checks.
- Restrict all role-defining field writes.

Medium term:

- Add Cloud Functions to set custom claims after approval.
- Use custom claims for faster route/rules checks where appropriate.
- Keep Firestore docs as source of profile and approval metadata.

### Rule Helpers Needed

Proposed helpers:

```js
function signedIn() {
  return request.auth != null;
}

function uid() {
  return request.auth.uid;
}

function isOwner(ownerUid) {
  return signedIn() && ownerUid == uid();
}

function isAdmin() {
  return signedIn()
    && (
      request.auth.token.role == 'admin'
      || exists(/databases/$(database)/documents/admins/$(uid()))
    );
}

function isClient(userId) {
  return signedIn()
    && userId == uid()
    && exists(/databases/$(database)/documents/clients/$(uid()));
}

function isCenter(userId) {
  return signedIn()
    && userId == uid()
    && exists(/databases/$(database)/documents/centers/$(uid()));
}

function isClinician(userId) {
  return signedIn()
    && userId == uid()
    && exists(/databases/$(database)/documents/clinicians/$(uid()));
}

function isApprovedActiveCenter(userId) {
  return isCenter(userId)
    && get(/databases/$(database)/documents/centers/$(userId)).data.approvalStatus == 'approved'
    && get(/databases/$(database)/documents/centers/$(userId)).data.isActive == true
    && get(/databases/$(database)/documents/centers/$(userId)).data.isBlocked != true;
}

function isApprovedActiveClinician(userId) {
  return isClinician(userId)
    && get(/databases/$(database)/documents/clinicians/$(userId)).data.approvalStatus == 'approved'
    && get(/databases/$(database)/documents/clinicians/$(userId)).data.isActive == true
    && get(/databases/$(database)/documents/clinicians/$(userId)).data.isBlocked != true;
}

function isPublicApprovedCenter() {
  return resource.data.approvalStatus == 'approved'
    && resource.data.isActive == true
    && resource.data.isBlocked != true;
}

function isPublicApprovedClinician() {
  return resource.data.approvalStatus == 'approved'
    && resource.data.isActive == true
    && resource.data.isBlocked != true;
}
```

Needs verification:

- Whether to use custom claims, Firestore role docs, or both in the first implementation.
- Whether `active` must remain accepted as legacy alias for `isActive`.

## 5. Field Protection Model

### Forbidden User-Controlled Fields

Users should not create/update these fields except through server/admin-controlled paths:

- `role`
- `isAdmin`
- `approvalStatus`
- `isActive`
- `active` for admin/provider activation
- `isBlocked`
- `blockReason`
- `blockedAt`
- `blockedBy`
- `verified`
- `verifiedAt`
- `verifiedBy`
- document review fields
- document approval/rejection fields
- `paymentStatus`
- `payment_confirmed`
- `paymentVerifiedAt`
- `paymentVerifiedBy`
- `paymentProofApproved`
- `sessionLink`
- safety/risk fields:
  - `riskScore`
  - `riskLevel`
  - `safetyState`
  - `strategyMode`
  - `escalationLevel`
  - `safetyTriggered`
- admin notes
- assignment fields:
  - `assignedAdminUid`
  - `assignedClinicianUid`
  - `assignedClinicianId`
  - reassignment fields
- lifecycle status fields except narrow allowed transitions:
  - `status`
  - `sessionStatus`
  - `reviewStatus`
  - `handoffState`
  - `lifecycleState`

### Protected Helper Lists

Rules should define separate field lists:

- `protectedAccountFields()`
- `providerApprovalFields()`
- `bookingParticipantFields()`
- `bookingAdminOnlyFields()`
- `bookingPaymentFields()`
- `bookingSessionLinkFields()`
- `chatSafetyFields()`
- `aiGovernanceFields()`
- `documentReviewFields()`

This is safer than one large list because different collections have different risks.

## 6. Collection Rule Design

### `admins/{adminId}`

Public read:

- none.

Owner read:

- preferably none, unless `adminId == uid()` and custom claims/admin doc already verifies admin.

Create:

- server/admin only.

Update:

- server/admin only.

Delete:

- false.

Forbidden fields:

- all user-controlled fields.

Admin-only fields:

- `active`
- `role`
- permissions
- audit metadata

Notes:

- Bootstrap admin creation must be handled outside client app.

### `clients/{clientId}`

Public read:

- none.

Owner read:

- `signedIn() && clientId == uid()`

Create:

- owner only, with restricted fields.

Update:

- owner-safe profile fields only.

Delete:

- false, or admin/server only with data lifecycle policy later.

Forbidden fields:

- `role` after create
- `isAdmin`
- `isBlocked`
- `approvalStatus`
- payment/admin/safety fields

Admin-only fields:

- block/moderation/account state.

Notes:

- If clean-core keeps email fallback role resolution, rules must support narrow lookup without enabling broad data exposure.

### `centers/{centerId}`

Public read:

- only if approved/active/not blocked.
- production-preferred: public read from sanitized `publicCenters/{centerId}` instead.

Owner read:

- center owner can read own registration state.

Create:

- `centerId == uid()`
- `role == center`
- `approvalStatus == pending_admin`
- `isActive == false`
- `isBlocked != true`

Update:

- owner draft updates only while not approved.
- admin/server updates approval, active, blocked, public fields.

Delete:

- false.

Forbidden fields:

- approval/block/verified/admin/document-review fields.

Admin-only fields:

- `approvalStatus`
- `isActive`
- `isBlocked`
- `verified`
- public publication flags
- review notes

Notes:

- Separate private registration documents from public display fields if possible.

### `clinicians/{clinicianId}`

Public read:

- only if approved/active/not blocked.
- production-preferred: public read from sanitized `publicClinicians/{clinicianId}`.

Owner read:

- clinician owner can read own registration/profile state.

Create:

- `clinicianId == uid()`
- `role == clinician`
- `approvalStatus == pending_admin` or source-compatible pending value
- `isActive == false`
- `isBlocked != true`

Update:

- owner draft updates only while pending.
- approved profile changes should go through `clinician_profile_change_requests`.

Delete:

- false.

Forbidden fields:

- approval/block/verified/rating/admin/document-review fields.

Admin-only fields:

- approval, active, block, verification, public publication.

Notes:

- Current source rules use clinician initial `approvalStatus == pending_review`, while center uses `pending_admin`. Clean-core code appears to use provider approval concepts and should standardize status names before final rules.

### `booking_requests/{requestId}`

Public read:

- none.

Owner/participant read:

- client if `clientId == uid()`
- center if `centerId == uid()`
- clinician if `clinicianId == uid()` or compatible assigned clinician field
- admin/server

Create:

- client-owned create only.
- center booking request should still be created by client, with `clientId == uid()`.
- initial status must be from an allowed initial set.

Update:

- actor-specific field lists only.

Delete:

- false.

Forbidden fields:

- participant ids after create
- payment verification fields
- admin notes
- lifecycle owner fields
- session link except allowed clinician/admin/server path

Admin-only fields:

- status lifecycle
- assignment
- payment verification
- admin notes
- dispute/accounting fields

Notes:

- This collection should be the first serious rules test target.

### `bookingRequests/{requestId}`

Public read:

- none.

Read/write:

- preferably false.

Compatibility option:

- if legacy clinician fallback remains required, mirror participant read/update rules with even narrower update fields.

Recommendation:

- keep denied until product confirms legacy dependency.

### `chat_threads/{threadId}`

Public read:

- none.

Participant read:

- owner
- assigned clinician if explicitly assigned
- admin

Create:

- preferably Cloud Function only.
- temporary client create only for owner-owned thread with a small allowed field set.

Update:

- preferably Cloud Function/admin only.

Delete:

- false.

Forbidden fields:

- safety/risk/handoff/assignment/admin fields.

Admin-only fields:

- `assignedAdminUid`
- `handoffState`
- `lifecycleState`
- `safetyState`
- `riskScore`
- `riskLevel`
- `strategyMode`

Notes:

- Current booking adapter writes many governance fields. This must not become broad client permission in production.

### `chat_threads/{threadId}/messages/{messageId}`

Public read:

- none.

Participant read:

- thread owner, assigned clinician, admin.

Create:

- participant create only with strict sender identity validation, or Cloud Function only.

Update:

- false, except admin/server moderation later.

Delete:

- false, except retention/legal process later.

Forbidden fields:

- sender spoofing
- safety/risk fields
- admin/system message kind from user client

Admin-only fields:

- moderation/action metadata.

### `support_requests/{requestId}`

Public read:

- none.

Owner read:

- creator owner.

Assignee read:

- assigned clinician/center/admin if modeled.

Create:

- signed-in owner with `createdByUid == uid()` and safe initial status.

Update:

- admin/assigned support only.

Delete:

- false.

Forbidden fields:

- assignment, status escalation, internal notes, safety flags.

Admin-only fields:

- assignment, status, escalation, internal notes.

### `sessionRatings/{ratingId}`

Public read:

- sanitized aggregate only; raw documents should not be public by default.

Owner read:

- reviewer and reviewed participant where appropriate.

Create:

- client/participant only for completed own booking.
- should ideally validate against `booking_requests/{requestId}`.

Update:

- limited owner update before locked, or false.

Delete:

- false.

Forbidden fields:

- aggregate fields
- moderation fields
- fake participant ids

Admin-only fields:

- moderation/publication flags.

### `clinician_profile_change_requests/{requestId}`

Public read:

- none.

Owner read:

- clinician where `clinicianId == uid()`.

Create:

- clinician owner only.
- `status == pending`.

Update:

- admin/server only.

Delete:

- false.

Forbidden fields:

- approval result
- applied flags
- reviewer/admin fields

Admin-only fields:

- `status`
- `reviewedAt`
- `reviewedBy`
- `adminNotes`
- `appliedAt`

### `center_profile_change_requests/{requestId}`

Clean-core does not currently use it in active migrated code, but future design should mirror clinician profile requests.

### `chat_escalations/{escalationId}`

Public read:

- none.

Assigned read:

- assigned clinician/admin/safety operator only.

Create:

- server/safety pipeline only.

Update:

- admin/safety/server only.

Delete:

- false.

Forbidden fields:

- all risk/governance/assignment fields for normal users.

Notes:

- Do not implement broad user create.

## 7. Booking Rules Design

### Client Creates Request

Allow only when:

- signed in.
- `request.resource.data.clientId == uid()`.
- `status` is in an allowed initial set.
- request kind is valid.
- participant ids are strings.
- no admin/payment/session/private fields are present.

Forbidden on create:

- `paymentStatus`
- `payment_confirmed`
- `sessionLink`
- `assignedAdminUid`
- `adminNotes`
- final lifecycle statuses
- review aggregate fields
- risk/safety fields

### Client Reads Own Request

Allow when:

- `resource.data.clientId == uid()`.

### Center Reads Assigned Center Request

Allow when:

- `resource.data.centerId == uid()`.
- center account is approved/active if this is an operational route.

### Clinician Reads Assigned Clinician Request

Allow when:

- `resource.data.clinicianId == uid()`, or compatible migrated fields:
  - `clinicianUid`
  - `assignedClinicianId`
  - `assignedClinicianUid`

### Center Updates Only Center Response Fields

Allowed fields:

- `centerAvailabilityStatus`
- `centerAvailabilityNote`
- `centerAvailabilityRespondedAt`
- `centerAvailabilityRespondedBy`
- narrow residency arrival/discharge fields if explicitly confirmed
- `updatedAt`

Conditions:

- `resource.data.centerId == uid()`.
- cannot change participant ids.
- cannot change payment/admin/session link fields.

### Clinician Updates Only Clinician/Session Fields

Possible allowed fields after review:

- `clinicianResponseStatus`
- `clinicianRespondedAt`
- `clinicianRespondedBy`
- `sessionStatus`
- `sessionScheduledAt`
- `sessionStartedAt`
- `sessionEndedAt`
- `sessionLink` only if product accepts clinician-set links; otherwise Cloud Function/admin only.
- `updatedAt`

Conditions:

- clinician is assigned to request.
- allowed transition from current status.

Recommendation:

- `sessionLink` should be Cloud Function/admin controlled or heavily validated.

### Client Updates Only Confirmation/Review Fields

Allowed fields:

- arrival/session confirmation flags
- client review submitted fields
- client note/comment if not public by default
- `updatedAt`

Forbidden:

- payment verification
- provider review values
- admin status
- lifecycle transitions beyond allowed confirmation.

### Admin/Server Owns Lifecycle/Payment/Assignment Fields

Admin/server-only fields:

- `status`
- `reviewStatus`
- `sessionStatus` final transitions
- `paymentStatus`
- `payment_confirmed`
- `paymentVerifiedAt`
- `paymentVerifiedBy`
- `assignedAdminUid`
- assignment changes
- dispute/accounting fields
- admin notes

## 8. Registration Rules Design

### Center Self-Create Pending Doc

Allow create when:

- signed in.
- `centerId == uid()`.
- `role == center`.
- `approvalStatus == pending_admin`.
- `isActive == false`.
- `active == false` if present.
- `isBlocked != true`.

Allowed create fields:

- identity/profile draft fields
- category/type labels
- contact draft fields
- timestamps

Forbidden create fields:

- admin notes
- verified fields
- approval beyond pending
- public publication flags
- document review result fields

### Center Draft Updates

Allow while:

- owner is signed in.
- document is not approved.
- changed fields are only draft registration fields.

Forbid:

- self-activation.
- self-approval.
- changing role.
- changing blocked state.

### Clinician Self-Create Pending Doc

Allow create when:

- signed in.
- `clinicianId == uid()`.
- `role == clinician`.
- pending approval status.
- `isActive == false`.
- `isBlocked != true`.

Important status decision:

- Source rules expect `pending_review` for clinicians.
- Other app concepts often use `pending_admin`.
- Product must standardize before implementation.

### Clinician Draft Updates

Allow while:

- owner is signed in.
- document is not approved.
- changed fields are profile/session/document draft fields only.

Forbid:

- self-activation.
- self-approval.
- changing rating aggregate.
- changing public verified status.

### Public Reads

Public reads should only show:

- approved.
- active.
- not blocked.
- public-safe fields.

Since Firestore rules cannot redact fields from a document, recommended production architecture is:

- private provider docs:
  - `centers/{uid}`
  - `clinicians/{uid}`
- public profile docs:
  - `publicCenters/{uid}`
  - `publicClinicians/{uid}`

If current schema remains single-doc, ensure no private fields are stored on publicly readable provider documents.

## 9. Public Exposure Design

### Public-Safe Center Fields

Allowed public profile fields:

- `name`
- `displayName`
- `category`
- `categoryLabelAr`
- `categoryLabelEn`
- `centerType`
- `centerTypeLabelAr`
- `centerTypeLabelEn`
- `city`
- `area`
- public `address`
- public `phone`
- public `whatsapp`
- `description`
- public gallery URLs
- public capabilities/services
- public pricing display
- aggregate rating fields
- `sortOrder`

Forbidden public center fields:

- submitted identity/license/tax/commercial document URLs
- admin review notes
- blocked flags/reasons
- private owner email if not intended public
- internal approval history
- payment/accounting fields

### Public-Safe Clinician Fields

Allowed public profile fields:

- display name
- professional title
- specialty labels
- public photo
- public bio
- session modes/pricing display if approved
- aggregate rating fields
- sort order

Forbidden public clinician fields:

- identity/certificate document URLs
- private phone/email unless explicitly public
- admin review notes
- blocked flags/reasons
- session private links
- safety/escalation assignments

### Public-Safe Rating Aggregates

Preferred:

- store aggregate values on public provider profile docs.
- keep raw `sessionRatings` private to participants/admin.

Raw rating fields that should not be public by default:

- reviewer uid
- client id
- free-text comments
- request id
- internal moderation flags

## 10. Cloud Functions Boundary

Operations that should move to Cloud Functions later:

- approve center registration.
- reject center registration.
- approve clinician registration.
- reject clinician registration.
- publish approved center profile.
- publish approved clinician profile.
- apply center profile change request.
- apply clinician profile change request.
- create booking request with normalized lifecycle fields.
- transition booking status.
- center availability response if it changes lifecycle.
- clinician accept/reject request.
- set or validate `sessionLink`.
- verify payment proof.
- create/update chat thread for booking follow-up.
- create admin/system chat messages.
- create AI/safety escalation case.
- write immutable audit logs.
- dispatch notifications.
- update rating aggregates.
- write legal consent receipt hashes/snapshots.

## 11. Rules Implementation Plan

### Batch 1: Deny-by-Default + Helpers

Goal:

- create clean-core rules file with default deny.
- add helper functions.
- decide custom-claims vs Firestore role-doc strategy.

Stop condition:

- no collection is opened broadly.

### Batch 2: Public Centers/Clinicians Reads

Goal:

- allow approved/active/not-blocked public reads.
- preferably introduce public-safe profile design.

Stop condition:

- no private document/media/admin fields exposed.

### Batch 3: Clients/Centers/Clinicians Ownership

Goal:

- allow self-create/self-read.
- allow only safe draft updates.
- protect role/approval/block/admin fields.

Stop condition:

- registration flow works in emulator with pending accounts.

### Batch 4: `booking_requests`

Goal:

- implement participant reads.
- implement client create.
- implement actor-specific narrow updates.

Stop condition:

- client/center/clinician flows work without broad lifecycle writes.

### Batch 5: Chat/Support/Rating/Profile-Change

Goal:

- harden `chat_threads/messages`.
- harden `support_requests`.
- harden `sessionRatings`.
- harden profile change request collections.

Stop condition:

- no user can spoof sender/admin/safety/status fields.

### Batch 6: AI Safety/Legal Collection Placeholders

Goal:

- deny or tightly reserve AI safety/legal collections.
- add `legalConsents` immutable owner-create pattern only if product/legal approves.

Stop condition:

- no AI raw logs/traces exposed.

### Batch 7: Emulator/Rules Tests

Goal:

- add tests for role ownership, forbidden fields, public exposure, booking transitions, and AI/legal placeholders.

Stop condition:

- rules tests pass before closed beta.

## 12. Open Questions for User

1. Should production rules use Firebase custom claims for roles, Firestore role documents, or both?
2. Should `approvalStatus` standardize on `pending_admin`, `pending_review`, or another single value?
3. Should public provider profiles remain in `centers`/`clinicians`, or should clean-core introduce sanitized `publicCenters` and `publicClinicians` later?
4. Can clinicians set their own `sessionLink`, or must links be admin/server-approved?
5. Which payment fields are still in scope before payment proof migration?
6. Should `bookingRequests` legacy fallback remain readable during clean-core QA, or should it be fully denied now?
7. Are center phone/WhatsApp/address intended to be public after approval?
8. Are clinician phone/email ever public?
9. Should raw `sessionRatings` be participant-only with aggregate public values?
10. Who is allowed to create `support_requests` in the final product?
11. Should `chat_threads` remain in clean-core before full chat/AI safety migration?
12. What legal consent records are required before closed beta?
13. What admin bootstrap mechanism will create the first admin safely?
14. What retention/deletion policy applies to registration documents and chat/support records?

## 13. Final Verdict

### Can Be Implemented Now

- deny-by-default rules foundation.
- helper functions.
- strict owner reads for `clients`, `centers`, `clinicians`.
- self-create pending registration rules.
- protection for account/admin/approval/block fields.
- public read for approved/active provider docs only if private fields are not present.
- initial `booking_requests` participant read and narrow create rules.
- deny or minimal compatibility for `bookingRequests`.

### Must Wait for Cloud Functions

- admin approvals and publication.
- booking lifecycle transitions.
- payment verification.
- session link setting if links need verification.
- chat thread/system message creation.
- audit logging.
- notification dispatch.
- rating aggregate updates.

### Must Wait for AI Safety OS

- `aiSafetyEvents`
- `aiEscalationCases`
- `aiSafetyTraces`
- `aiSafetyIncidents`
- `aiSafetySystemAlerts`
- `aiSafetyPolicyRuntimeConfig`
- `aiSafetyPolicySnapshots`
- real crisis/escalation workflow rules.

### Must Wait for Legal/Policy Review

- `legalConsents` final shape.
- retention/deletion policy.
- public display of professional/medical claims.
- user-visible ratings and comments.
- external contact links responsibility.
- AI/chat/safety data access and audit exports.

### Overall Recommendation

Do not copy the source `firestore.rules` blindly. Reuse its deny-by-default structure and many helper concepts, but redesign role helpers, public provider reads, booking updates, chat/safety permissions, and AI/legal placeholders for clean-core.

The safest next implementation phase is Batch 1: create a clean-core deny-by-default rules foundation with helpers and protected field lists, then proceed collection by collection with emulator tests.

