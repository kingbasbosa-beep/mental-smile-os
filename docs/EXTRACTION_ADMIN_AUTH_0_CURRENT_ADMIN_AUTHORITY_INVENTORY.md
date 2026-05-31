# EXTRACTION-WAVE / ADMIN-AUTH-0 REPORT
# Current Admin Authority Extraction Inventory

Project: Mental Smile  
Era: Post-Grounding / Owner-Control-Sovereign Separation Preparation  
Status: Inventory only  
Runtime effect: None

---

## 1. Executive Summary

The current `/admin/*` surface is still a compatibility cockpit carrying mixed authority. It is not yet a purified Control Room, Owner Room, or Sovereign Room.

Inside the current admin surface, several authority types still coexist:

- observation
- analysis
- approval
- direct mutation
- booking lifecycle operation
- finance-adjacent authority
- payout/accounting/archive authority
- AI policy governance
- system/domain governance
- trust approval/blocking
- support and escalation handling
- content/marketing/workspace surfaces
- frozen legacy aliases and compatibility paths

This inventory does not recommend deleting admin. It recommends extracting the authority lines trapped inside admin so each line can be frozen, purified, moved, or wrapped later.

Core finding:

```text
/admin/* is operationally necessary today,
but architecturally overloaded.
```

The next safe architectural step is not to create new rooms. It is to classify current admin residue so the future rooms do not accidentally inherit super-admin authority.

---

## 2. Admin Surface Inventory

| Admin Surface / Route | File | Current Function | Current Authority Type | Risk |
| --------------------- | ---- | ---------------- | ---------------------- | ---- |
| `/admin/*` | `lib/app/router/` | Generic admin compatibility surface. | observe, analyze, approve, mutate, frozen legacy | Critical |
| `/admin/hub` | `lib/features/admin_surface/` | Admin landing/hub for operational navigation. | observe, app operations | Medium |
| `/admin/operations` | `lib/features/admin_surface/` | Operational overview and queue visibility. | observe, analyze, app operations | Medium |
| `/admin/booking-queue` | `lib/features/admin_surface/pages/admin_booking_queue_page.dart` | Booking and center lifecycle decisions. | approve, mutate, app operations | Critical |
| Booking decision adapter | `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | Direct booking lifecycle writes to `booking_requests`. | mutate, approve, finance-adjacent | Critical |
| Booking command wrapper | `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart` | Passive diagnostic command shadow over selected booking decisions. | observe, analyze | Medium |
| `/admin/payments` | `lib/features/admin_surface/` | Payment evidence/admin finance-adjacent review. | finance, approve, mutate | Critical |
| Payment decision adapter | `lib/features/admin_surface/data/services/` | Payment approval/rejection behavior. | finance, mutate | Critical |
| `/admin/accounting` | `lib/features/admin_surface/` | Accounting review/financial lifecycle visibility and action. | finance, approve, mutate | Critical |
| Payout confirmation paths | `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | Center/clinician payout confirmation. | finance, mutate | Critical |
| Financial archive paths | `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | Sends records to financial archive. | finance, legal, mutate | Critical |
| `/admin/sessions` | `lib/features/admin_surface/` | Session lifecycle visibility/action. | app operations, mutate | High |
| Session decision adapter | `lib/features/admin_surface/data/services/` | Admin session lifecycle mutation. | mutate, app operations | High |
| `/admin/clinician-requests` | `lib/features/admin_surface/` | Clinician approval/trust handling. | trust, approve, mutate | High |
| `/admin/clinician-profile-requests` | `lib/features/admin_surface/` | Clinician profile change approval/application. | trust, mutate | High |
| `/admin/centers` | `lib/features/admin_surface/` | Center approval/blocking/management. | trust, tenant operations, mutate | High |
| `/admin/clients` | `lib/features/admin_surface/` | Client visibility/admin management. | observe, app operations, mutate | High |
| Account blocking service | `lib/features/admin_surface/data/services/` | Blocking/unblocking accounts. | trust, mutate | Critical |
| `/admin/support-chats` | `lib/features/admin_surface/` | Support chat monitoring/handling. | support/continuity, observe, mutate | High |
| `/chat/escalations` / admin chat page | `lib/features/admin_surface/pages/chat_escalations_page.dart` | Assign/forward/resolve escalations. | support/continuity, mutate | High |
| Chat escalation wrapper | `lib/features/chat/data/commands/chat_escalation_command_wrapper.dart` | Passive diagnostic command shadow over escalation actions. | observe, analyze | Medium |
| Chat Firestore service | `lib/features/chat/data/services/chat_firestore_service.dart` | Chat/escalation writes. | support/continuity, mutate | High |
| `/admin/ai-policies` | `lib/features/admin_surface/` | AI policy view/save/publish authority. | AI policy, system/IT, mutate | High |
| AI policy health/service surfaces | `lib/features/admin_surface/`, `lib/core/` | AI policy health checks and operational status. | AI policy, system/IT, observe/analyze | Medium |
| `/admin/system-domains` | `lib/features/admin_surface/`, `lib/core/system/domain_registry.dart` | System domain visibility/configuration. | system/IT, mutate | High |
| `/admin/gateways/*` | `lib/features/admin_surface/` | Gateway/preview/admin compatibility surfaces. | frozen legacy, observe | Medium |
| `/admin/control-room/*` | `lib/features/admin_surface/` | Preview control-room-like surfaces under admin. | preview, observe | Medium |
| `/workspace/external-follow-up*` | `lib/features/admin_surface/`, workspace features | External follow-up and continuity campaigns/templates. | support/continuity, marketing/content, mutate | High |
| `/workspace/marketing` | workspace/admin surfaces | Marketing operational surface. | marketing/content | Medium |
| `/workspace/content` | workspace/admin surfaces | Content/library management. | marketing/content, web operations | Medium |
| Registration aliases | `lib/app/router/` | Legacy route aliases for registration. | frozen legacy, web operations | Medium |
| `/home` alias | `lib/app/router/` | Legacy navigation compatibility. | frozen legacy | Low |

---

## 3. Mutation Authority Inventory

| File / Service | Method | Collection Mutated | Mutation Type | Current Actor | Risk | Future Treatment |
| -------------- | ------ | ------------------ | ------------- | ------------- | ---- | ---------------- |
| `admin_booking_decision_adapter.dart` | `assignClinician` | `booking_requests` | Booking assignment | admin | High | Trusted Backend Command |
| `admin_booking_decision_adapter.dart` | `rejectRequest` | `booking_requests` | Booking rejection | admin | High | Trusted Backend Command |
| `admin_booking_decision_adapter.dart` | `returnToPending` | `booking_requests` | Booking lifecycle return | admin | High | Trusted Backend Command |
| `admin_booking_decision_adapter.dart` | `approveCenterRequest` | `booking_requests` | Center request approval | admin | High | Trusted Backend Command |
| `admin_booking_decision_adapter.dart` | `returnCenterRequestToClient` | `booking_requests` | Center request return | admin | High | Trusted Backend Command |
| `admin_booking_decision_adapter.dart` | `openCenterIntakeStep` | `booking_requests` | Center intake lifecycle | admin | High | Trusted Backend Command |
| `admin_booking_decision_adapter.dart` | `moveCenterToFollowUp` | `booking_requests` | Center follow-up lifecycle | admin | High | Trusted Backend Command |
| `admin_booking_decision_adapter.dart` | `approvePayment` | `booking_requests` | Payment evidence approval | admin | Critical | Sovereign Finance |
| `admin_booking_decision_adapter.dart` | `rejectPayment` | `booking_requests` | Payment evidence rejection | admin | Critical | Sovereign Finance |
| `admin_booking_decision_adapter.dart` | `confirmCenterAccountingReview` | `booking_requests` | Accounting review confirmation | admin | Critical | Sovereign Finance |
| `admin_booking_decision_adapter.dart` | `confirmCenterPayout` | `booking_requests` | Center payout confirmation | admin | Critical | Sovereign Finance |
| `admin_booking_decision_adapter.dart` | `confirmClinicianPayout` | `booking_requests` | Clinician payout confirmation | admin | Critical | Sovereign Finance |
| `admin_booking_decision_adapter.dart` | `sendToSessionArchive` | `booking_requests` | Session archive transition | admin | High | Trusted Backend Command |
| `admin_booking_decision_adapter.dart` | `sendToFinancialArchive` | `booking_requests` | Financial archive transition | admin | Critical | Sovereign Finance / Sovereign Legal |
| Admin session adapter | session lifecycle methods | `booking_requests` / session fields | Session lifecycle changes | admin | High | Trusted Backend Command |
| Account blocking service | block/unblock methods | `clients`, `clinicians`, `centers`, auth-adjacent records | Account restriction | admin | Critical | Owner decision / Trusted Backend Command |
| Admin clinician requests | approve/reject methods | `clinicians`, request collections | Trust approval | admin | High | Tenant Operation / Trust Governance |
| Admin centers | approve/block/update methods | `centers`, request collections | Center trust/tenant mutation | admin | High | Tenant/Center Operation / Trust Governance |
| Admin profile requests page | apply profile changes | `clinicians`, `centers`, profile request collections | Identity/profile mutation | admin | High | Trusted Backend Command |
| `chat_firestore_service.dart` | `assignEscalationToAdmin` | `chat_escalations`, possibly `chat_threads` | Escalation assignment | admin | High | Control observe/case + Trusted Backend Command later |
| `chat_firestore_service.dart` | `forwardEscalationToClinician` | `chat_escalations`, `chat_threads` | Escalation forwarding | admin | High | Control observe/case + Trusted Backend Command later |
| `chat_firestore_service.dart` | `resolveEscalation` | `chat_escalations`, `chat_threads` | Escalation resolution | admin | High | Control observe/case + Trusted Backend Command later |
| AI policy page/services | save/publish methods | `ai_policies` | AI governance mutation | admin | High | Owner decision |
| System domain services | write/update methods | `system_domains`, health/system collections | System configuration | admin/system | High | Owner decision / Backend/System Authority |
| External follow-up registry service | registry update methods | `external_follow_up_registry` | Continuity registry mutation | admin | High | Support/Continuity Operation / Owner policy |
| External follow-up template service | template CRUD | `external_follow_up_message_templates` | Communication template mutation | admin | Medium | Web Operation / Support governance |
| External follow-up campaign service | campaign create/update/send state | `external_follow_up_campaigns` | Outreach campaign lifecycle | admin | High | Support/Continuity Operation |
| Centers Firestore service | center writes | `centers`, related collections | Center profile/trust mutation | admin/center | High | Tenant/Center Operation |

---

## 4. Finance / Legal Authority Residue

Admin still contains or touches finance/legal-adjacent authority. These lines must leave generic admin/control over time.

| Authority | Current Admin Residue | Required Future Location |
| --------- | --------------------- | ------------------------ |
| payment approval | Admin payment/booking decision paths can approve evidence. | Sovereign Finance |
| payment rejection | Admin can reject payment evidence. | Sovereign Finance |
| accounting review | Admin accounting/booking paths confirm accounting review. | Sovereign Finance |
| payout confirmation | Admin paths confirm center/clinician payouts. | Sovereign Finance |
| settlement readiness | Implied through accounting/payout/archive fields. | Sovereign Finance |
| refunds | Any refund-like authority should not remain admin-owned. | Sovereign Finance |
| financial archive | Admin can send to financial archive. | Sovereign Finance + Sovereign Legal |
| tax/legal documents | Any tax/legal document authority belongs outside admin. | Sovereign Legal / Finance |
| legal holds | If present or future, must not be generic admin. | Sovereign Legal |
| compliance evidence | Compliance data and evidence need sovereign/legal governance. | Sovereign Legal |

Critical rule:

```text
Control Room may observe finance anomalies.
It must not own finance truth.
```

---

## 5. Owner Room Candidates

The following admin powers are Owner Room candidates because they define entity-level governance, platform direction, or constitutional legitimacy.

| Candidate | Current Admin Residue | Owner Room Reason |
| --------- | --------------------- | ----------------- |
| AI policy governance | `/admin/ai-policies`, AI policy services. | AI boundaries are platform governance. |
| System/domain governance | `/admin/system-domains`, domain registry. | Runtime domains and system configuration are entity authority. |
| Development priorities | Operational pain and admin reports. | Owner prioritizes platform evolution. |
| IT/infrastructure governance | System health/domain surfaces. | Infrastructure direction should not be generic admin mutation. |
| Marketing governance | `/workspace/marketing`. | Brand and market direction are entity-level governance. |
| Registry/pipeline legitimacy | Emerging pipeline and registry authority. | Owner decides legitimacy, not daily operations. |
| High-risk closure approvals | Future pipeline valve closure requests. | Owner co-approves high-risk containment. |
| Cross-room conflict resolution | Mixed admin authority conflicts. | Owner governs boundary disputes. |

Owner Room must not inherit direct mutation paths. It should own legitimacy, not become the new cockpit.

---

## 6. Control Room Candidates

These admin capabilities are likely to remain in a future purified Control Room, but with mutation removed or sharply scoped.

| Candidate | Current Admin Residue | Future Control Posture |
| --------- | --------------------- | ---------------------- |
| dashboards | Admin hub/operations pages. | Observe operational status. |
| monitoring | Health, queues, anomalies. | Observe and escalate. |
| operational reports | Admin summaries/reports. | Analyze and forward. |
| queue visibility | Booking, sessions, escalations. | Observe queue state, not own truth. |
| escalation visibility | Chat escalation pages. | Case visibility and scoped action. |
| anomaly reporting | Finance/system/support anomalies. | Report to Owner/Sovereign/System. |
| case creation | Support/escalation/cross-domain issue raising. | Request action, not directly mutate high-risk truth. |
| support continuity visibility | Follow-up and support states. | Consent-aware visibility; no exploitative outreach. |
| command status visibility | Future command runtime. | Observe execution state. |

What must become observe-only:

- finance anomaly visibility
- payout status visibility
- accounting status visibility
- legal/compliance concern visibility
- AI policy health visibility
- system/domain health visibility

Control Room should not become powerless, but its power should be:

```text
observe
analyze
case
escalate
recommend
track
```

not:

```text
own all runtime truth
```

---

## 7. Sovereign Room Candidates

### Sovereign Finance

| Authority | Current Admin Location | Why Sovereign | Risk If Left In Admin |
| --------- | ---------------------- | ------------- | --------------------- |
| Payment approval | Admin payment/booking paths | Financial evidence determines economic truth. | Admin can alter payment reality. |
| Payment rejection | Admin payment/booking paths | Rejection affects user/service lifecycle. | Financial disputes and silent authority. |
| Accounting review | Admin accounting paths | Reconciliation and settlement depend on it. | Accounting drift and payout errors. |
| Payout confirmation | Booking/payment admin adapters | Payout is high-risk financial authority. | Critical financial corruption. |
| Refunds | Finance-adjacent admin paths if present/future | Refunds require finance governance. | User/tenant financial harm. |
| Settlement | Accounting/payout/archive-adjacent paths | Settlement is sovereign financial closure. | Incorrect financial finality. |
| Financial archive | Admin archive paths | Financial archive is retention/finality. | Legal/finance memory corruption. |
| Tax summaries | Finance/legal surfaces | Tax obligations are sovereign-grade. | Compliance risk. |
| Finance reconciliation | Admin accounting/finance surfaces | Reconciliation must be finance-owned. | Hidden debt and mismatch. |

### Sovereign Legal

| Authority | Current Admin Location | Why Sovereign | Risk If Left In Admin |
| --------- | ---------------------- | ------------- | --------------------- |
| Legal holds | Legal/compliance-adjacent admin paths if present/future | Legal hold restricts memory and mutation. | Evidence mishandling. |
| Contracts | Admin/legal/content-adjacent future surfaces | Contracts define entity obligations. | Unauthorized legal commitment. |
| Compliance evidence | System/admin/compliance-adjacent data | Evidence must be preserved and scoped. | Compliance failure. |
| Legal risk review | Admin issue/legal concern paths | Legal judgment cannot be generic admin action. | Operational convenience overrides law. |
| Tax/legal documents | Finance/legal document paths | Legal/tax retention has strict obligations. | Legal exposure. |
| Legal archive | Archive/finalization paths | Legal memory must be defensible. | Rewriting or losing legal history. |

---

## 8. App/Web Operations Candidates

| Area | Future Location | Current Admin Relationship |
| ---- | --------------- | -------------------------- |
| Booking user workflow | App Operations | Admin currently observes and mutates booking lifecycle. |
| Session user workflow | App Operations | Admin/session surfaces hold lifecycle authority. |
| Chat user workflow | App Operations / Support Operations | Admin escalations mutate chat support lifecycle. |
| Client profile self-service | Client Self-Service | Admin may approve/apply sensitive changes. |
| Clinician profile operations | Clinician Operations / Trust | Admin profile requests apply changes. |
| Center profile operations | Tenant/Center Operations / Trust | Admin center surfaces mutate center state. |
| Registration web portal | Web Operations / Trust | Admin approves downstream registration/trust. |
| Library/content web surfaces | Web Operations | Admin/workspace surfaces manage content. |
| Marketing workspace | Web Operations / Owner Governance | Admin workspace currently carries marketing authority. |
| External follow-up | Support/Continuity Operations | Admin/workspace may create continuity campaigns. |
| Tenant module/config visibility | Tenant/Center Operations / Owner Registry | Admin should not micromanage tenant scope. |

Important separation:

```text
App Operations runs product workflows.
Web Operations runs public/intake/content surfaces.
Owner governs direction.
Control observes health.
```

---

## 9. Frozen Legacy Lines

These authority lines must not expand while extraction is underway.

| Frozen Line | Reason |
| ----------- | ------ |
| admin direct finance mutation | Finance must become sovereign-scoped. |
| admin payout confirmation | Critical financial authority. |
| admin accounting finalization | Settlement and archive coupling. |
| admin financial archive | Legal/financial finality. |
| admin legal authority | Legal/compliance must be sovereign. |
| admin AI policy mutation | AI policy belongs to Owner governance. |
| admin system/domain writer | System authority belongs to Owner/System. |
| admin tenant micromanagement | Violates tenant/center sovereignty. |
| admin full-control booking residue | Must continue moving toward command/audit/backend. |
| admin trust blocking without governance | Trust authority affects provider/tenant ecosystem. |
| preview control-room mutation | Preview surfaces must not become real runtime authority. |
| legacy aliases as future routes | Compatibility does not equal architecture. |

Freeze does not mean delete:

```text
Freeze means no expansion without review.
```

---

## 10. Extraction Priority

| Priority | Authority Line | Why First | Suggested Next Step |
| -------- | -------------- | --------- | ------------------- |
| 1 | Finance/payout/accounting inside admin | Highest risk, sovereign-grade, cross-domain coupling. | Sovereign Finance/Legal Separation Map |
| 2 | Admin direct booking lifecycle mutation | Already partially shadow-wrapped; still mutates real truth. | Continue command/audit planning, not enforcement. |
| 3 | Account blocking and trust authority | Can harm users/providers/tenants directly. | Trust Authority Extraction Map |
| 4 | AI policy mutation | Platform-wide governance risk. | Owner Room AI Policy Boundary |
| 5 | System/domain writer authority | Infrastructure/runtime configuration risk. | Owner/System Authority Boundary |
| 6 | Chat escalation mutation | Already shadow-wrapped; still legacy-service executed. | Control Room case/visibility map |
| 7 | External follow-up/continuity campaigns | Human/consent risk. | Continuity Governance Boundary |
| 8 | Marketing/content authority | Brand/public trust risk, lower runtime danger. | Web Operations Boundary |
| 9 | Legacy aliases/ghost routes | Route confusion and resurrection risk. | Freezer/Burial verification |
| 10 | Preview admin/control surfaces | Can accidentally become real architecture. | Preview-only labeling and no-expansion review |

The first extraction target should be finance/payout/accounting because it is both high-risk and clearly misplaced inside generic admin.

---

## 11. Recommended Next Wave

Recommendation:

```text
Option B: Sovereign Finance/Legal Separation Map
```

Reason:

The inventory shows that the most dangerous admin residue is sovereign-grade authority:

- payment approval/rejection
- accounting review
- payout confirmation
- settlement readiness
- financial archive
- legal/compliance evidence

These should not remain conceptually inside admin/control. They also should not be implemented yet as a new room. The next wave should map exactly where finance and legal authority currently lives, what must freeze, what can remain visible to Control Room, and what future sovereign boundaries are required.

Why not the other options:

| Option | Reason Not First |
| ------ | ---------------- |
| Control Room Purification Map | Useful, but finance/legal must first be separated as forbidden Control authority. |
| Owner Room Boundary Spec | Risk of creating a super-admin spec before sovereign hazards are isolated. |
| Admin Mutation Wrapper Expansion | Wrappers help grounding, but finance/legal authority needs boundary doctrine before more mutation coverage. |

Recommended sequence:

```text
Sovereign Finance/Legal Separation Map
 -> Control Room Purification Map
 -> Owner Room Boundary Spec
 -> Targeted wrapper/audit planning
```

---

## Commands Executed By Codex

None

