# Firestore Rules Batch 2 Notes

Date: 2026-05-14  
Target: Mental Smile `clean_core`  
Batch: Safe public provider reads only

## What Was Opened

Batch 2 opens limited read access for provider profile documents:

- `centers/{centerId}`
- `clinicians/{clinicianId}`

Public reads are allowed only when the document itself satisfies:

- `approvalStatus == "approved"`
- `isActive == true`
- `isBlocked != true`

Owner reads were also opened:

- a signed-in center owner can `get` `centers/{uid}`
- a signed-in clinician owner can `get` `clinicians/{uid}`

## What Remains Denied

All provider writes remain denied in this batch:

- center create
- center update
- center delete
- clinician create
- clinician update
- clinician delete

The following remain explicitly denied:

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
- `aiSafetyEvents`
- `aiEscalationCases`
- `aiSafetyTraces`
- `aiSafetyIncidents`
- `aiSafetySystemAlerts`
- `aiSafetyPolicyRuntimeConfig`
- `aiSafetyPolicySnapshots`
- `legalConsents`
- final catch-all

No booking, chat, payment, support, rating, AI safety, legal consent, profile-change, or registration write access was opened.

## Public Exposure Risks

Firestore rules cannot redact individual fields from a document. If a document is readable, the whole document is readable.

Before production, approved provider documents must not contain private fields such as:

- identity document URLs
- license/certificate document URLs
- admin notes
- blocked reasons
- internal review fields
- private verification metadata
- safety/risk fields
- payment/accounting fields
- private session links
- private contact information not intended for public display

Current migrated clean-core usage still references fields such as document readiness, document URLs, admin notes in session contexts, payment flags, and session links in operational pages. These do not automatically become public through Batch 2 unless they are stored on approved public provider docs, but the data model should be reviewed carefully.

## Recommended Public Profile Split

For production, prefer sanitized public profile collections:

- `publicCenters/{centerId}`
- `publicClinicians/{clinicianId}`

Admin or Cloud Functions should publish only approved public-safe fields into those collections.

Suggested public center fields:

- name/display name
- category/type labels
- city/area/public address
- public phone/WhatsApp if approved
- public description
- public gallery
- public services/capabilities
- public pricing display
- aggregate ratings
- sort order

Suggested public clinician fields:

- display name
- professional title
- specialty labels
- public bio
- public photo
- approved session mode/price display
- aggregate ratings
- sort order

## Next Recommended Batch 3

Batch 3 should implement owner registration and ownership rules:

- center self-create pending doc
- clinician self-create pending doc
- limited draft updates while pending
- forbid self-approval/self-activation
- protect `role`, `approvalStatus`, `isActive`, `isBlocked`, `verified`, document review fields, admin notes, and payment/session/safety fields

Batch 3 should not open booking, chat, payment, AI safety, or legal consent access.

