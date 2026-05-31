# EXPLORATION-WAVE REPORT
# Authority Network & Room Boundary Map

Project: Mental Smile  
Era: Post-Grounding / Owner-Control-Sovereign Separation Exploration  
Status: Architectural discovery only  
Runtime effect: None

---

## 1. Current Authority Reality

The current `/admin/*` surface is still a mixed authority environment. It contains observation, operations, approval, mutation, finance-adjacent workflows, system configuration, AI policy surfaces, support visibility, registration/trust flows, and legacy operational residue.

That does not mean every admin surface is wrong. It means `/admin/*` is still carrying too many kinds of authority inside one room.

Current admin power categories:

| Category | Current Admin Reality | Constitutional Concern |
| -------- | --------------------- | ---------------------- |
| observe | Admin dashboards, queues, summaries, operational lists. | Generally acceptable for Control Room if scoped and redacted. |
| analyze | Admin reviews bookings, chats, escalations, health signals, reports. | Acceptable if analysis does not imply silent mutation. |
| approve | Admin approves/rejects requests, center actions, clinician/trust flows. | Risky because approval is authority, not observation. |
| mutate | Admin adapters write lifecycle state directly. | High risk; should move toward command/backend/audit. |
| finance | Payments, accounting, payout, financial archive surfaces. | Must not remain generic admin authority. |
| legal | Compliance/legal-adjacent holds, documents, archive implications. | Needs sovereign legal room or owner/legal governance. |
| marketing | Workspace marketing/content surfaces. | Owner/Web Operations governance, not Control Room mutation. |
| development | System/domain and operational improvement paths. | Owner/IT governance, not admin runtime authority. |
| AI policy | AI policy surfaces and health checks. | Owner governance; Control may observe health only. |
| system/IT | System domains, health, alerts, configuration-like surfaces. | Owner/System authority, with backend execution where needed. |
| content/library | Resources, library/content surfaces. | Web/App content operations, owner-governed. |
| registration/trust | Clinician/center registration, approval, blocking, profile requests. | Trust authority must be separated from generic admin. |
| support/continuity | Support chats, escalation, external follow-up, continuity surfaces. | Control Room may observe/case; outreach must be consent-aware. |
| app operations | Booking, session, chat, profile workflows. | Operational domain authority; Control observes/escalates. |
| web operations | Registration, marketing, content/library web surfaces. | Web Operations + Owner governance. |

Current reality summary:

```text
/admin/* still behaves as a compatibility cockpit,
not yet as a purified Control Room.
```

The central risk is not that admin exists. The risk is that admin still combines:

```text
visibility + decision + mutation + finance + system policy
```

inside one compatibility shell.

---

## 2. Room Classification

| Authority / Function | Current Location | Future Room | Why | Risk If Left In Admin |
| -------------------- | ---------------- | ----------- | --- | --------------------- |
| Operational dashboards | `/admin/*` | Control Room / Admin Operations | Admin should monitor operational health and queue state. | Low if observe-only; high if dashboards mutate. |
| Booking queue observation | `/admin/booking-queue` | Control Room / Admin Operations | Useful operational visibility. | Direct lifecycle mutation remains broad admin authority. |
| Booking lifecycle decisions | `/admin/booking-queue`, adapters | Backend/System Authority via command | Lifecycle truth should not be owned by UI. | Silent admin mutation, audit gaps, cross-domain coupling. |
| Payment approval/rejection | `/admin/payments`, booking adapters | Sovereign Finance Room | Financial decisioning is sovereign-grade. | Generic admin can alter financial truth. |
| Accounting review | `/admin/accounting`, booking adapters | Sovereign Finance Room | Accounting affects settlement and archive readiness. | Finance leakage and reconciliation ambiguity. |
| Payout confirmation | Admin booking/payment surfaces | Sovereign Finance Room | Payout is high-risk irreversible/near-irreversible authority. | Critical financial corruption risk. |
| Financial archive | Admin archive paths | Sovereign Finance Room | Financial finalization must be sovereign-audited. | Silent financial finalization. |
| Legal holds/documents | Admin/system/archive-adjacent areas | Sovereign Legal Room | Legal evidence and holds need legal governance. | Admin may accidentally create legal exposure. |
| Compliance evidence | Admin/system/compliance-adjacent surfaces | Sovereign Legal Room / Owner Room | Compliance is governance and evidence. | Compliance drift, hidden legal authority. |
| AI policy governance | `/admin/ai-policies` | Owner Room | AI policy is platform governance, not support admin work. | Admin becomes AI governor. |
| AI health observation | AI health/admin surfaces | Control Room observe-only | Admin may observe anomalies. | Observation turns into policy mutation. |
| System domains | `/admin/system-domains` | Owner Room / Backend/System Authority | System configuration is entity/runtime authority. | Admin becomes infrastructure controller. |
| Development priorities | Admin reports/workspace | Owner Room | Owner prioritizes platform evolution. | Admin pain becomes direct runtime change pressure. |
| IT/infrastructure | System/admin surfaces | Owner Room + Backend/System Authority | Infrastructure requires governed ownership and technical execution. | Hidden dev/IT authority under admin. |
| Marketing governance | `/workspace/marketing` | Owner Room / Web Operations | Marketing is entity strategy and web operations. | Admin becomes brand/market authority. |
| Content/library | `/workspace/content`, resources | Web Operations / App Operations | Content has user-facing operational impact. | Content changes bypass governance. |
| Registration intake | Web/app registration routes | App/Web Operations + Trust | Pre-approval flow should be mostly self-service and trust-scoped. | Admin micromanages pre-payment/pre-trust interactions. |
| Clinician approval/blocking | `/admin/clinician-requests`, trust surfaces | Trust / Owner-governed authority | Trust authority affects marketplace safety. | Generic admin can shape provider ecosystem. |
| Center approval/blocking | `/admin/centers` | Tenant/Center Operations + Trust / Owner governance | Center activation is tenant/trust boundary. | Admin overreach into tenant sovereignty. |
| Profile change approval | Admin profile request pages | Trust / Tenant Operation / Backend command | Changes affect identity and trust records. | Admin silent profile mutation. |
| Chat escalation assignment | `/chat/escalations`, admin chat pages | Control Room / Support Operations | Assignment can remain operational if scoped. | Escalation authority may broaden into support control. |
| Chat escalation resolve/forward | Admin chat escalation page | Control Room / Support Operations | Case lifecycle, not sovereign authority. | Missing audit and support accountability. |
| External follow-up | Workspace/external follow-up | Support/Continuity Operations | Continuity must be consent-aware and non-clinical. | Exploitative or overreaching outreach. |
| Tenant settings/modules | Admin/system/module surfaces | Tenant/Center Operations + Owner registry governance | Tenant scope must be protected. | Generic admin controls tenant identity. |
| Audit visibility | Admin/audit-like surfaces | Control Room redacted, Owner/Sovereign by scope | Audit is memory with visibility boundaries. | Audit overexposure and privacy leakage. |
| Frozen aliases/legacy routes | `/home`, aliases, old routes | Frozen Legacy | Keep for compatibility until verified burial. | Legacy path resurrects old authority. |

---

## 3. Owner Room Scope

The Owner Room should own entity-level governance, platform direction, and constitutional legitimacy. It should not become a better-branded super-admin.

Owner Room should own:

| Scope | Owner Role |
| ----- | ---------- |
| Constitutional decisions | Maintain and evolve the rules that limit authority. |
| Entity strategy | Decide where the platform is going and what the business/entity prioritizes. |
| Development priorities | Prioritize engineering/IT work based on evidence and governance. |
| IT/infrastructure oversight | Govern infrastructure direction, not manually mutate runtime truth. |
| Marketing governance | Approve brand/market direction and policy, not operate every campaign. |
| AI policy governance | Set AI boundaries, approved use cases, and risk posture. |
| Platform configuration | Govern high-level configuration legitimacy. |
| Registry evolution | Approve changes to allowed reality, capabilities, policies, and command eligibility. |
| Pipeline legitimacy | Decide which domains become pipelines and what their authority boundaries are. |
| High-risk valve closures | Approve or co-approve closure of critical operational/sovereign pipelines. |
| Cross-room conflict resolution | Resolve disputes between Control, Sovereign, Tenant, and System authority. |

Owner Room must not become:

```text
super-admin
daily operations room
tenant micromanagement room
silent mutation authority
support cockpit
finance executor
legal executor
backend operator
AI autopilot authority
```

Critical risk:

```text
If Owner Room can directly mutate everything,
then the system has not escaped admin-centric authority.
It has only renamed it.
```

Owner Room should decide legitimacy and direction. It should not casually perform operational execution.

---

## 4. Control Room / Admin Operations Scope

Control Room is the purified future of admin operations. It should be strong in awareness and weak in unilateral mutation.

Control Room should contain:

- monitoring
- operational analysis
- queue visibility
- anomaly visibility
- case observation
- escalation visibility
- support continuity visibility
- report forwarding
- operational health dashboards
- recommendation to Owner/Sovereign/Trusted Backend
- status visibility for commands and incidents

Control Room may request action. It should not own ultimate authority for high-risk action.

Control doctrine:

```text
Admin observes and escalates.
Owner decides.
Trusted command executes.
Audit remembers.
```

More precise:

```text
Control Room sees enough to protect operations.
It does not see everything by default.
It does not mutate everything by convenience.
```

Control Room should keep limited scoped execution only where:

- action is low-risk
- scope is clear
- rollback is trivial
- audit requirement is known
- future command path is defined

Everything else should become:

```text
case/request/recommendation
```

not direct mutation.

---

## 5. Sovereign Finance / Legal Room

Finance and legal authority must leave generic admin/control.

### Sovereign Finance Room

Belongs in Sovereign Finance:

- payment approval/rejection governance
- payout confirmation
- payout execution readiness
- accounting review
- settlement
- refunds
- commission distribution
- financial archive
- tax summaries
- financial reconciliation
- finance audit visibility
- finance pipeline closure/reopen approval

Control Room may observe finance anomalies, but should not own finance truth.

Finance flow should be:

```text
Control observes anomaly
 -> Sovereign Finance reviews
 -> Owner/Finance approval where required
 -> trusted finance command executes
 -> audit/reconciliation records
```

### Sovereign Legal Room

Belongs in Sovereign Legal:

- contracts
- legal holds
- compliance evidence
- legal documents
- tax/legal archival policy
- dispute files
- ownership/IP records
- regulatory review
- legal risk classification
- legally sensitive audit access

Legal lines should connect primarily to:

- Owner Room for governance decisions
- Sovereign Finance where financial/legal overlap exists
- Backend/System Authority for governed execution
- Audit for immutable evidence

Legal should not expose full truth to Control Room by default.

Control Room can report a legal/compliance concern. It should not become the legal room.

---

## 6. App vs Web Operational Separation

Mental Smile should not treat app and web as one generic operational surface.

### App Operations

Belongs to App Operations:

- client app workflows
- clinician app workflows
- center app workflows
- booking interactions
- session interactions
- chat interactions
- profile updates
- app support entry points
- app-side notifications and user-facing lifecycle states

App Operations concerns:

- user workflow safety
- tenant/client/clinician experience
- lifecycle correctness
- operational availability

### Web Operations

Belongs to Web Operations:

- registration web portal
- marketing site/content surfaces
- library/resource web surfaces
- public-facing content
- onboarding funnels
- web landing pages
- content governance execution

Web Operations concerns:

- public trust
- intake quality
- content accuracy
- brand/market alignment
- conversion without manipulation

### Shared Oversight

Control Room may observe operational issues across app and web.

Owner Room governs strategy and policy across both.

But app and web should not collapse into one admin-controlled surface. Public registration, marketing, and content operations are not the same as app booking/session/chat operations.

---

## 7. Intervention Boundary

Doctrine under review:

```text
The entity intervention begins at payment proof submission,
not before.
```

This is a useful boundary, but it must be stated carefully.

Before payment proof:

- user exploration should be self-service where possible
- registration/intake should be guided but not over-controlled
- tenant/center/clinician may own scoped pre-service interaction
- admin/control should observe system health and abuse signals
- entity should avoid micromanaging user intention

At payment proof:

- financial evidence enters the system
- entity risk increases
- booking lifecycle becomes materially committed
- audit and authority requirements become stronger
- payment pipeline begins to matter

After payment proof:

- entity has stronger duty to govern lifecycle correctness
- payment, session, support, review, and payout coupling begins
- operational intervention may be justified

What admin should only observe before payment:

- suspicious patterns
- registration issues
- support requests
- failed web/app flows
- abuse or safety signals

What should be self-service:

- browsing
- basic intake
- non-binding preferences
- profile entry
- pre-payment booking draft behavior where safe

What should be tenant/center/clinician responsibility:

- center-provided information
- clinician availability or profile accuracy within governed trust limits
- scoped tenant operational communication
- pre-service clarification where policy allows

What must not be controlled by the entity:

- user emotional dependence
- forced continuation
- unnecessary pre-payment surveillance
- tenant micromanagement beyond policy
- clinician/center autonomy beyond trust and safety boundaries

Correction:

```text
Entity intervention does not begin from nowhere at payment proof.
Entity authority intensifies at payment proof.
Before that, the entity governs safety, trust, and platform boundaries,
but should avoid controlling the user's journey.
```

---

## 8. Current Lines To Freeze

These old authority lines should be frozen as future architecture sources. They may remain for compatibility, but should not expand.

| Authority Line | Freeze Reason |
| -------------- | ------------- |
| Admin direct finance mutation | Finance must move to sovereign authority. |
| Admin legal authority | Legal/compliance cannot remain generic admin power. |
| Admin marketing authority | Marketing is owner/web governance, not control-room mutation. |
| Admin AI policy authority | AI policy is owner governance with strict boundaries. |
| Admin system/domain writer authority | System/IT authority must be owner/system governed. |
| Admin direct tenant micromanagement | Tenant sovereignty requires scoped operations. |
| Admin full-control booking residue | Booking lifecycle must continue moving toward command/audit/backend. |
| Admin payout confirmation | Sovereign finance only. |
| Admin accounting finalization | Sovereign finance only. |
| Admin financial archive | Sovereign finance/legal boundary. |
| Admin trust blocking without governance | Trust authority must be scoped, reviewed, and auditable. |
| Preview Control Room mutation | Preview surfaces must not become real authority accidentally. |

Freeze law:

```text
Legacy authority may remain for stability.
It must not become the future architecture.
```

---

## 9. Authority Flow Diagrams

### A. Operational Issue Flow

```text
Admin/Control observes issue
 -> raises case or request
 -> Owner reviews under constitution where authority is high-risk
 -> decision issued
 -> trusted command executes
 -> audit records
 -> Control observes outcome
```

Purpose:

Control protects operations through visibility and escalation, not unilateral rule.

### B. Finance Issue Flow

```text
Admin/Control observes finance anomaly
 -> Sovereign Finance reviews evidence
 -> Owner/Sovereign approval where required
 -> finance command executes
 -> audit records
 -> reconciliation ledger updates
```

Purpose:

Finance truth belongs to sovereign finance authority, not generic admin.

### C. Legal Issue Flow

```text
Admin/Control observes legal or compliance concern
 -> Sovereign Legal reviews
 -> Owner decision if policy/entity impact exists
 -> legal hold, policy action, or governed response
 -> audit records
```

Purpose:

Legal authority must be scoped, evidence-driven, and protected from operational convenience.

### D. Development / IT Flow

```text
Operational pain detected
 -> Control/Admin report
 -> Owner prioritizes
 -> development/IT executes
 -> deployment governance
 -> audit/change record
 -> Control observes operational effect
```

Purpose:

Admin pain should inform product/IT priorities, not directly mutate platform architecture.

---

## 10. Critical Architecture Questions

### Is Owner Room Becoming Too Powerful?

Yes, that is the largest risk in this separation model.

Owner Room must own legitimacy, priorities, and constitutional decisions. It must not own every button. If every issue escalates to Owner, the system becomes founder-dependent and bottlenecked.

Safeguard:

```text
Owner decides policy and high-risk authority.
Domains execute scoped operations within policy.
```

### Is Control Room Becoming Too Weak?

It can become too weak if "observe only" means "powerless while harm occurs."

Control Room needs:

- case creation
- escalation
- emergency signal authority
- low-risk scoped actions
- visibility into command status
- ability to recommend closure/review

But it should not hold broad mutation truth.

### Could Decisions Become Bottlenecked?

Yes. If Owner approval is required for routine actions, operations will stall.

Resolution:

- routine low-risk actions remain scoped
- medium-risk actions use predefined policy
- high-risk actions require approval
- sovereign actions require sovereign review
- emergency actions expire into post-review

### Who Executes Approved Decisions?

Future target:

```text
Trusted command/backend authority executes.
```

Current reality:

```text
Legacy services/adapters still execute.
```

This gap must remain explicit. The current system should not pretend commands already own truth.

### How Do We Avoid Owner Dependency?

By separating:

- policy ownership
- domain authority
- execution authority
- audit memory
- succession governance

Owner Room should be institutionally governed, not person-dependent.

### How Do We Prevent Hidden Authority Moving Into Finance/Legal/Dev?

Each room must have limits too.

Sovereign Finance can be powerful, but not invisible. Legal can be protective, but not absolute. Development can execute platform changes, but not quietly rewrite authority.

All rooms need:

- scope
- audit
- review
- conflict path
- no silent mutation

### What Can Remain Manual For Now?

- owner review
- finance/legal classification
- route authority mapping
- legacy freezer labels
- command wrapper prioritization
- reconciliation notes
- high-risk approval decisions

Manual is acceptable during grounding if it is documented and not disguised as automation.

### What Must Not Be Implemented Yet?

- real Owner Room mutation console
- real Sovereign Finance execution room
- finance/payout/accounting command enforcement
- legal hold runtime enforcement
- generic valve closure controls
- broad admin route migration
- backend authority takeover
- new claims replacing admin without migration design

---

## 11. Network Recommendation

Recommended next option:

```text
D) Current Admin Authority Extraction Inventory
```

Reason:

The project cannot safely define final Owner, Control, and Sovereign rooms until it has a precise extraction map of what `/admin/*` still contains.

Starting with Owner Room Boundary Spec is tempting, but risky. It may define a beautiful future room while current admin residue remains unclear.

Starting with Control Room Purification is useful, but it depends on knowing which admin powers must leave.

Starting with Sovereign Finance/Legal split is important, but finance/legal are only part of the mixed admin authority problem.

The safest next move is:

```text
Map every current admin authority line,
label its future room,
freeze what must not expand,
and only then create room-specific specs.
```

---

## 12. Final Verdict

Choice:

```text
D) Stop and map current admin residue first
```

Justification:

The Owner-Control-Sovereign separation is architecturally correct, but it can fail in three ways:

1. Owner Room becomes super-admin.
2. Control Room becomes powerless theater.
3. Sovereign/IT/AI rooms inherit hidden authority without audit.

The only way to prevent that is to map current admin residue before building room doctrine.

Final position:

```text
Mental Smile should not start by creating new rooms.
It should start by extracting and labeling the authority still trapped inside /admin/*.
```

Once current admin residue is mapped, the next sequence should be:

```text
Admin Authority Extraction Inventory
 -> Control Room Purification Map
 -> Sovereign Finance/Legal Separation Map
 -> Owner Room Boundary Spec
```

This order keeps the architecture grounded and prevents the future rooms from becoming renamed admin compartments.

---

## Commands Executed By Codex

None

