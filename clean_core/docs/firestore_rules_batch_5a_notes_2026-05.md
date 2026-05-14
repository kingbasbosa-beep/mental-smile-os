# Firestore Rules Batch 5A Notes

Date: 2026-05-14  
Target: Mental Smile `clean_core`  
Batch: Profile change requests and support requests

## Rules Opened

Batch 5A opens conservative ownership rules for:

- `clinician_profile_change_requests`
- `center_profile_change_requests`
- `support_requests`

No chat, payment, AI safety, legal consent, session rating, admin approval, or lifecycle orchestration rules were opened.

## Profile Change Requests

### Clinician Profile Change Requests

Reads are allowed for:

- admin helper
- owner clinician where `resource.data.clinicianId == request.auth.uid`

Creates are allowed only when:

- signed in
- `request.resource.data.clinicianId == request.auth.uid`
- `status == "pending"`
- top-level fields are limited to:
  - `clinicianId`
  - `clinicianName`
  - `clinicianEmail`
  - `requestType`
  - `currentBio`
  - `requestedBio`
  - `currentPhotoUrl`
  - `requestedPhotoUrl`
  - `status`
  - `createdAt`
  - `updatedAt`
- no protected review/admin/moderation/payment/safety fields are present

Owner updates are denied after create.

Deletes are denied.

### Center Profile Change Requests

Prepared with the same ownership pattern:

- owner center read where `resource.data.centerId == request.auth.uid`
- owner center create only with `centerId == request.auth.uid`
- `status == "pending"`
- safe request payload fields only
- no owner update/delete

## Support Requests

Reads are allowed for:

- admin helper
- owner where `resource.data.createdByUid == request.auth.uid`

Creates are allowed only when:

- signed in
- `createdByUid == request.auth.uid`
- `status == "new"`
- top-level fields are limited to safe request payload fields
- no assignment/admin/escalation/payment/safety fields are present

Owner updates are allowed only for safe follow-up fields:

- `followUpNote`
- `ownerFollowUpNote`
- `lastOwnerMessage`
- attachment metadata fields
- `updatedAt`

Deletes are denied.

## Protected Fields Denied

Profile change request protected fields:

- `reviewedBy`
- `reviewedAt`
- `reviewerUid`
- `adminNotes`
- `adminNote`
- `adminDecision`
- approval/rejection/application fields
- moderation fields
- payment fields
- safety/risk fields

Support request protected fields:

- `status` on owner update
- assignment fields
- escalation fields
- reviewer/admin fields
- internal notes
- resolution fields
- payment fields
- safety/risk fields
- lifecycle fields

## App-Code Conflicts Noticed

`clinician_operations_page.dart` currently creates clinician profile change requests with:

- `adminDecision: ""`
- `adminNote: ""`

Batch 5A intentionally denies these fields from user-created profile change requests. They should be removed from client-created payloads later or initialized by an admin/server function.

No active clean-core support request creation page was found in the migrated client/clinician pages; current migrated pages mainly read support request counts and route to a placeholder support issue selector.

## What Remains Denied

Still denied:

- `chat_threads`
- `chat_threads/{threadId}/messages`
- `sessionRatings`
- `bookingRequests` legacy fallback
- `chat_escalations`
- all AI Safety collections
- `legalConsents`
- payment proof flows
- broad admin writes
- lifecycle orchestration
- owner profile-change updates after create

## Risks / Deferred Items

- Admin moderation for profile changes is not opened yet.
- Support assignment/escalation/resolution is not opened yet.
- Audit logging and notification dispatch remain Cloud Function candidates.
- AI safety integration for support/escalation remains deferred.

## Next Recommended Batch 5B

Batch 5B should handle `sessionRatings` conservatively:

- participant-only create/read
- no public raw rating docs by default
- protect reviewer identity and free-text comments
- recommend aggregate rating publication through server/admin pipeline

Do not open chat, AI safety, legal consent, payment, or admin approval in Batch 5B.

