# GROUNDING-W1 Runtime Inventory & Authority Map

Mental Smile - Grounding Era

Status: inspection-only documentation. No runtime behavior, routes, Firebase rules, claims, migrations, or production code were changed.

## 1. Executive Summary

The current Mental Smile runtime is a Flutter application backed by Firebase Auth and Firestore. Access is primarily controlled in two places:

- App navigation: `lib/app/router/app_router.dart` uses route families and `RouteAccessGate` through `AccountAccessService`.
- Firestore runtime authority: `firestore.rules` relies on Firebase custom claims, especially `role == "admin"`, for actual data access.

The codebase has a stable operational nucleus, but it is still a hybrid legacy runtime. Tenant workflows exist for clients, clinicians, and centers, yet the admin surface still contains direct mutation power over bookings, payments, sessions, profile approvals, centers, clinicians, AI policy, system domains, and escalation handling.

Current constitutional doctrine is mostly not enforced by runtime infrastructure yet. There are no implemented command runtime collections, audit append-only runtime, registry-driven authority checks, or separated room claims. The real authority remains route-gated UI plus broad Firestore custom-claim permissions.

Grounding conclusion: Mental Smile is ready for inventory, freezer labeling, wrapper planning, and audit/registry artifact grounding. It is not ready for route migration, backend authority takeover, claim migration, or high-risk enforcement.

## 2. Route Inventory

| Route | File / Source | Current Role Access | Current Runtime Meaning | Label | Notes |
| ----- | ------------- | ------------------- | ----------------------- | ----- | ----- |
| `/`, `/language`, `/login`, `/menu` | `lib/app/router/routes.dart`, `lib/app/router/app_router.dart` | Public / signed-in dependent | Entry, language, login, main menu | ACTIVE_STABLE | Stable shell routes. |
| `/home` | `routes.dart`, `app_router.dart` | Public / compatibility | Alias to menu | LEGACY_COMPATIBILITY | Keep frozen as alias. |
| `/account-blocked` | `routes.dart`, `app_router.dart` | Signed-in redirected state | Blocked account explanation | ACTIVE_STABLE | Tied to account access state. |
| `/register/client` | `routes.dart`, `app_router.dart` | Public | Client registration | ACTIVE_STABLE | Writes `clients`. |
| `/register/clinician` | `routes.dart`, `app_router.dart` | Public | Legacy clinician registration | LEGACY_COMPATIBILITY | Web registration also exists. |
| `/register/center` | `routes.dart`, `app_router.dart` | Public | Legacy center registration | LEGACY_COMPATIBILITY | Web registration also exists. |
| `/follow-up/register` | `routes.dart`, `app_router.dart` | Public | External follow-up registration | ACTIVE_STABLE | Operational capture surface. |
| `/web/center/*` | `routes.dart`, `app_router.dart` | Public / authenticated user context | Center web registration portal steps | ACTIVE_STABLE | Writes `centers`. |
| `/web/clinician/*` | `routes.dart`, `app_router.dart` | Public / authenticated user context | Clinician web registration portal steps | ACTIVE_STABLE | Writes `clinicians`. |
| `/web/library`, `/web/library/policy` | `routes.dart`, `app_router.dart` | Public | Web library / policy preview | PREVIEW_ONLY | Read-oriented web surface. |
| `/client/dashboard` | `routes.dart`, `app_router.dart` | `client` via app gate | Client dashboard | ACTIVE_STABLE | Reads own profile/bookings/support/reviews. |
| `/client/payment-proof` | `routes.dart`, `app_router.dart` | `client` via app gate | Payment proof upload / submission | COMMAND_REQUIRED_FUTURE | Writes payment fields in `booking_requests`. |
| `/client/sessions` | `routes.dart`, `app_router.dart` | `client` via app gate | Client session check-in / state updates | COMMAND_REQUIRED_FUTURE | Writes session-related fields. |
| `/booking` | `routes.dart`, `app_router.dart` | Public / contextual | Booking landing | ACTIVE_STABLE | Navigation to booking flows. |
| `/booking/request` | `routes.dart`, `app_router.dart` | `client` via app gate | Client booking request | ACTIVE_STABLE | Creates `booking_requests`. |
| `/booking/center-request` | `routes.dart`, `app_router.dart` | `client` via app gate | Center booking request | ACTIVE_STABLE | Creates/updates `booking_requests`; reads `admins`. |
| `/booking/my` | `routes.dart`, `app_router.dart` | `client` via app gate | Client booking list/intake | COMMAND_REQUIRED_FUTURE | Creates and updates `booking_requests`. |
| `/clinician/operations` | `routes.dart`, `app_router.dart` | `clinician`, approved and active | Clinician operational workspace | COMMAND_REQUIRED_FUTURE | Writes booking decisions, support, escalation, profile requests. |
| `/clinician/profile-edit-request` | `routes.dart`, `app_router.dart` | `clinician`, approved and active | Clinician profile change request | ACTIVE_STABLE | Request-based write, admin applies later. |
| `/clinician/inbox` | `routes.dart`, `app_router.dart` | `clinician`, approved and active | Clinician booking inbox | COMMAND_REQUIRED_FUTURE | Writes primary and legacy booking docs. |
| `/clinician/chat-inbox` | `routes.dart`, `app_router.dart` | `clinician`, approved and active | Clinician chat inbox | ACTIVE_STABLE | Chat workflow. |
| `/chat/clinician/inbox` | `routes.dart`, `app_router.dart` | `clinician`, approved and active | Legacy clinician chat alias | LEGACY_COMPATIBILITY | Alias should remain frozen. |
| `/clinician/sessions` | `routes.dart`, `app_router.dart` | `clinician`, approved and active | Clinician session list | ACTIVE_STABLE | Reads booking sources including legacy fallback. |
| `/center/dashboard` | `routes.dart`, `app_router.dart` | `center`, approved and active | Center dashboard | ACTIVE_STABLE | Reads center profile. |
| `/center/operations` | `routes.dart`, `app_router.dart` | `center`, approved and active | Center operational workspace | COMMAND_REQUIRED_FUTURE | Writes profile change requests. |
| `/center/profile-edit-request` | `routes.dart`, `app_router.dart` | `center`, approved and active | Center profile change request | ACTIVE_STABLE | Request-based write, admin applies later. |
| `/center/inbox` | `routes.dart`, `app_router.dart` | `center`, approved and active | Center booking inbox | COMMAND_REQUIRED_FUTURE | Updates booking availability/status. |
| `/center/residencies` | `routes.dart`, `app_router.dart` | `center`, approved and active | Center residency view | ACTIVE_STABLE | Primarily read-oriented. |
| `/chat` | `routes.dart`, `app_router.dart` | Signed-in participant context | Chat page | ACTIVE_STABLE | Creates messages and updates thread metadata. |
| `/chat/escalations` | `routes.dart`, `app_router.dart` | Admin-only in router | Escalation queue | CONTROL_ROOM_CANDIDATE | Currently admin mutation capable through service. |
| `/chat/escalation/report` | `routes.dart`, `app_router.dart` | Admin-only in router | Escalation report | CONTROL_ROOM_CANDIDATE | Report visibility; should become audit/case surface. |
| `/module/addiction`, `/module/special_needs`, `/module/family_stress` | `routes.dart`, `app_router.dart` | Public / contextual | Module entry pages | ACTIVE_STABLE | Mostly navigation/content. |
| `/module/specialists*` | `routes.dart`, `app_router.dart` | Public / contextual | Specialist directory and details | ACTIVE_STABLE | Reads `clinicians`, `sessionRatings`. |
| `/module/centers*` | `routes.dart`, `app_router.dart` | Public / contextual | Center directory and details | ACTIVE_STABLE | Reads `centers`. |
| `/module/library` | `routes.dart`, `app_router.dart` | Public / contextual | Library module | ACTIVE_STABLE | Content surface. |
| `/module/support` | `routes.dart`, `app_router.dart` | Signed-in / contextual | Support issue selector | ACTIVE_STABLE | Creates `support_requests`. |
| `/session/review` | `routes.dart`, `app_router.dart` | Client/clinician context | Session review submission | COMMAND_REQUIRED_FUTURE | Writes `sessionRatings` and updates booking review fields. |
| `/admin/hub` | `routes.dart`, `app_router.dart` | `admin` app gate | Admin landing and summaries | FROZEN_NO_EXPANSION | Compatibility admin shell. |
| `/admin/operations` | `routes.dart`, `app_router.dart` | `admin` app gate | Operational admin dashboard | DANGEROUS_SHARED_AUTHORITY | Mixed observe and mutate posture. |
| `/admin/booking-queue` | `routes.dart`, `app_router.dart` | `admin` app gate | Booking lifecycle queue | DANGEROUS_SHARED_AUTHORITY | Direct booking lifecycle authority. |
| `/admin/payments` | `routes.dart`, `app_router.dart` | `admin` app gate | Payment and payout decisions | SOVEREIGN_ROOM_CANDIDATE | Current direct mutation; future backend/sovereign command. |
| `/admin/sessions` | `routes.dart`, `app_router.dart` | `admin` app gate | Session lifecycle decisions | COMMAND_REQUIRED_FUTURE | Direct operational mutation. |
| `/admin/accounting` | `routes.dart`, `app_router.dart` | `admin` app gate | Accounting workspace | SOVEREIGN_ROOM_CANDIDATE | Should not remain Control Room/admin. |
| `/admin/clinician-requests` | `routes.dart`, `app_router.dart` | `admin` app gate | Clinician approval/rejection | COMMAND_REQUIRED_FUTURE | Trust and authority mutation. |
| `/admin/clinician-profile-requests` | `routes.dart`, `app_router.dart` | `admin` app gate | Profile change approval and application | COMMAND_REQUIRED_FUTURE | Applies data into `clinicians`/`centers`. |
| `/admin/clinicians` | `routes.dart`, `app_router.dart` | `admin` app gate | Clinician workspace | CONTROL_ROOM_CANDIDATE | Read-heavy but admin gated. |
| `/admin/centers`, `/admin/center-details` | `routes.dart`, `app_router.dart` | `admin` app gate | Center approval/blocking/details | COMMAND_REQUIRED_FUTURE | Direct center state mutation. |
| `/admin/clients` | `routes.dart`, `app_router.dart` | `admin` app gate | Client visibility | CONTROL_ROOM_CANDIDATE | Should become observe/case only. |
| `/admin/support-chats` | `routes.dart`, `app_router.dart` | `admin` app gate | Support chat oversight | CONTROL_ROOM_CANDIDATE | Needs case/audit posture. |
| `/admin/alerts-review` | `routes.dart`, `app_router.dart` | `admin` app gate | System alert viewing | CONTROL_ROOM_CANDIDATE | Read-only rules now. |
| `/admin/ai-policies` | `routes.dart`, `app_router.dart` | `admin` app gate | AI policy draft/publish | OWNER_ROOM_CANDIDATE | Current admin direct write. |
| `/admin/system-domains`, `/admin/domain-availability` | `routes.dart`, `app_router.dart` | `admin` app gate | System domain status | OWNER_ROOM_CANDIDATE | Current admin write allowed by rules. |
| `/admin/functional-workspaces` | `routes.dart`, `app_router.dart` | `admin` app gate | Workspace menu | FROZEN_NO_EXPANSION | Compatibility navigation. |
| `/workspace/external-follow-up*` | `routes.dart`, `app_router.dart` | `admin` app gate | External follow-up registry/templates/campaigns | OWNER_ROOM_CANDIDATE | Admin-gated operational growth surface. |
| `/workspace/customer-follow-up` | `routes.dart`, `app_router.dart` | `admin` app gate | Customer follow-up workspace | CONTROL_ROOM_CANDIDATE | Should be continuity/case only. |
| `/workspace/technical-support` | `routes.dart`, `app_router.dart` | `admin` app gate | Technical support workspace | CONTROL_ROOM_CANDIDATE | Observe/case posture. |
| `/workspace/marketing`, `/workspace/content` | `routes.dart`, `app_router.dart` | `admin` app gate | Marketing/content workspaces | OWNER_ROOM_CANDIDATE | Future owner governance, not Control Room. |
| `/admin/growth-layer` | `routes.dart`, `app_router.dart` | `admin` app gate | Growth/admin planning | OWNER_ROOM_CANDIDATE | Keep out of Control Room. |
| `/admin/employee-system`, `/admin/maintenance` | `routes.dart`, `app_router.dart` | `admin` app gate | Employee/maintenance placeholders | OWNER_ROOM_CANDIDATE | Candidate for owner/infrastructure. |
| `/admin/ai-devops`, `/admin/workspace-command-center` | `routes.dart`, `app_router.dart` | `admin` app gate | AI/devops/command center shell | OWNER_ROOM_CANDIDATE | Preview/planning posture, no runtime command engine yet. |
| `/admin/control-room/*` | `routes.dart`, `app_router.dart` | `admin` app gate | Control Room placeholder pages | PREVIEW_ONLY | Currently still under `/admin`; do not treat as real room. |
| `/admin/blueprint-handoff`, `/admin/compliance-checkpoints`, `/admin/exposure-rules`, `/admin/activation-readiness`, `/admin/system-activation-pack` | `routes.dart`, `app_router.dart` | `admin` app gate | Governance/readiness pages | OWNER_ROOM_CANDIDATE | Planning/governance surfaces. |
| `/admin/gateways/*` | `routes.dart`, `app_router.dart` | `admin` app gate | Gateway previews | PREVIEW_ONLY | Future wrapper/gateway candidates. |
| `/admin/archive*` | `routes.dart`, `app_router.dart` | `admin` app gate | Archive views | CONTROL_ROOM_CANDIDATE | Should remain read/report/audit first. |
| `/admin/session-report` | `routes.dart`, `app_router.dart` | `admin` app gate | Session report view | CONTROL_ROOM_CANDIDATE | Read/report posture. |

## 3. Firestore Collection Inventory

| Collection | Current Use | Current Writers | Current Readers | Authority Source | Risk | Future Target |
| ---------- | ----------- | --------------- | --------------- | ---------------- | ---- | ------------- |
| `booking_requests` | Primary booking, payment, payout, session, intake, center, clinician lifecycle | Clients, centers, clinicians, admin adapters/pages | Participants and admins by rules | Custom claims plus document ownership checks | Critical | Command-backed lifecycle with audit. |
| `bookingRequests` | Legacy/compatibility booking fallback | Some legacy service paths attempt updates | Legacy read fallback in code | Rules deny all access | High | Burial candidate after dependency verification. |
| `clients` | Client profiles and role docs | Client registration; admins can write by rules | Own client/admin | Custom claims and ownership | Medium | Tenant-scoped profile domain. |
| `clinicians` | Clinician profiles, approval, block state | Registration; clinician web profile; admin approval/block/profile apply | Public approved data, own clinician, admin | Custom claims and approval status | Critical | Tenant/professional trust command domain. |
| `centers` | Center profiles, approval, block state | Registration; center web profile; admin approval/block/profile apply | Public approved data, own center, admin | Custom claims and approval status | Critical | Tenant/professional trust command domain. |
| `admins` | Admin role docs and admin metadata | Admin by rules; read during account resolution and center request flow | Admins; limited app-side lookups | Admin custom claim | Critical | Owner/system identity registry; freeze broad writes. |
| `ai_policies` | AI policy drafts/published configs | Admin AI policy page | Admin | Admin custom claim | High | Owner Room registry/policy command domain. |
| `system_domains` | Domain health/status emitted by services | Admin/system health services in app code | Admin | Admin custom claim | High | Owner/system registry or backend-only status writes. |
| `chat_threads` | Chat threads, risk/lifecycle metadata | Chat service, booking legacy chat adapter, chat page | Participants and admins | Claims plus thread participant logic | High | Chat domain with case/audit wrappers. |
| `chat_threads/{threadId}/messages` | Chat messages | Signed-in participants/services | Participants and admins | Rules allow create if signed in and thread exists | Medium | Tenant-safe messaging plus escalation audit. |
| `chat_escalations` | Escalation records | Signed-in create; admin/service updates | Admin and involved clinician/client | Custom claims plus ownership fields | High | Case-linked command/audit domain. |
| `chat_escalations/{id}/reports` | Escalation reports | Signed-in create | Admin/involved users by rules | Custom claims plus ownership fields | Medium | Append-only case report artifact. |
| `external_follow_up_registry` | Follow-up registry entries | Admin follow-up services | Admin | Admin custom claim | High | Owner/continuity registry; command/audit required. |
| `external_follow_up_message_templates` | Follow-up message templates | Admin follow-up services | Admin | Admin custom claim | High | Owner/continuity registry; audit required. |
| `external_follow_up_campaigns` | Follow-up campaigns | Admin follow-up services | Admin | Admin custom claim | High | Owner/continuity campaign governance. |
| `analytics_summaries` | Admin analytics summaries | Rules deny client writes; repository reads | Admin | Trusted tooling implied | Medium | Observability artifact, backend/system writer only. |
| `system_alerts` | Admin system alerts | Rules deny client writes | Admin | Trusted tooling implied | Medium | Observability artifact, backend/system writer only. |
| `system_health` | System health docs | Rules deny client writes | Admin | Trusted tooling implied | Medium | Observability artifact. |
| `support_requests` | User support requests | Client/module/clinician surfaces | Own user/admin | Claims plus ownership | Medium | Case/continuity domain. |
| `sessionRatings` | Session reviews/ratings | Client/clinician review page | Admin and related users | Claims plus related booking | Medium | Audit-linked review artifact. |
| `clinician_profile_change_requests` | Clinician profile change review queue | Clinician creates; admin reviews | Own clinician/admin | Claims plus ownership | High | Command request style profile change. |
| `center_profile_change_requests` | Center profile change review queue | Center creates; admin reviews | Own center/admin | Claims plus ownership | High | Command request style profile change. |
| `resources` | Resource content | Admin writes | Signed-in reads | Admin custom claim | Medium | Owner/content governance. |
| `debug` | Debug denied collection | None | None | Rules deny all | Low | Keep denied. |

## 4. Firestore Write Path Inventory

| File | Method / Function | Operation | Collection / Doc Path | Actor | Current Authority | Risk | Suggested Future Treatment |
| ---- | ----------------- | --------- | --------------------- | ----- | ----------------- | ---- | -------------------------- |
| `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | `updateRequestEverywhere`, `updatePrimaryCenterRequest` | `update` | `booking_requests/{id}` | Admin UI | ADMIN_DIRECT | Critical | COMMAND_REQUIRED_FUTURE + AUDIT_REQUIRED_FUTURE |
| `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | `assignClinician`, `rejectRequest`, `returnToPending` | `update` | `booking_requests/{id}` | Admin UI | ADMIN_DIRECT | Critical | Command wrapper for booking lifecycle |
| `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | `approveCenterRequest`, `returnCenterRequestToClient`, `openCenterIntakeStep` | `update` | `booking_requests/{id}` | Admin UI | ADMIN_DIRECT | Critical | Case/command/audit wrapper |
| `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | `approvePayment`, `rejectPayment` | `update` | `booking_requests/{id}` | Admin UI | ADMIN_DIRECT | Critical | SOVEREIGN_COMMAND_REQUIRED |
| `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | `confirmCenterAccountingReview`, `confirmCenterPayout`, `confirmClinicianPayout` | `update` | `booking_requests/{id}` | Admin UI | ADMIN_DIRECT | Critical | SOVEREIGN_COMMAND_REQUIRED |
| `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | `sendToSessionArchive`, `sendToFinancialArchive` | `update` | `booking_requests/{id}` | Admin UI | ADMIN_DIRECT | High | AUDIT_REQUIRED_FUTURE |
| `lib/features/admin_surface/data/services/admin_payment_decision_adapter.dart` | `approvePayment`, `rejectPayment`, `confirmClinicianPayout`, `confirmCenterPayout` | `update` | `booking_requests/{id}` | Admin UI | ADMIN_DIRECT | Critical | SOVEREIGN_COMMAND_REQUIRED |
| `lib/features/admin_surface/data/services/admin_payment_decision_adapter.dart` | archive methods | `update` | `booking_requests/{id}` | Admin UI | ADMIN_DIRECT | High | Audit-linked archive command |
| `lib/features/admin_surface/data/services/admin_session_decision_adapter.dart` | `scheduleSession`, `scheduleCenterResidency`, `markInProgress`, `markCompleted`, `moveToReschedule` | `update` | `booking_requests/{id}` | Admin UI | ADMIN_DIRECT | Critical | Session lifecycle command wrapper |
| `lib/features/admin_surface/pages/admin_clinician_requests_page.dart` | approve/reject/return pending | `update` | `clinicians/{id}` | Admin UI | ADMIN_DIRECT | Critical | Professional approval command |
| `lib/features/admin_surface/pages/admin_centers_page.dart` | approve/reject/follow-up/document/block UI | `update` | `centers/{id}` | Admin UI | ADMIN_DIRECT | Critical | Center trust command wrapper |
| `lib/core/auth/account_access_service.dart` | `AccountBlockingService.block`, `unblock` | `update` | dynamic collection/doc | Admin/tooling caller | ADMIN_DIRECT | Critical | Authority command with scoped target validation |
| `lib/features/admin_surface/pages/admin_clinician_profile_requests_page.dart` | approve clinician request | `set merge`, `update` | `clinicians/{id}`, `clinician_profile_change_requests/{id}` | Admin UI | ADMIN_DIRECT | High | Profile change command + audit |
| `lib/features/admin_surface/pages/admin_clinician_profile_requests_page.dart` | approve center request | `set merge`, `update` | `centers/{id}`, `center_profile_change_requests/{id}` | Admin UI | ADMIN_DIRECT | High | Profile change command + audit |
| `lib/features/admin_surface/pages/admin_ai_policy_page.dart` | save draft / publish policy | `set` | `ai_policies/{id}` | Admin UI | ADMIN_DIRECT | High | Owner Room policy command + registry audit |
| `lib/features/admin_surface/services/ai_policy_health_service.dart` | emit health | `set` | `system_domains/aiPolicy` | App service/admin context | SYSTEM_DIRECT | High | Backend-only system domain writer |
| `lib/features/booking/data/services/booking_health_service.dart` | emit health | `set` | `system_domains/booking` | App service/admin context | SYSTEM_DIRECT | High | Backend-only health writer |
| `lib/features/chat/data/services/chat_health_service.dart` | emit health | `set` | `system_domains/chat` | App service/admin context | SYSTEM_DIRECT | High | Backend-only health writer |
| `lib/features/chat/data/services/chat_firestore_service.dart` | `createThread` | `set` | `chat_threads/{id}` | Signed-in app actor | TENANT_SAFE | Medium | Keep scoped; add audit for escalation-sensitive threads |
| `lib/features/chat/data/services/chat_firestore_service.dart` | `sendMessage` | transaction set/update | `chat_threads/{id}/messages`, `chat_threads/{id}` | Participant | TENANT_SAFE | Medium | Keep scoped; validate participant and risk updates |
| `lib/features/chat/data/services/chat_firestore_service.dart` | `assignEscalationToAdmin`, `forwardEscalationToClinician`, `resolveEscalation` | transaction update | `chat_escalations/{id}`, `chat_threads/{id}` | Admin UI/service | ADMIN_DIRECT | High | CASE_LINKED_COMMAND + audit |
| `lib/features/chat/data/services/chat_firestore_service.dart` | `createEscalation`, `createSafetyReport` | `add` | `chat_escalations`, reports subcollection | Signed-in actor/service | AUDIT_REQUIRED_FUTURE | High | Case/audit wrapper |
| `lib/features/booking/data/services/booking_legacy_chat_adapter.dart` | create/link/send booking thread | `set`, `add`, `update` | `chat_threads`, messages | Booking flow service | SYSTEM_DIRECT | Medium | Legacy adapter freezer; future chat command/audit wrapper |
| `lib/features/booking/presentation/pages/booking_request_page.dart` | create booking request | `set`, `update` | `booking_requests/{id}` | Client | TENANT_SAFE | Medium | Keep scoped; add command envelope later |
| `lib/features/booking/presentation/pages/center_booking_request_page.dart` | create/update center booking request | `set`, `update` | `booking_requests/{id}` | Client | TENANT_SAFE | Medium | Keep scoped; add audit for lifecycle changes |
| `lib/features/booking/presentation/pages/my_bookings_page.dart` | create booking / submit intake | `set`, `update` | `booking_requests/{id}` | Client | TENANT_SAFE | Medium | Add audit-ready metadata |
| `lib/features/client/presentation/pages/client_payment_proof_page.dart` | submit/confirm payment proof fields | `update` | `booking_requests/{id}` | Client | TENANT_SAFE | High | Payment evidence command/audit wrapper |
| `lib/features/client/presentation/pages/client_sessions_page.dart` | client check-in/session fields | `update` | `booking_requests/{id}` | Client | TENANT_SAFE | High | Session lifecycle command wrapper |
| `lib/features/booking/data/services/center_inbox_service.dart` | respond to availability | `update` | `booking_requests/{id}`, legacy fallback | Center | TENANT_SAFE | High | Center lifecycle command wrapper |
| `lib/features/booking/data/services/center_request_inbox_service.dart` | update center availability | `update` | `booking_requests/{id}` | Center | TENANT_SAFE | High | Center lifecycle command wrapper |
| `lib/features/booking/presentation/pages/clinician_inbox_page.dart` | clinician accept/reject | `update` | `booking_requests/{id}`, legacy fallback | Clinician | TENANT_SAFE | High | Professional lifecycle command wrapper |
| `lib/features/clinician/presentation/pages/clinician_operations_page.dart` | booking response/completion | `update` | `booking_requests/{id}`, legacy fallback | Clinician | TENANT_SAFE | High | Session/booking command wrapper |
| `lib/features/clinician/presentation/pages/clinician_operations_page.dart` | create support/escalation/profile/rating artifacts | `add` | `support_requests`, `chat_escalations`, `sessionRatings`, `clinician_profile_change_requests` | Clinician | TENANT_SAFE | Medium | Audit-ready artifact wrapper |
| `lib/features/centers/presentation/pages/center_operations_page.dart` | create center profile change requests | `add` | `center_profile_change_requests` | Center | TENANT_SAFE | Medium | Keep request-based; add audit |
| `lib/features/centers/data/services/centers_firestore_service.dart` | create/update/block center | `set`, `update` | `centers/{id}` | Service caller | ADMIN_DIRECT | High | Restrict callers; command wrapper for trust state |
| `lib/features/web_registration/presentation/pages/web_clinician_*.dart` | registration/profile/session/docs | `set`, `update` | `clinicians/{uid}` | Clinician user | TENANT_SAFE | Medium | Keep scoped; require approval lifecycle |
| `lib/features/web_registration/presentation/pages/web_center_*.dart` | registration/profile/media/pricing/docs | `set`, `update` | `centers/{uid}` | Center user | TENANT_SAFE | Medium | Keep scoped; require approval lifecycle |
| `lib/features/auth/presentation/pages/client_register_page.dart` | client registration | `set` | `clients/{uid}` | Client user | TENANT_SAFE | Low | Stable. |
| `lib/features/auth/presentation/pages/clinician_register_page.dart` | clinician registration | `set` | `clinicians/{uid}` | Clinician user | TENANT_SAFE | Medium | Approval lifecycle required. |
| `lib/features/centers/presentation/pages/center_register_page.dart` | center registration | `set`, auth cleanup delete | `centers/{uid}` | Center user | TENANT_SAFE | Medium | Approval lifecycle required. |
| `lib/features/reviews/presentation/pages/session_review_page.dart` | submit review and update booking review markers | `set`, `update` | `sessionRatings/{id}`, `booking_requests/{id}` | Client/clinician | TENANT_SAFE | Medium | Audit-ready review wrapper. |
| `lib/features/modules/presentation/pages/support_issue_selector_page.dart` | create support request | `set` | `support_requests/{id}` | Signed-in user | TENANT_SAFE | Low | Case link later. |
| `lib/features/external_follow_up/data/services/follow_up_registry_service.dart` | create/update/archive registry entry | `set`, `update` | `external_follow_up_registry/{id}` | Admin UI/service | ADMIN_DIRECT | High | Owner/continuity registry command. |
| `lib/features/external_follow_up/data/services/follow_up_message_template_service.dart` | create/update/archive template | `set`, `update` | `external_follow_up_message_templates/{id}` | Admin UI/service | ADMIN_DIRECT | High | Owner/continuity registry command. |
| `lib/features/external_follow_up/data/services/follow_up_campaign_service.dart` | create/update campaign | `set`, `update` | `external_follow_up_campaigns/{id}` | Admin UI/service | ADMIN_DIRECT | High | Continuity command/audit wrapper. |

## 5. Admin Authority Map

| Admin Surface / Service | Current Powers | Collections Mutated | Future Room | Risk | Freeze Decision |
| ----------------------- | -------------- | ------------------- | ----------- | ---- | --------------- |
| Admin Hub | Observes summaries, navigates admin surface | None directly identified | Legacy Frozen | Medium | Freeze as compatibility entry. |
| Admin Operations | Mixed operational cockpit | Indirect via child pages/adapters | Control Room observe/case only | High | Freeze expansion; split later. |
| Admin Booking Queue | Assign, reject, return, move stages, center lifecycle | `booking_requests` | Trusted Backend Command | Critical | No expansion; wrap first. |
| Admin Payments | Approve/reject payment, confirm payouts, archive | `booking_requests` | Sovereign Finance/Legal | Critical | Freeze direct expansion; sovereign command future. |
| Admin Sessions | Schedule, progress, complete, reschedule | `booking_requests` | Trusted Backend Command | Critical | Wrap with session command. |
| Admin Accounting | Accounting visibility/workspace | `booking_requests` through related pages/adapters | Sovereign Finance/Legal | Critical | Freeze as sovereign candidate. |
| Admin Clinician Requests | Approve/reject/pending clinician trust | `clinicians` | Trusted Backend Command | Critical | Wrap approval lifecycle. |
| Admin Centers | Approve/reject/follow-up/block/document status | `centers` | Trusted Backend Command | Critical | Wrap approval/block lifecycle. |
| Admin Profile Requests | Apply requested profile changes | `clinicians`, `centers`, profile request collections | Trusted Backend Command | High | Keep request-based; wrap apply step. |
| Admin Clients | Client visibility | Primarily read | Control Room observe/case only | Medium | Read-only future. |
| Admin Support Chats | Chat/support oversight | Chat through services | Control Room observe/case only | High | Case/audit wrapper. |
| Chat Escalations | Assign, forward, resolve escalations | `chat_escalations`, `chat_threads` | Control Room observe/case only | High | Convert mutation to case commands. |
| Admin AI Policies | Draft/publish AI policies | `ai_policies`, `system_domains` | Owner Room | High | Owner policy registry candidate. |
| Admin System Domains | Domain health/status governance | `system_domains` | Owner Room | High | Backend/system writer future. |
| Alerts Review | Read alerts | None by rules | Control Room observe/case only | Medium | Keep observe-only. |
| Archives | Archive visibility | Some archive adapters mutate booking archive status | Control Room observe/case only | High | Archive finalization needs audit. |
| Gateway Pages | Gateway previews | No command runtime confirmed | Owner Room | Medium | PREVIEW_ONLY; no runtime authority. |
| Marketing/Content Workspaces | Marketing/content governance | External follow-up and content surfaces | Owner Room | High | Do not treat as Control Room. |
| External Follow-up Workspace | Registry/templates/campaigns | `external_follow_up_*` | Owner Room / Control continuity boundary | High | Separate continuity governance from marketing ownership. |

## 6. Role / Claims Reality

Current role names observed in app-side routing are:

- `admin`
- `clinician`
- `center`
- `client`

App-side role documents are resolved by `AccountAccessService`. It checks `admins/{uid}` or active admin by email first, then clinician, center, and client records. This controls the Flutter navigation experience and approval/active-state gating.

Firestore custom claims are the actual data authority in `firestore.rules`. The rules explicitly depend on `request.auth.token.role`, not only on role documents. This creates a compatibility mismatch: a user can appear as one role in app-side documents while Firestore authority is controlled by Firebase custom claims.

The broadest authority is `role == "admin"`. It can read/write many operational and sovereign-like collections. This is the main super-role residue.

| Current Role / Claim | Current Meaning | Problem | Future Claim Family Candidate |
| -------------------- | --------------- | ------- | ----------------------------- |
| `role == "admin"` custom claim | Broad admin Firestore authority | Mixes observability, operations, owner, finance, AI, system, approval, and mutation authority | `control.*`, `owner.*`, `sovereign.*`, `system.*` |
| `admins/{uid}` role doc | App-side admin resolution | UI role doc does not equal Firestore claim authority | `owner.identity` or admin compatibility registry |
| `role == "client"` custom claim | Client Firestore ownership | Mostly scoped, but booking/payment/session writes touch lifecycle truth | `tenant.*` |
| `clients/{uid}` role doc | App-side client profile and role resolution | Depends on document consistency with auth claim | `tenant.client` |
| `role == "clinician"` custom claim | Clinician own profile and assigned workflow authority | Professional state changes can mutate lifecycle fields | `tenant.operator`, professional scoped claims |
| `clinicians/{uid}` role doc | App-side clinician approval/active gate | Approval status is app-gated and rule-aware but still admin-mutated | `tenant.professional` |
| `role == "center"` custom claim | Center own profile and center workflow authority | Center lifecycle writes affect booking truth | `tenant.operator`, center scoped claims |
| `centers/{uid}` role doc | App-side center approval/active gate | Approval/block status is admin-mutated | `tenant.center` |
| Signed-in participant | Chat/support create authority | Some creates are broad if signed in and thread exists | `tenant.support`, `control.case_request` |
| Service-like app writers | Health/system domain writes from client app code paths | System truth should not be client-side writable | `system.audit_writer`, `system.registry_manager` |

## 7. Dangerous Zones

| Zone | Why Dangerous | Current Entry Points | Risk | First Safe Treatment |
| ---- | ------------- | -------------------- | ---- | -------------------- |
| Booking lifecycle mutations | Booking state drives operational truth across client/clinician/center/admin | Admin booking adapter, client booking pages, clinician/center inbox services | Critical | Inventory exact transitions, freeze admin expansion, design command wrapper. |
| Payment approval/rejection | Payment truth and service progression are financial/operational authority | Admin booking/payment adapters, client payment proof page | Critical | Sovereign command wrapper and immutable audit before enforcement. |
| Payout confirmation | Money movement confirmation is sovereign-grade truth | Admin booking/payment adapters | Critical | Sovereign Finance/Legal command only; no early activation. |
| Session lifecycle changes | Changes clinical/operational completion and archive readiness | Admin session adapter, client sessions, clinician operations | Critical | Session lifecycle command and audit chain. |
| Clinician/center approval/blocking | Controls professional trust and platform access | Admin clinician requests, admin centers, `AccountBlockingService` | Critical | Professional trust command with scoped target validation. |
| Profile change approval application | Admin applies user-submitted changes into source profile docs | Admin profile request page | High | Keep request collections; wrap apply step with audit. |
| Chat escalation updates | Escalation resolution/forwarding can affect safety and continuity | `ChatFirestoreService`, chat escalation pages | High | Case-linked command/audit wrapper. |
| AI policy publishing | AI behavior governance is owner-level authority | Admin AI policy page | High | Owner policy registry command; no Control Room mutation. |
| System domain writes | Runtime health/status can become hidden operational authority | Health services and admin system domain pages | High | Backend-only system domain writer. |
| Admin collection writes | Admin identity/authority metadata can reproduce super-admin behavior | `admins` collection rules allow admin write | Critical | Freeze; future owner/system identity registry. |

## 8. Legacy / Freezer Candidates

| Item | Type | Current Status | Why Frozen | Future Action |
| ---- | ---- | -------------- | ---------- | ------------- |
| `/admin/*` | Route family | Active compatibility shell | Contains mixed control, owner, finance, AI, system, and operational mutation authority | FROZEN_NO_EXPANSION; classify in W2. |
| `/admin/control-room/*` | Preview route family | Admin-gated placeholder/control preview | Not a real separated Control Room yet | PREVIEW_ONLY until passive shell is grounded. |
| `/admin/gateways/*` | Preview route family | Admin-gated gateway previews | No trusted command runtime exists yet | PREVIEW_ONLY; future wrapper planning only. |
| `/home` | Alias route | Active alias to menu | Compatibility route, not a new topology anchor | Keep compatibility; no expansion. |
| `/register/clinician`, `/register/center` | Legacy aliases/pages | Active legacy registration surfaces | Web registration portal also exists | Keep stable; later consolidate after verification. |
| `/chat/clinician/inbox` | Alias route | Active legacy clinician chat route | Duplicate/compatibility alias | Keep frozen until deep links verified. |
| `bookingRequests` | Firestore collection | Legacy fallback in code, rules deny all | Ghost compatibility collection can confuse authority | BURIAL_CANDIDATE after no-dependency proof. |
| `BookingLegacyChatAdapter` | Service adapter | Active booking-chat bridge | Legacy compatibility behavior writes chat artifacts | COMMAND_REQUIRED_FUTURE / freezer label. |
| Admin booking/payment/session adapters | Service adapters | Active direct mutation adapters | Central direct admin mutation surface | COMMAND_REQUIRED_FUTURE; wrap first. |
| External follow-up services | Service adapters | Active admin-owned writes | Mixes continuity, marketing, owner governance | OWNER_ROOM_CANDIDATE with continuity boundaries. |
| AI policy page/services | Admin surface/service | Active admin policy writer | Owner-level policy authority lives under admin | OWNER_ROOM_CANDIDATE; registry/audit later. |
| System domain services | Service adapters | Active app-side status writers | System truth should not be client-side authority | SYSTEM_DIRECT freezer, backend-only future. |

## 9. Final Verdict

Safe now:

- Documentation-only inventory.
- Freezer label planning.
- Route and authority map refinement.
- Passive command/audit/registry artifact specifications.

Must not be touched yet:

- Firestore rules.
- Firebase custom claims.
- `/admin/*` route migration.
- Financial approval/payout execution.
- Auth/role authority.
- Tenant suspension/blocking enforcement.
- Booking/session lifecycle enforcement.

Should be wrapped first:

- `AdminBookingDecisionAdapter`.
- `AdminPaymentDecisionAdapter`.
- `AdminSessionDecisionAdapter`.
- `AccountBlockingService`.
- Admin profile approval application.
- Chat escalation assign/forward/resolve methods.

Needs audit first:

- Booking lifecycle transitions.
- Payment approval/rejection.
- Payout confirmations.
- Session scheduling/completion.
- Clinician/center approval and blocking.
- Profile change application.
- AI policy publish.
- System domain writes.

Recommended GROUNDING-W2 next step:

Create a legacy freezer registry and route/service labels document. Start with `/admin/*`, `bookingRequests`, admin mutation adapters, legacy chat adapter, AI policy/system domain writers, external follow-up services, and all compatibility aliases. W2 should still avoid runtime enforcement and should produce labels plus allowed/forbidden change rules.

## Inspected Sources

- `lib/app/router/routes.dart`
- `lib/app/router/app_router.dart`
- `lib/core/auth/account_access_service.dart`
- `firestore.rules`
- `lib/core/system/domain_registry.dart`
- `lib/features/admin_surface/`
- `lib/features/booking/`
- `lib/features/chat/`
- `lib/features/client/`
- `lib/features/clinician/`
- `lib/features/centers/`
- `lib/features/external_follow_up/`
- `mental_smile_clean_core/lib/`

