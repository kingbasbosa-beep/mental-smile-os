# Firebase / Firestore Security Audit - Mental Smile

Date: 2026-05-09

Scope:
- Flutter Firestore usage under `lib/`
- Existing `firestore.rules`
- Existing `firestore.indexes.json`
- Security-sensitive account and approval fields

No app behavior, screens, routes, or Firestore collection names were changed by this audit.

## Executive Summary

The project uses Firebase Auth plus Firestore documents for four account roles:

- `client`
- `clinician`
- `center`
- `admin`

The current app stores role/status fields in Firestore documents for display and app routing. For production security, admin decisions must not trust Firestore role fields. The generated `firestore.rules` now expects Firebase Auth custom claims:

- `request.auth.token.role == 'admin'`
- `request.auth.token.role == 'client'`
- `request.auth.token.role == 'clinician'`
- `request.auth.token.role == 'center'`

Firestore role/status fields may remain for UI display, but approval, blocking, and admin-only decisions should be enforced by custom claims and server/admin workflows.

## Sensitive Fields

These fields are treated as protected and must not be directly edited by normal users:

- `role`
- `isAdmin`
- `approvalStatus`
- `isActive`
- `active`
- `isBlocked`
- `blockedAt`
- `blockedBy`
- `blockReason`
- `adminNotes`
- `verifiedAt`
- `verifiedBy`
- `featured`
- `ranking`
- `subscriptionStatus`

## Collections And Subcollections Found

### `clients`

Source files:
- `lib/features/auth/presentation/pages/client_register_page.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/booking/presentation/pages/booking_request_page.dart`
- `lib/features/admin_surface/pages/admin_clients_page.dart`
- `lib/core/auth/account_access_service.dart`

Read operations:
- client dashboard reads own `clients/{uid}`
- booking request reads current client profile
- admin clients page reads client list
- account access service resolves role by uid/email

Write/update/delete operations:
- client registration creates `clients/{uid}`
- client profile/avatar update appears limited
- admin may manage client/block state
- delete should be denied

Allowed role:
- client: own document only
- admin: all client documents
- clinician/center: no direct client document access unless represented through request documents

Risky fields:
- `role`
- `isBlocked`
- `blockReason`
- `blockedAt`
- `blockedBy`

Risky direct writes:
- client registration writes `role: client` on create. This is acceptable only during own create and should not be editable later.

Needs confirmation:
- Whether admin pages require reading all client docs using custom claims before deployment.

### `clinicians`

Source files:
- `lib/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_sessions_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_documents_page.dart`
- `lib/features/auth/presentation/pages/clinician_register_page.dart`
- `lib/features/specialists/presentation/specialists_list_page.dart`
- `lib/features/specialists/presentation/specialist_details_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/admin_surface/pages/admin_clinician_requests_page.dart`
- `lib/features/admin_surface/pages/admin_clinician_workspace_page.dart`
- `lib/features/chat/data/services/chat_firestore_service.dart`
- `lib/features/home/presentation/pages/menu_page.dart`
- `lib/core/auth/account_access_service.dart`

Read operations:
- public/signed-in specialists listing
- specialist details
- clinician operations own profile
- menu role resolution
- admin approval pages

Write/update/delete operations:
- web clinician registration creates and progressively updates `clinicians/{uid}`
- admin approval page updates approval/block/activation fields
- clinician profile changes should go through `clinician_profile_change_requests`
- delete should be denied

Allowed role:
- clinician: own document, limited registration fields before approval
- client/center/clinician: read only approved and active clinicians for listing
- admin: full review/update

Risky fields:
- `role`
- `isAdmin`
- `approvalStatus`
- `isActive`
- `isBlocked`
- `adminNotes`
- `verifiedAt`
- `verifiedBy`

Risky direct writes flagged:
- `web_clinician_register_portal_page.dart` writes `role`, `isAdmin`, `isActive`, `approvalStatus` during account creation. This should be allowed only on create with strict fixed values.
- `admin_clinician_requests_page.dart` writes approval/block/activation fields. This must be admin-only.

Direct publish writes that should become requested/admin-reviewed:
- `photoUrl`
- `bio`
- session and document-facing fields after approval

Current safer pattern:
- `clinician_profile_change_requests`

Needs confirmation:
- Whether all clinician listing queries include both `approvalStatus == approved` and `isActive == true`.

### `centers`

Source files:
- `lib/features/web_registration/presentation/pages/web_center_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_media_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_pricing_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_documents_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_details_page.dart`
- `lib/features/centers/data/services/centers_firestore_service.dart`
- `lib/features/centers/presentation/pages/center_dashboard_page.dart`
- `lib/features/centers/presentation/pages/center_operations_page.dart`
- `lib/features/centers/presentation/pages/center_register_page.dart`
- `lib/features/centers/presentation/pages/center_residencies_page.dart`
- `lib/features/booking/presentation/pages/center_booking_request_page.dart`
- `lib/features/admin_surface/pages/admin_centers_page.dart`
- `lib/features/admin_surface/pages/admin_center_details_page.dart`
- `lib/features/admin_surface/pages/admin_clinician_profile_requests_page.dart`
- `lib/features/home/presentation/pages/menu_page.dart`
- `lib/core/auth/account_access_service.dart`

Read operations:
- center listing/details
- center dashboard/operations own profile
- booking center request
- admin center approval/details
- account access service role resolution

Write/update/delete operations:
- web center registration creates and progressively updates `centers/{uid}`
- admin center approval updates status/activation/block fields
- center profile/dashboard must use `center_profile_change_requests` after approval
- delete should be denied

Allowed role:
- center: own document, limited registration fields before approval
- signed-in public listing: approved and active centers only
- admin: full review/update

Risky fields:
- `role`
- `approvalStatus`
- `isActive`
- `active`
- `isBlocked`
- `adminNotes`
- `featured`
- `ranking`
- `subscriptionStatus`

Risky direct writes flagged:
- `web_center_register_portal_page.dart` writes `role`, `approvalStatus`, `active`, `isActive` during create. This should be allowed only with strict fixed values.
- `admin_centers_page.dart` writes approval/block/activation fields. This must be admin-only.
- `web_center_details_page.dart` still writes to `centers/{uid}` and is legacy/risky unless confirmed unused.

Direct publish writes that should become requested/admin-reviewed:
- `galleryItems`
- `galleryImages`
- `imageUrl`
- `coverImageUrl`
- `documentItems`
- `documentsReady`
- `imagesReady`
- pricing fields
- `centerCapabilities`
- core profile fields after approval

Current safer pattern:
- `center_profile_change_requests`

Needs confirmation:
- Whether `web_center_details_page.dart` is still reachable.
- Whether center list/detail queries always filter approved and active centers.

### `admins`

Source files:
- `lib/features/home/presentation/pages/menu_page.dart`
- `lib/features/booking/presentation/pages/center_booking_request_page.dart`
- `lib/features/admin_surface/pages/chat_escalations_page.dart`
- `lib/core/auth/account_access_service.dart`

Read operations:
- current app checks `admins/{uid}.active`
- admin guard/debug traces

Write/update/delete operations:
- no normal app writes should exist

Allowed role:
- admin only

Risky fields:
- `active`
- admin identity data

Risk:
- Existing app logic still reads Firestore admin docs, while production rules should depend on custom claims for admin authority.

Needs confirmation:
- Server/Admin SDK process for assigning `role: admin` custom claim.

### `booking_requests`

Source files:
- `lib/features/booking/presentation/pages/my_bookings_page.dart`
- `lib/features/booking/presentation/pages/booking_request_page.dart`
- `lib/features/booking/presentation/pages/center_booking_request_page.dart`
- `lib/features/booking/presentation/pages/clinician_inbox_page.dart`
- `lib/features/booking/data/services/center_inbox_service.dart`
- `lib/features/booking/data/services/center_request_inbox_service.dart`
- `lib/features/clinician/presentation/pages/clinician_sessions_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/centers/presentation/pages/center_residencies_page.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/client/presentation/pages/client_sessions_page.dart`
- `lib/features/client/presentation/pages/client_payment_proof_page.dart`
- many admin pages/services under `lib/features/admin_surface/`
- archive pages under `lib/features/admin/`

Read operations:
- client own bookings
- clinician assigned bookings
- center assigned bookings/residencies
- admin queues/archive/payments/sessions

Write/update/delete operations:
- booking request creation
- admin status transitions
- client payment proof
- client/clinician/center reviews
- center availability/arrival/session bridge updates
- delete should be denied

Allowed role:
- client: own requests
- clinician: assigned requests
- center: own center requests
- admin: full operational state transitions

Risky fields:
- `status`
- `workflowStage`
- payment fields
- assigned clinician/center fields
- review totals
- archive/accounting fields

Risky direct writes:
- Many workflow status updates happen directly from pages/services. These need strict field-level rules and test coverage.

Needs confirmation:
- Exact allowed state machine for every status transition.

### `bookingRequests`

Source files:
- `lib/features/booking/presentation/pages/clinician_inbox_page.dart`
- `lib/features/booking/data/services/center_inbox_service.dart`
- `lib/features/clinician/presentation/pages/clinician_sessions_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`

Read/write operations:
- legacy fallback references exist

Allowed role:
- none in production

Risk:
- Legacy collection can cause confusion if reopened.

Recommendation:
- Keep denied.

### `sessionRatings`

Source files:
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/specialists/presentation/specialist_details_page.dart`
- `lib/features/reviews/presentation/pages/session_review_page.dart`
- `lib/features/admin_surface/pages/admin_session_report_page.dart`
- `lib/features/admin_surface/pages/admin_archive_reports_page.dart`

Read operations:
- client dashboard stats
- clinician operations stats
- specialist details ratings
- admin reports

Write/update/delete operations:
- session review page creates ratings
- reviewer may update own rating
- delete should be denied

Allowed role:
- reviewer owner
- related client/clinician/center
- admin

Risky fields:
- `derivedStars`
- `percentageScore`
- `reviewerType`
- `clinicianId`
- `centerId`
- `clientId`

Risk:
- Ratings can be manipulated if not tied to a completed booking request.

Needs confirmation:
- Whether each rating must reference a completed `booking_requests/{requestId}`.

### `support_requests`

Source files:
- `lib/features/modules/presentation/pages/support_issue_selector_page.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/admin_surface/pages/customer_follow_up_workspace_page.dart`

Read operations:
- admin reads all
- clients/clinicians may count own requests in dashboards

Write/update/delete operations:
- users create structured support requests
- admin updates status
- delete should be denied

Allowed role:
- authenticated user: create own request
- admin: read/update
- owner read may be needed for dashboards

Risky fields:
- `status`
- `priority`
- `userRole`
- `createdByUid`

Risk:
- If owner dashboards read support request counts, rules must allow owner reads.

### `chat_threads`

Source files:
- `lib/features/chat/presentation/pages/chat_page.dart`
- `lib/features/chat/data/services/chat_firestore_service.dart`
- `lib/features/booking/data/services/booking_legacy_chat_adapter.dart`

Subcollections:
- `chat_threads/{threadId}/messages`

Read operations:
- owner reads own thread
- assigned clinician reads assigned thread
- admin reads support/chat streams

Write/update/delete operations:
- owner creates thread
- messages created under thread
- admin/owner updates thread metadata
- delete should be denied

Allowed role:
- owner
- assigned clinician
- admin

Risky fields:
- `ownerUid`
- `assignedClinicianUid`
- `archived`
- thread status/escalation fields

Risk:
- General chat produced Firestore index/internal assertion issues previously.

### `chat_escalations`

Source files:
- `lib/features/chat/data/services/chat_firestore_service.dart`
- `lib/features/chat/data/services/chat_health_service.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/admin_surface/pages/chat_escalations_page.dart`

Subcollections:
- `chat_escalations/{escalationId}/reports`

Read operations:
- admin reads all
- assigned clinician reads assigned escalations

Write/update/delete operations:
- escalation create
- admin update
- reports create
- delete should be denied

Allowed role:
- admin
- assigned clinician read
- authenticated create, if generated from chat

Risky fields:
- `assignedToUid`
- `assignedToType`
- escalation status fields

Risk:
- Assignment fields must be admin/system controlled where possible.

### `clinician_profile_change_requests`

Source files:
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/admin_surface/pages/admin_clinician_profile_requests_page.dart`

Read operations:
- clinician reads own requests
- admin reads all

Write/update/delete operations:
- clinician creates pending request
- admin approves/rejects and applies changes
- delete should be denied

Allowed role:
- clinician owner
- admin

Risky fields:
- requested profile fields
- `status`
- admin review fields

Risk:
- Direct write into `clinicians/{uid}` must not bypass this after approval.

### `center_profile_change_requests`

Source files:
- `lib/features/centers/presentation/pages/center_operations_page.dart`
- `lib/features/admin_surface/pages/admin_clinician_profile_requests_page.dart`

Read operations:
- center reads own requests
- admin reads all

Write/update/delete operations:
- center creates pending request
- admin approves/rejects and applies changes
- delete should be denied

Allowed role:
- center owner
- admin

Risky fields:
- `requestedGalleryItems`
- `requestedDocumentItems`
- `requestedImagesReady`
- `requestedDocumentsReady`
- requested pricing/profile fields
- `status`

Risk:
- Live `centers/{uid}` direct publish writes after approval must remain blocked.

### `system_domains`

Source files:
- `lib/core/system/domain_status_service.dart`
- `lib/features/chat/data/services/chat_health_service.dart`
- `lib/features/booking/data/services/booking_health_service.dart`
- `lib/features/admin_surface/services/ai_policy_health_service.dart`
- `lib/dev/domain_status_seeder.dart`

Allowed role:
- admin only

Risk:
- Operational health/status collection should not be public.

### `ai_policies`

Source files:
- `lib/features/admin_surface/pages/admin_ai_policy_page.dart`
- `lib/features/admin_surface/services/ai_policy_health_service.dart`
- `lib/dev/ai_policy_seeder.dart`

Allowed role:
- admin only

Risk:
- Policy text affects AI/admin behavior; protect fully.

### `analytics_summaries`

Source files:
- `lib/features/admin_surface/services/analytics_summary_repository.dart`

Allowed role:
- admin read only

Needs confirmation:
- Which backend job writes this collection.

### `resources`

Source files:
- rules only found in current scan

Allowed role:
- authenticated read
- admin write

Needs confirmation:
- Actual feature owner and intended public/private exposure.

### External follow-up collections

Collections:
- `external_follow_up_registry`
- `external_follow_up_message_templates`
- `external_follow_up_campaigns`

Source files:
- `lib/features/external_follow_up/data/services/follow_up_registry_service.dart`
- `lib/features/external_follow_up/data/services/follow_up_message_template_service.dart`
- `lib/features/external_follow_up/data/services/follow_up_campaign_service.dart`
- workspace pages under `lib/features/admin_surface/pages/`

Allowed role:
- admin for templates/campaigns
- registry owner-create may exist, but needs confirmation before production

Risk:
- Follow-up messaging can expose PII and must be admin-controlled.

## Direct Sensitive Writes Found

### Account creation writes

Allowed only on strict self-create:
- client writes `role: client`
- clinician writes `role: clinician`, `isAdmin: false`, `isActive: false`, `approvalStatus: pending_review`
- center writes `role: center`, `active: false`, `isActive: false`, `approvalStatus: pending_admin`

### Admin approval writes

Must be admin-only:
- `approvalStatus`
- `isActive`
- `active`
- `isBlocked`
- `blockReason`
- `verifiedAt`
- `verifiedBy`

Files:
- `lib/features/admin_surface/pages/admin_clinician_requests_page.dart`
- `lib/features/admin_surface/pages/admin_centers_page.dart`
- `lib/features/admin_surface/pages/admin_clients_page.dart`
- `lib/core/auth/account_access_service.dart`

## Direct Publish Writes That Should Stay Admin-Reviewed

Clinician:
- `photoUrl`
- `bio`
- documents after approval
- public profile/session display fields after approval

Center:
- `galleryItems`
- `galleryImages`
- `documentItems`
- `imagesReady`
- `documentsReady`
- pricing maps
- capability maps
- core profile fields

Target reviewed collections:
- `clinician_profile_change_requests`
- `center_profile_change_requests`

## Highest Risk Areas

1. Custom claims not configured yet.
   - The new rules depend on `request.auth.token.role`.

2. Firestore indexes.
   - Existing multi-filter queries can fail at runtime without composite indexes.

3. Legacy collections.
   - `bookingRequests` should remain denied.

4. Chat queries.
   - Previous runtime showed Firestore index/internal assertion errors.

5. Center/clinician public listing.
   - Must always expose only `approvalStatus == approved` and `isActive == true`.

6. Registration rules vs progressive registration.
   - Web registration writes multiple steps; each field must remain explicitly allowed.

7. Admin access split.
   - Existing app logic still reads `admins/{uid}`; production rules now expect custom claims for true authority.

## Needs Confirmation

- Exact final booking request state machine.
- Whether guest support without Firebase Auth is required.
- Whether `resources` should be public or signed-in only.
- Whether analytics summaries are written by Cloud Functions/Admin SDK.
- Whether all center/specialist list queries include approved+active filters.
- Whether `web_center_details_page.dart` is fully unused.
