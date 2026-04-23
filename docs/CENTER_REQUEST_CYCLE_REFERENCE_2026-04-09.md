# Center Request Cycle Reference

## Scope

This document records the stabilized center request flow in `mental_smile_app_clean` after the center-cycle cleanup and end-to-end validation.

It is intended as a practical reference for:

- request creation
- admin transitions
- center availability response
- payment handling
- residency setup and start confirmations
- completion, reviews, accounting, and archive

It also captures the main errors that appeared during stabilization and how they were resolved.

## Important Note About Old Requests

One old request remained inconsistent because it was created before the center flow became canonical.

Typical symptoms for old requests:

- missing or inconsistent `requestKind`
- older fields written before the center cycle was normalized
- requests appearing briefly then disappearing in center pages
- confirmation/review actions failing while newer requests succeed

Recommendation:

- do not use this old request as a future reference sample
- remove it from production data through Firestore Console if it continues to cause confusion
- use only fresh requests created after the canonical center flow fixes as the validation baseline

## Canonical Actors

- Client / family
- Center
- Admin

## Canonical Collection

- `booking_requests`

Legacy `bookingRequests` should not be used in current center-cycle screens or writes.

## End-to-End Status Path For Center Requests

1. `pending_admin`
2. `center_follow_up`
3. `awaiting_payment`
4. `payment_review`
5. `session_setup_pending`
6. `session_scheduled`
7. `session_in_progress`
8. `session_completed_pending_reviews`
9. `payout_pending`
10. `completed_success`
11. archived sections

## Functional Flow

### 1. Client Creates Center Request

Page:

- `lib/features/booking/presentation/pages/center_booking_request_page.dart`

Key idea:

- request is created in `booking_requests` with canonical center fields

Important fields:

- `requestKind = center`
- `clientId`
- `centerId`
- `centerName`
- `selectedAccommodationKey`
- admin decision and payment/session/review baseline fields

### 2. Admin Moves Request To Center Follow-Up

Page:

- `lib/features/booking/presentation/pages/admin_booking_queue_page.dart`

Button:

- `Move to follow-up`

Transition:

- `pending_admin -> center_follow_up`

### 3. Center Responds To Availability

Page:

- `lib/features/booking/presentation/pages/center_inbox_page.dart`

Buttons:

- `متاح`
- `غير متاح`

Effect:

- center records availability response
- request remains in center-admin workflow until admin decision

### 4. Admin Approves And Opens Payment

Pages:

- `lib/features/booking/presentation/pages/admin_booking_queue_page.dart`
- `lib/features/admin/presentation/pages/admin_payments_page.dart`

Button:

- `اعتماد وفتح الدفع`

Transition:

- `center_follow_up` or client-revised center path -> `awaiting_payment`

### 5. Client Uploads Payment Proof

Page:

- `lib/features/client/presentation/pages/client_payment_proof_page.dart`

Transition:

- `awaiting_payment -> payment_review`

### 6. Admin Approves Payment

Page:

- `lib/features/admin/presentation/pages/admin_payments_page.dart`

Effect:

- payment approved
- request enters `session_setup_pending`

### 7. Admin Schedules Residency

Page:

- `lib/features/admin/presentation/pages/admin_sessions_page.dart`

Button:

- `تجهيز/جدولة الإقامة`

Transition:

- `session_setup_pending -> session_scheduled`

Saved fields:

- `sessionDateText`
- `sessionLink`
- `sessionCode`
- `sessionAdminNotes`

### 8. Center Confirms Arrival

Page:

- `lib/features/centers/presentation/pages/center_residencies_page.dart`

Button:

- `تأكيد وصول الحالة`

Saved fields:

- `centerArrivalConfirmed`
- `centerArrivalConfirmedAt`
- `centerArrivalConfirmedBy`
- `centerArrivalNotes`
- `centerRoomDeliveredAsBooked`

If family confirmation already exists:

- request moves to `session_in_progress`

### 9. Client / Family Confirms Residency Start

Page:

- `lib/features/client/presentation/pages/client_sessions_page.dart`

Button:

- `تأكيد بداية الإقامة`

Saved fields:

- `clientCheckInConfirmed`
- `clientCheckInConfirmedAt`
- `clientCheckInNotes`
- arrival matching / explanation / reception fields

If center arrival confirmation already exists:

- request moves to `session_in_progress`

### 10. Admin Marks Residency Completed

Page:

- `lib/features/admin/presentation/pages/admin_sessions_page.dart`

Button:

- `تعليم كإقامة مكتملة`

Transition:

- `session_scheduled` or `session_in_progress` -> `session_completed_pending_reviews`

### 11. Reviews

Client page:

- `lib/features/client/presentation/pages/client_sessions_page.dart`

Button:

- `تقييم الإقامة`

Center page:

- `lib/features/centers/presentation/pages/center_residencies_page.dart`

Button:

- `إرسال تقرير الخروج`

Review page:

- `lib/features/reviews/presentation/pages/session_review_page.dart`

Outcomes:

- after first review: `reviewStatus = partial`
- after both reviews: `status = payout_pending`, `reviewStatus = completed`

### 12. Accounting Review

Page:

- `lib/features/admin/presentation/pages/admin_payments_page.dart`

Buttons:

- `مراجعة محاسبية`
- `تم تحويل مستحق المركز`

### 13. Archive

Pages:

- `lib/features/admin/presentation/pages/admin_archive_page.dart`
- archive section pages

Final result:

- operation archived successfully inside its proper archive sections

## Buttons By Stage

### Admin Booking Queue

- `Move to follow-up`
- `اعتماد وفتح الدفع`
- `إرجاع للعميل للتعديل`
- `رفض`

### Admin Payments

- `اعتماد السداد`
- `عرض التقرير`
- `مراجعة محاسبية`
- `تم تحويل مستحق المركز`

### Admin Sessions

- `تجهيز/جدولة الإقامة`
- `تعليم كإقامة جارية`
- `تعليم كإقامة مكتملة`
- `إعادة جدولة`

### Center Inbox

- `متاح`
- `غير متاح`

### Center Residencies

- `تأكيد وصول الحالة`
- `إرسال تقرير الخروج`

### Client Sessions

- `تأكيد بداية الإقامة`
- `تقييم الإقامة`

## Main Problems We Hit And How They Were Fixed

### 1. Duplicate / inconsistent admin identity

Problem:

- more than one admin source or missing active admin state

Fix:

- admin truth source normalized to `admins/{uid}.active == true`
- primary admin fallback added temporarily for known admin UID

### 2. Old screens still read legacy `bookingRequests`

Problem:

- requests appeared briefly then disappeared
- pages hit `permission-denied`

Fix:

- removed legacy reads and writes from critical pages
- standardized on `booking_requests`

Affected areas included:

- my bookings
- payment proof
- admin payments
- reviews
- archive home

### 3. Firestore rules too strict for center transitions

Problem:

- `permission-denied` on:
  - move to follow-up
  - center response
  - admin approve to payment
  - review updates
  - accounting steps

Fix:

- added narrow bridge validators for the exact successful payloads
- moved some checks earlier in `allow update`
- aligned rules with actual payloads rather than idealized older assumptions

### 4. Streams recreated in `build`

Problem:

- unstable UI
- Firestore web assertion issues
- repeated `stream_start`

Fix:

- moved critical streams to `initState` where needed

### 5. Center requests shown as clinician requests

Problem:

- client/admin UI displayed center items with clinician wording

Fix:

- center request display now uses center-aware labels
- archive/report wording unified
- request-type display became more tolerant for older data

### 6. Old center requests missing canonical `requestKind`

Problem:

- request could read or partially move, but fail in confirmations or reviews

Fix:

- introduced tolerant center detection in UI and rules
- center pages and review pages now accept legacy-or-canonical center requests

### 7. Archive home clutter

Problem:

- archived operations appeared under archive sections on the main archive page

Fix:

- archive home converted to section dashboard only
- archived items remain inside dedicated archive sections

## What Is Stable Now

Validated successfully on new center requests:

- create request
- admin follow-up
- center availability
- admin payment opening
- client payment proof
- admin payment approval
- residency setup
- center arrival confirmation
- client start confirmation
- completion
- client review
- center discharge report
- accounting review
- payout confirmation
- archive

## Remaining Technical Debt

- `firestore.rules` still contains warning-heavy helper sections from older stages
- there are still temporary bridge validators that should be consolidated later
- old requests created before canonical center cleanup should not be used as validation samples

## Recommendation Before Starting Clinician Cycle

1. Treat center cycle as operationally complete.
2. Delete or ignore corrupted legacy center requests that predate canonical cleanup.
3. Use only fresh clinician requests to validate the clinician cycle from zero.
4. Later, do a dedicated cleanup pass for `firestore.rules` without changing behavior.
