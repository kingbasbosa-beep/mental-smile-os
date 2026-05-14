# Firestore Rules Batch 3 Notes

Date: 2026-05-14  
Target: Mental Smile `clean_core`  
Batch: Provider registration ownership rules

## What Writes Were Opened

Batch 3 opens only provider registration ownership writes:

- center self-create pending registration document
- clinician self-create pending registration document
- limited center owner draft updates while pending
- limited clinician owner draft updates while pending

No booking, chat, support, rating, AI safety, legal consent, payment, profile-change, or admin approval access was opened.

## Pending Status Values Supported

The rules support the pending values currently written by migrated clean-core web registration pages:

- centers: `pending_admin`
- clinicians: `pending_review`

No other pending status values were opened in this batch.

## Center Create Rule

Allowed only for:

- signed-in owner
- document id equals `request.auth.uid`
- `role == "center"`
- `approvalStatus == "pending_admin"`
- `isActive == false`
- `active` absent or `false`
- `isBlocked` absent or not `true`
- `isAdmin` absent or not `true`
- `verified` absent or not `true`
- top-level fields limited to the center registration create allowlist

## Clinician Create Rule

Allowed only for:

- signed-in owner
- document id equals `request.auth.uid`
- `role == "clinician"`
- `approvalStatus == "pending_review"`
- `isActive == false`
- `active` absent or `false`
- `isBlocked` absent or not `true`
- `isAdmin` absent or not `true`
- `verified` absent or not `true`
- top-level fields limited to the clinician registration create allowlist

## Safe Draft Fields Allowed

Center pending owner updates allow only registration draft fields, including:

- manager/contact fields
- phone/WhatsApp/country code
- city/area/address
- description
- detox flag
- gallery/media draft fields
- pricing/capability draft fields
- document item metadata and file URLs used by current web registration
- step completion flags currently used by clean-core registration:
  - `imagesReady`
  - `pricingReady`
  - `documentsReady`
- `updatedAt`

Clinician pending owner updates allow only registration draft fields, including:

- photo/bio
- session price/duration/modes
- group session flag
- document submitted metadata and file URLs used by current web registration
- step completion flag currently used by clean-core registration:
  - `documentsSubmitted`
- `updatedAt`

## Protected Fields Denied

Owner updates are denied for:

- `role`
- `isAdmin`
- `approvalStatus`
- `isActive`
- `active`
- `isBlocked`
- `blockReason`
- `blockedAt`
- `blockedBy`
- `verified`
- `verifiedAt`
- `verifiedBy`
- approval/rejection/admin fields
- payment fields
- session link fields
- safety/risk fields
- AI governance fields

Important implementation note:

- Current center and clinician final document pages write `approvalStatus` and `isActive` again with the same pending/inactive values.
- Batch 3 intentionally denies owner updates to those protected fields, per the security requirement.
- The app may need a later safe code adjustment or a narrowly designed rules exception if that redundant write must remain.

## What Remains Denied

Still denied:

- `clients`
- `admins`
- `booking_requests`
- `bookingRequests`
- `chat_threads`
- `chat_threads/{threadId}/messages`
- `support_requests`
- `sessionRatings`
- `clinician_profile_change_requests`
- `center_profile_change_requests`
- `chat_escalations`
- all AI Safety collections
- `legalConsents`
- provider deletes
- provider owner updates after approval
- admin approval writes

## Risks / Deferred Decisions

- Public reads still expose the whole approved provider document. Future `publicCenters` / `publicClinicians` split remains recommended.
- Owner draft document/file URL fields are allowed while pending because current web registration writes them directly.
- Document review/approval fields remain protected for future admin review.
- Admin approval and publication are not implemented in rules yet.
- Custom claims vs Firestore document role strategy remains a larger architecture decision.

## Next Recommended Batch 4

Batch 4 should implement `booking_requests` rules:

- client creates own request with safe initial fields
- client reads own requests
- center reads assigned center requests
- clinician reads assigned clinician requests
- center updates only center response fields
- clinician updates only clinician/session fields
- client updates only confirmation/review fields
- admin/server owns lifecycle/payment/assignment fields

Batch 4 should still avoid opening full chat, payment proof, support, AI safety, legal consent, and admin approval flows.

