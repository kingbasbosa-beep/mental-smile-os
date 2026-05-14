# Firestore Rules Batch 5B Notes

Date: 2026-05-14  
Target: Mental Smile `clean_core`  
Batch: Conservative `sessionRatings` rules

## Current Usage Found

Clean-core currently references `sessionRatings` in:

- `lib/features/client/presentation/pages/client_dashboard_page.dart`
  - Reads raw `sessionRatings` where `clientId == currentUser.uid` and `reviewerType == "clinician"`.
  - Uses `derivedStars` and `percentageScore` to show ratings about the client.
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
  - Reads raw `sessionRatings` where `clinicianId == currentUser.uid` and `reviewerType == "client"`.
  - Uses `derivedStars` and `percentageScore` for the clinician operations ratings summary.
- `lib/features/specialists/presentation/specialist_details_page.dart`
  - Public specialist details reads raw `sessionRatings` where `clinicianId == specialistId` and `reviewerType == "client"`.
  - This is a public raw-rating exposure conflict. Batch 5B intentionally does not open public raw reads.

Routes still reference `Routes.sessionReview`, but the clean-core route currently behaves as a placeholder/deferred route. No migrated page that creates `sessionRatings` directly was found in this batch inspection.

## Read Rules Opened

Raw `sessionRatings` reads are now allowed only for:

- admin helper
- rating reviewer/owner where one of these fields matches `request.auth.uid`:
  - `reviewerUid`
  - `reviewerId`
  - `uid`
  - `clientId`
- reviewed provider where one of these fields matches `request.auth.uid`:
  - `clinicianId`
  - `centerId`

No public raw reads are allowed.

## Create Rules Opened

Creates are allowed only when:

- user is signed in
- reviewer/creator identity matches `request.auth.uid`
- document includes a linked booking identifier:
  - `bookingRequestId`, or
  - `requestId`
- document contains a bounded rating value:
  - `rating`, `stars`, or `derivedStars` from 1 to 5
  - `score`, `percentageScore`, or `totalScore` from 0 to 100
- top-level fields are limited to the safe allowlist:
  - `bookingRequestId`
  - `requestId`
  - `clientId`
  - `reviewerId`
  - `reviewerUid`
  - `uid`
  - `reviewerType`
  - `clinicianId`
  - `centerId`
  - `rating`
  - `score`
  - `stars`
  - `derivedStars`
  - `percentageScore`
  - `totalScore`
  - `comment`
  - `createdAt`
  - `updatedAt`

## Update / Delete Posture

Updates are denied after create.

Deletes are denied.

This is intentional until moderation, edit windows, duplicate-review handling, and Cloud Function aggregation are designed.

## Public Raw Rating Exposure Decision

Public raw `sessionRatings` reads remain denied.

The current public specialist details page may fall back to profile aggregate fields when raw rating reads fail. This is the preferred temporary behavior. Public specialist/center pages should not depend on raw review documents.

## Aggregate Strategy

Aggregate ratings should be calculated and published by a trusted backend/admin pipeline later.

Recommended future targets:

- sanitized aggregate fields on approved provider documents, or
- dedicated public-safe documents such as `publicClinicians` / `publicCenters`

Client/provider users must not update:

- `aggregateTotal`
- `aggregateCount`
- `averageRating`
- `ratingCount`
- public aggregate fields
- moderation/approval fields

## Conflicts Noticed

- `specialist_details_page.dart` currently attempts to stream raw `sessionRatings` publicly. Batch 5B intentionally denies this for unauthenticated/non-participant users.
- Future `sessionReview` implementation must write documents that match the conservative create contract:
  - reviewer identity equals auth uid
  - booking request id is present
  - rating value is within range
  - no aggregate/admin/moderation/payment/safety fields

## What Remains Denied

Still denied:

- `chat_threads`
- `chat_threads/{threadId}/messages`
- `bookingRequests` legacy fallback
- payment proof flows
- broad admin writes
- lifecycle orchestration
- AI Safety collections
- `legalConsents`
- raw public rating reads
- rating updates/deletes

## Next Recommended Batch 5C

Batch 5C should be a conservative chat/support boundary review before opening any chat rules:

- confirm which chat thread fields are active in clean-core
- decide whether chat remains fully denied until AI Safety OS
- if opened, use participant-only reads and narrow message creates
- keep risk/safety/escalation fields server/admin-only
- preserve AI/legal/crisis deferral

