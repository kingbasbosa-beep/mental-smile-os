# SESSION_REVIEW_RUNTIME_AUDIT

هذا التقرير لا يغير Runtime.

هذا التقرير لا يغير Rules.

هذا التقرير لا ينفذ Extraction.

هذا التقرير فقط يفهم `SessionReviewPage` قبل أي خطوة مستقبلية.

المرجعيات الحاكمة:

* `docs/BOOKING_LEGACY_OWNER_DECISIONS.md`
* `docs/BOOKING_LEGACY_EXTRACTION_DECISION_PLAN.md`
* `docs/SESSION_RATINGS_DECOUPLING_AUDIT.md`

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

`SessionReviewPage` هي غالبًا أهم نقطة تشابك Runtime بين:

* Trust & Transparency
* Legacy Booking
* Session/coordination lifecycle
* Archive/report readiness

الصفحة تنشئ أو تدير review/rating trust data، لكنها مرتبطة بوضوح بـ legacy request lifecycle من خلال `requestId` وقراءة/تحديث `booking_requests`.

الحكم المختصر:

```text
SessionReviewPage
=
Hybrid Runtime Workflow
```

طبيعتها المعمارية المستهدفة:

```text
Trust Workflow
```

لكن واقعها الحالي:

```text
Trust write
+ Booking request read
+ Booking/session status mutation
+ Archive/report dependency
```

لا يتم تعديلها الآن.

---

# 2. Page Inventory

## File path

```text
lib/features/reviews/presentation/pages/session_review_page.dart
```

## Route(s)

Known route:

```text
/session/review
```

Route constant:

```text
Routes.sessionReview
```

## Constructor parameters

Inferred constructor inputs:

* `requestId`
* reviewer context, likely from route arguments
* actor/reviewer type context, likely client/clinician/center
* optional source/context fields depending entry point

## Runtime dependencies

Known/inferred dependencies:

* Firebase Auth
* FirebaseFirestore
* `booking_requests`
* `sessionRatings`
* possibly `bookingRequests` fallback awareness
* localization
* route arguments
* request/session status fields

## Providers/services المستخدمة

No separate service is confirmed as the main writer from prior inventory.

The page appears page-driven and likely writes directly through:

```text
FirebaseFirestore.instance
```

This increases coupling because UI, validation, Firestore write, and legacy status mutation live close together.

---

# 3. Entry Point Analysis

## Known / inferred entry points

| actor | source file | route | trigger | notes |
|---|---|---|---|---|
| client | `lib/features/booking/presentation/pages/my_bookings_page.dart` | `/session/review` | completed/action-needed legacy request opens review | likely strongest client entry |
| client | `lib/features/client/presentation/pages/client_sessions_page.dart` | `/session/review` | session/coordination item asks for review | inferred from route purpose |
| clinician | `lib/features/clinician/presentation/pages/clinician_sessions_page.dart` | `/session/review` | provider review/closure flow | inferred provider-side review |
| center | `lib/features/centers/presentation/pages/center_residencies_page.dart` | `/session/review` | center service activity/residency completion review | known prior inventory entry |
| admin | admin session/report pages | `/session/review` or report view | admin sees review status but should not own review | likely read/report, not primary producer |
| archive/report | `admin_archive_reports_page.dart` and archive pages | archive routes, not direct review creation | review data consumed in reports | consumer, not producer |

## Entry point verdict

The main entry points originate from legacy booking/session completion screens.

That means Trust data creation is still triggered from Booking/Session UI.

---

# 4. Review Lifecycle

Current inferred lifecycle:

```text
User
↓
Open Review
↓
Route receives requestId / context
↓
Read legacy request from booking_requests
↓
Validate actor and review eligibility
↓
Collect rating/comment input
↓
Create or update sessionRatings
↓
Update legacy request review/session fields
↓
Maybe close completion state
↓
UI shows success / returns / updates
```

## Detailed lifecycle

### 1. User

Actor may be:

* client
* clinician
* center

### 2. Open Review

Opened through:

* old request history
* session/coordination list
* center activity/residency record

### 3. Validation

Likely validation dimensions:

* request exists
* user authenticated
* reviewer identity matches actor
* review not already completed or allowed to update
* request status allows review

### 4. Firestore Writes

At minimum:

```text
sessionRatings
```

Likely also:

```text
booking_requests
```

### 5. Status Updates

Potential updates:

* `reviewStatus`
* `sessionStatus`
* `status`
* `finalReviewPercentage`
* reviewer-specific completion flags

### 6. UI Updates

After write:

* success message
* pop/return
* changed item state in previous list
* updated archive/report readiness later

---

# 5. Firestore Write Analysis

## Write target: `sessionRatings`

Purpose:

Create Trust/Transparency review record.

Expected fields:

| field | purpose |
|---|---|
| `requestId` | legacy bridge to booking request |
| `reviewerUid` | ownership and rules validation |
| `reviewerType` | client/clinician/center review context |
| `rating` / score fields | rating value |
| `comment` / text fields | review text |
| provider reference fields | clinician/center association |
| `createdAt` / `updatedAt` | audit timing |

## Write target: `booking_requests`

Purpose:

Keep legacy request/session lifecycle in sync with review completion.

Potential fields:

| field | purpose |
|---|---|
| `reviewStatus` | legacy review state |
| `finalReviewPercentage` | completion/report signal |
| `sessionStatus` | may move toward completed state |
| `status` | may move to completed success / pending reviews |
| reviewer completion flags | track who reviewed |
| `updatedAt` | legacy update timing |

## Write target: `bookingRequests`

Status:

Unknown/direct write not confirmed for current review flow.

Risk:

If fallback exists, it should be treated as legacy-only and not expanded.

## Write target: analytics / reports / summaries

No direct write confirmed.

Likely indirect consumers:

* admin reports
* archive reports
* analytics summaries

## Write target: audit collections

No dedicated review audit collection confirmed.

Future Trust model may need one, but no implementation is proposed here.

---

# 6. Firestore Read Analysis

## Reads from `booking_requests`

Purpose:

* locate request by `requestId`
* verify request exists
* read provider/client/center context
* determine status/review eligibility
* calculate completion state

Strength:

```text
Critical
```

## Reads from `sessionRatings`

Purpose:

* detect existing rating
* prevent duplicate review
* show current review state
* build completion percentage

Strength:

```text
High
```

## Reads from `clinicians`

Purpose:

* provider display context
* public profile aggregation elsewhere

Strength:

```text
Medium
```

## Reads from `centers`

Purpose:

* center review context where center service activity is involved

Strength:

```text
Medium
```

## Reads from `clients`

Purpose:

* reviewer/client identity display or ownership validation may rely on auth/doc context

Strength:

```text
Low/Medium
```

## Reads from analytics

No direct read confirmed for the page.

Strength:

```text
Low / Unknown
```

---

# 7. Status Mutation Analysis

Known/inferred possible mutations:

| field | old value | new value | reason | risk |
|---|---|---|---|---|
| `reviewStatus` | `not_started` / `pending_reviews` | `pending_reviews` / `completed` | track review completion | High |
| `sessionStatus` | `session_completed_pending_reviews` or equivalent | completed/final state | close session/coordination lifecycle | High |
| `status` | `session_completed_pending_reviews` | `completed_success` or closed state | finish legacy request lifecycle | High |
| `finalReviewPercentage` | 0 / partial | partial or 100 | admin/archive/report signal | Medium/High |
| reviewer-specific flags | false/missing | true | prevent duplicate review and track actors | Medium |
| `updatedAt` | previous timestamp | server timestamp | audit update | Low |
| archive fields | maybe false/missing | possibly unchanged or set later | archive readiness, not necessarily page-owned | Unknown |

## Status mutation verdict

The risky part is not writing the rating itself.

The risky part is that review creation may also mutate booking/session lifecycle fields.

This is the main decoupling obstacle.

---

# 8. Coupling Analysis

Approximate current coupling:

```text
Trust & Transparency: 50%
Booking / Legacy Request: 30%
Archive / Reports: 10%
Analytics: 5%
Support: 5%
```

## Explanation

### Trust 50%

The core data being created is a rating/review, which is a trust signal.

### Booking 30%

The page depends on `requestId`, reads `booking_requests`, and likely updates request/session lifecycle fields.

### Archive 10%

Review completion affects admin archive/report readiness and final review percentages.

### Analytics 5%

Ratings can feed aggregates and summaries, but page-level direct analytics is not the dominant dependency.

### Support 5%

Complaints/support may later relate to review visibility, but `SessionReviewPage` is not primarily support-owned.

---

# 9. Rules Dependency Analysis

لا يتم تعديل rules.

## Rules used during review creation

Likely main rule:

```text
match /sessionRatings/{ratingId}
```

Known validation assumptions from prior audit:

* signed-in user required
* `request.resource.data.reviewerUid == uid()`
* `reviewerType` must be one of:
  * `client`
  * `clinician`
  * `center`
* `requestId` must be string

## Booking request rule dependency

If `SessionReviewPage` updates `booking_requests`, then it also depends on:

```text
match /booking_requests/{requestId}
```

Potential assumptions:

* admin or own booking user update allowed
* update fields must satisfy booking update validation
* status/review fields must be allowed by rule helpers

## Risk

```text
Critical
```

Because extracting reviews without rules redesign may break write permissions or leave request lifecycle inconsistent.

---

# 10. Runtime Risk Analysis

If `sessionRatings` is separated in the future:

| affected area | risk | why |
|---|---|---|
| `SessionReviewPage` writes | Critical | page likely writes both review and legacy request state |
| `booking_requests.reviewStatus` | Critical | legacy flows depend on review status |
| `sessionRatings.requestId` | Critical | required by rules and lookup |
| client completed request UI | High | review action/visibility may depend on request status |
| clinician sessions UI | High | completion/review state may depend on legacy fields |
| center residencies UI | High | review action may depend on request/session state |
| admin archive reports | High | report completion may depend on rating/request bridge |
| provider public profile ratings | Medium/High | display must keep working |
| analytics summaries | Medium | aggregates may need projection updates |
| support/chat | Low/Medium | indirect linkage only |

---

# 11. Extraction Readiness

Score من 0 إلى 100.

| area | score | explanation |
|---|---:|---|
| Page | 35 | page is hybrid and likely owns too much runtime behavior |
| Writes | 30 | dual write/coupled writes make extraction risky |
| Reads | 45 | reads are understandable but request dependency is strong |
| Rules | 20 | `requestId` and booking update rules are hard blockers |
| UI | 50 | labels/entry points can be adjusted, but flow still coupled |
| Analytics | 55 | likely can adapt later with projections, but not ready now |

Overall readiness:

```text
39 / 100
```

Meaning:

* ownership decision is clear.
* implementation readiness is low.
* next step should be deeper producer/write audit, not extraction.

---

# 12. Trust Transition Readiness

## Is `SessionReviewPage` a Trust Workflow?

Conceptually yes.

It creates ratings/reviews, which belong to Trust & Transparency.

## Is it a Booking Workflow?

Runtime-wise, partially yes.

It is opened from booking/session flows and likely mutates request/session state.

## Final classification

```text
Hybrid Workflow
```

Target future:

```text
Trust Workflow
with legacy source reference
```

The correct future shape:

* Trust owns review record.
* Booking/request only provides optional source reference.
* Archive/report consumes trust projection.
* No booking lifecycle gate owns the rating.

---

# 13. What Must Not Be Done

ممنوع الآن:

* تغيير `SessionReviewPage`
* تغيير review writes
* تغيير `requestId`
* تغيير rules
* نقل `sessionRatings`
* تغيير analytics
* تغيير `booking_requests` review fields
* تغيير status values
* تغيير profile pages
* تغيير admin reports
* حذف أو تغيير route `/session/review`
* إنشاء Trust collections جديدة كبديل فعلي
* عمل migration لأي review data

قبل أي خطوة مستقبلية يجب:

* فهم كل writes داخل `SessionReviewPage`
* فهم كل request status mutations
* فهم كل consumers of `reviewStatus`
* تصميم Trust rule model
* كتابة emulator tests
* مراجعة provider profile display
* مراجعة admin report/archive dependencies
* الحصول على Owner approval

---

# 14. Final Verdict

هل `SessionReviewPage` هي أكبر نقطة تشابك بين Trust وBooking؟

نعم، على الأرجح.

السبب:

* هي التي تحول user review action إلى trust data.
* لكنها تعتمد على `requestId`.
* وتقرأ `booking_requests`.
* وقد تحدث request/session/review status.
* وتؤثر على archive/report readiness.

أكبر نقطة خطر:

```text
Review creation is probably not just a Trust write.
It is also a legacy request lifecycle mutation.
```

الخطوة التالية بعد هذا audit:

```text
SESSION_REVIEW_WRITE_PATH_AUDIT
```

يجب أن يكون تقريرًا أضيق يركز فقط على:

* كل write داخل `SessionReviewPage`
* exact fields
* exact conditions
* exact status transitions
* duplicate prevention
* rollback/failure behavior

بدون تنفيذ أي تعديل.

هذا التقرير لا يغير Runtime.

هذا التقرير لا يغير Rules.

هذا التقرير لا ينفذ Extraction.

هذا التقرير فقط يفهم `SessionReviewPage` قبل أي خطوة مستقبلية.
