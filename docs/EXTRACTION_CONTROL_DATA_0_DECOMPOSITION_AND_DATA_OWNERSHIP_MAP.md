# EXTRACTION-WAVE / CONTROL-DATA-0 REPORT
# Control Room Decomposition & Data Ownership Technical Map

Project: Mental Smile  
Era: Post-Grounding / Control and Data Ownership Extraction  
Status: Technical reality map only  
Runtime effect: None

---

## 1. Executive Summary

The current route/control/admin reality is still admin-centric in shape, even though the architectural direction has moved toward Owner, Control, Sovereign, App/Web Operations, tenant-scoped operations, and future command/audit/backend authority.

The current `/admin/*` surface is overloaded. It still mixes:

- observation
- operational analysis
- direct lifecycle mutation
- finance authority
- payout/accounting authority
- support escalation
- trust approval/blocking
- AI policy governance
- system/domain governance
- marketing/content workspace authority
- legacy route compatibility

This means the system has not yet decomposed authority. It has begun grounding authority through passive shadow wrappers, but those wrappers do not own runtime truth.

The decomposition must separate:

```text
route location
authority ownership
data ownership
execution authority
protected memory
```

Data ownership is equally important. Some data may safely be local/user-owned, but core operational truth cannot be device-only. Payment proof, consent, dispute evidence, booking lifecycle, session state, payout/accounting records, trust approvals, and audit memory must be platform-held or protected by future sovereign memory. Otherwise the platform cannot protect rights, resolve disputes, prevent collusion, or defend financial/legal truth.

Core conclusion:

```text
User-owned local data is valid for personal/private context.
Operational truth must be platform-held.
Sovereign truth must become protected memory.
Client devices may cache views, but must not become the only source of multi-party truth.
```

---

## 2. Current Route Topology

| Route / Route Family | Current Purpose | Current Authority | Future Target | Action |
| -------------------- | --------------- | ----------------- | ------------- | ------ |
| `/admin/*` | Generic admin compatibility cockpit. | observe, analyze, approve, mutate, finance, trust, system. | Frozen Legacy / split into future rooms. | split later |
| `/admin/hub` | Admin navigation and overview. | observe/navigation. | Control Room | rename later |
| `/admin/operations` | Operational overview and queues. | observe/analyze. | Control Room | observe-only |
| `/admin/booking-queue` | Booking and center lifecycle decisions. | mutate/approve via adapter and passive wrappers. | App Operations + Trusted Backend Command + Control visibility. | extract |
| `/admin/payments` | Payment evidence/admin finance review. | finance mutation/approval. | Sovereign Finance | freeze |
| `/admin/accounting` | Accounting and finance lifecycle review. | finance mutation/approval. | Sovereign Finance | freeze |
| `/admin/sessions` | Session lifecycle visibility/action. | app operations mutation. | App Operations + Trusted Backend Command | extract |
| `/admin/clinician-requests` | Clinician approval/trust. | trust approval/mutation. | Clinician Operations / Trust Governance | extract |
| `/admin/clinician-profile-requests` | Clinician profile change approval. | trust/profile mutation. | Clinician Operations / Trust Governance | extract |
| `/admin/centers` | Center approval/blocking/profile operations. | tenant/trust mutation. | Tenant/Center Operations / Trust Governance | extract |
| `/admin/clients` | Client visibility/admin management. | observe/mutate. | Client Self-Service + Control scoped visibility | split later |
| `/admin/support-chats` | Support chat operations. | support/continuity visibility and mutation. | Control Room + Support/Continuity Operations | split later |
| `/chat/escalations` | Chat escalation admin handling. | support case mutation, now passively shadow-wrapped. | Control Room / Support Operations | keep, purify later |
| `/admin/ai-policies` | AI policy management. | AI policy/system governance mutation. | Owner Room | extract |
| `/admin/system-domains` | System domain configuration/health. | system/IT authority. | Owner Room / Backend-System Authority | extract |
| `/admin/control-room/*` | Preview control room surfaces under admin. | preview/observe. | Control Room later, not real yet. | freeze |
| `/admin/gateways/*` | Gateway/compatibility admin surfaces. | legacy/preview. | Frozen Legacy | freeze |
| `/workspace/external-follow-up*` | Continuity/follow-up registry/templates/campaigns. | support/continuity, marketing-adjacent mutation. | Support/Continuity Operations + Legal consent boundary | split later |
| `/workspace/marketing` | Marketing workspace. | marketing/content authority. | Web Operations + Owner governance | extract |
| `/workspace/content` | Content/library management. | content authority. | Web Operations / App Operations | extract |
| `/client/*` | Client app workflows. | client-scoped operations. | Client Self-Service | keep |
| `/clinician/*` | Clinician workflows. | clinician-scoped operations. | Clinician Operations | keep |
| `/center/*` | Center workflows. | tenant/center-scoped operations. | Tenant/Center Operations | keep |
| `/booking/*` | Booking user/app lifecycle surfaces. | app operation, multi-party lifecycle. | App Operations | keep |
| `/chat/*` | Chat and support surfaces. | app/support operations. | App Operations + Support Operations | keep |
| `/register/clinician` | Registration alias/intake. | web/trust intake. | Web Operations / Trust | bury later |
| `/register/center` | Registration alias/intake. | web/trust intake. | Web Operations / Trust | bury later |
| `/chat/clinician/inbox` | Legacy/alias inbox path. | frozen compatibility. | Burial Candidate | bury later |
| `/home` | Legacy alias. | navigation compatibility. | Burial Candidate | bury later |

---

## 3. Current Admin "Mahlebiya" Map

| Admin Function | Current Location | Problem | Future Room / Domain | Priority |
| -------------- | ---------------- | ------- | -------------------- | -------- |
| booking lifecycle | `/admin/booking-queue`, `AdminBookingDecisionAdapter` | Admin still mutates booking truth directly. | App Operations + Trusted Backend Command | Critical |
| session lifecycle | `/admin/sessions`, session-adjacent adapter paths | Session fields are coupled to payment/payout/accounting/review/archive. | App Operations + command/audit later | High |
| payment | `/admin/payments`, booking adapter payment methods | Financial truth under generic admin. | Sovereign Finance | Critical |
| payout | booking/payment/admin adapter payout methods | High-risk finance finality. | Sovereign Finance | Critical |
| accounting | `/admin/accounting`, adapter accounting methods | Reconciliation authority in admin. | Sovereign Finance | Critical |
| financial archive | booking adapter archive methods | Finance/legal finality under admin. | Sovereign Finance + Sovereign Legal | Critical |
| chat escalation | `/chat/escalations`, `ChatFirestoreService` | Support lifecycle mutation still service-executed. | Control Room + Support Operations | High |
| support/continuity | `/admin/support-chats`, `/workspace/external-follow-up*` | Consent and humane continuity risks mixed with admin. | Support/Continuity Operations + Legal consent boundary | High |
| clinician approval/trust | `/admin/clinician-requests` | Trust authority is generic admin-controlled. | Clinician Operations / Trust Governance | High |
| center approval/trust | `/admin/centers` | Tenant/trust authority mixed with admin. | Tenant/Center Operations / Trust Governance | High |
| profile change approval | profile request admin pages | Identity/profile mutation under admin. | Trust Governance + Backend Command later | High |
| account blocking | account blocking service/admin flows | Direct restriction of people/entities. | Owner decision + Trust/Backend Command | Critical |
| AI policies | `/admin/ai-policies` | AI governance under admin. | Owner Room | High |
| system domains | `/admin/system-domains`, `domain_registry.dart` | System/IT authority under admin. | Owner Room + Backend/System Authority | High |
| marketing/content/workspace | `/workspace/marketing`, `/workspace/content` | Brand/content authority mixed with admin. | Web Operations + Owner governance | Medium |
| registration visibility | registration/admin/trust surfaces | Intake/trust mixed with admin. | Web Operations + Trust Governance | Medium |
| legacy aliases | `/home`, registration aliases, old inbox paths | Compatibility can be mistaken for architecture. | Frozen Legacy / Burial Candidate | Medium |

Admin mahlebiya summary:

```text
Admin is currently a blended operational dessert:
some useful visibility,
some dangerous mutation,
some sovereign authority,
some owner governance,
some legacy compatibility.
```

The cure is not a rename. It is decomposition.

---

## 4. Control Room Future Scope

Control Room should keep:

- dashboards
- monitoring
- anomaly signals
- queue visibility
- case creation
- escalation tracking
- operational reports
- support visibility
- command status visibility
- drift visibility
- issue forwarding
- operational health review

Control Room should not keep:

- payment approval/rejection
- payout confirmation
- accounting finalization
- financial archive mutation
- legal hold authority
- AI policy publishing
- system/domain writer authority
- trust blocking as generic admin
- tenant micromanagement
- direct booking/session lifecycle authority where high-risk
- owner strategy decisions
- backend/system execution authority

Control doctrine:

```text
Control sees.
Control analyzes.
Control raises cases.
Control tracks.
Control does not own sovereign truth.
Control does not become super-admin by another name.
```

---

## 5. Owner Room Future Scope

Owner Room should connect to:

- entity strategy
- constitutional governance
- development priorities
- IT/infrastructure governance
- AI policy governance
- registry/pipeline legitimacy
- high-risk decision ratification
- partner/sharing governance
- periodic governance meeting outputs
- platform evolution
- cross-room conflict resolution
- policy approval
- future valve legitimacy

Owner must not directly mutate:

- routine booking lifecycle truth
- ordinary session state
- payment approval/rejection as daily finance action
- payout confirmation
- accounting completion
- legal evidence
- tenant operational records
- support conversations
- clinical/user app workflows
- audit memory
- backend execution state

Owner doctrine:

```text
Owner governs legitimacy, direction, and high-risk policy.
Owner must not become the final form of admin.
```

---

## 6. Sovereign Room Boundaries

No Sovereign Room UI yet.

Conceptual boundary only.

### Sovereign Finance

Sovereign Finance boundary includes:

- payment evidence governance
- payment approval/rejection
- payout readiness
- payout confirmation
- accounting review
- settlement
- refunds
- financial archive eligibility
- finance correction
- reconciliation
- finance pipeline freeze/reopen recommendation

### Sovereign Legal

Sovereign Legal boundary includes:

- legal holds
- compliance evidence
- retention
- disputes
- contracts
- tax/legal documents
- consent evidence
- legal archive policy
- legal risk review
- evidence preservation/redaction policy

Boundary doctrine:

```text
Sovereign Finance owns money truth.
Sovereign Legal owns evidence, retention, liability, and legal memory.
Control may see signals.
Owner may govern legitimacy.
Neither Control nor Owner should silently execute sovereign truth.
```

---

## 7. Data Ownership Classification

| Data Type | Example | Can Be Device-Only? | Must Be Platform-Held? | Why |
| --------- | ------- | ------------------- | ---------------------- | --- |
| personal notes | private journaling, personal reminders | Yes | No, unless user opts to sync | Single-user private context; no multi-party obligation. |
| personal preferences | theme, notification preference, local UI choices | Yes | Sometimes, if cross-device sync required | Low institutional risk. |
| local drafts | unsent messages, draft booking notes | Yes | No until submitted | Not yet institutional truth. |
| self-tracking data | private mood/self notes | Yes, if not part of care/service record | No, unless user shares/submits | Protects privacy and autonomy. |
| booking request state | submitted booking lifecycle | No | Yes | Multi-party operational truth involving client/clinician/center/platform. |
| payment proof | uploaded proof/reference/hash | No | Yes | Financial evidence and dispute protection. |
| payment decision | approved/rejected payment state | No | Yes | Financial truth; must be auditable. |
| payout record | center/clinician payout state | No | Yes | Sovereign financial obligation and reconciliation. |
| accounting review | reconciliation status/decision | No | Yes | Finance memory and settlement readiness. |
| session status | scheduled/in progress/completed/reschedule/archive state | No | Yes | Multi-party lifecycle truth. |
| chat messages | support/user/provider conversations | No for submitted messages | Yes, with privacy controls | Multi-party communication and dispute/safety relevance. |
| support escalation | escalation assignment/forward/resolve | No | Yes | Operational case history and accountability. |
| dispute evidence | attachments, timestamps, references | No | Yes, protected | Legal/finance defensibility. |
| consent evidence | outreach consent, communication preference checkpoints | No | Yes, protected | Rights protection and humane continuity boundary. |
| review/rating | submitted ratings/reviews | No | Yes | Trust, quality, dispute, and lifecycle relevance. |
| profile data | client/clinician/center profile fields | Partially for local draft only | Yes once submitted/active | Identity, trust, matching, and operational accuracy. |
| trust approval data | approval/rejection/blocking/trust state | No | Yes | Authority over access and safety. |
| legal/compliance evidence | legal holds, compliance records | No | Yes, protected | Legal defensibility and retention. |
| audit memory | command/audit/history events | No | Yes, protected/immutable future | Institutional memory cannot be client-owned only. |

---

## 8. Recommended Data Model Philosophy

Should Mental Smile store all operational data on user devices only?

```text
No.
```

Device-only operational truth is unsafe for Mental Smile because the platform handles multi-party, financial, legal, support, and trust workflows.

Risks of device-only operational truth:

- device loss
- local tampering
- collusion between parties
- dispute manipulation
- no protected memory
- offline conflict ambiguity
- inability to prove payment/consent/trust state
- inability to reconcile payouts/accounting
- no institutional audit trail
- inconsistent cross-device state
- weak legal/financial defensibility

Benefits of local/device storage:

- privacy for personal notes
- lower platform storage load
- faster drafts/offline UX
- user autonomy
- reduced exposure for non-submitted data

Balanced model:

| Model | Purpose |
| ----- | ------- |
| User-Owned Local Data | Private notes, preferences, drafts, personal self-tracking not submitted as service truth. |
| Platform Operational Truth | Booking/session/chat/profile/support/trust state that affects multiple parties. |
| Sovereign Protected Memory | Payment, payout, accounting, legal, consent, dispute, audit, archive, correction history. |
| Cached/Derived Client Views | Local copies/projections of platform truth for UX; not source of truth. |

Data doctrine:

```text
Personal context can be local.
Multi-party truth must be platform-held.
Sovereign truth must be protected memory.
```

---

## 9. Anti-Collusion / Rights Protection Model

The system must protect rights even if two parties agree to manipulate truth. This is especially important for payment, consent, disputes, trust, and lifecycle finality.

Must be platform-held to prevent collusion:

- payment evidence hash/reference
- payment approval/rejection events
- consent checkpoints
- dispute timestamps
- submitted chat/support escalation events
- booking lifecycle transitions
- session lifecycle transitions
- audit events
- payout/accounting records
- financial archive transitions
- profile approval/application events
- clinician/center trust decisions
- escalation assignment/forward/resolve events

Why:

```text
If both parties can rewrite their local records,
the platform cannot protect either party when the relationship breaks down.
```

Can be user-held without harming institutional truth:

- private notes
- local drafts before submission
- personal preferences
- unsynced self-reflection data
- local reminders
- downloaded/exported copies of platform-held records
- cached read-only views

Important distinction:

```text
User ownership does not require device-only truth.
Users can own access, export, portability, and correction rights
while protected platform memory preserves institutional accountability.
```

---

## 10. Technical Recommendation: Where Data Should Live

| Layer | Storage Location | Purpose | Examples |
| ----- | ---------------- | ------- | -------- |
| local device storage | device/app local storage | User-private or temporary UX data. | personal notes, preferences, unsent drafts, cached screens. |
| Firestore operational documents | current/future platform operational collections | Active multi-party runtime truth. | `booking_requests`, `chat_threads`, `chat_escalations`, profiles, support state. |
| future protected audit collections | future append-only/protected platform memory | Institutional history of meaningful changes. | payment decisions, payout confirmations, escalation resolution, trust approvals. |
| future immutable storage/evidence references | protected evidence storage/reference layer | Preserve sensitive files/evidence without overexposing raw data. | payment proof reference, dispute attachment reference, legal document reference. |
| cached projections | app local cache or derived read models | Fast role-scoped views, not source truth. | queue summaries, dashboards, user-visible status. |
| export/download for user ownership | generated files/user copies | Portability and user rights. | receipts, booking summaries, chat export where policy allows, consent history summary. |

Recommended principle:

```text
Do not make client devices the source of operational truth.
Do make client devices respectful holders of personal context and cached views.
```

---

## 11. Current Firestore Reality Gap

Current reality still differs significantly from the target philosophy.

Known gaps:

- `booking_requests` acts as shared state for booking, session, payment, payout, accounting, review, archive, and workflow.
- Lifecycle fields from multiple domains are mixed.
- Admin mutation residue still writes real state.
- Passive shadow wrappers exist but do not own truth.
- No immutable audit runtime exists.
- No true sovereign memory exists yet.
- Finance/legal truth is not separated into protected memory.
- Control/Owner/Sovereign route boundaries are not real runtime boundaries.
- Firestore rules/custom claims still reflect current compatibility more than future constitutional identity.

Current state:

```text
Firestore is operational truth.
Admin still mutates important parts of that truth.
Audit is not yet protected memory.
```

Target state:

```text
Firestore holds operational truth.
Audit holds protected memory.
Sovereign evidence is scoped and retained.
Client devices hold private context and cached views.
Commands/backend eventually govern high-risk mutation.
```

---

## 12. Route Extraction Sequence

Recommended sequence:

1. Freeze and bury legacy aliases only after verification.
2. Purify Control Room visible-only surfaces.
3. Separate finance/legal conceptually and keep frozen.
4. Define protected memory/data ownership boundaries.
5. Define Owner governance surfaces and decision outputs.
6. Split app operations from web operations.
7. Define tenant/center/clinician/client scoped operation boundaries.
8. Continue command/audit/runtime separation gradually.
9. Create room routes only after authority boundaries are explicit.
10. Implement enforcement only after audit and rollback/correction philosophy is real.

Important correction:

```text
Do not rename routes before authority is decomposed.
Do not move UI before data ownership is understood.
Do not create rooms before protected memory boundaries exist.
```

---

## 13. Risk Register

| Risk | Description | Severity |
| ---- | ----------- | -------- |
| building rooms before boundaries | New rooms inherit old admin powers. | Critical |
| client-only operational truth | Multi-party, finance, consent, and dispute truth becomes tamperable/lost. | Critical |
| admin residue staying too long | Compatibility cockpit remains actual architecture. | High |
| over-centralized platform storage | Platform stores too much private personal context unnecessarily. | High |
| privacy exposure | More platform-held data increases breach/redaction burden. | High |
| losing protected memory | Without audit, actions become unverifiable. | Critical |
| owner becoming super-admin | Owner Room becomes renamed admin. | Critical |
| sovereign rooms becoming new cockpits | Finance/legal rooms mutate without audit/command boundaries. | Critical |
| routes renamed without authority change | Cosmetic migration creates false confidence. | High |
| local cache mistaken for truth | Client projections drift from platform truth. | Medium |
| collusion/tampering | Parties manipulate device-only data to alter disputes. | Critical |
| consent evidence weakness | Continuity/support outreach loses rights protection. | High |
| shared `booking_requests` complexity | Field ownership remains unclear across domains. | High |

---

## 14. Recommended Next Wave

Options:

| Option | Assessment |
| ------ | ---------- |
| A. Control Room Purification Map | Useful, but should follow a clearer data ownership/protected memory boundary. |
| B. Data Ownership & Protected Memory Specification | Best next step because route decomposition depends on knowing what truth belongs where. |
| C. Route Extraction Plan | Too early if authority/data ownership are not settled. |
| D. Owner Room Boundary Spec | Important, but risks becoming abstract without data/authority grounding. |

Recommendation:

```text
Option B: Data Ownership & Protected Memory Specification
```

Reason:

The main danger is not only overloaded admin routes. It is unclear truth ownership. If the project moves routes first, it may create nicer rooms that still mutate unsafe data. If it moves data thinking first, later room boundaries can be real.

---

## 15. Final Verdict

Question:

```text
What should be decomposed first:
routes, authority, or data ownership?
```

Answer:

```text
Authority first,
data ownership immediately with it,
routes last.
```

Correct order:

```text
1. Authority ownership
2. Data ownership / protected memory
3. Route and room extraction
4. Command/audit/backend enforcement
```

Why:

- Routes are visible labels.
- Authority is what actions are allowed.
- Data ownership is what truth must be protected.
- Protected memory is what prevents the system from lying to itself later.

Final doctrine:

```text
Do not move rooms before moving meaning.
Do not move data to devices when it represents multi-party truth.
Do not create Control, Owner, or Sovereign surfaces
until authority and protected memory boundaries are clear.
```

---

## Commands Executed By Codex

None

