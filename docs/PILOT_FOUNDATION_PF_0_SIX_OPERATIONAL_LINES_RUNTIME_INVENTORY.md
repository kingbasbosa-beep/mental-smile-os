# PILOT-FOUNDATION / PF-0 REPORT
# Six Operational Lines Runtime Inventory

Project: Mental Smile  
Era: Pilot Foundation  
Status: Inventory only  
Runtime effect: None  
Inspection mode: No repository commands executed. Findings are reconciled from existing grounding/extraction/sovereign documents, known runtime surfaces, and previously identified project structure. Unknowns are marked explicitly.

---

# PART A — Executive Summary

Mental Smile is preparing for a near-term pilot around six immediate operational lines:

1. Center Verification
2. Clinician Verification
3. Client Registration
4. Follow-up Tracking
5. Survey Answers
6. Survey Analysis

What exists today:

- admin-centered trust/approval surfaces exist for centers and clinicians.
- client/clinician/center app surfaces exist conceptually and through route families.
- registration aliases and registration/trust paths exist in current topology.
- external follow-up / continuity workspace surfaces exist conceptually from prior inventories.
- chat/support escalation runtime exists and has passive shadow wrappers for assignment, forwarding, and resolution.
- Firestore operational truth exists through collections such as `clients`, `clinicians`, `centers`, `booking_requests`, `chat_threads`, `chat_escalations`, and external follow-up collections.
- documentation currently acts as the strongest archive/governance memory.

What is missing or unconfirmed:

- mature survey runtime is not confirmed.
- survey answer collections are not confirmed.
- survey analysis collections are not confirmed.
- protected audit memory does not exist.
- formal archive/reporting runtime does not exist.
- verification decision audit is not protected memory yet.
- pilot cohort fields are not confirmed.
- document upload storage paths are not confirmed in this inventory.

What is duplicated or legacy:

- registration aliases are legacy/burial candidates.
- `/admin/*` still carries trust, support, finance, AI, system, and operational residue.
- `booking_requests` remains a centralized multi-domain operational state.
- some current admin surfaces are compatibility shells rather than future room boundaries.

What is risky:

- admin trust approval/blocking remains broad.
- document verification evidence may not have protected memory.
- follow-up/continuity has consent risk.
- survey analysis may be absent or disconnected from archive/reporting.
- Firestore rules may create `permission-denied` risk if pilot flows depend on claims or approval status.
- client-only operational truth would be unsafe for verification, consent, disputes, and surveys submitted as institutional evidence.

What can support pilot immediately:

- center/clinician verification can likely run with a manual/admin-assisted process.
- client registration can likely run if existing registration/profile rules permit writes.
- follow-up tracking can likely run with existing external follow-up/support surfaces, but requires manual consent discipline.
- surveys can run only if a lightweight/manual data capture process is accepted or if current survey surfaces are confirmed.

What must not be touched yet:

- Firestore rules
- custom claims
- production routes
- admin refactors
- trust enforcement
- finance/legal enforcement
- audit runtime
- command runtime
- cleanup/removal candidates

Pilot principle:

```text
Use existing runtime where it is stable.
Use manual governance where runtime is missing.
Do not create hard enforcement during pilot foundation.
```

---

# PART B — Route Inventory

| Operational Line | Route / Route Family | Page / Widget | Current Purpose | Future Target | Status |
| ---------------- | -------------------- | ------------- | --------------- | ------------- | ------ |
| Center Verification | `/register/center` | Registration alias / center registration surface | Center intake/registration entry. | Web Operations + Trust & Verification | LEGACY |
| Center Verification | `/admin/centers` | Admin center management/approval surface | Center approval, blocking, trust/profile operations. | Trust & Verification + Tenant/Center Operations | ACTIVE |
| Center Verification | `/center/*` | Center app surfaces | Center-scoped operational/profile surfaces. | Tenant/Center Operations | PARTIAL |
| Center Verification | `/admin/booking-queue` | Admin booking queue page | Center request lifecycle decisions. | App Operations + Trusted Command later | ACTIVE |
| Clinician Verification | `/register/clinician` | Registration alias / clinician registration surface | Clinician intake/registration entry. | Web Operations + Trust & Verification | LEGACY |
| Clinician Verification | `/admin/clinician-requests` | Admin clinician request surface | Clinician approval/rejection/trust review. | Trust & Verification | ACTIVE |
| Clinician Verification | `/admin/clinician-profile-requests` | Admin profile request surface | Clinician profile change approval/application. | Trust & Verification | ACTIVE |
| Clinician Verification | `/clinician/*` | Clinician app surfaces | Clinician-scoped operations/profile. | Clinician Operations | PARTIAL |
| Client Registration | `/client/*` | Client app surfaces | Client profile/app workflows. | Client Self-Service | ACTIVE |
| Client Registration | `/admin/clients` | Admin client visibility/management | Client visibility and possible admin actions. | Control scoped visibility + Client Self-Service | ACTIVE |
| Client Registration | `/home` | Legacy alias | Navigation compatibility. | Burial Candidate | BURIAL_CANDIDATE |
| Follow-up Tracking | `/workspace/external-follow-up*` | External follow-up workspace surfaces | Registry/templates/campaign/follow-up operations. | Support Continuity + Legal consent boundary | PARTIAL |
| Follow-up Tracking | `/admin/support-chats` | Admin support chat surface | Support visibility/action. | Control Room + Support Continuity | PARTIAL |
| Follow-up Tracking | `/chat/escalations` | Chat escalation admin page | Escalation assignment/forward/resolve. | Control Room + Support Operations | ACTIVE |
| Survey Answers | `lib/features/survey/` route unknown | Unknown | Survey capture not confirmed. | App/Web Operations + Analytics | MISSING |
| Survey Answers | Client/clinician/center surfaces if embedded | Unknown | Possible survey entry by role. | App Operations | UNKNOWN |
| Survey Analysis | Admin/workspace/reporting route unknown | Unknown | Survey analysis/reporting not confirmed. | Analytics + Knowledge & Archive Office | MISSING |
| Survey Analysis | Docs/manual reports | Markdown docs | Documentation can hold manual pilot analysis. | Knowledge & Archive Office | PARTIAL |

Status note:

```text
Survey route/runtime status requires manual file confirmation before pilot use.
```

---

# PART C — Field Inventory

## 1. Center Verification Fields

| Field | Location | Purpose | Required? | Stored Where | Notes |
| ----- | -------- | ------- | --------- | ------------ | ----- |
| center name | center registration/admin center surfaces | Identify center. | Yes | `centers` likely | Confirm exact field name before pilot. |
| type | center profile/registration | Classify center. | Recommended | `centers` likely | Could be manual if absent. |
| location | center profile/registration | Operational/geographic identity. | Yes | `centers` likely | Needed for pilot matching/trust. |
| phone | center profile/registration | Contact. | Yes | `centers` likely | Must be platform-held after submission. |
| website | center profile/registration | Public/trust reference. | Optional | `centers` likely | Useful for verification. |
| license | center registration/admin docs | Verification evidence. | Yes for trust pilot | `centers` or document reference UNKNOWN | Storage path not confirmed. |
| documents | center registration/admin docs | Evidence package. | Yes if used | UNKNOWN | Must not be device-only once submitted. |
| photos | center profile/docs | Center evidence/public profile. | Optional | UNKNOWN | Need storage confirmation. |
| approval status | admin centers | Trust lifecycle. | Yes | `centers` likely | Must be platform-held. |
| rejection reason | admin centers | Decision explanation. | Recommended | `centers` or request collection | Important for appeals. |
| verification status | center/admin trust | Verification lifecycle. | Yes | `centers` likely | Exact enum unknown. |
| blocked status | admin center/account blocking | Restriction state. | Yes if blocking exists | `centers` likely | High-risk authority. |
| owner/admin notes | admin trust surfaces | Review context. | Recommended | `centers` or admin notes field UNKNOWN | Should not become hidden authority. |
| profile request fields | center profile request surfaces | Requested changes. | If profile edits exist | `center_profile_change_requests` | Previously identified collection. |

## 2. Clinician Verification Fields

| Field | Location | Purpose | Required? | Stored Where | Notes |
| ----- | -------- | ------- | --------- | ------------ | ----- |
| name | clinician registration/profile | Identity. | Yes | `clinicians` likely | Platform-held after submission. |
| specialty | clinician profile | Matching/trust. | Yes for pilot | `clinicians` likely | Exact field unknown. |
| license | registration/admin verification | Professional verification. | Yes | `clinicians` or document reference UNKNOWN | Storage path needs confirmation. |
| certificates | registration/profile/admin | Qualification evidence. | Recommended | UNKNOWN | Must be platform-held if used for trust. |
| experience | clinician profile | Trust/profile info. | Recommended | `clinicians` likely | May be free text or structured. |
| center affiliation | clinician profile/center link | Relationship with center. | Recommended | `clinicians` and/or `centers` | Multi-party truth. |
| phone/email | registration/profile | Contact/account. | Yes | `clinicians` and auth/user profile | Rules risk if auth required. |
| approval status | admin clinician requests | Trust decision. | Yes | `clinicians` / request collection | Platform-held. |
| rejection reason | admin clinician requests | Decision explanation. | Recommended | request collection or `clinicians` | Appeal support. |
| verification status | trust/profile | Verification lifecycle. | Yes | `clinicians` likely | Exact enum unknown. |
| blocked status | account blocking/admin | Restriction. | If blocking exists | `clinicians` likely | High-risk. |
| profile request fields | profile request page | Requested profile changes. | If edits exist | `clinician_profile_change_requests` | Previously identified collection. |

## 3. Client Registration Fields

| Field | Location | Purpose | Required? | Stored Where | Notes |
| ----- | -------- | ------- | --------- | ------------ | ----- |
| name | client registration/profile | Identity. | Yes | `clients` / `users` | Exact split needs confirmation. |
| email | auth/profile | Account/contact. | Yes | auth + `clients` / `users` | Rules may depend on auth UID. |
| phone | client profile | Contact/follow-up. | Recommended | `clients` likely | Pilot needs contact discipline. |
| profile | client app/profile | User profile state. | Recommended | `clients` likely | Avoid overcollection. |
| consent | registration/follow-up | Rights and outreach boundary. | Critical if follow-up | `clients` or consent field UNKNOWN | Must be platform-held. |
| preferences | client profile | Matching/UX. | Optional | `clients` or local | Can be local until submitted. |
| account status | admin/client/account service | active/blocked/etc. | Yes if restrictions exist | `clients` likely | High-risk if admin mutable. |
| support/follow-up status | support/follow-up surfaces | Continuity state. | Pilot recommended | external follow-up/support collections | Needs consent boundary. |
| pilot flag | pilot cohort | Pilot segmentation. | Unknown | UNKNOWN | Not confirmed. Could be manual initially. |

## 4. Follow-up Tracking Fields

| Field | Location | Purpose | Required? | Stored Where | Notes |
| ----- | -------- | ------- | --------- | ------------ | ----- |
| followup id | external follow-up service/surface | Track follow-up item. | Yes | `external_follow_up_*` likely | Exact collection split below. |
| user id | follow-up/support | Link target user. | Yes | external follow-up collections | Must be platform-held. |
| status | campaign/follow-up | Lifecycle. | Yes | external follow-up collections | Needed for pilot tracking. |
| message type | template/campaign | Classify communication. | Recommended | templates/campaigns | Avoid emotional manipulation. |
| consent status | follow-up/client | Rights boundary. | Critical | client/support/follow-up collection UNKNOWN | Must be platform-held. |
| communication channel | campaign/follow-up | SMS/email/phone/etc. | Recommended | external follow-up collection | Needed for governance. |
| date/time | follow-up record | Scheduled/sent/contacted. | Yes | external follow-up collection | Platform-held. |
| campaign/template | external follow-up | Message governance. | Recommended | `external_follow_up_campaigns`, templates | Existing collections identified. |
| response status | follow-up | User response/closed/no reply. | Recommended | external follow-up collection | Pilot useful. |
| admin notes | admin/workspace | Operator notes. | Optional | external follow-up collection | Sensitive; avoid overuse. |
| escalation status | support/escalation | Escalated/not escalated. | Recommended | support/chat escalation | Link to support flow. |

## 5. Survey Answer Fields

| Field | Location | Purpose | Required? | Stored Where | Notes |
| ----- | -------- | ------- | --------- | ------------ | ----- |
| survey id | survey runtime if present | Identify survey. | Yes | UNKNOWN | Survey collection not confirmed. |
| user id | survey answer | Link respondent if not anonymous. | Depends | UNKNOWN | Must respect anonymity if offered. |
| user type | survey answer | client/clinician/center/etc. | Recommended | UNKNOWN | Useful for analysis. |
| question id | survey answer | Link answer to question. | Yes | UNKNOWN | Needed for analysis. |
| answer value | survey answer | Structured response. | Yes | UNKNOWN | Could be manual for pilot. |
| free text answer | survey answer | Qualitative response. | Optional | UNKNOWN | Sensitive; retention needed. |
| category/department | survey answer | Map feedback to governance area. | Recommended | UNKNOWN | Helps department analysis. |
| timestamp | survey answer | Submission time. | Yes | UNKNOWN | Platform-held if submitted. |
| pilot cohort | survey answer | Pilot segmentation. | Recommended | UNKNOWN | Not confirmed. |
| anonymity flag | survey answer | Privacy expectation. | If anonymous surveys exist | UNKNOWN | Must be explicit. |

## 6. Survey Analysis Fields

| Field | Location | Purpose | Required? | Stored Where | Notes |
| ----- | -------- | ------- | --------- | ------------ | ----- |
| analysis id | analysis/report runtime if present | Identify analysis. | Yes if stored | UNKNOWN | Not confirmed. |
| survey id | survey analysis | Link analysis to survey. | Yes | UNKNOWN | Needed if runtime exists. |
| category | analysis/report | Group insight. | Recommended | docs/manual or UNKNOWN | Pilot can do manually. |
| AI summary | analysis report | AI-assisted summary. | Optional | docs/manual or UNKNOWN | Requires human review. |
| human summary | analysis report | Human interpretation. | Yes for governance | docs/manual or UNKNOWN | Preferred for pilot. |
| score aggregation | analysis report | Quantitative analysis. | Recommended | docs/manual or UNKNOWN | Can be spreadsheet/manual. |
| department recommendation | governance report | Route insight to department. | Recommended | docs/manual | Fits MASTER-2 topology. |
| archive/report link | archive/report | Institutional memory. | Recommended | docs/manual | Needed for pilot package. |
| created by | report metadata | Accountability. | Recommended | docs/manual or UNKNOWN | Platform if runtime exists. |
| reviewed by | report metadata | Human review. | Recommended | docs/manual | Needed if AI used. |
| timestamp | report metadata | Time anchor. | Yes | docs/manual or UNKNOWN | Required for pilot archive. |

---

# PART D — Firestore Collection Inventory

| Collection | Used By Which Operational Line | Fields Observed | Writers | Readers | Risk |
| ---------- | ------------------------------ | --------------- | ------- | ------- | ---- |
| `users` | client/clinician/center registration if present | auth/profile linkage UNKNOWN | user/system/admin depending rules | app/admin | Medium |
| `clients` | Client Registration, Follow-up | profile, status, contact, preferences, support/follow-up possible | client/admin/system | client/admin/support | High |
| `clinicians` | Clinician Verification | profile, license/status, blocked/approval fields likely | clinician/admin | clinician/admin/client matching | High |
| `centers` | Center Verification | center profile, approval/blocking/status fields likely | center/admin | center/admin/client matching | High |
| `booking_requests` | verification-adjacent center flow, session/payment not pilot core | booking/session/payment/center workflow fields | admin/client/clinician/center depending flow | app/admin | Critical |
| `bookingRequests` | legacy compatibility | legacy booking compatibility | legacy/admin/system | legacy/admin | High |
| `chat_threads` | Follow-up/support continuity | chat thread state/messages references | users/service/admin | users/admin/support | High |
| `chat_escalations` | Follow-up/support continuity | escalation assignment/status/resolve | admin/service | admin/support | High |
| `external_follow_up_registry` | Follow-up Tracking | registry/config for follow-up | admin/workspace | admin/support | High |
| `external_follow_up_message_templates` | Follow-up Tracking | templates/message types | admin/workspace | admin/support | Medium |
| `external_follow_up_campaigns` | Follow-up Tracking | campaigns/status/scheduling | admin/workspace | admin/support | High |
| `support_requests` | Follow-up/support if present | support request state | user/admin/support | admin/support/user scoped | Medium |
| `clinician_profile_change_requests` | Clinician Verification | requested profile changes/status | clinician/admin | admin/clinician | High |
| `center_profile_change_requests` | Center Verification | requested profile changes/status | center/admin | admin/center | High |
| `analytics_summaries` | Survey Analysis / Analytics if present | summaries/metrics | system/admin | admin/owner | Medium |
| `system_alerts` | Control/Analytics | alerts/anomalies | system/admin | admin/control | Medium |
| `system_health` | Control/Technical | health status | system/admin | admin/technical | Medium |
| `resources` | Library/survey/report adjacency | content/library resources | admin/content | app/web/admin | Medium |
| survey collections UNKNOWN | Survey Answers / Survey Analysis | survey/question/answer/analysis fields unknown | UNKNOWN | UNKNOWN | Unknown |
| archive/report collections UNKNOWN | Survey Analysis / Archive | reports/package metadata unknown | UNKNOWN | UNKNOWN | Unknown |

Risk note:

```text
Pilot survey readiness cannot be confirmed until actual survey collections/routes are verified.
```

---

# PART E — Storage / Document Handling Inventory

| File Type | Upload Surface | Storage Path / Field | Linked Collection | Current Risk | Pilot Readiness |
| --------- | -------------- | -------------------- | ----------------- | ------------ | --------------- |
| center licenses | center registration/admin center verification | UNKNOWN | `centers` or verification request UNKNOWN | High | PARTIAL / manual fallback needed |
| center photos | center profile/registration | UNKNOWN | `centers` UNKNOWN | Medium | PARTIAL |
| clinician licenses | clinician registration/admin verification | UNKNOWN | `clinicians` UNKNOWN | High | PARTIAL / manual fallback needed |
| certificates | clinician profile/registration | UNKNOWN | `clinicians` UNKNOWN | Medium | PARTIAL |
| identity documents | registration/trust if present | UNKNOWN | UNKNOWN | High | UNKNOWN |
| payment proof | payment/booking flows | previously finance-adjacent; path UNKNOWN | `booking_requests` likely reference | Critical | Do not touch for pilot unless needed |
| support/dispute attachments | support/chat/dispute if present | UNKNOWN | `chat_threads`, `chat_escalations`, support collection UNKNOWN | High | UNKNOWN |

Storage finding:

```text
Document upload and storage paths are not safe to assume.
Pilot verification should allow manual evidence review/export until storage paths are confirmed.
```

---

# PART F — Firestore Rules Inventory

No repository commands were executed, so this section identifies expected rule risk categories from current architecture and prior grounding inventories.

| Operational Line | Current Rules Support? | Who Can Read? | Who Can Write? | Risk | Pilot Concern |
| ---------------- | ---------------------- | ------------- | -------------- | ---- | ------------- |
| Center Verification | PARTIAL likely | center/admin depending rules | center/admin depending approval/status | High | registration or profile writes may fail if approval/claims required. |
| Clinician Verification | PARTIAL likely | clinician/admin depending rules | clinician/admin depending approval/status | High | license/profile request writes may depend on auth/claims. |
| Client Registration | PARTIAL likely | client/admin depending rules | client/user on own doc; admin broad possible | Medium | new client profile creation may hit permission-denied if rules require doc shape or auth UID. |
| Follow-up Tracking | UNKNOWN/PARTIAL | admin/support likely | admin/workspace likely | High | follow-up writes may require admin claims and may not support pilot helper roles. |
| Survey Answers | UNKNOWN | UNKNOWN | UNKNOWN | High | survey collections/rules may be missing, causing permission-denied. |
| Survey Analysis | UNKNOWN | UNKNOWN | UNKNOWN | High | analysis/report writes likely unsupported unless using docs/manual process. |

Explicit rule risks:

- rules may rely on custom claims.
- rules may allow too much admin mutation.
- rules may require approved status before certain profile writes.
- rules may block registration writes if document ownership checks are strict.
- survey rules may be missing entirely.
- external follow-up rules may be admin-only.
- profile request collections may have narrow write conditions.

Pilot rule doctrine:

```text
Do not discover permission-denied during live pilot.
Manually verify each pilot write path before participants use it.
```

---

# PART G — Admin / Control Surface Inventory

| Operational Line | Admin Surface | Current Action | Should Remain Control? | Should Move Later? | Notes |
| ---------------- | ------------- | -------------- | ---------------------- | ------------------ | ----- |
| Center Verification | `/admin/centers` | approve/block/review center profile | Observe only later | Trust & Verification / Tenant Operations | High-risk trust authority. |
| Center Verification | `/admin/booking-queue` | center request lifecycle actions | Queue visibility only later | App Operations + command boundary | Passive wrappers exist for some center lifecycle actions. |
| Clinician Verification | `/admin/clinician-requests` | approve/reject clinician requests | Observe only later | Trust & Verification | Needs checklist and appeal path. |
| Clinician Verification | `/admin/clinician-profile-requests` | apply/reject profile changes | Observe only later | Trust & Verification | Identity/trust mutation. |
| Client Registration | `/admin/clients` | client visibility/admin management | Scoped visibility | Client Self-Service + Control visibility | Avoid admin micromanagement. |
| Follow-up Tracking | `/workspace/external-follow-up*` | registry/templates/campaigns | Partly, as visibility | Support Continuity + Legal consent boundary | Consent-sensitive. |
| Follow-up Tracking | `/admin/support-chats` | support chat handling | Yes, case visibility | Support Continuity | Must not become therapy continuation. |
| Follow-up Tracking | `/chat/escalations` | assign/forward/resolve escalations | Yes, case visibility/action | Support Operations + command/audit later | Passive wrappers exist. |
| Survey Answers | survey surface unknown | UNKNOWN | Not until confirmed | App/Web Operations | Missing/unknown runtime. |
| Survey Analysis | analytics/reporting/admin unknown | UNKNOWN | Reports can be Control/Analytics | Analytics + Archive Office | Manual docs may be current archive. |

---

# PART H — Archive / Report Reality

Current archive/reporting reality:

- The strongest archive today is documentation in `docs/`.
- Governance, grounding, extraction, sovereign, and constitutional reports exist as Markdown documents.
- No protected audit runtime exists.
- No confirmed survey archive runtime exists.
- No confirmed follow-up results archive exists beyond operational collections/docs.
- Verification decisions are likely stored as current state in Firestore, not protected decision memory.
- Weekly/quarterly pilot packages are not yet a runtime feature.

| Artifact | Exists Today? | Location | Missing For Pilot |
| -------- | ------------- | -------- | ----------------- |
| governance reports | Yes | `docs/` | pilot-specific package template |
| quarterly reviews | Conceptual | `docs/` doctrine | actual quarterly process/package |
| verification decision archive | Partial/No protected memory | Firestore current status likely | decision log/export/manual archive |
| survey results archive | Unknown | UNKNOWN / docs manual possible | survey answer storage or manual package |
| survey analysis archive | Partial manually | `docs/` possible | analysis template, human/AI review fields |
| follow-up results archive | Partial/unknown | external follow-up collections/docs | consent-aware outcome report |
| GitHub snapshots | Conceptual/process | GitHub/manual | snapshot manifest discipline |
| backup manifests | Conceptual | docs/manual future | actual backup checklist/package |

Pilot archive doctrine:

```text
For pilot, docs/manual packages may act as archive.
They must not be confused with protected audit memory.
```

---

# PART I — Pilot Readiness Assessment

| Operational Line | Ready For Pilot? | Missing Minimum | Risk Level | Recommended Next Step |
| ---------------- | ---------------- | --------------- | ---------- | --------------------- |
| Center Verification | READY_WITH_MANUAL_PROCESS | confirmed upload/storage paths, verification checklist, appeal/rejection note discipline | High | Pilot Trust Verification Checklist |
| Clinician Verification | READY_WITH_MANUAL_PROCESS | license/certificate storage confirmation, verification checklist, appeal/rejection note discipline | High | Pilot Trust Verification Checklist |
| Client Registration | PARTIAL | rule/write-path confirmation, consent field confirmation, pilot cohort/manual tracking | Medium | Firestore rules safety check before live pilot |
| Follow-up Tracking | PARTIAL | consent model, follow-up outcome fields, manual archive package | High | Follow-up data plan |
| Survey Answers | BLOCKED/PARTIAL manually | confirmed survey routes/collections/forms; if absent, manual form plan | High | Survey + Follow-up Data Plan |
| Survey Analysis | READY_WITH_MANUAL_PROCESS | analysis template, human+AI review structure, archive package | Medium | Survey + Follow-up Data Plan |

Pilot readiness summary:

```text
Trust verification can begin manually.
Client registration needs rules/path safety confirmation.
Follow-up and survey need a minimum data plan before pilot.
```

---

# PART J — Cleanup / Removal Candidates

| Candidate | Type | Why Candidate | Safe To Remove Now? | Recommendation |
| --------- | ---- | ------------- | ------------------- | -------------- |
| `/home` | legacy alias | Navigation compatibility, not architecture. | No | Freeze; bury only after reference/deep-link verification. |
| `/register/clinician` | legacy/alias route | Registration path may be alias or old route. | No | Freeze; verify active pilot dependency first. |
| `/register/center` | legacy/alias route | Registration path may be alias or old route. | No | Freeze; verify active pilot dependency first. |
| `/chat/clinician/inbox` | legacy alias/path | Prior burial candidate. | No | Freeze; bury only after verification. |
| `bookingRequests` | legacy collection | Compatibility with `booking_requests`. | No | Freeze; no new dependencies. |
| admin direct trust shortcuts | admin authority | Generic admin trust mutation. | No | Freeze expansion; checklist first. |
| external follow-up admin shortcuts | support/continuity | Consent-sensitive operational shortcuts. | No | Freeze expansion; data plan first. |
| unknown survey legacy surfaces | survey | Unknown runtime maturity. | No | Inventory manually before removal. |
| preview control-room routes | preview | Could be mistaken for real Control Room. | No | Keep preview-only/frozen. |

Cleanup doctrine:

```text
Nothing should be removed before pilot.
Freeze and label first.
```

---

# PART K — Minimum Pilot Data Plan

This is pilot-only and not final architecture.

## 1. Center Verification

Minimum fields:

- center name
- location
- phone/contact
- license/document reference or manual evidence package
- verification status
- approval/rejection status
- rejection reason if rejected
- reviewer note

Current storage:

- `centers` and/or existing admin request/profile collections.

Manual:

- document review checklist
- evidence snapshot/export
- reviewer decision note

Platform-held:

- submitted center identity
- license/document reference
- approval/rejection decision
- status

Local/exported:

- reviewer working notes if not official
- offline evidence checklist copy

Manual archive:

- weekly verification decision package.

## 2. Clinician Verification

Minimum fields:

- name
- specialty
- phone/email
- license reference
- certificates if required
- center affiliation if applicable
- verification status
- approval/rejection status
- rejection reason

Current storage:

- `clinicians`, `clinician_profile_change_requests` if profile changes apply.

Manual:

- license review checklist
- appeal note process

Platform-held:

- clinician identity/profile
- license evidence reference
- verification decision

Manual archive:

- clinician verification package.

## 3. Client Registration

Minimum fields:

- name
- email/phone
- profile basics
- consent/follow-up preference
- account status
- pilot cohort/manual tag if no field exists

Current storage:

- `clients` and possibly `users`.

Manual:

- pilot participant list if runtime flag absent.

Platform-held:

- account/profile/contact/consent after submission.

Local/exported:

- user personal notes/preferences if not submitted.

Manual archive:

- pilot registration count/status summary.

## 4. Follow-up Tracking

Minimum fields:

- follow-up id or manual row id
- user id/contact reference
- consent status
- communication channel
- status
- date/time
- response status
- escalation status

Current storage:

- external follow-up collections if active; otherwise manual package.

Manual:

- consent-aware contact log.

Platform-held:

- consent status
- sent/contacted status
- escalation status.

Local/exported:

- draft message text before sending.

Manual archive:

- follow-up outcome report.

## 5. Survey Answers

Minimum fields:

- survey id
- respondent type
- question id
- answer value
- timestamp
- anonymity flag if promised
- pilot cohort

Current storage:

- UNKNOWN. If survey runtime absent, use external/manual survey tool with exported pilot package.

Manual:

- response export.
- anonymization discipline if promised.

Platform-held:

- submitted answers if used for governance decisions.

Local/exported:

- respondent personal draft before submission.

Manual archive:

- raw response export with access control.

## 6. Survey Analysis

Minimum fields:

- survey id
- category
- score aggregation
- human summary
- AI summary if used
- comparison note
- department recommendation
- created/reviewed by
- timestamp

Current storage:

- docs/manual report is acceptable for pilot.

Manual:

- analysis report.
- human review over AI summary.

Platform-held:

- final pilot analysis package.

Manual archive:

- weekly or post-pilot survey analysis report.

---

# PART L — Recommended Next Step

Options:

| Option | Assessment |
| ------ | ---------- |
| A. Create Pilot Field Gap Plan | Useful, but survey/follow-up gaps are broader than fields. |
| B. Create Pilot Firestore Rules Safety Plan | Important before live writes, especially registration. |
| C. Create Pilot Survey + Follow-up Data Plan | Best next step because these are least confirmed and most likely to need manual/process fallback. |
| D. Create Pilot Trust Verification Checklist | Also valuable, but center/clinician verification can proceed manually more easily than survey/follow-up without a data plan. |

Recommendation:

```text
Option C: Create Pilot Survey + Follow-up Data Plan
```

Justification:

Center and clinician verification appear pilot-capable with manual checklist discipline. Survey answers, survey analysis, and follow-up tracking are less confirmed and have high consent/archive risk. A minimum survey + follow-up data plan will prevent pilot data from scattering across tools, chats, and undocumented notes.

---

## Commands Executed By Codex

None

