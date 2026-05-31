# PROJECT STATE 0
# Mental Smile Reality Snapshot

Date: 2026-05-30

Purpose:

If the project disappeared tomorrow, this document should explain what exists today.

This is a reality snapshot. It is not a vision document, not a future-state document, and not a new constitutional document.

Evidence base:

- Flutter runtime under `lib/`.
- Firebase rules in `firestore.rules` and `storage.rules`.
- Cloud Functions in `functions/index.js`.
- Current project documents under `docs/`.
- Pilot Foundation PF-0, PF-1, and PF-2.
- Grounding, extraction, sovereign, MASTER, and constitutional documents.

No cleanup is prescribed here.

---

# PART A: Executive Reality Summary

Mental Smile today is a Flutter/Firebase mental-health support platform with:

- public/app navigation for client support, addiction/family-support entry paths, specialists, centers, library, booking, chat, and registration;
- role-gated surfaces for client, clinician, center, and admin users;
- a large admin surface that currently carries operations, trust review, booking, payments, sessions, support, archive, reporting, AI policy, domain status, and preview Control Room concepts;
- Firestore/Storage rules that enforce custom-claim role authority more strictly than the UI;
- a strong doctrine/documentation archive that is ahead of several runtime departments;
- pilot readiness that is real but uneven, with several operational lines requiring manual process discipline.

Current maturity level:

- Product runtime: PARTIAL but substantial.
- Governance runtime: PARTIAL; mostly admin-surface plus documentation.
- Constitutional maturity: strong doctrine, early runtime grounding.
- Trust function: READY_WITH_MANUAL_PROCESS.
- Survey runtime: not confirmed; manual/external survey required unless implemented separately.
- Protected memory / sovereign archive runtime: constitutional only or documentation/manual.

Current operating model:

- Founder/Owner-led.
- Technical execution exists.
- Trust, Control, Archive, Finance, Legal, Marketing, and Support are mostly delegated or conceptual functions, not mature staffed departments.
- Admin custom claims are the main privileged runtime authority.
- Docs/manual packages are currently the strongest institutional memory.

Current architecture state:

- Flutter app with centralized route constants in `lib/app/router/routes.dart`.
- Route access gated in `lib/app/router/app_router.dart`.
- Firebase Auth + custom claims drive backend authorization.
- Firestore collections are mixed: some active runtime, some legacy compatibility, some admin-only operational stores, some analytics/health stores.
- Storage paths exist for documents and public assets, but many current UI flows store file names/URLs rather than confirmed direct upload flows.
- Admin surface remains broad and carries residue from domains that future topology separates.

Current constitutional state:

- Constitution V1 exists.
- Constitution V2 exists and is the active constitutional frame.
- MASTER-1 reconciles current reality and constitutional growth.
- MASTER-2 defines governance topology.
- MASTER-3 defines construction sequence.
- Grounding/extraction/sovereign docs define freezes, wrappers, authority boundaries, and future separation.

Current pilot readiness:

- Pilot can proceed only as a controlled, manual-assisted pilot.
- Center and clinician trust verification are the strongest pilot-ready lines, if PF-2 checklist discipline is used.
- Client registration and booking need write-path verification before live cohort use.
- Follow-up is partial and consent-sensitive.
- Survey answers are blocked or manual-only until a confirmed survey runtime or external/manual survey process is selected.
- Survey analysis can be manual/docs-based with human review.

---

# PART B: Project Topology Inventory

| Domain | Exists? | Runtime? | Current state |
|---|---:|---:|---|
| App shell | Yes | Yes | ACTIVE. Flutter app, splash/language/login/menu, route gates. |
| Web | Yes | Yes | PARTIAL. Flutter web registration/library routes and `web/` host files exist. |
| Control Room | Yes | Partial | PARTIAL/PLACEHOLDER. Admin hub, domain status, alerts, analytics summaries, preview Control Room pages. |
| Registration | Yes | Yes | PARTIAL. Client, clinician, center runtime exists; web clinician/center portal exists; legacy app routes remain. |
| Trust | Yes | Partial | READY_WITH_MANUAL_PROCESS. Approval/status fields and admin review pages exist; protected trust audit runtime does not. |
| Client | Yes | Yes | ACTIVE/PARTIAL. Dashboard, sessions, payment proof, bookings, support entry. |
| Clinician | Yes | Yes | ACTIVE/PARTIAL. Operations, sessions, inbox, chat inbox, profile change requests. |
| Center | Yes | Yes | ACTIVE/PARTIAL. Dashboard, operations, inbox, residencies, profile updates, center listing/details. |
| Booking | Yes | Yes | ACTIVE/PARTIAL. `booking_requests` is primary; `bookingRequests` is legacy denied by rules. |
| Chat | Yes | Yes | ACTIVE/PARTIAL. Threads, messages, escalations, reports, AI policy caveats, clinician/admin views. |
| Follow-up | Yes | Partial | PARTIAL. External follow-up registry/templates/campaigns and support workspace exist; consent/archive process still manual. |
| Library | Yes | Yes | PARTIAL. Library UI exists with featured domains and category placeholders; `resources` collection seeded/admin writable. |
| Support | Yes | Yes | PARTIAL. Structured support requests and admin support chat exist; not a therapy-continuation system. |
| Surveys | Partial | Partial | PARTIAL. Session review/rating runtime exists through `sessionRatings`; broader pilot survey runtime is not confirmed. |
| Analytics | Yes | Partial | PARTIAL. Firebase Analytics client, scheduled BigQuery summary writer to `analytics_summaries`, admin reports. |
| Reports | Yes | Partial | PARTIAL. Admin session report and archive report pages exist; docs are main report archive. |
| Admin Surface | Yes | Yes | ACTIVE/PARTIAL. Broad operational shell with residue; custom-claim gated. |
| Owner Concepts | Yes | No/Manual | CONSTITUTIONAL/MANUAL. Owner Room doctrine exists; runtime mostly admin/founder process. |
| Finance Concepts | Yes | Partial | PARTIAL/FROZEN. Payment proof, payment admin pages, accounting archive exist; sovereign finance doctrine exists separately. |
| Legal Concepts | Yes | Mostly docs | CONSTITUTIONAL/PARTIAL. Legal/consent doctrine exists; runtime consent/legal memory not mature. |
| Marketing Concepts | Yes | Preview | PLACEHOLDER/PARTIAL. Marketing workspace/growth layer exist as admin surfaces, not live campaign engine. |
| AI Policy | Yes | Partial | PARTIAL. `ai_policies`, admin AI policy page, AI DevOps/manual governance pages. |
| Clean Core package | Yes | Yes as package | PARTIAL. `mental_smile_clean_core` contains governance, audit, backend-boundary, human-review, policy runtime types; mostly semantic/contracts. |

---

# PART C: Route Inventory

## APP

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/` | Splash | ACTIVE | Yes | Low | Keep. |
| `/language` | Language selection | ACTIVE | Yes | Low | Keep. |
| `/login` | Authentication | ACTIVE | Yes | Low | Keep. |
| `/account-blocked` | Blocked/pending/rejected access UX | ACTIVE | Yes | Low | Keep. |
| `/menu` | Primary operational menu | ACTIVE | Yes | Low | Keep. |
| `/home` | Alias opening menu; old HomePage is legacy/welcome surface | LEGACY ALIAS | Yes | Medium | Frozen compatibility. |

## WEB

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/web/center/*` | Center web registration portal steps | ACTIVE/PARTIAL | Yes | Medium with `/register/center` | Canonical for center web registration. |
| `/web/clinician/*` | Clinician web registration portal steps | ACTIVE/PARTIAL | Yes | Medium with `/register/clinician` | Canonical for clinician web registration. |
| `/web/register/success` | Registration completion | ACTIVE | Yes | Low | Keep. |
| `/web/library` | Web library | ACTIVE/PARTIAL | Yes | Medium with `/module/library` | Alias/parallel surface. |
| `/web/library/policy` | Library policy | ACTIVE | Yes | Low | Keep. |

## ADMIN

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/admin/hub` | Admin entry/control hub | ACTIVE | Yes | Medium; carries many domains | Keep but do not expand authority casually. |
| `/admin/operations` | Operational admin area | ACTIVE/PARTIAL | Yes | Medium | Frozen for unreviewed expansion. |
| `/admin/booking-queue` | Booking lifecycle queue | ACTIVE/SHADOW-WRAPPED | Yes | High authority coupling | Frozen; wrappers documented. |
| `/admin/payments` | Payment review/admin | ACTIVE/PARTIAL | Yes | Finance residue | Frozen for sovereign finance expansion. |
| `/admin/sessions` | Session setup/completion/admin review | ACTIVE/PARTIAL | Yes | Finance/control/session coupling | Frozen for new authority. |
| `/admin/session-report` | Booking/session report view | ACTIVE | Yes | Low | Keep. |
| `/admin/clients` | Client admin list | ACTIVE/PARTIAL | Yes | Medium | Keep. |
| `/admin/clinician-requests` | Clinician approval queue | ACTIVE | Yes | Trust residue | Use with PF-2 discipline. |
| `/admin/clinician-workspace` | Clinician admin workspace | ACTIVE/PARTIAL | Yes | Medium | Keep. |
| `/admin/clinician-profile-requests` | Clinician/center profile change review | ACTIVE | Yes | Trust/profile coupling | Keep, manual trust notes required. |
| `/admin/centers` | Center approval/list | ACTIVE | Yes | Trust residue | Use with PF-2 discipline. |
| `/admin/centers/details` | Center details admin view | ACTIVE | Yes | Low | Keep. |
| `/admin/support-chats` | Admin support/chat visibility | ACTIVE/PARTIAL | Yes | Support/chat residue | Keep with support boundary. |
| `/admin/alerts-review` | System alert review | ACTIVE/PARTIAL | Yes | Low | Admin-only. |
| `/admin/ai-policies` | AI policy docs/runtime settings | ACTIVE/PARTIAL | Yes | Medium | Admin-only. |
| `/admin/system-domains` | Domain status | ACTIVE/PARTIAL | Yes | Low | Admin-only. |
| `/admin/domain-availability` | Domain availability | PARTIAL | Yes | Low | Admin-only. |
| `/admin/archive*` | Archive views for sessions/payments/reports/clinicians/centers/support/accounting | ACTIVE/PARTIAL | Yes | Medium | Keep as archive surface, docs remain stronger archive. |
| `/admin/accounting` | Accounting workspace | PARTIAL | Yes | Finance residue | Frozen for sovereign finance expansion. |

## CONTROL

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/admin/control-room/guided-workflows` | Preview Control Room workflow shell | PLACEHOLDER | No operational runtime | Medium | Placeholder/frozen. |
| `/admin/control-room/references` | Preview references | PLACEHOLDER | No operational runtime | Low | Placeholder/frozen. |
| `/admin/control-room/detailed-monitoring` | Preview monitoring | PLACEHOLDER | No operational runtime | Medium | Placeholder/frozen. |
| `/admin/control-room/analytics-details` | Preview analytics detail | PLACEHOLDER | No operational runtime | Medium | Placeholder/frozen. |
| `/admin/gateways*` | Gateway governance/visibility shells | PREVIEW/PARTIAL | Yes as UI | Medium | Not live integrations. |
| `/admin/blueprint-handoff`, `/admin/compliance-checkpoints`, `/admin/exposure-rules`, `/admin/activation-readiness`, `/admin/system-activation-pack` | Constitutional/control docs surfaced in app | PARTIAL | Yes as UI | Low | Governance surfaces only. |

## REGISTRATION

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/register/client` | Client registration | ACTIVE/PARTIAL | Yes | Low | Verify rules before pilot. |
| `/register/clinician` | Legacy clinician app registration | LEGACY COMPATIBILITY | Yes | High with web portal | Frozen; no new architecture. |
| `/register/center` | Legacy center app registration | LEGACY COMPATIBILITY | Yes | High with web portal | Frozen; no new architecture. |
| `/web/clinician/register` | Web clinician registration entry | ACTIVE/PARTIAL | Yes | Medium | Preferred current web path. |
| `/web/center/register` | Web center registration entry | ACTIVE/PARTIAL | Yes | Medium | Preferred current web path. |
| `/follow-up/register` | External follow-up registration | PARTIAL | Admin-protected | Low | Consent-sensitive. |

## CLIENT

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/client/dashboard` | Client dashboard | ACTIVE/PARTIAL | Yes | Low | Role-gated. |
| `/client/payment-proof` | Payment proof reference flow | ACTIVE/PARTIAL | Yes | Finance coupling | Keep; storage/upload path is mostly reference fields. |
| `/client/sessions` | Client session tracking | ACTIVE/PARTIAL | Yes | Medium with bookings | Keep. |
| `/booking/my` | Client bookings | ACTIVE/PARTIAL | Yes | Medium with sessions | Keep. |

## CLINICIAN

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/clinician/operations` | Main clinician operations | ACTIVE/PARTIAL | Yes | Medium | Role + approval gated. |
| `/clinician/sessions` | Clinician sessions | ACTIVE/PARTIAL | Yes | Medium | Keep. |
| `/clinician/inbox` | Booking inbox | ACTIVE/PARTIAL | Yes | Legacy fallback risk | Keep; legacy `bookingRequests` fallback exists in code. |
| `/clinician/chat-inbox` | Chat escalation inbox | ACTIVE/PARTIAL | Yes | Medium | Keep. |
| `/chat/clinician/inbox` | Legacy alias | LEGACY COMPATIBILITY | Yes | High | Frozen; burial only after link verification. |
| `/clinician/profile-edit-request` | Profile change request | ACTIVE/PARTIAL | Yes | Trust/profile coupling | Keep with admin review. |

## CENTER

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/center/dashboard` | Center dashboard | ACTIVE/PARTIAL | Yes | Low | Role + approval gated. |
| `/center/operations` | Center profile/operations | ACTIVE/PARTIAL | Yes | Medium | Keep with admin profile requests. |
| `/center/inbox` | Center booking inbox | ACTIVE/PARTIAL | Yes | Legacy fallback risk | Keep. |
| `/center/residencies` | Center residency/session flow | ACTIVE/PARTIAL | Yes | Medium | Keep. |
| `/center/profile-edit-request` | Profile change request | ACTIVE/PARTIAL | Yes | Trust/profile coupling | Keep. |

## SUPPORT

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/module/support-issue-selector` | Structured support request entry | ACTIVE/PARTIAL | Yes | Low | Keep. |
| `/chat` | Support chat | ACTIVE/PARTIAL | Yes | Chat/support boundary risk | Keep; not therapy replacement. |
| `/chat/escalations` | Admin escalation queue | ACTIVE/PARTIAL | Admin/clinician | Medium | Keep with human review boundary. |
| `/chat/escalation/report` | Chat escalation report | ACTIVE/PARTIAL | Admin | Medium | Keep. |
| `/workspace/customer-follow-up` | Customer follow-up workspace | PARTIAL | Admin | Medium | Consent-sensitive. |
| `/workspace/external-follow-up*` | External follow-up registry/templates/campaigns | PARTIAL | Admin | Medium | Consent-sensitive; manual archive. |

## LIBRARY

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/module/library` | In-app library | PARTIAL | Yes | Medium with web library | Keep. |
| `/web/library` | Web library | PARTIAL | Yes | Medium | Keep. |
| `/web/library/policy` | Library content policy | ACTIVE | Yes | Low | Keep. |

## FUTURE

| Route family | Purpose | Current state | Active? | Duplicate risk | Freeze status |
|---|---|---|---:|---|---|
| `/module/family_stress` | Coming-soon module | PLACEHOLDER | No | Low | Dormant/frozen. |
| `/admin/growth-layer` | Growth governance shell | PREVIEW/PARTIAL | Yes as UI | Medium | Not a live growth engine. |
| `/admin/employee-system` | Employee/system shell | PREVIEW/PARTIAL | Yes as UI | Medium | Not mature HR runtime. |
| `/admin/maintenance`, `/admin/ai-devops` | Technical/AI DevOps coordination | PREVIEW/PARTIAL | Yes as UI | Medium | Manual coordination only. |
| `/workspace/marketing`, `/workspace/content`, `/admin/workspace-command-center` | Marketing/content workspace concepts | PREVIEW/PARTIAL | Yes as UI | Medium | Launcher/planning surfaces, not full runtime. |

---

# PART D: Screen Inventory

| Screen/page | Location | Purpose | Maturity | Active? | Pilot relevance |
|---|---|---|---|---:|---|
| SplashPage | `features/splash` | Initial entry | ACTIVE | Yes | Low |
| MkLanguagePage | `features/language` | Language selection | ACTIVE | Yes | Medium |
| LoginPage | `features/auth` | Auth entry | ACTIVE | Yes | Critical |
| AccountBlockedPage | `core/auth` | Blocked/pending/rejected UX | ACTIVE | Yes | Critical for trust gates |
| MenuPage | `features/home` | Primary menu | ACTIVE | Yes | Critical |
| HomePage | `features/home` | Legacy/welcome entry | LEGACY | Maybe | Low |
| ClientRegisterPage | `features/auth` | Client registration | PARTIAL | Yes | Critical |
| ClinicianRegisterPage | `features/auth` | Legacy clinician registration | LEGACY/PARTIAL | Yes | Medium; freeze |
| CenterRegisterPage | `features/centers` | Legacy center registration | LEGACY/PARTIAL | Yes | Medium; freeze |
| WebClinicianRegister/Profile/Sessions/Documents/Success | `features/web_registration` | Web clinician onboarding | PARTIAL | Yes | Critical |
| WebCenterRegister/Profile/Media/Pricing/Documents/Details/Success | `features/web_registration` | Web center onboarding | PARTIAL | Yes | Critical |
| SupportEntryPage.addiction | `features/modules` | Addiction support entry | ACTIVE/PARTIAL | Yes | High |
| SupportEntryPage.specialNeeds | `features/modules` | Family/special-needs support entry | ACTIVE/PARTIAL | Yes | Medium |
| ModulePlaceholderPage | `features/modules` | Coming soon modules | PLACEHOLDER | Yes as placeholder | Low |
| SpecialistsCategories/List/Details | `features/specialists` | Specialist browsing and booking entry | ACTIVE/PARTIAL | Yes | High |
| CentersLanding/List/Details | `features/centers` | Center browsing and booking entry | ACTIVE/PARTIAL | Yes | High |
| BookingPage/BookingRequestPage/CenterBookingRequestPage | `features/booking` | Booking request creation | ACTIVE/PARTIAL | Yes | High |
| MyBookingsPage | `features/booking` | User booking tracking | ACTIVE/PARTIAL | Yes | High |
| ClinicianInboxPage/CenterInboxPage | `features/booking` | Provider request inboxes | ACTIVE/PARTIAL | Yes | High |
| ChatPage | `features/chat` | Support chat | ACTIVE/PARTIAL | Yes | Medium/High |
| ClinicianChatInboxPage | `features/chat` | Clinician escalation inbox | ACTIVE/PARTIAL | Yes | Medium |
| ChatEscalationReportPage | `features/chat` | Escalation report display | PARTIAL | Yes | Medium |
| ClientDashboardPage | `features/client` | Client dashboard | ACTIVE/PARTIAL | Yes | High |
| ClientSessionsPage | `features/client` | Session status/reviews | ACTIVE/PARTIAL | Yes | High |
| ClientPaymentProofPage | `features/client` | Payment proof fields | PARTIAL | Yes | Medium |
| ClinicianOperationsPage | `features/clinician` | Clinician ops/profile/support | ACTIVE/PARTIAL | Yes | High |
| ClinicianSessionsPage | `features/clinician` | Clinician sessions | ACTIVE/PARTIAL | Yes | High |
| CenterDashboardPage | `features/centers` | Center dashboard | ACTIVE/PARTIAL | Yes | High |
| CenterOperationsPage | `features/centers` | Center profile/update ops | ACTIVE/PARTIAL | Yes | High |
| CenterResidenciesPage | `features/centers` | Center residency/session flow | PARTIAL | Yes | Medium |
| SessionReviewPage | `features/reviews` | Session ratings/reports | ACTIVE/PARTIAL | Yes | Medium |
| LibraryPage | `features/library` | Content library | PARTIAL | Yes | Medium |
| LibraryPolicyPage | `features/library` | Content policy | ACTIVE | Yes | Medium |
| AdminHubPage | `features/admin_surface` | Admin/control hub | ACTIVE/PARTIAL | Yes | Critical for ops |
| AdminBookingQueuePage | `features/admin_surface` | Booking queue/admin decisions | ACTIVE/WRAPPED | Yes | High |
| AdminClientsPage | `features/admin_surface` | Client admin | PARTIAL | Yes | Medium |
| AdminClinicianRequestsPage | `features/admin_surface` | Clinician approval | ACTIVE | Yes | Critical |
| AdminClinicianProfileRequestsPage | `features/admin_surface` | Profile request review | ACTIVE | Yes | Critical |
| AdminCentersPage/AdminCenterDetailsPage | `features/admin_surface` | Center approval/details | ACTIVE | Yes | Critical |
| AdminSupportChatPage | `features/admin_surface` | Support chat oversight | PARTIAL | Yes | Medium |
| ChatEscalationsPage | `features/admin_surface` | Escalation handling | PARTIAL | Yes | Medium |
| AdminPaymentsPage/AdminSessionsPage/AdminSessionReportPage | `features/admin_surface` | Payments/session setup/reporting | PARTIAL | Yes | Medium; finance residue |
| AdminArchive* pages | `features/admin_surface` and `features/admin` | Archive views | PARTIAL | Yes | Medium |
| AdminRegistrationMaintenancePage | `features/admin_surface` | Registration health report | PARTIAL | Yes | High before pilot |
| ExternalFollowUpWorkspace/Registration/Templates/Campaigns/Details | `features/external_follow_up` | Manual/admin follow-up system | PARTIAL | Yes | High but consent-sensitive |
| AdminAI/Domain/Gateway/Growth/Maintenance/Activation pages | `features/admin_surface` | Governance/preview/admin shells | PARTIAL/PLACEHOLDER | Yes as UI | Low/Medium |
| AdminControlRoomPlaceholder pages | `features/admin_surface` | Coming Soon Control Room pages | PLACEHOLDER | No operational runtime | Low |

---

# PART E: Registration Inventory

## Client

Current flow:

- `/register/client` creates Firebase Auth user and writes `clients/{uid}`.
- Client role is written as `role: client`.
- Firestore rules allow client create only on own UID and prohibit protected fields.
- Client update is limited to display/avatar/photo fields.

Approval/trust flow:

- No explicit approval flow for normal clients.
- Account can be blocked via protected fields controlled by admin.
- Client dashboard and client-only routes require auth role alignment.

Fields confirmed:

- display name/email/password in UI.
- `role`, profile display/avatar fields.
- Booking/payment/session/support collections later hold operational state.

Collections:

- `clients`
- `booking_requests`
- `support_requests`
- `sessionRatings`

Rules risks:

- Client write shape must match rules exactly.
- Custom claim role must be present for role-gated backend access.
- Any pilot cohort/consent fields are not confirmed in client create/update allowlist.

## Clinician

Current flow:

- Legacy `/register/clinician` and web `/web/clinician/*` flows exist.
- Auth user is created, then `clinicians/{uid}` is written.
- Web portal uses staged draft data in browser storage and updates `clinicians/{uid}` across profile/sessions/documents steps.

Approval/trust flow:

- New clinician creates with `approvalStatus: pending_review`, `isActive: false`.
- Admin can approve/reject/update protected trust/status fields.
- Clinician-only routes require approved + active state in app gate.
- PF-2 requires manual trust verification record for pilot approval.

Fields confirmed:

- display/full names, email, title, specialty, phone/country, bio.
- session price/duration/modes/group-session flags.
- identity/certificate/extra file names and document URL fields.
- `documentsSubmitted`, `documentsUploadMode`.
- protected fields: role, approvalStatus, isActive/active, isBlocked, admin notes, verified fields, featured/ranking/subscription.

Collections:

- `clinicians`
- `clinician_profile_change_requests`
- `booking_requests`
- `chat_escalations`
- `support_requests`
- `sessionRatings`

Rules risks:

- Clinician self-updates are allowed only before approval and only for listed registration fields.
- Post-approval profile changes must go through profile change request/admin flow.
- Custom claims must match `clinician`.
- Document upload/runtime storage is not fully proven by UI; several flows store file names/URLs.

## Center

Current flow:

- Legacy `/register/center` and web `/web/center/*` flows exist.
- Auth user is created, then `centers/{uid}` is written/updated across profile/media/pricing/documents/details.

Approval/trust flow:

- New center creates with `approvalStatus: pending_admin`, `isActive: false`, `active: false` if present.
- Admin center pages approve/reject/block and inspect documents/media/pricing.
- Center-only routes require approved + active state in app gate.
- PF-2 requires manual verification record for pilot approval.

Fields confirmed:

- name/display/email/category/type/manager/phone/WhatsApp/location/address/description.
- detox/gallery/images/capabilities/services.
- accommodation/autism costs and pricing flags.
- document items, identity/license/commercial/tax file names and URLs.
- `imagesReady`, `pricingReady`, `documentsReady`.

Collections:

- `centers`
- `center_profile_change_requests`
- `booking_requests`
- `sessionRatings`

Rules risks:

- Center self-updates are allowed only before approval and only for listed registration fields.
- Post-approval updates must route through change requests/admin flow.
- Storage paths exist, but runtime direct uploads are not confirmed everywhere.
- Custom claims must match `center`.

## Admin

Current flow:

- Admin accounts are not self-registered in app runtime.
- `tools/firebase/bootstrap_owner_admins.js` sets Firebase Auth custom claims `{ role: 'admin' }` and upserts `admins/{uid}`.
- Seeder tooling can create/update staging admin.

Approval/trust flow:

- Admin authority is custom-claim based in Firestore.
- Storage rules also allow admin by claim or active admin doc fallback.
- App `AccountAccessService` checks admin docs for UI/UX access, but Firestore authority remains claims-based.

Fields confirmed:

- `admins/{uid}` with role/admin/active/isActive/isAdmin/isBlocked/approvalStatus fields through bootstrap.

Collections:

- `admins`
- all admin-readable/admin-writable operational collections listed in Firestore rules.

Rules risks:

- UI admin access and backend admin authorization can diverge if custom claims are missing/stale.
- Admins must refresh ID token after claims are assigned.
- Do not broaden Firestore rules to compensate for claims mismatch.

---

# PART F: Trust Inventory

Trust verification exists today as:

- Firestore fields on `clinicians` and `centers`.
- Admin approval/rejection/blocking pages.
- Account access gates requiring approved + active clinician/center state.
- PF-2 manual checklist doctrine.
- Manual archive requirement for every pilot trust decision.

Approval statuses confirmed:

- Client: no routine approval status required at creation.
- Clinician: `pending_review`, `approved`, `rejected`/`rejected_admin` concepts.
- Center: `pending_admin`, `approved`, `rejected`/`rejected_admin` concepts.
- Profile change requests: `pending`, `approved`, `rejected`, `applied`.
- PF-2 trust checklist statuses: `APPROVED`, `REJECTED`, `NEEDS_REVIEW`, `SUSPENDED`.

Trust records:

- No confirmed protected trust audit collection exists.
- Current runtime truth lives in `clinicians`, `centers`, and profile change request collections.
- PF-2 requires manual `TRUST_VERIFICATION_RECORD` for pilot decisions.

Known partner concept:

- Exists in PF-2 as a manual/trust-review concept.
- May support pilot participation if minimum threshold is met.
- Cannot bypass archive record or become permanent trust status without documentation.

Unknown applicant concept:

- Exists in PF-2 as stricter review path.
- Requires stronger evidence and escalation if evidence is incomplete.
- Unknown applicants should not be approved without minimum evidence.

Current reality:

- Trust is pilot-capable only as a delegated manual function using admin surfaces and archived checklist records.
- It is not yet a protected, immutable, standalone Trust Department runtime.

---

# PART G: Firestore Inventory

Confirmed rules collections:

| Collection | Purpose | Writers | Readers | Maturity | Risk |
|---|---|---|---|---|---|
| `clients` | Client profiles | client own create/update limited; admin | own client, admin; list limited | ACTIVE/PARTIAL | Custom claim/write-shape risk; no confirmed pilot cohort fields. |
| `clinicians` | Clinician profiles/trust/listing | clinician own pre-approval; admin | admin, own clinician, approved active public/signed-in readers | ACTIVE/PARTIAL | Approval/trust authority concentrated in admin; post-approval self-update restricted. |
| `centers` | Center profiles/trust/listing | center own pre-approval; admin | admin, own center, approved active public/signed-in readers | ACTIVE/PARTIAL | Same trust/admin coupling; document/media state may be manual. |
| `booking_requests` | Booking/session/payment/review lifecycle | client/clinician/center create if owner; admin; limited owner updates | admin and booking participants | ACTIVE/CRITICAL | Central lifecycle collection; many statuses and authority transitions; frozen wrappers exist. |
| `bookingRequests` | Legacy booking compatibility | denied | denied | LEGACY/FROZEN | Code has fallback references; rules deny all read/write. |
| `sessionRatings` | Session reviews/reports | signed-in reviewer | admin and involved users | ACTIVE/PARTIAL | Broader pilot survey not covered; review shape must be valid. |
| `clinician_profile_change_requests` | Clinician profile change queue | clinician owner create; admin update | admin or owning clinician | ACTIVE/PARTIAL | Admin applies/rejects; protected field risk. |
| `center_profile_change_requests` | Center profile change queue | center owner create; admin update | admin or owning center | ACTIVE/PARTIAL | Similar trust/profile authority risk. |
| `support_requests` | Structured support requests | signed-in creator; admin update | admin or creator | ACTIVE/PARTIAL | Requires `source: structured_support` and `status: new`; follow-up consent boundary. |
| `chat_threads` | Chat/support threads | signed-in owner create; admin/owner update | admin, owner, assigned clinician | ACTIVE/PARTIAL | Chat/support safety and escalation boundary. |
| `chat_threads/{threadId}/messages` | Chat messages | signed-in users if thread exists | admin, owner, assigned clinician | ACTIVE/PARTIAL | Message creation is broad once thread exists; no update/delete. |
| `chat_escalations` | Chat escalation records | signed-in create; admin update | admin or assigned clinician | ACTIVE/PARTIAL | Human review boundary; escalation authority. |
| `chat_escalations/{id}/reports` | Escalation reports | signed-in create | admin or assigned clinician | PARTIAL | Sensitive support/risk reports. |
| `admins` | Admin identity/activation doc | admin only; bootstrap via Admin SDK | admin only | ACTIVE/CRITICAL | Firestore authority still custom-claim based. |
| `system_health` | QA/system health snapshots | Admin SDK only | admin | PARTIAL | Client writes denied. |
| `system_alerts` | Ops alert snapshots | Admin SDK only | admin | PARTIAL | Client writes denied. |
| `analytics_summaries` | BigQuery/Firebase Analytics summaries | Cloud Function/Admin SDK only | admin | PARTIAL | Requires env-configured BigQuery dataset/location. |
| `system_domains` | Domain health/status | admin | admin | PARTIAL | Admin-writable; supports domain status UI. |
| `ai_policies` | AI policy draft/published settings | admin | admin | PARTIAL | Governance settings, not full AI runtime guarantee. |
| `resources` | Library/content resources | admin | signed-in users | PARTIAL | Seed tooling exists; library UI mostly static/category-based. |
| `external_follow_up_registry` | Follow-up person/entry registry | admin | admin | PARTIAL | Consent-sensitive; manual archive needed. |
| `external_follow_up_message_templates` | Follow-up templates | admin | admin | PARTIAL | Manual/admin use. |
| `external_follow_up_campaigns` | Follow-up campaigns | admin | admin | PARTIAL | Manual/admin use, not mature automation. |
| `debug` | Debug | denied | denied | DEAD/FROZEN | Not usable by client. |

Other confirmed runtime sources:

- `FirebaseAnalytics` client events through `shared/analytics/app_analytics.dart`.
- Scheduled Cloud Function `writeAnalyticsSummariesHourly` writes `analytics_summaries`.
- QA bots write `system_health` and `system_alerts` through privileged tooling.

Collections not confirmed:

- Broad pilot survey collections are not present in rules.
- Protected memory collections are not present as runtime.
- Trust verification archive collection is not present as runtime.
- Consent/legal immutable archive collection is not present as runtime.

---

# PART H: Storage Inventory

Storage rules define these paths:

| Path | Purpose | Readers | Writers | Current state | Risk |
|---|---|---|---|---|---|
| `centers/{uid}/...` | Center private files | admin or owner | center owner | AVAILABLE | UI flows often store file names/URLs; direct upload needs verification. |
| `clinicians/{uid}/...` | Clinician private files | admin or owner | clinician owner | AVAILABLE | Same upload verification risk. |
| `clients/{uid}/...` | Client private files | admin or owner | owner | AVAILABLE | Payment proof currently appears as filename/reference fields. |
| `identity/{uid}/...` | Identity docs | admin or owner | owner | AVAILABLE | High-sensitivity. |
| `certificates/{uid}/...` | Certificates | admin or owner | owner | AVAILABLE | High trust relevance. |
| `licenses/{uid}/...` | Licenses | admin or owner | owner | AVAILABLE | High trust relevance. |
| `national_ids/{uid}/...` | National IDs | admin or owner | owner | AVAILABLE | High sensitivity. |
| `verification_docs/{uid}/...` | Verification documents | admin or owner | owner | AVAILABLE | Trust archive not otherwise protected. |
| `medical_docs/{uid}/...` | Medical documents | admin or owner | owner | AVAILABLE | Very sensitive; avoid unless necessary. |
| `branding/...` | Public branding | public read | admin write | ACTIVE | Asset ops. |
| `public_gallery/...` | Public gallery | public read | admin write | ACTIVE | Center/gallery risk if unreviewed. |
| `public_images/...` | Public images | public read | admin write | ACTIVE | Public content review needed. |
| `marketing_assets/...` | Marketing assets | public read | admin write | PARTIAL | Growth/marketing surface not mature. |

Upload constraints:

- Max size: 25 MB.
- Blocks common executable/script content types.
- Deletes are denied.

Current reality:

- Storage rules are more complete than many UI upload flows.
- Registration screens often capture file names and URL placeholders, not guaranteed Storage uploads.
- For pilot trust, manual evidence packages may still be needed.

---

# PART I: Rules Inventory

Custom claims usage:

- Firestore `isAdmin`, `isClient`, `isClinician`, and `isCenter` depend on `request.auth.token.role`.
- Firestore comments explicitly state authorization depends on custom claims, not UI role documents.
- App-side `AccountAccessService` is a UI/UX gate, not backend authority.

Admin authority:

- Firestore admin authority requires `request.auth.token.role == 'admin'`.
- Storage admin authority accepts the custom claim or an active `admins/{uid}` doc fallback.
- Bootstrap script sets admin custom claims and admin docs for owner admins.

Trust authority:

- Protected account fields cannot be changed by normal users.
- Clinician/center approval and active status are admin-controlled.
- Admin can update profile request statuses.
- PF-2 trust verification remains manual/archive-backed, not protected runtime.

Registration restrictions:

- Client create must be own UID and must not include protected fields.
- Clinician create must be own UID, role clinician, inactive, not blocked, pending review.
- Center create must be own UID, role center, inactive, pending admin.
- Clinician/center self-update is only pre-approval and only for allowlisted registration fields.

Known permission-denied risks:

- Missing or stale custom claims after account creation.
- UI role docs existing without matching Auth custom claim.
- Attempting to write protected fields from client app.
- Adding pilot/cohort/consent fields without rules allowlist updates.
- Survey collections absent from rules.
- Legacy `bookingRequests` fallback paths denied by rules.
- Post-approval clinician/center profile edits attempted directly instead of through change request flow.

---

# PART J: Control Room Inventory

What exists:

- Admin hub and admin sections.
- Domain status and domain availability surfaces.
- System alerts review.
- AI policy page.
- Analytics summaries repository and scheduled Cloud Function writer.
- Admin booking queue, payments, sessions, reports, support chat, chat escalations.
- Archive pages for sessions, payments, reports, clinicians, centers, support, accounting.
- Gateway/activation/compliance/exposure/system pages as governance/preview UI.

Monitoring:

- `system_health`, `system_alerts`, `system_domains`.
- QA bot scripts can write health/alert snapshots through privileged tooling.
- Domain health services exist for booking/chat/AI policy.

Reports:

- Admin session report page.
- Admin archive reports page.
- `analytics_summaries` from BigQuery/Firebase Analytics if configured.
- Markdown docs remain the main authoritative reports.

Analytics:

- Firebase Analytics client calls.
- Cloud Function summarizes top modules, selected paths, and chat opens by context.
- Admin summaries are partial and depend on BigQuery environment configuration.

Complaints/escalations:

- `support_requests`, `chat_threads`, `chat_escalations`, escalation reports.
- Admin support chat and chat escalation pages.

Approvals:

- Admin clinician requests.
- Admin centers.
- Profile change request pages.
- Booking queue decisions.

Follow-up:

- External follow-up workspace and collections.
- Customer follow-up workspace.
- Consent/archive process remains manual.

What is planned/conceptual:

- Mature Control Room as separate operational institution.
- Protected memory.
- Sovereign finance/legal room.
- Immutable trust/consent/audit memory.
- Full survey/analysis/archive system.

What is legacy/residue:

- `/admin/*` still carries multiple future departments.
- Control Room preview routes are placeholders.
- Finance/payment authority is still inside admin surfaces.
- Trust authority is still inside admin approval/profile surfaces.

---

# PART K: Library Inventory

| Content/domain | Current runtime | State |
|---|---|---|
| Library shell | `LibraryPage`, `/module/library`, `/web/library` | ACTIVE/PARTIAL |
| Library policy | `LibraryPolicyPage` | ACTIVE |
| Featured family-awareness content | Safe embrace / `family_awareness` | PARTIAL |
| Featured prevention-awareness content | Safe start / `prevention_awareness` | PARTIAL |
| Articles | Category exists; gradual content note | PLACEHOLDER/PARTIAL |
| Exercises | Category exists; light support caveat | PLACEHOLDER/PARTIAL |
| Audio | Category exists; calming/general support caveat | PLACEHOLDER/PARTIAL |
| Videos | Category exists; future links require review | PLACEHOLDER/PARTIAL |
| Tools | Category exists; tools being prepared | PLACEHOLDER |
| Saved | Category exists; saving not active | DORMANT |
| Addiction support materials | Support entry links to library | PARTIAL |
| Mental health general content | Implied through library categories | PARTIAL |
| Children support | Not confirmed as standalone active runtime | DORMANT/CONCEPTUAL |
| Deaf support | Not confirmed as active runtime | DORMANT/CONCEPTUAL |
| Special needs / family support | Route uses `specialNeeds` as family support entry | ACTIVE/PARTIAL |
| Educational areas | Library categories and resources collection | PARTIAL |
| Future domains | Coming soon/module placeholders | DORMANT/PLACEHOLDER |
| `resources` collection | Seed script/admin writable, signed-in readable | PARTIAL |

Current reality:

- Library is usable as a shell and category/featured-content experience.
- It is not yet a mature content management, licensing, review, saved-items, or personalized library runtime.

---

# PART L: Follow-up & Support Inventory

Support continuity:

- Structured support requests exist through `support_requests`.
- Chat support exists through `chat_threads` and `messages`.
- Escalations exist through `chat_escalations`.
- Admin support chat page exists.
- Clinician support request indicators exist in clinician operations.

Follow-up:

- External follow-up workspace exists.
- `external_follow_up_registry` stores entries.
- `external_follow_up_message_templates` stores templates.
- `external_follow_up_campaigns` stores campaigns.
- Follow-up constants include birthday, recovery support, general support, educational awareness, WhatsApp/email/both, support frequencies, and sources.

External follow-up:

- Admin-only.
- Manual/admin controlled.
- Consent-sensitive.
- Not a mature automated continuity engine.

Campaigns:

- Runtime pages and collections exist.
- Actual pilot use requires consent status, archive package, and manual discipline.

Communication:

- Gateway pages exist as governance/visibility shells.
- Communication gateway actions include external contact launch patterns.
- Not a live integrated omnichannel engine.

Current reality:

- Follow-up/support are partial but real.
- They can support pilot only with manual consent tracking and archive discipline.

---

# PART M: Survey & Analytics Inventory

Surveys:

- Broad pilot survey runtime is not confirmed.
- No `surveys`, `survey_answers`, or `survey_analysis` collection is present in Firestore rules.
- PF-1 defines a manual/external Pilot Survey V1 plan.

Survey answers:

- Not confirmed as app runtime.
- PF-1 allows external/manual tool with exported archive package.
- Session ratings are not the same as broad pilot surveys.

Session reviews / ratings:

- `SessionReviewPage` writes to `sessionRatings`.
- Admin/session/client/clinician pages read ratings.
- Reviewer types: client, clinician, center.
- Used for session reports and dashboard summaries.

Survey analysis:

- No mature runtime collection confirmed.
- Manual docs/report package is acceptable for pilot if human reviewed.
- AI analysis may assist but cannot decide pilot success, risk, legal outcome, or enforcement.

Reports:

- Admin session report page.
- Archive report pages.
- Markdown docs.
- Analytics summaries.

AI analysis:

- AI policy surfaces exist.
- Chat AI policy/service exists.
- MASTER/PF doctrine requires human review/comparison.

Human analysis:

- Required by constitutional doctrine.
- Current practical form is owner/admin/manual review and docs.

Analytics:

- Firebase Analytics event logging exists.
- Scheduled Cloud Function can write hourly summaries to `analytics_summaries` from BigQuery.
- Admin analytics summaries are partial and environment-dependent.

Current reality:

- Session review analytics exist.
- Broader pilot survey collection/analysis runtime does not.
- Pilot survey readiness is manual/external unless a new confirmed runtime is added.

---

# PART N: Archive Inventory

Using PF-1 taxonomy where possible:

| Archive class | Existing artifacts | Current state |
|---|---|---|
| CONSTITUTION | Constitution V1, Constitution V2 | ACTIVE DOCS |
| GOVERNANCE | MASTER-1, MASTER-2, MASTER-3, Federated execution plan | ACTIVE DOCS |
| WAVES | Grounding Wave 1-4 docs and closeouts | ACTIVE DOCS |
| EXTRACTION | Extraction Admin Auth, Control Data decomposition | ACTIVE DOCS |
| SOVEREIGN | Finance/legal separation/freezer/audit boundary docs | ACTIVE DOCS |
| TECHNICAL_AUDIT | Security/firestore/access/localization/clean-core audits | ACTIVE DOCS |
| PILOT | PF-0, PF-1, PF-2 | ACTIVE DOCS |
| TRUST_VERIFICATION | PF-2 checklist, admin approval runtime | PARTIAL/MANUAL |
| PILOT_SURVEY | PF-1 survey plan | MANUAL/PLANNED |
| PILOT_FOLLOWUP | PF-1 follow-up plan, external follow-up collections | PARTIAL/MANUAL |
| PILOT_ANALYSIS | PF-1 analysis/archive plan | MANUAL |
| CONTROL_REPORT | Admin report pages, analytics summaries, docs | PARTIAL |
| SUPPORT_CONTINUITY | Support requests/chat/follow-up docs | PARTIAL |
| ARCHIVE_PACKAGE | Archive taxonomy exists; no mature package runtime | CONCEPTUAL/MANUAL |
| MIGRATIONS | Clean core and release audit docs | ACTIVE DOCS |
| REPORTS | Admin archive/report pages and docs | PARTIAL |

Current archive reality:

- The strongest archive today is the `docs/` directory.
- Runtime archive pages exist but are not equivalent to a sovereign institutional archive.
- Protected memory is constitutional/doctrinal, not implemented as a full immutable runtime.

---

# PART O: Constitutional Inventory

| Document | Current role | State |
|---|---|---|
| Constitution V1 | Founding constitutional baseline | SUPERSEDED/REFERENCE |
| Constitution V2 | Active constitutional federation doctrine | ACTIVE |
| MASTER-1 | Reconciliation of reality, admin residue, maturity, construction path | ACTIVE |
| MASTER-2 | Governance topology blueprint | ACTIVE |
| MASTER-3 | Construction program and readiness gates | ACTIVE |

Current active doctrines:

- Reality first.
- No governance fantasy.
- Delegation before department.
- Enforcement follows maturity.
- Authority must not outrun memory.
- Owner Room as practical leadership.
- Control Lite before mature Control Room.
- Trust Function before Trust Department.
- Protected memory is required before hard sovereign enforcement.
- Admin residue is frozen and extracted gradually.
- Permission-denied prevention before premature rules hardening.
- Human analysis is required; AI analysis is assistive and review-bound.
- Docs/manual archive is acceptable during pilot if disciplined.

---

# PART P: Dormant Domain Inventory

| Domain | Classification | Evidence/current reality |
|---|---|---|
| Children Support | DORMANT/CONCEPTUAL | No confirmed active standalone runtime. |
| Deaf Support | DORMANT/CONCEPTUAL | No confirmed active standalone runtime. |
| Special Needs | PARTIAL | Route exists as `/module/special_needs`, but implemented as family-support entry. |
| Family Support | ACTIVE/PARTIAL | Support entry, library featured family-awareness, support issue selector. |
| Addiction Support | ACTIVE/PARTIAL | Addiction support entry with specialist/center/library/support paths. |
| Family Stress | PLACEHOLDER | `/module/family_stress` opens placeholder. |
| Future Menu Domains | PLACEHOLDER/DORMANT | Menu/domain concepts exist; not all have runtime. |
| Coming Soon Sections | PLACEHOLDER | Control Room placeholder pages show Coming Soon. |
| Saved Library | DORMANT | UI says saving is not active; no saved items stored. |
| Marketing/Growth | PARTIAL/PLACEHOLDER | Admin workspaces/growth layer exist as planning/governance, not live engine. |
| HR/Employee System | PARTIAL/PLACEHOLDER | Admin employee/system shell exists; not mature HR runtime. |
| Communication Gateways | PARTIAL/PLACEHOLDER | Gateway pages exist; not full integrations. |
| Sovereign Finance | CONSTITUTIONAL/PARTIAL | Payment/accounting admin surfaces exist; sovereign finance runtime not mature. |
| Legal/Consent Memory | CONSTITUTIONAL/PARTIAL | Doctrine exists; no mature protected runtime. |
| Protected Memory | CONSTITUTIONAL | Doctrine exists; runtime not confirmed. |

---

# PART Q: Pilot Readiness Inventory

| Operational line | Status | Reality |
|---|---|---|
| Registration | PARTIAL | Client/clinician/center flows exist, but claims/rules/write-path verification is required before live cohort. |
| Trust | READY_WITH_MANUAL_PROCESS | PF-2 checklist makes center/clinician verification pilot-capable if every decision is archived manually. |
| Client | PARTIAL | Dashboard/sessions/payment/support exist; consent/pilot cohort fields not confirmed. |
| Center | READY_WITH_MANUAL_PROCESS | Center runtime and admin approval exist; evidence upload/archive process must be manually verified. |
| Clinician | READY_WITH_MANUAL_PROCESS | Clinician runtime and admin approval exist; license/specialty/identity review must be manual/archive-backed. |
| Follow-up | PARTIAL | External follow-up collections/pages exist, but consent/outcome/archive discipline is required. |
| Survey | BLOCKED/PARTIAL | Broad survey runtime absent/unknown. Use external/manual survey unless built and rules-confirmed. |
| Library | PARTIAL | Usable library shell and featured content; content depth and governance are partial. |
| Support | PARTIAL | Support requests/chat/escalation exist; must not be treated as therapy continuation. |

Pilot launch blockers or pre-launch checks:

- Verify Firebase Auth custom claims for every pilot role.
- Test client, clinician, center, admin write paths against deployed rules.
- Decide and document manual survey tool/process.
- Create manual trust verification archive packages for pilot clinicians/centers.
- Confirm storage/evidence process for licenses, certificates, identities, center documents.
- Confirm follow-up consent and opt-out tracking.

---

# PART R: Technical Debt Inventory

Frozen debt:

- `/home` alias to menu while HomePage remains legacy/welcome.
- `/register/clinician` and `/register/center` legacy registration routes.
- `/chat/clinician/inbox` legacy alias.
- `bookingRequests` legacy collection denied by rules but referenced as fallback in code.
- `BookingLegacyChatAdapter`.
- Preview Control Room pages.
- Admin surface carrying many future departments.
- Finance/payment authority inside admin pages.
- Trust authority inside generic admin pages.

Accepted debt:

- Manual trust verification for pilot.
- Manual/docs archive as current institutional memory.
- Manual/external survey process.
- Admin-only follow-up workspace for pilot if consent discipline exists.
- Static/partial library categories before full content governance runtime.

Duplicated routes:

- `/web/clinician/register` and `/register/clinician`.
- `/web/center/register` and `/register/center`.
- `/web/library` and `/module/library`.
- `/clinician/chat-inbox` and `/chat/clinician/inbox`.
- `/home` and `/menu` behavior overlap.

Legacy paths:

- `/register/clinician`
- `/register/center`
- `/chat/clinician/inbox`
- `bookingRequests`
- booking/chat legacy adapter paths

Admin residue:

- Admin owns booking lifecycle, payment review, session setup, trust approval, support chat, follow-up, archive, AI policy, domain health, and preview control concepts.

Control room residue:

- Real monitoring/reporting is split across admin pages, domain status, alerts, analytics summaries, archive pages, docs, and QA scripts.
- Placeholder Control Room routes exist but are not operational.

No cleanup recommendation is made here.

---

# PART S: Final Reality Verdict

What exists today:

- A working Flutter/Firebase app with meaningful client, clinician, center, booking, chat, support, library, registration, and admin surfaces.
- A broad admin-controlled operational layer.
- Firestore and Storage rules with custom-claim role doctrine.
- Partial analytics and reporting.
- A large, current documentation archive and active constitutional doctrine.
- Pilot foundation docs PF-0, PF-1, PF-2.

What works today:

- Route-based app navigation.
- Role-gated app access.
- Client/clinician/center registration flows, subject to rules/claims correctness.
- Admin review surfaces for clinicians, centers, profile requests, bookings, payments, sessions, support, reports, and domain status.
- Booking requests and session reviews.
- Chat threads, messages, escalations, and reports.
- Structured support requests.
- External follow-up admin collections/pages.
- Static/featured library experience.
- Admin analytics summaries if BigQuery/Firebase Analytics configuration is present.

What is partially working:

- Trust verification: works through admin status fields and manual PF-2 process, not protected trust memory.
- Follow-up: collections and pages exist, but consent/archive maturity is partial.
- Survey: session ratings exist, broad pilot survey runtime does not.
- Archive: docs and admin pages exist, but protected institutional archive runtime does not.
- Finance: payment proof/review/accounting surfaces exist, but sovereign finance doctrine is not runtime.
- Control Room: admin/control-lite surfaces exist, mature Control Room does not.
- Library: shell/content categories exist, but content governance/storage/saved-items are partial.

What is dormant:

- Children support standalone runtime.
- Deaf support runtime.
- Family stress route.
- Saved library.
- Full communication gateways.
- Mature marketing/growth engine.
- Mature HR/employee system.
- Sovereign finance/legal runtime.
- Protected memory runtime.

What is constitutional only:

- Full constitutional federation.
- Mature Owner Room / Control Room / departments.
- Protected memory doctrine.
- Sovereign finance/legal separation as enforced runtime.
- Full archive office.
- Mature delegation lifecycle.
- Full human/AI comparison governance workflow.

What is pilot ready:

- Trust verification for centers and clinicians, only with manual PF-2 checklist and archive records.
- Center/clinician participation, only after write-path, evidence, approval, and custom-claim checks.
- Manual survey analysis/reporting using PF-1 taxonomy.
- Support/follow-up, only with consent-aware manual process.
- Library exposure as educational/support content, not clinical intervention.

What must be addressed before launch:

- Run real write-path verification for client, clinician, center, admin, booking, support, follow-up, and session review flows.
- Confirm custom claims for pilot users.
- Select and document manual/external survey process or implement and rule-gate survey runtime.
- Confirm document/evidence upload or manual evidence package process.
- Create trust verification records for all pilot centers/clinicians.
- Confirm follow-up consent and opt-out process.
- Keep admin/finance/trust/control expansion frozen unless specifically reviewed.

What should not be touched before pilot without explicit reason:

- Legacy routes that may still support links or fallback.
- `bookingRequests` fallback code without migration proof.
- Admin booking/payment/session authority without wrapper/sovereign review.
- Firestore rules broadening to hide claims mismatch.
- Storage rules for sensitive documents.
- Constitutional/archive docs during pilot unless adding clearly labeled pilot records.

Complete verdict:

Mental Smile is not just an idea. It has a real app, real Firebase rules, real operational screens, and real pilot-capable pathways. It is also not yet a mature institution. The runtime is ahead of a prototype but behind the constitutional vision. The strongest current reality is a founder-led, admin-assisted, documentation-heavy pilot platform with partial operations and strong governance doctrine.

The safest launch posture is:

READY_WITH_MANUAL_PROCESS for a limited pilot,
not READY for autonomous/mature institutional operation.

