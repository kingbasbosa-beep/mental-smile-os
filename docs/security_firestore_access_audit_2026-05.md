# Mental Smile Clean-Core Security / Firestore / Access Audit

Date: 2026-05-14  
Scope: `clean_core` only  
Mode: Audit only, no code or rules changes

## 1. Executive Summary

Clean-core is ready for local smoke testing and internal QA from a migration standpoint, but it is not production-ready from a security/rules standpoint yet.

The current app has a useful client-side access foundation:

- `lib/core/auth/account_access_service.dart`
- `lib/app/router/app_router.dart`
- role constants in `lib/shared/contracts/role_names.dart`
- blocked-account page in `lib/core/auth/presentation/pages/account_blocked_page.dart`

However, many sensitive decisions are still represented in client-side Firestore writes or client-side route checks. Before closed beta or production, these must be enforced in Firestore Security Rules and, for several flows, Cloud Functions.

Highest priority risks:

- Provider registration writes set sensitive fields such as `role`, `approvalStatus`, `isActive`, and readiness flags from the client.
- Booking/session status transitions are performed directly from client pages.
- `sessionLink` and session lifecycle fields require stricter role-scoped read/write rules.
- Public center/clinician reads need strict field exposure rules.
- `chat_threads/messages` are created by booking flow code and contain safety-style fields, but the full AI/safety governance layer is intentionally not migrated yet.
- Some placeholder routes remain gated or default-routed, which is acceptable for migration but needs product decisions before production.

## 2. Authentication Flow

### Current Implementation

Relevant files:

- `lib/main.dart`
- `lib/app/app.dart`
- `lib/app/router/app_router.dart`
- `lib/core/auth/account_access_service.dart`
- `lib/core/auth/presentation/pages/account_blocked_page.dart`
- `lib/shared/ui_kit/app_shell_actions.dart`
- `lib/features/home/presentation/pages/home_page.dart`
- `lib/features/home/presentation/pages/menu_page.dart`

Authentication usage found:

- `FirebaseAuth.instance.currentUser` is used in router gates, dashboards, booking/session pages, center inbox, clinician operations, and registration continuation pages.
- `FirebaseAuth.instance.authStateChanges()` is used in `lib/shared/ui_kit/app_shell_actions.dart`.
- `signOut()` exists in home, dashboard, web registration portal pages, blocked account page, and shared shell actions.
- Web registration uses `createUserWithEmailAndPassword()` in:
  - `lib/features/web_registration/presentation/pages/web_center_register_portal_page.dart`
  - `lib/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart`

### Safe Logic

- Protected routes check for a signed-in non-anonymous Firebase user in `AppRouter._RouteAccessGate`.
- Blocked accounts are routed to `AccountBlockedPage` if `AccountAccessService.resolve()` returns `isBlocked == true` and the user is not admin.
- Center and clinician operational routes require approved and active provider accounts before access.
- Registration routes remain public, which is correct for web-first onboarding.

### Risks / Gaps

- The login route currently returns `_FoundationPlaceholderPage(title: 'Login')`; this is a migration placeholder and not a real production login page.
- Role resolution depends on Firestore documents and email fallback queries. This is practical for migration, but rules must prevent users from creating or editing role-defining fields.
- If a user has no document but has an email, `AccountAccessService` returns `SignedInAccessState(role: 'client')`. This is user-friendly but must be backed by rules that do not grant broad client privileges unless the user has a valid owned client document or narrowly-scoped create ability.
- Admin detection trusts `admins/{uid}.active == true`; this is acceptable only if `admins` is server/admin-only.

## 3. Account Access / Role Gate Review

Relevant file:

- `lib/core/auth/account_access_service.dart`

### Fields Reviewed

- `role`
- `approvalStatus`
- `isActive`
- `isBlocked`
- `blockReason`
- `active` in `admins`
- document collection / document id

### Safe Logic

- Admin lookup is checked first via `admins/{uid}`.
- Clinician lookup checks `clinicians/{uid}` first, then email fallback.
- Center lookup checks `centers/{uid}` first, then email fallback.
- Client lookup checks `clients/{uid}` first, then email fallback.
- Blocked state is centralized in `SignedInAccessState`.
- Provider access requires `approvalStatus == approved` and `isActive == true` in router gate.

### Risky Assumptions

- `_matchesProviderRole()` allows a center document with empty `role` to match center. This supports legacy data but should not be a long-term production assumption.
- Client fallback by email can classify a signed-in user as `client` without an existing document.
- `isActive` defaults to `false`; this is safe for providers but may cause user experience friction if docs are incomplete.
- The route gate is client-side only. Firestore rules must enforce the same boundaries.

### Server-Controlled Later

These fields should become server/admin-controlled:

- `role`
- `isAdmin`
- `active` on admin documents
- `approvalStatus`
- `isActive`
- `isBlocked`
- `blockReason`
- `blockedAt`
- `blockedBy`
- `verified`
- `documentsReady`
- `imagesReady`
- public moderation flags
- payment status fields
- session lifecycle fields
- status transition fields

## 4. Route Protection

Relevant files:

- `lib/app/router/routes.dart`
- `lib/app/router/app_router.dart`

### Public Routes

- `/`
- `/language`
- `/home`
- `/menu`
- `/module/library`
- `/web/library`
- `/module/centers`
- `/module/centers/list`
- `/module/centers/details`
- `/module/specialists`
- `/module/specialists/list`
- `/module/specialists/details`
- `/booking`
- `/web/center/register`
- `/web/center/profile`
- `/web/center/media`
- `/web/center/pricing`
- `/web/center/documents`
- `/web/clinician/register`
- `/web/clinician/profile`
- `/web/clinician/sessions`
- `/web/clinician/documents`
- `/web/register/success`

Registration routes being public is intended. However, pages after account creation also rely on current user/draft uid; Firestore rules must require ownership.

### Client-Only Routes

- `/client/dashboard`
- `/client/sessions`
- `/client/payment-proof`
- `/client/follow-up-registration`
- `/booking/my`
- `/booking/request`
- `/booking/center-request`

Notes:

- Some client-only routes are placeholders or deferred (`clientPaymentProof`, `followUpRegistration`).
- Booking request submission is correctly protected at router level.

### Center-Only Routes

- `/center/dashboard`
- `/center/operations`
- `/center/inbox`
- `/center/residencies`

Notes:

- `centerOperations` is a gated placeholder/deferred route.
- `centerInbox` and `centerResidencies` are migrated and need strict document ownership rules.

### Clinician-Only Routes

- `/clinician/operations`
- `/clinician/sessions`
- `/clinician/chat-inbox`
- `/clinician/profile-edit-request`

Notes:

- `clinicianChatInbox` and `clinicianProfileEditRequest` are gated but currently route to placeholder/default behavior.
- Clinician operations and sessions are active and should require approved/active clinician docs.

### Admin Placeholder / Deferred Routes

- `/admin`

Notes:

- Admin page is not migrated. Route is gated to `admin`.
- It is acceptable as placeholder during migration, but production should either remove it or wire a reviewed admin surface.

### Sensitive Placeholder Routes

Defined but not migrated as real pages:

- `Routes.chat`
- `Routes.addiction`
- `Routes.specialNeeds`
- `Routes.supportIssueSelector`
- `Routes.sessionReview`
- `Routes.centerOperations`
- `Routes.clientPaymentProof`
- `Routes.followUpRegistration`
- `Routes.clinicianChatInbox`
- `Routes.clinicianProfileEditRequest`

Security note:

- `supportIssueSelector` and `sessionReview` are role-gated.
- `chat`, `addiction`, and `specialNeeds` currently fall through to generic placeholder behavior and are public by default. This is acceptable for clean-core migration only; do not expose real AI/crisis/support flows until reviewed.

## 5. Firestore Reads/Writes Inventory

### `admins`

Files:

- `lib/core/auth/account_access_service.dart`
- `lib/features/home/presentation/pages/menu_page.dart`
- `lib/features/booking/presentation/pages/center_booking_request_page.dart`

Operations:

- Read `admins/{uid}` for admin detection.
- Query/read admins while building center booking/admin routing.

Role:

- Authenticated users indirectly read admin status during routing.
- Booking request flow reads admin collection to assign/refer.

Risk: High

Notes:

- `admins` must be admin/server-controlled.
- Public users should not be able to enumerate admin profile details.
- If reads are needed for routing, expose only minimal active/admin existence checks via rules or Cloud Function.

### `clients`

Files:

- `lib/core/auth/account_access_service.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/booking/presentation/pages/booking_request_page.dart`

Operations:

- Read own client document.
- Query by email fallback.
- Booking flow reads client profile to attach request metadata.

Role:

- Client.

Risk: Medium

Notes:

- Clients should read only their own document.
- Users should not update `role`, `isBlocked`, moderation fields, or account state.
- Email fallback queries should be carefully constrained.

### `centers`

Files:

- `lib/core/auth/account_access_service.dart`
- `lib/features/centers/data/services/centers_firestore_service.dart`
- `lib/features/centers/presentation/pages/center_dashboard_page.dart`
- `lib/features/booking/presentation/pages/center_booking_request_page.dart`
- `lib/features/home/presentation/pages/menu_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_media_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_pricing_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_documents_page.dart`

Operations:

- Public listings/details read active/approved centers.
- Center registration creates `centers/{uid}`.
- Center profile/media/pricing/documents update `centers/{uid}`.
- Center dashboard reads own center document.

Role:

- Public reads for approved/active profile fields.
- Center-owned registration writes.
- Admin approval required later.

Risk: High

Notes:

- Registration currently writes `role`, `approvalStatus`, `isActive`, `active`, `imagesReady`, and `documentsReady` from client. Rules must restrict allowed initial values.
- Public reads must not expose documents, admin notes, private contact internals, or unapproved profiles.

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

- Public specialist list/detail reads.
- Booking page reads available clinicians.
- Clinician registration creates `clinicians/{uid}`.
- Clinician profile/session/documents update `clinicians/{uid}`.
- Clinician operations reads own profile.

Role:

- Public read for approved/active clinician public fields.
- Clinician-owned registration writes.

Risk: High

Notes:

- `approvalStatus`, `isActive`, `role`, public visibility, verified fields, document review state, and rating aggregates must be server/admin-controlled.
- Public specialist pages must not expose private emails, documents, internal notes, or session private links.

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

- Client creates booking request.
- Client creates center booking request.
- Client reads own requests.
- Center reads requests for its center id.
- Center updates availability/session/residency fields.
- Clinician reads assigned requests.
- Clinician updates session/request lifecycle fields.

Role:

- Client, center, clinician.

Risk: Critical

Notes:

- Status transitions must not be controlled solely by clients.
- Rules must enforce participant ownership: `clientId`, `centerId`, `clinicianId`.
- Fields such as payment status, session links, approval/rejection status, admin notes, and lifecycle states need strict role/server enforcement.

### `bookingRequests`

Files:

- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`

Operations:

- Legacy fallback read/update.

Role:

- Clinician.

Risk: High

Notes:

- This is a legacy collection fallback. Prefer migration away from it or rules that mirror `booking_requests` minimally until retired.

### `chat_threads` and `chat_threads/{id}/messages`

Files:

- `lib/features/booking/data/services/booking_legacy_chat_adapter.dart`

Operations:

- Query reusable chat thread.
- Create/update booking follow-up thread.
- Add messages.
- Update message count/preview/handoff state.

Role:

- Client booking flow and admin queue bridge.

Risk: Critical

Notes:

- This touches safety-like fields (`riskScore`, `riskLevel`, `strategyMode`, `safetyState`, `handoffState`) before the full AI/safety governance layer is migrated.
- Must be rules-hardened or moved behind Cloud Functions before production.

### `messages`

Files:

- `lib/features/booking/data/services/booking_legacy_chat_adapter.dart`

Operations:

- Subcollection reads/writes under `chat_threads`.

Role:

- Client/admin-style booking follow-up.

Risk: Critical

Notes:

- Message visibility, sender type, and thread membership must be enforced server-side.

### `support_requests`

Files:

- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`

Operations:

- Read counts/streams.

Role:

- Client, clinician.

Risk: Medium to High

Notes:

- Support requests can contain sensitive mental-health context. Reads must be owner/assignee/admin only.

### `sessionRatings`

Files:

- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/specialists/presentation/specialist_details_page.dart`

Operations:

- Read rating streams/aggregates.

Role:

- Public aggregate display, client dashboard, clinician dashboard.

Risk: Medium

Notes:

- Public pages should read approved aggregate/public-safe rating data only.
- Raw comments or reviewer identifiers should be protected.

### `chat_escalations`

Files:

- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`

Operations:

- Read escalated/referred chat cases.

Role:

- Clinician.

Risk: Critical

Notes:

- This is highly sensitive and should not be production-enabled without AI/safety/security rules and human review.

### `clinician_profile_change_requests`

Files:

- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`

Operations:

- Read pending profile change requests.
- Add new profile change request.

Role:

- Clinician.

Risk: High

Notes:

- This is the right pattern conceptually: request changes instead of direct public profile writes.
- Rules must prevent clinicians from approving their own requests or setting moderation/admin fields.

## 6. Sensitive Field Review

### Must Not Be User-Controlled

- `role`
- `isAdmin`
- `active` on admin docs
- `approvalStatus`
- `isActive`
- `isBlocked`
- `blockReason`
- `blockedAt`
- `blockedBy`
- `verified`
- document approval/rejection fields
- public profile moderation fields
- `sessionLink`
- `paymentStatus`
- `paymentProofUrl`
- admin notes
- `status` transitions after request creation
- `handoffState`
- `safetyState`
- `riskScore`
- `riskLevel`
- `strategyMode`

### Can Be User-Owned With Validation

For centers:

- name/display name during registration
- phone/whatsapp/address/city/area
- description
- media URLs if validation and review exist
- pricing draft fields if pending review
- documents submitted for review

For clinicians:

- professional title
- specialty
- bio draft
- session price/duration draft
- document submissions

For clients:

- booking note
- basic request intent
- profile-safe contact fields if implemented

## 7. Registration Security

### Center Registration

Files:

- `lib/features/web_registration/presentation/pages/web_center_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_media_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_pricing_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_documents_page.dart`

Current behavior:

- Creates Firebase Auth user.
- Creates/updates `centers/{uid}`.
- Stores registration fields directly in center doc.
- Uses `approvalStatus: pending_admin`, `isActive: false`, `active: false`.

Classification:

- Safe enough for migration: Yes.
- Needs rules hardening: Yes, critical.
- Needs admin/server enforcement: Yes.
- Needs Cloud Functions: Recommended for approval and public publication.

Security notes:

- Rules should allow create only for `request.auth.uid == docId`.
- Rules should require initial `approvalStatus == pending_admin`, `isActive == false`, and `role == center`.
- Rules should forbid user updates to approval/block/admin fields after creation.
- Documents/media/pricing should remain pending/draft until admin-approved.

### Clinician Registration

Files:

- `lib/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_sessions_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_documents_page.dart`

Current behavior:

- Creates Firebase Auth user.
- Creates/updates `clinicians/{uid}`.
- Captures profile, session setup, and documents.

Classification:

- Safe enough for migration: Yes.
- Needs rules hardening: Yes, critical.
- Needs admin/server enforcement: Yes.
- Needs Cloud Functions: Recommended for approval and public publication.

Security notes:

- Rules must prevent clinicians from self-activating or self-verifying.
- Uploaded document URLs/metadata must not be public.
- Public specialist pages should show only approved safe fields.

## 8. Booking / Session Security

### Booking Request Creation

Files:

- `lib/features/booking/presentation/pages/booking_request_page.dart`
- `lib/features/booking/presentation/pages/center_booking_request_page.dart`
- `lib/features/booking/presentation/pages/my_bookings_page.dart`

Classification:

- Safe enough for migration: Yes.
- Needs rules hardening: Critical.
- Needs server/admin enforcement: Yes.
- Needs Cloud Functions: Recommended.

Notes:

- Client can create request docs.
- Request ownership must be enforced using `clientId == request.auth.uid`.
- Client should not set admin-only statuses or payment fields.
- Request group ids and admin assignment logic are better generated/validated server-side.

### Center Availability / Residency Updates

Files:

- `lib/features/booking/data/services/center_request_inbox_service.dart`
- `lib/features/booking/presentation/pages/center_inbox_page.dart`
- `lib/features/centers/presentation/pages/center_residencies_page.dart`

Classification:

- Safe enough for migration: Yes.
- Needs rules hardening: Critical.
- Needs server/Admin enforcement: For status transitions.

Notes:

- Center should update only allowed center-owned response fields for requests where `centerId == request.auth.uid`.
- Center should not change client id, clinician id, payment status, admin review status, or final lifecycle without allowed transition logic.

### Clinician Session Updates

Files:

- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/clinician/presentation/pages/clinician_sessions_page.dart`

Classification:

- Safe enough for migration: Yes.
- Needs rules hardening: Critical.
- Needs server/Admin enforcement: Yes.

Notes:

- Clinician should access only assigned requests.
- `sessionLink` should be readable only by relevant client/clinician/center/admin depending on request type and status.
- Session lifecycle transitions should be restricted to allowed status graph.

### Client Session Confirmation

Files:

- `lib/features/client/presentation/pages/client_sessions_page.dart`

Classification:

- Safe enough for migration: Yes.
- Needs rules hardening: High.

Notes:

- Client should only update confirmation/review fields for own requests.
- Client should not change provider/admin/payment fields.

## 9. Public Data Exposure

### Centers

Files:

- `lib/features/centers/data/services/centers_firestore_service.dart`
- `lib/features/centers/presentation/pages/centers_list_page.dart`
- `lib/features/centers/presentation/pages/center_details_page.dart`

Public fields shown include:

- name
- category/type
- city/area/address
- phone/whatsapp
- gallery/media
- pricing/capabilities
- descriptions
- active/availability label

Risks:

- Phone/WhatsApp and Maps are external-contact surfaces.
- Media/document fields must be separated; public gallery is not the same as submitted proof documents.
- Only approved/active center docs should be visible publicly.

### Specialists / Clinicians

Files:

- `lib/features/specialists/presentation/specialists_list_page.dart`
- `lib/features/specialists/presentation/specialist_details_page.dart`

Public fields shown include:

- display name
- specialty/title
- profile photo
- rating/session info

Risks:

- Private email, documents, document URLs, internal approval fields, and session links must not be public.
- Ratings should be aggregate/sanitized.

### Contact Actions

Files:

- `lib/features/centers/presentation/pages/center_details_page.dart`

Current contact actions:

- `tel:`
- `https://wa.me/...`
- Google Maps search URL built from text address/city/area

Risk: Medium

Notes:

- This is acceptable as a minimal public-contact feature.
- Later rules/admin review should validate public phone/WhatsApp/address fields before publication.

## 10. Firebase Rules Requirement Map

Do not implement now. This is a requirement map only.

### `admins/{uid}`

Allowed reads:

- Admin self and server/admin only.
- Minimal active-admin check if absolutely needed.

Allowed writes:

- Admin/server only.

Forbidden:

- User-created admin docs.
- User updates to `active`, `role`, permissions.

### `clients/{uid}`

Allowed reads:

- Owner client.
- Admin.

Allowed creates:

- Owner client with restricted fields.

Allowed updates:

- Owner-safe profile fields only.

Forbidden:

- `role`, `isBlocked`, approval/admin fields, payment/admin flags.

### `centers/{uid}`

Allowed public reads:

- Only approved and active docs.
- Only public-safe fields.

Allowed owner reads:

- Center owner can read own full registration state except admin-private notes if stored separately.

Allowed owner creates:

- `request.auth.uid == uid`
- `role == center`
- `approvalStatus == pending_admin`
- `isActive == false`

Allowed owner updates:

- Draft registration/profile fields while pending or through request flow.

Forbidden:

- `approvalStatus`, `isActive`, `isBlocked`, `verified`, admin notes, document review fields.

Admin-only:

- Approval/rejection.
- Public publication.
- Block/unblock.

### `clinicians/{uid}`

Allowed public reads:

- Approved and active public-safe profile fields only.

Allowed owner reads:

- Clinician owner can read own profile/registration state.

Allowed owner creates:

- `request.auth.uid == uid`
- `role == clinician`
- `approvalStatus == pending_admin`
- `isActive == false`

Allowed owner updates:

- Draft/private onboarding fields or profile-change request creation.

Forbidden:

- `approvalStatus`, `isActive`, `isBlocked`, `verified`, rating aggregate, document review fields, admin notes.

### `booking_requests/{requestId}`

Allowed reads:

- Client where `clientId == request.auth.uid`.
- Center where `centerId == request.auth.uid`.
- Clinician where `clinicianId == request.auth.uid`.
- Admin.

Allowed creates:

- Client-owned creation only with restricted initial status and fields.

Allowed updates:

- Client: narrow confirmation/review/cancel-request fields.
- Center: availability/residency response fields only.
- Clinician: assigned session fields only.
- Admin/server: status lifecycle, payment, assignment, final review.

Forbidden:

- Changing participant ids.
- Client/provider changing admin status, payment status, admin notes.
- Public reads.

### `bookingRequests`

Requirement:

- Legacy compatibility only.
- Mirror strict `booking_requests` rules if kept.
- Prefer deprecation.

### `chat_threads/{threadId}` and `messages`

Allowed reads:

- Owner/participant/admin only.

Allowed writes:

- Prefer Cloud Functions.

Forbidden:

- Client changing safety fields, admin assignment, risk fields, lifecycle state.
- Unscoped message creation.

### `support_requests`

Allowed reads:

- Owner, assigned staff, admin.

Allowed writes:

- Owner creation only with limited fields; updates by assigned/admin.

Forbidden:

- Public reads.
- User changing assignment, escalation, internal notes.

### `sessionRatings`

Allowed public reads:

- Aggregated/approved ratings only.

Allowed owner writes:

- Client can create rating for completed own session only.

Forbidden:

- Clinician self-rating.
- Editing aggregate values.
- Public exposure of private reviewer identity unless intentionally anonymized.

### `clinician_profile_change_requests`

Allowed creates:

- Clinician owner only for own profile.

Allowed reads:

- Clinician owner and admin.

Allowed updates:

- Admin only for approval/rejection/status.

Forbidden:

- Clinician approving own request.

### `chat_escalations`

Allowed reads:

- Assigned clinician/admin only.

Allowed writes:

- Server/admin/safety pipeline only.

Forbidden:

- Public or broad clinician reads.

## 11. Cloud Functions Candidates

Recommended future backend functions:

- `approveCenterRegistration`
- `rejectCenterRegistration`
- `approveClinicianRegistration`
- `rejectClinicianRegistration`
- `publishApprovedCenterProfile`
- `publishApprovedClinicianProfile`
- `submitCenterProfileChangeRequest`
- `submitClinicianProfileChangeRequest`
- `approveProfileChangeRequest`
- `createBookingRequest`
- `transitionBookingStatus`
- `centerRespondToAvailability`
- `clinicianAcceptOrRejectRequest`
- `setSessionLink`
- `confirmSessionCompleted`
- `verifyPaymentProof`
- `dispatchBookingNotification`
- `writeAuditLog`
- `createSupportRequest`
- `assignSupportRequest`
- AI/crisis escalation functions later, after policy OS design.

## 12. Security Priority Plan

### Critical Before Production

- Firestore rules for roles and ownership.
- Prevent user writes to `role`, `approvalStatus`, `isActive`, `isBlocked`, `verified`, payment fields, and admin fields.
- Restrict public center/clinician reads to approved/active public-safe data.
- Harden `booking_requests` read/write/update rules.
- Harden `chat_threads/messages` or move booking chat adapter writes behind Cloud Functions.
- Protect `sessionLink`.
- Remove or guard public placeholder routes for non-migrated sensitive flows.

### Important Before Beta

- Add audit logs for registration approval and booking transitions.
- Move approval/status transitions to Cloud Functions or admin-only rules.
- Validate phone/WhatsApp/external contact fields.
- Separate private registration documents from public profile fields.
- Define legacy `bookingRequests` retirement or compatibility rules.
- Fix mojibake in placeholder/audit-visible strings before user-facing QA.

### Can Defer After Closed Testing

- Advanced notification dispatch.
- Full profile-change moderation UI.
- Rich payment-proof verification.
- Rating anti-abuse logic.
- External link reputation checks.
- Granular admin permissions.

### AI / Security OS Later

- AI safety policy store.
- Crisis escalation rules.
- Moderated AI chat.
- Human review queues.
- Safety audit/event logs.
- Deterministic safety kernel / control plane.

## 13. Final Verdict

### Local Smoke Testing

Ready.

Reason:

- Clean-core has migrated route foundation, public shell, registration, booking, client, center, and clinician experiences.
- Static validation previously found no broken imports, missing l10n keys, or forbidden migrated imports.

### Internal QA

Ready with caveats.

Caveats:

- QA must use test data only.
- Firestore rules should be in a test-safe mode, not production-open.
- Sensitive placeholder flows should not be treated as production-complete.

### Closed Beta

Not ready yet.

Blockers:

- Firestore rules not hardened.
- Booking/session status transitions still need server/rules enforcement.
- Registration public/private field separation is not finalized.
- Chat/support/safety-adjacent collections are not yet governed.

### Production

Not ready.

Production requires:

- Security rules implementation.
- Rules tests or emulator validation.
- Cloud Functions for critical transitions.
- Admin approval enforcement.
- Privacy review.
- External links/contact review.
- AI/legal/crisis phase before any safety-sensitive launch.

## 14. Recommended Next Audit/Implementation Sequence

1. Write Firestore rules requirements into a formal rules design document.
2. Implement rules in a separate controlled phase.
3. Add emulator/rules tests for role ownership and sensitive fields.
4. Move critical booking/status transitions into Cloud Functions.
5. Harden public read models for centers/clinicians.
6. Review chat/support/safety-adjacent collections before enabling real flows.
7. Only then start AI/security/policy OS implementation.

