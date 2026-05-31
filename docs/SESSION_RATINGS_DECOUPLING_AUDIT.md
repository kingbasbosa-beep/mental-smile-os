# SESSION_RATINGS_DECOUPLING_AUDIT

هذا التقرير لا يغير Runtime.

هذا التقرير لا يغير Rules.

هذا التقرير لا ينفذ Extraction.

هذا التقرير فقط يفهم `sessionRatings` قبل أي خطوة مستقبلية.

المرجعيات الحاكمة:

* `docs/MENTAL_SMILE_DOMAIN_OWNERSHIP_CONSTITUTION.md`
* `docs/MENTAL_SMILE_FREEZE_AND_CLASSIFICATION_MAP.md`
* `docs/BOOKING_LEGACY_INVENTORY.md`
* `docs/BOOKING_LEGACY_EXTRACTION_DECISION_PLAN.md`
* `docs/BOOKING_LEGACY_OWNER_DECISIONS.md`

القرار النهائي المعتمد:

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

`sessionRatings` هي collection أقرب معماريًا إلى Trust & Transparency Domain من Booking Domain.

لكنها حاليًا مربوطة بالـ legacy booking/session lifecycle من خلال:

* `requestId`
* review close flow
* session review page
* admin reports/archive
* provider public display

النتيجة:

* لا يتم نقلها الآن.
* لا يتم حذفها الآن.
* لا يتم تغيير rules الآن.
* لا يتم تغيير `requestId` الآن.
* لا يتم فصلها عن profile pages أو analytics الآن.

التصنيف الحالي:

```text
Trust Data
+ Legacy Request Bridge
+ Booking Lifecycle Coupling
+ Extraction Candidate
```

التصنيف المستهدف:

```text
Trust & Transparency Domain
```

---

# 2. Collection Inventory

## Collection

```text
sessionRatings
```

## Inferred schema fields

| field | inferred type | purpose | current ownership | inferred ownership |
|---|---|---|---|---|
| `requestId` | string | يربط التقييم بطلب legacy داخل `booking_requests` | Booking lifecycle bridge | Trust reference فقط مستقبلًا |
| `reviewerUid` | string | هوية من كتب التقييم | Trust + Auth | Trust & Transparency |
| `reviewerType` | string enum | نوع المراجع: client / clinician / center | Trust + legacy role flow | Trust & Transparency |
| `clinicianId` | string optional/inferred | ربط التقييم بالأخصائي | Marketplace/Trust bridge | Trust & Transparency |
| `centerId` | string optional/inferred | ربط التقييم بالمركز | Marketplace/Trust bridge | Trust & Transparency |
| `clientId` | string optional/inferred | ربط التقييم بالعميل عند الحاجة | Legacy booking/support bridge | Trust with privacy boundaries |
| `rating` / `stars` | number | درجة التقييم | Trust | Trust & Transparency |
| `comment` / `reviewText` | string | نص التعليق | Trust | Trust & Transparency |
| `createdAt` | timestamp | توقيت إنشاء التقييم | Audit | Trust history |
| `updatedAt` | timestamp optional | توقيت تحديث التقييم | Audit | Trust history |
| `status` / `reviewStatus` | string optional | حالة review أو lifecycle bridge | Booking lifecycle mixed | Trust moderation status |
| `finalReviewPercentage` | number optional | signal تقريري/إداري | Reports + legacy session closure | Trust/reporting projection |
| provider display denormalized fields | string optional | تسهيل العرض في admin/profile | UI convenience | Trust projection فقط |

## Field purpose summary

`sessionRatings` تجمع إشارات ثقة:

* rating score
* reviewer identity
* reviewer type
* comment/review content
* provider reference
* request reference

المشكلة ليست في كونها collection تقييمات.

المشكلة أن `requestId` يجعلها مرتبطة بـ `booking_requests` كأن التقييم جزء من booking/session lifecycle.

---

# 3. Dependency Analysis

## Dependency table

| dependency | exists / inferred | strength | required vs optional | runtime usage |
|---|---|---|---|---|
| `requestId` | نعم | Strong | Required في rules الحالية | write validation, review lookup, admin report bridge |
| `bookingId` | غير واضح كحقل مستقل | Weak/Unknown | Not required | غالبًا replaced by `requestId` |
| `sessionId` | غير واضح كحقل مستقل | Weak/Unknown | Not required | session concept مربوط بـ request lifecycle |
| `clinicianId` | نعم/مستنتج من profile consumers | Medium/Strong | Optional حسب نوع provider | clinician public profile ratings |
| `centerId` | محتمل/مستنتج | Medium | Optional | center trust/profile future use |
| `clientId` | محتمل/مستنتج | Medium | Optional | privacy-sensitive reviewer relation |
| `reviewerUid` | نعم | Strong | Required | rules create/update validation |
| `reviewerType` | نعم | Strong | Required | rules validation and display context |

## Dependency verdict

أقوى dependency حاليًا هو:

```text
sessionRatings.requestId -> booking_requests/{requestId}
```

هذا لا يعني أن `sessionRatings` تنتمي إلى Booking Domain.

يعني فقط أنها ما زالت تستخدم booking request كـ legacy reference.

---

# 4. Producer Analysis

## Known / inferred producers

| producer | source file | trigger | write path | risk |
|---|---|---|---|---|
| Session review page | `lib/features/reviews/presentation/pages/session_review_page.dart` | user submits review / close session review | `FirebaseFirestore.instance.collection('sessionRatings')` | High |
| Client review flow | `SessionReviewPage` via client route/context | client completes rating | `sessionRatings` + possible `booking_requests` review fields | High |
| Clinician/center review flow | `SessionReviewPage` with reviewerType | provider-side review completion | `sessionRatings` + legacy request status bridge | High |
| Admin/report close flow | inferred from archive/report pages | report/review status visibility | mostly reads, may depend on request review fields | Medium |

## Producer notes

`SessionReviewPage` appears to be the central producer.

Risk comes from dual-write or coupled behavior:

```text
create rating
+
update booking request review/session status
```

أي فصل مستقبلي يجب أن يفهم هذه العلاقة قبل تعديل أي code.

---

# 5. Consumer Analysis

## Known / inferred consumers

| consumer | source file | purpose | risk level |
|---|---|---|---|
| Clinician public/profile details | `lib/features/specialists/presentation/specialist_details_page.dart` | عرض تقييمات أو rating stream للأخصائي | High |
| Specialist list/profile surfaces | `lib/features/specialists/presentation/*` | social proof / trust display | Medium |
| Admin reports archive | `lib/features/admin_surface/pages/admin_archive_reports_page.dart` | report/review archive and percentages | High |
| Admin archive pages | `lib/features/admin_surface/pages/admin_archive_*` and `lib/features/admin/presentation/pages/admin_archive_*` | legacy report/archive visibility | Medium/High |
| Session review page | `lib/features/reviews/presentation/pages/session_review_page.dart` | read existing request/review state and submit rating | High |
| Booking/my request flow | `lib/features/booking/presentation/pages/my_bookings_page.dart` | may open review for completed requests | High |
| Center residencies/activity | `lib/features/centers/presentation/pages/center_residencies_page.dart` | may open review or show completed/review state | Medium/High |
| Analytics/reporting | `functions/index.js`, admin analytics summaries inferred | aggregate reporting | Medium |
| Future trust pages | not yet cleanly separated | provider trust history | Unknown |

## Consumer verdict

Consumers use `sessionRatings` for trust display and reports, but lifecycle entry points still come from booking/session pages.

This confirms:

```text
Data nature = Trust
Current access path = Booking/session legacy
```

---

# 6. UI Dependency Map

```text
sessionRatings
  ↓
SpecialistDetailsPage
  -> provider trust display
  -> public/client confidence

sessionRatings
  ↓
SessionReviewPage
  -> rating create/update
  -> legacy request closure bridge

sessionRatings
  ↓
AdminArchiveReportsPage
  -> review reports
  -> archive/report visibility

sessionRatings
  ↓
MyBookingsPage
  -> opens review flow from legacy request state

sessionRatings
  ↓
CenterResidenciesPage
  -> review/session activity bridge

sessionRatings
  ↓
Analytics / summaries
  -> aggregate review/trust signals
```

UI dependency is not only display.

It includes workflow completion from legacy request/session state.

---

# 7. Firestore Dependency Map

## Lookups

```text
sessionRatings
  where requestId == current request id
```

Likely used for:

* preventing duplicate reviews
* checking review completion
* admin reports

## Queries

Known/inferred:

```text
sessionRatings by clinicianId
sessionRatings by requestId
sessionRatings by reviewerUid
sessionRatings by reviewerType
sessionRatings ordered by createdAt
```

## Indexes

Potential index needs:

* `clinicianId + createdAt`
* `centerId + createdAt`
* `requestId`
* `reviewerUid + requestId`
* `reviewerType + requestId`

No index changes are proposed here.

## Aggregates

Potential aggregate flows:

```text
sessionRatings
  -> average provider rating
  -> review count
  -> finalReviewPercentage / review completion signals
  -> admin report summaries
  -> public trust display
```

## Joins / references

| from | to | purpose |
|---|---|---|
| `sessionRatings.requestId` | `booking_requests/{requestId}` | legacy request/session reference |
| `sessionRatings.clinicianId` | `clinicians/{clinicianId}` | provider profile trust display |
| `sessionRatings.centerId` | `centers/{centerId}` | future center trust display |
| `sessionRatings.reviewerUid` | auth/user doc | ownership and rules validation |

---

# 8. Rules Dependency Map

لا يتم تعديل rules.

## Current known rule touchpoint

```text
match /sessionRatings/{ratingId}
```

Known behavior from current rules map:

* read allowed through `canReadRating()`
* create allowed through `ratingWriteValid()`
* update allowed when reviewer identity and request link remain consistent
* delete denied

## Required fields in rules

```text
reviewerUid == uid()
reviewerType in ['client', 'clinician', 'center']
requestId is string
```

## Dependency level

```text
High
```

Because rules currently treat `requestId` as required.

## Risks

* removing or weakening `requestId` before redesign would break writes.
* moving reviews to Trust Domain without rule plan may block users.
* changing reviewer types may break validation.
* profile pages may need broader read semantics later.
* privacy must be reviewed before public trust display expands.

---

# 9. Trust Domain Readiness

## Is `sessionRatings` closer to Trust Domain?

Yes.

Reasons:

* ratings are trust signals.
* comments/reviews are transparency artifacts.
* provider review summaries belong on public/provider profiles.
* review history informs marketplace trust, not booking ownership.

## Why it is not clean yet

It is still coupled to Booking because:

* `requestId` is required.
* review creation is triggered from session/booking completion.
* admin reports use legacy request/review state.
* lifecycle terms imply session closure.

## Readiness verdict

```text
Conceptual readiness: High
Runtime readiness: Medium/Low
Rules readiness: Low
```

---

# 10. Decoupling Complexity

Overall complexity:

```text
High
```

## Why High?

* `requestId` is required by rules.
* review flow likely updates both `sessionRatings` and `booking_requests`.
* public provider profile reads depend on current schema.
* admin reports/archive depend on request/review linkage.
* analytics may rely on session-style review completion.

## What makes it not Critical yet?

The target owner is clear:

```text
Trust & Transparency Domain
```

And the collection itself already contains trust-shaped data.

The hard part is not deciding ownership.

The hard part is decoupling runtime dependencies safely.

---

# 11. Extraction Readiness Score

Score من 0 إلى 100.

| area | score | explanation |
|---|---:|---|
| Data | 65 | fields are trust-shaped, but `requestId` coupling is strong |
| UI | 55 | profile display can fit Trust, but review entry points are booking/session-linked |
| Services | 45 | producers appear page-driven and coupled to legacy request state |
| Rules | 25 | current rules require `requestId`; Trust-owned rule model not ready |
| Analytics | 50 | useful trust aggregates likely exist, but report/archive coupling remains |

## Overall extraction readiness

```text
48 / 100
```

Meaning:

* ownership decision is mature.
* extraction implementation is not ready.
* next step must be audit/design, not migration.

---

# 12. Future Trust Model Candidate

بدون تنفيذ وبدون migration.

## Candidate collections

```text
provider_reviews
provider_ratings
trust_history
transparency_events
provider_review_summaries
complaint_visibility_summaries
```

## Candidate responsibilities

### `provider_reviews`

Stores individual review records.

Fields could include:

* providerId
* providerType
* reviewerUid
* reviewerType
* rating
* comment
* status
* createdAt
* sourceReference

### `provider_ratings`

Stores aggregate rating summaries.

Fields could include:

* providerId
* providerType
* averageRating
* ratingCount
* lastUpdatedAt

### `trust_history`

Stores trust timeline events.

Examples:

* document disclosed
* credential updated
* review received
* complaint response posted

### `transparency_events`

Stores public transparency actions.

Examples:

* provider responded to complaint
* license document updated
* verification review cycle completed

## Important boundary

Future Trust model may keep a legacy reference:

```text
sourceReference: {
  type: 'legacy_booking_request',
  id: requestId
}
```

But it should not require booking lifecycle ownership.

---

# 13. What Must Not Be Done

ممنوع الآن:

* نقل البيانات
* حذف `sessionRatings`
* تغيير rules
* تغيير `requestId`
* تغيير profile pages
* تغيير analytics
* تغيير `SessionReviewPage`
* تغيير Firestore write shape
* تغيير reviewer types
* تغيير status values
* فصل reviews عن booking runtime قبل tests
* إنشاء Trust collections جديدة كتنفيذ فعلي
* عمل migration من `sessionRatings` إلى أي collection جديدة

قبل أي خطوة مستقبلية يجب عمل:

* complete producer inventory
* complete consumer inventory
* rules design
* emulator tests
* profile display QA
* admin report QA
* privacy review
* Owner approval

---

# 14. Final Verdict

هل `sessionRatings` مرشحة بقوة للانتقال إلى Trust & Transparency Domain؟

نعم.

السبب:

`sessionRatings` تحتوي بيانات ثقة وشفافية، وليست بيانات حجز جوهرية. التقييمات والتعليقات وسجل المراجعات يجب أن تخدم marketplace trust، وليس booking lifecycle.

أكبر العقبات:

1. `requestId` required حاليًا في rules.
2. review creation مرتبط بـ session/booking completion.
3. admin reports/archive تستخدم legacy request linkage.
4. profile pages تحتاج استمرار قراءة آمن.
5. analytics قد تكون مبنية على schema الحالي.

الحكم النهائي:

```text
sessionRatings
=
Trust & Transparency Data
+ Legacy Booking Reference
+ High Decoupling Complexity
+ Strong Extraction Candidate
```

هذا التقرير لا يغير Runtime.

هذا التقرير لا يغير Rules.

هذا التقرير لا ينفذ Extraction.

هذا التقرير فقط يفهم `sessionRatings` قبل أي خطوة مستقبلية.
