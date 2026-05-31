# SESSION_REVIEW_WRITE_PATH_AUDIT

هذا التقرير لا يغير Runtime.

هذا التقرير لا يغير Rules.

هذا التقرير لا ينفذ Extraction.

هذا التقرير فقط يحدد مكان المشرط قبل أي جراحة مستقبلية.

المرجعيات الحاكمة:

* `docs/BOOKING_LEGACY_OWNER_DECISIONS.md`
* `docs/SESSION_RATINGS_DECOUPLING_AUDIT.md`
* `docs/SESSION_REVIEW_RUNTIME_AUDIT.md`

القرار النهائي:

```text
Reviews & Ratings
=
Trust & Transparency Domain
```

وليس:

```text
Booking Lifecycle
```

---

# 1. Executive Summary

`SessionReviewPage` هي نقطة كتابة حساسة جدًا لأنها غالبًا لا تكتب review فقط، بل تربط review creation بحالة legacy request داخل `booking_requests`.

الغرض من هذا التقرير هو تحديد write path المتوقع والمخاطر المحيطة به قبل أي decoupling لاحق.

الحكم المختصر:

```text
SessionReviewPage
=
Primary Trust/Booking Coupling Node
```

الصفحة تنتج Trust data في `sessionRatings`، لكنها تعتمد على:

* `requestId`
* قراءة legacy request
* منع duplicate reviews
* تحديث review/session completion state
* admin/report/archive readiness

لا يتم تنفيذ أي فصل الآن.

---

# 2. Write Entry Inventory

## Main write actions

| function / action | trigger | actor | purpose | risk |
|---|---|---|---|---|
| submit review action | user presses submit / submit and close | client / clinician / center | create rating/review record | Critical |
| load and validate request before submit | page submit path before write | client / clinician / center | ensure request exists and actor can review | High |
| write `sessionRatings` record | submit flow | authenticated reviewer | persist trust review | Critical |
| update legacy request review state | after/around rating write | authenticated reviewer or allowed owner | mark request/session review progress | Critical |
| close completion state | submit flow after enough reviews | client / clinician / center | move legacy flow toward completed/closed | High |
| UI success handling | after write | current actor | show success / pop / refresh previous screen | Medium |

## Entry verdict

The write path starts in UI submit action and should be treated as one logical operation:

```text
create trust review
+
sync legacy request lifecycle
```

This dual purpose is the coupling risk.

---

# 3. Exact Firestore Write Map

هذا التقرير لا يشغل commands ولا يفتح runtime code الآن. الخريطة التالية مبنية على الجرد السابق ووثائق audit السابقة، ويجب تأكيدها لاحقًا في code-level review قبل أي تنفيذ.

## Direct / inferred writes

| file | function / flow | collection | document path | fields written |
|---|---|---|---|---|
| `lib/features/reviews/presentation/pages/session_review_page.dart` | submit review flow | `sessionRatings` | likely auto doc or rating doc | `requestId`, `reviewerUid`, `reviewerType`, rating fields, comment fields, provider reference fields, timestamps |
| `lib/features/reviews/presentation/pages/session_review_page.dart` | submit review flow | `booking_requests` | `booking_requests/{requestId}` | `reviewStatus`, `sessionStatus`, `status`, `finalReviewPercentage`, reviewer completion flags, `updatedAt` |
| `lib/features/reviews/presentation/pages/session_review_page.dart` | legacy compatibility if present | `bookingRequests` | `bookingRequests/{requestId}` | unknown / should be treated as legacy-only and not expanded |
| downstream reports | indirect after reads | reports/archive projections | no direct confirmed write | none confirmed |
| analytics | indirect aggregate | analytics summaries | no direct confirmed page write | none confirmed |

## Write method classification

Potential methods to verify later:

* `set()`
* `add()`
* `update()`
* possibly sequential writes

No transaction/batch guarantee is confirmed by this report.

---

# 4. sessionRatings Write Audit

## Expected field map

| field name | source value | validation source | purpose |
|---|---|---|---|
| `requestId` | route args / widget parameter | Firestore rules require string | legacy source reference |
| `reviewerUid` | `FirebaseAuth.instance.currentUser.uid` | rules require equals `uid()` | ownership and anti-spoofing |
| `reviewerType` | route/context actor type | rules enum: client/clinician/center | review role identity |
| `rating` / stars value | UI rating input | UI validation | trust score |
| `comment` / review text | UI text input | UI validation/moderation later | transparency content |
| `clinicianId` | request data or route context | request lookup | provider association |
| `centerId` | request data if center flow | request lookup | center association |
| `clientId` | request data/current user context | auth/request ownership | reviewer/client relation |
| `createdAt` | server timestamp or local timestamp | app write policy | audit |
| `updatedAt` | server timestamp if update | app write policy | audit |
| display names | request/provider/user data | request/profile lookup | UI denormalization |

## Trust interpretation

The `sessionRatings` write is conceptually a Trust write.

The dangerous field is not the rating itself.

The dangerous field is:

```text
requestId
```

because it makes Trust data depend on legacy booking identity.

---

# 5. booking_requests Mutation Audit

## Does review creation mutate `booking_requests`?

Based on previous audits: yes, or at minimum it is strongly inferred.

The review flow likely updates request-level review/session completion state.

## Mutation fields

| field | old state | new state | reason | risk |
|---|---|---|---|---|
| `reviewStatus` | `not_started` / `pending_reviews` | `pending_reviews` / `completed` | track review progress | Critical |
| `sessionStatus` | `session_completed_pending_reviews` or active completion state | completed/closed equivalent | move legacy session lifecycle forward | Critical |
| `status` | `session_completed_pending_reviews` | `completed_success` or final state | close legacy request | Critical |
| `finalReviewPercentage` | `0` / partial | partial / `100` | reporting and archive readiness | High |
| reviewer completion flags | false/missing | true | prevent duplicate role review and calculate completion | High |
| `updatedAt` | previous timestamp | new timestamp | audit update | Low |

## Mutation verdict

`booking_requests` mutations are the primary reason `SessionReviewPage` cannot be cleanly moved to Trust Domain immediately.

---

# 6. Status Transition Matrix

| field | from | to | trigger |
|---|---|---|---|
| `reviewStatus` | `not_started` | `pending_reviews` | first review submitted or review flow begins |
| `reviewStatus` | `pending_reviews` | `completed` | all required reviewer roles complete |
| `sessionStatus` | `session_completed_pending_reviews` | completed/final equivalent | review requirements completed |
| `status` | `session_completed_pending_reviews` | `completed_success` or final equivalent | review closure reaches completion |
| `finalReviewPercentage` | `0` | partial percentage | one actor submits review |
| `finalReviewPercentage` | partial percentage | `100` | all expected reviews submitted |
| reviewer flag | false/missing | true | actor submits review |
| `updatedAt` | old timestamp | current timestamp | any review-related request update |

## Matrix warning

The exact status values must be confirmed in a code-level read before implementation.

This report must not be used as permission to change status strings.

---

# 7. Batch / Transaction Analysis

## Current known pattern

Not confirmed as transaction-based.

Likely pattern:

```text
mixed or sequential single writes
```

Possible flows:

```text
write sessionRatings
↓
update booking_requests
```

or:

```text
read request
↓
write sessionRatings
↓
update request status fields
```

## Transaction risk

If no transaction/batch exists:

* rating can be created while request status fails to update.
* request can be updated while rating write fails.
* duplicate prevention can be race-prone.

## Required future verification

Before any extraction:

* confirm if writes are sequential, batched, or transactional.
* confirm failure order.
* confirm duplicate prevention before/after write.

No code change is recommended here.

---

# 8. Failure Behavior Audit

## Scenario A

```text
sessionRatings write succeeds
booking_requests update fails
```

Impact:

* Trust review exists.
* Legacy request still appears pending review.
* User may retry and create duplicate unless duplicate prevention catches it.
* Admin reports may show mismatch.

Risk:

```text
Critical
```

## Scenario B

```text
booking_requests update succeeds
sessionRatings write fails
```

Impact:

* Legacy request may show review completed.
* Actual trust review missing.
* Provider profile rating does not update.
* Audit trail inconsistent.

Risk:

```text
Critical
```

## Scenario C

```text
read request succeeds
duplicate check stale
two users/actions submit close together
```

Impact:

* duplicate rating risk.
* completion percentage may be wrong.
* final status may be reached early or late.

Risk:

```text
High
```

## Rollback behavior

No rollback behavior is confirmed.

If writes are not transactional, rollback is likely manual or absent.

## Retry behavior

No reliable retry behavior is confirmed.

User retry may create inconsistency if idempotency is not enforced by document ID or query.

---

# 9. Duplicate Prevention Audit

Potential duplicate prevention layers:

| layer | likely role | strength | risk |
|---|---|---|---|
| UI validation | disables/blocks submit if already reviewed | Medium | bypass possible |
| query by `requestId` + reviewer | checks existing review | Medium/High | race condition possible |
| request status flag | uses `reviewStatus` / reviewer flags | Medium | coupled to booking lifecycle |
| Firestore rules | validates identity, not necessarily uniqueness | Low for uniqueness | rules cannot easily enforce query uniqueness |
| deterministic doc ID | unknown | High if used | must be verified |

## Duplicate prevention verdict

The strongest safe future model would use deterministic review identity, but this report does not propose implementation.

Current model appears dependent on:

```text
requestId
+ reviewerUid
+ reviewerType
+ legacy request flags
```

---

# 10. Runtime Dependency Matrix

```text
SessionReviewPage
↓
sessionRatings
Strength: Critical
Reason: primary trust review write
```

```text
SessionReviewPage
↓
booking_requests
Strength: Critical
Reason: request lookup, review lifecycle status, completion state
```

```text
SessionReviewPage
↓
reports
Strength: Medium/High
Reason: review completion and rating data feed archive/admin reports
```

```text
SessionReviewPage
↓
archive
Strength: Medium
Reason: final states and review percentages affect archive readiness
```

```text
SessionReviewPage
↓
provider profiles
Strength: Medium/High
Reason: ratings surface as public trust signals
```

```text
SessionReviewPage
↓
analytics
Strength: Medium
Reason: ratings may feed aggregate trust/report metrics
```

---

# 11. Extraction Break Points

| break point | risk | why |
|---|---|---|
| removing `requestId` from `sessionRatings` | Critical | rules and lookup depend on it |
| stopping `booking_requests` status update | Critical | legacy UI may never close request/review flow |
| moving rating writes to new Trust collection | Critical | existing consumers read `sessionRatings` |
| changing reviewer identity fields | High | rules depend on `reviewerUid` and `reviewerType` |
| changing status strings | High | client/provider/admin pages may filter by them |
| separating archive/report before projections exist | High | admin reports may lose review completion data |
| changing duplicate prevention logic | High | duplicate reviews or blocked legitimate reviews |
| changing profile display queries | Medium/High | public trust display may break |
| changing analytics consumers | Medium | aggregate summaries may drift |

---

# 12. Trust Separation Readiness

If future goal is:

```text
sessionRatings
→ Trust Domain
```

First 5 dependencies to decouple:

## 1. Trust identity from legacy request identity

Current:

```text
requestId required
```

Future:

```text
sourceReference optional
providerId required
```

No implementation now.

## 2. Review write from request lifecycle update

Current:

```text
write rating
+ update booking request
```

Future:

```text
write trust review
emit/provide projection for legacy closure
```

No implementation now.

## 3. Duplicate prevention from booking flags

Current:

```text
request flags + query checks
```

Future:

```text
trust-owned uniqueness strategy
```

No implementation now.

## 4. Admin reports from booking review fields

Current:

```text
booking_requests.reviewStatus/finalReviewPercentage
```

Future:

```text
trust summaries/projections
```

No implementation now.

## 5. Profile display from session-style ratings

Current:

```text
sessionRatings tied to session/request
```

Future:

```text
provider_reviews/provider_ratings
```

No implementation now.

---

# 13. What Must Not Be Done

ممنوع الآن:

* تعديل `SessionReviewPage`
* تعديل writes
* تعديل rules
* تعديل `requestId`
* تعديل `booking_requests`
* تعديل statuses
* إنشاء collections جديدة
* migration
* extraction
* تغيير duplicate prevention
* تغيير profile rating queries
* تغيير admin report consumers
* تغيير analytics
* حذف `sessionRatings`
* تغيير route `/session/review`

قبل أي خطوة مستقبلية يجب تنفيذ audit أدق على الكود نفسه يثبت:

* exact function names
* exact write order
* exact fields
* exact duplicate checks
* exact failure behavior
* whether batch/transaction exists

---

# 14. Final Verdict

هل `SessionReviewPage` هي:

```text
Primary Trust/Booking Coupling Node
```

نعم.

السبب:

* تكتب Trust data في `sessionRatings`.
* تعتمد على legacy `requestId`.
* تقرأ من `booking_requests`.
* غالبًا تعدل `booking_requests`.
* تؤثر على report/archive readiness.
* تمثل نقطة انتقال user action من session/booking إلى trust/review.

أول عملية Extraction آمنة بعد اكتمال هذا audit ليست نقل البيانات.

أول عملية آمنة يجب أن تكون:

```text
Exact Code-Level Write Verification
```

ثم:

```text
Trust Projection Design
```

ثم:

```text
Rules Design
```

ثم فقط بعد ذلك يمكن التفكير في extraction.

هذا التقرير لا يغير Runtime.

هذا التقرير لا يغير Rules.

هذا التقرير لا ينفذ Extraction.

هذا التقرير فقط يحدد مكان المشرط قبل أي جراحة مستقبلية.
