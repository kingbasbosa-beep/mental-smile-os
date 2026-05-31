# MASTER-FLOW-0
# Mental Smile Operational Flow Bible

Status: Operational flow doctrine  
Runtime effect: None  
Implementation effect: None  
Date: 2026-05-30

This document defines how operational movement works inside Mental Smile.

It does not create implementation.
It does not change routes.
It does not change Firestore.
It does not change rules.
It does not clean up legacy surfaces.

It describes how information, decisions, reports, escalations, trust actions, support actions, survey analysis, follow-up actions, development actions, and governance actions move.

---

# PART A: Foundational Flow Doctrine

## A1. Core Flow Law

Mental Smile operates under three movement laws:

```text
Information Flows Up
Authority Flows Down
Archive Flows Across Time
```

These laws prevent the system from confusing visibility with authority, action with legitimacy, or memory with paperwork.

## A2. Information Flows Up

Information begins where reality happens:

```text
User / Runtime / Operator / System
↓
Control
↓
Governance Department or delegated function
↓
Owner
```

Information includes:

- registration signals
- trust evidence
- complaints
- support requests
- survey answers
- follow-up outcomes
- operational anomalies
- technical issues
- content usage
- finance/legal signals
- risk signals

Information is not authority. A signal does not automatically become a decision.

## A3. Authority Flows Down

Authority begins from legitimacy:

```text
Constitution
↓
Owner ratification or delegated department authority
↓
Department action package
↓
Technical / operational execution
↓
System state or manual outcome
```

Authority should be scoped, explainable, and archived.

The Owner ratifies constitutional, strategic, high-risk, cross-domain, or policy-changing decisions. Departments or delegated functions recommend. Control observes and escalates. Technical or operational actors execute only within approved authority.

## A4. Archive Flows Across Time

Archive connects past, present, and future:

```text
Signal
↓
Analysis
↓
Recommendation
↓
Decision / ratification
↓
Execution result
↓
Archive package
↓
Quarterly or future review
```

Archive is not only storage. It is institutional memory.

## A5. System Role

The System produces operational signals and preserves runtime state.

The System may:

- capture registrations
- store statuses
- show queues
- collect messages
- record reviews
- expose analytics
- hold documents or references

The System must not:

- create constitutional authority by itself
- decide trust without human review
- silently resolve high-risk disputes
- replace Owner ratification
- replace protected memory where protected memory is required

## A6. Control Role

Control sees the system.

Control may:

- observe
- classify
- queue
- aggregate
- report
- escalate
- track SLA and unresolved cases
- forward signals to departments

Control must not:

- become super-admin
- become Trust
- become Finance
- become Legal
- become Owner
- silently mutate high-risk truth

During the pilot, Control exists mostly as Control Lite through admin surfaces, manual reporting, and archive discipline.

## A7. Governance Departments Role

Governance departments, or delegated functions where departments are not mature, perform domain analysis.

They may:

- review evidence
- analyze risk
- compare human and AI analysis
- create recommendations
- prepare action packages
- define department-specific archive packages
- request Owner ratification when required

They must not:

- invent authority outside scope
- bypass Control visibility when signals are operational
- bypass Owner ratification for high-risk or cross-domain decisions
- hide policy inside implementation

## A8. Owner Role

The Owner ratifies legitimacy.

The Owner may:

- accept or reject recommendations
- choose between prepared options
- ratify high-risk decisions
- settle cross-domain conflicts
- approve constitutional or strategic direction
- approve department activation or delegation changes

The Owner must not:

- become daily operator
- become super-admin
- mutate operational truth directly as habit
- replace department analysis with impulse
- invent technical, trust, support, or legal solutions without recommendation context

Owner doctrine:

```text
Owner selects from recommendations.
Owner does not become the cockpit.
```

---

# PART B: Registration Flow

Official registration flow:

```text
Registration
↓
Trust Verification
↓
Decision
↓
Archive
↓
Notification
```

## B1. Client

Flow:

```text
Client submits registration
↓
System creates client account/profile signal
↓
Control observes registration health if needed
↓
Decision: accepted, blocked, incomplete, or support-needed
↓
Archive registration count/status summary where pilot-relevant
↓
Client receives account or support notification
```

Signals:

- new client account
- missing profile data
- blocked/inactive account state
- support request during onboarding
- consent or rights concern if collected

Decisions:

- allow normal client access
- request correction/support
- block or restrict account
- escalate rights/safety concern

Reports:

- registration health report
- stuck/incomplete registration report
- pilot cohort registration summary

Archive package:

- registration date/count
- client type or cohort if applicable
- unresolved registration issues
- support/legal concerns if any
- manual pilot notes if runtime field is absent

## B2. Clinician

Flow:

```text
Clinician submits registration
↓
System stores clinician profile and documents/references
↓
Trust Verification reviews identity, specialty, license, certificate, affiliation
↓
Decision: approved, rejected, needs review, suspended if later risk
↓
TRUST_VERIFICATION_RECORD archived
↓
Clinician notified of status or clarification need
```

Signals:

- new clinician profile
- pending review status
- document/file reference
- missing license/certificate
- specialty mismatch
- profile change request
- appeal or resubmission

Decisions:

- approve for pilot
- reject with reason
- request clarification
- suspend later if risk appears
- reactivate after review

Reports:

- verification backlog
- missing documents report
- approval/rejection summary
- trust exception report

Archive package:

- entity type: clinician
- applicant type: known partner or unknown applicant
- evidence reviewed
- missing evidence
- reviewer
- decision
- decision rationale
- appeal/resubmission links if any
- next review date if exception exists

## B3. Center

Flow:

```text
Center submits registration
↓
System stores center profile, media, pricing, documents/references
↓
Trust Verification reviews identity, location, responsible person, license, public presence
↓
Decision: approved, rejected, needs review, suspended if later risk
↓
TRUST_VERIFICATION_RECORD archived
↓
Center notified of status or clarification need
```

Signals:

- new center profile
- pending admin status
- missing required documents
- unclear responsible person
- location mismatch
- pricing/media readiness
- profile change request

Decisions:

- approve for pilot
- reject with reason
- request clarification
- suspend due to new risk
- reactivate after correction

Reports:

- center verification backlog
- missing required documents report
- readiness report
- known-partner exception report

Archive package:

- entity type: center
- applicant type
- center identity/location evidence
- documents reviewed
- known-partner context if applicable
- reviewer notes
- decision
- rationale
- next review date if exception exists

---

# PART C: Trust Flow

Trust flow always follows:

```text
Input
↓
Review
↓
Decision
↓
Archive
↓
Notification
```

Trust decisions are not merely status fields. They must be explainable later.

## C1. Known Partner

Input:

- registration or profile
- founder/Owner relationship context
- documents available now
- missing documents if any

Review:

- verify identity/contact
- document known-partner basis
- review minimum evidence
- record missing evidence
- assign next review date for exceptions

Decision:

- approve with documented exception
- needs review
- reject if minimum threshold fails
- suspend if later risk appears

Archive:

- TRUST_VERIFICATION_RECORD
- known-partner basis
- evidence reviewed
- exception and review date

Notification:

- status accepted, clarification requested, or rejected

Rule:

```text
Known partner may reduce uncertainty.
Known partner may not erase process.
```

## C2. Unknown Applicant

Input:

- registration/profile
- identity evidence
- license/registration evidence
- contact/location/affiliation evidence

Review:

- stricter evidence review
- check consistency
- request clarification where incomplete
- escalate forged, expired, contradictory, or unclear evidence

Decision:

- approve only if minimum threshold is met
- needs review where evidence is incomplete
- reject if evidence fails after clarification

Archive:

- full evidence list
- missing evidence
- reviewer notes
- decision rationale
- escalation notes if any

Notification:

- status, requested corrections, or rejection reason

## C3. Appeal

Input:

- applicant disputes rejection or suspension
- new explanation or evidence

Review:

- compare original decision with appeal evidence
- use Owner/founder review for high-risk or contested cases
- avoid single-reviewer finality where possible

Decision:

- uphold original decision
- revise to needs review
- approve with conditions
- reject again with final reason

Archive:

- original decision
- appeal note
- new evidence
- final appeal decision

Notification:

- appeal outcome and any required next step

## C4. Re-submission

Input:

- corrected documents
- new profile details
- updated license/certificate
- corrected location/contact data

Review:

- compare old and new evidence
- verify whether prior blocker is resolved
- escalate if contradiction remains

Decision:

- approve
- needs review
- reject

Archive:

- resubmission record
- changed evidence
- new decision
- reason for status update

Notification:

- accepted, still incomplete, or rejected

## C5. Suspension

Input:

- complaint
- document issue
- safety concern
- legal/rights concern
- operational incident
- new trust signal

Review:

- immediate risk classification
- Control visibility
- Trust review
- Legal/Owner review if high-risk

Decision:

- suspend temporarily
- restrict exposure
- request clarification
- leave active with warning note

Archive:

- suspension reason
- evidence
- scope
- reviewer
- review date
- reactivation conditions

Notification:

- affected entity receives status and review path where appropriate

## C6. Reactivation

Input:

- resolved issue
- corrected evidence
- appeal accepted
- review date reached

Review:

- verify blocker is removed
- check if new conditions are needed
- confirm no unresolved complaint/legal hold

Decision:

- reactivate
- keep suspended
- reject or block

Archive:

- reactivation rationale
- evidence of correction
- reviewer
- effective date

Notification:

- status update and any operating conditions

---

# PART D: Complaint Flow

Official complaint flow:

```text
User Complaint
↓
System Capture
↓
Control Queue
↓
Analysis
↓
Department Review
↓
Owner Ratification (if required)
↓
Response
↓
Archive
```

## D1. System Capture

Complaint origin may be:

- support request
- chat
- follow-up response
- survey answer
- email/manual note
- clinician or center report
- internal operator report

Minimum captured signal:

- complainant type
- date/time
- subject
- affected entity if any
- severity
- consent/privacy sensitivity
- immediate risk flag

## D2. Control Queue

Control classifies:

- operational issue
- trust issue
- support issue
- legal/rights issue
- technical issue
- finance issue
- content/library issue
- high-risk safety issue

Control does not decide final outcome unless the issue is low-risk and already within delegated process.

## D3. Analysis

Analysis includes:

- facts known
- missing facts
- user impact
- urgency
- repeated pattern check
- department owner
- escalation need
- response obligation

AI may summarize or cluster complaints, but human review decides meaning.

## D4. Department Review

Department or delegated function reviews by domain:

- Trust reviews verification or provider conduct issues.
- Support Continuity reviews outreach/support experience.
- Technical reviews defects or reliability.
- Legal reviews rights, privacy, consent, disputes.
- Finance reviews payment/accounting issues.
- Library/Content reviews content claims or safety.

## D5. Owner Ratification

Owner ratification is required when:

- high-risk trust decision is needed
- legal/rights risk is material
- public/partnership consequence exists
- suspension/reactivation is contested
- policy change is needed
- cross-domain conflict exists
- precedent will be created

## D6. Response

Response should be:

- timely
- factual
- respectful
- bounded
- clear on next steps
- non-defensive
- not overpromising resolution

## D7. Archive

Complaint archive package:

- complaint id or manual reference
- source
- category
- severity
- analysis summary
- department review
- Owner ratification if any
- response sent
- closure outcome
- unresolved items

## D8. SLA Concepts

SLA is a governance expectation, not necessarily a mature automated system today.

Suggested pilot SLA classes:

| Class | Meaning | Target handling concept |
|---|---|---|
| Critical | safety, legal, severe trust, urgent service failure | immediate same-day review |
| High | complaint affecting participation, provider trust, rights, payment, major defect | one working day review |
| Medium | non-urgent operational friction, support concern, content issue | two to three working days review |
| Low | suggestion, minor clarity issue, non-blocking feedback | weekly batch review |

Escalation path:

```text
Control classification
↓
Department review
↓
Owner ratification if high-risk/cross-domain
↓
Response
↓
Archive
```

---

# PART E: Survey Flow

Official survey flow:

```text
Survey Answer
↓
Human Analysis
↓
AI Analysis
↓
Comparison
↓
Recommendation
↓
Department Package
↓
Quarterly Archive
```

## E1. Survey Answer

Survey answers may come from:

- manual/external pilot survey
- session ratings
- support follow-up
- internal operator feedback
- client/clinician/center survey responses

Minimum survey evidence:

- survey version
- timestamp
- respondent type
- consent/anonymity choice if applicable
- answer data
- issue category where relevant

## E2. Human Analysis

Human analysis reviews:

- context
- sensitivity
- consent/rights concerns
- trust implications
- support implications
- technical blockers
- content risk
- operational feasibility

Human analysis is primary.

## E3. AI Analysis

AI analysis may assist with:

- summarization
- theme clustering
- repeated issue detection
- sentiment grouping
- draft recommendations

AI must not decide:

- pilot success
- legal outcome
- user risk
- trust approval
- enforcement action

## E4. Comparison

Comparison records:

- where human and AI analysis agree
- where they differ
- which AI suggestions were accepted
- which AI suggestions were rejected
- what requires department review
- what requires Owner ratification

## E5. Recommendation

Recommendations are grouped by:

- technical
- trust
- support
- content/library
- legal/rights
- operations
- archive/process

Each recommendation includes:

- evidence source
- severity
- responsible function
- pilot impact
- proposed action

## E6. Department Package

Department package contains:

- survey summary
- relevant raw/export reference
- human analysis
- AI analysis if used
- comparison notes
- recommendation list
- unresolved concerns
- action owner

## E7. Quarterly Archive

Quarterly archive contains:

- survey version
- response count
- respondent type breakdown
- analysis package
- department packages
- accepted recommendations
- rejected/deferred recommendations
- Owner notes
- action status

---

# PART F: Follow-Up Flow

Official follow-up flow:

```text
Consent
↓
Follow-up Trigger
↓
Support Contact
↓
Response
↓
Outcome
↓
Archive
```

## F1. Consent

Follow-up begins with consent.

Minimum consent data:

- consent status
- consent timestamp or manual evidence
- allowed channel
- opt-out state
- participant type
- follow-up purpose

No follow-up should proceed when consent is absent, withdrawn, unclear, or outside scope.

## F2. Follow-up Trigger

Triggers may include:

- birthday
- recovery support schedule
- general support schedule
- educational awareness
- post-session support
- unresolved support concern
- manual admin entry
- pilot continuity check

Trigger must be humane and bounded.

## F3. Support Contact

Support contact should:

- respect channel consent
- use approved tone/templates where available
- avoid pressure
- avoid therapy-like ownership
- avoid crisis management unless routed to proper escalation
- record contact attempt

## F4. Response

Response categories:

- responded positively
- requested support
- no response
- opted out
- escalated
- complaint raised
- rights/consent concern raised

## F5. Outcome

Outcome states:

- completed
- pending
- opted out
- escalated
- closed
- needs review

## F6. Archive

Follow-up archive package:

- consent status
- trigger
- date/time
- channel
- template/campaign reference if any
- response
- outcome
- escalation link if any
- unresolved items

## F7. Support Continuity Doctrine

```text
Follow-up may support continuity.
It must not become pressure, therapy continuation, or emotional ownership.
```

Support Continuity observes patterns, preserves humane contact, and escalates risk. It does not replace licensed care, crisis intervention, or user autonomy.

---

# PART G: Library Flow

Official library flow:

```text
Content Proposal
↓
Content Review
↓
Publication
↓
Usage Analytics
↓
Quarterly Review
↓
Archive
```

## G1. Content Proposal

Proposal may originate from:

- Owner
- Marketing & Content
- Library Governance
- Support Continuity
- Trust
- survey feedback
- clinician/center feedback
- technical/content maintenance

Proposal must identify:

- content type
- target audience
- purpose
- safety boundaries
- evidence/source basis
- whether external content or licensing is involved

## G2. Content Review

Review checks:

- mental-health claim safety
- clarity
- cultural/language fit
- content ownership/license
- no therapy replacement implication
- support tone
- sensitive-population risk
- legal review if claims or rights are sensitive

## G3. Publication

Publication decision may be:

- publish
- publish with caveat
- revise
- hold
- reject

Publication should record:

- content version
- reviewer
- date
- category
- safety caveat

## G4. Usage Analytics

Usage analytics may include:

- module entry
- selected path
- library open
- featured content usage
- support path correlation
- content feedback from surveys

Analytics provides signal. It does not decide content value alone.

## G5. Quarterly Review

Quarterly library review asks:

- What content was used?
- What content created confusion?
- What content should be expanded?
- What content should be retired or revised?
- Did any content create risk or unsupported claims?

## G6. Archive

Library archive package:

- content proposal
- review notes
- publication decision
- usage summary
- survey/support feedback
- revision decisions
- legal/content caveats

## G7. Owner, Marketing, Content, Control Visibility

Owner:

- ratifies high-risk content policy and major content direction.

Marketing:

- may propose content, public communication, and campaign alignment.

Content / Library Governance:

- reviews usefulness, safety, tone, source, and publication readiness.

Control:

- sees usage signals, complaints, content-risk signals, and support issues.
- does not decide publication alone.

---

# PART H: Report Flow

Report flow turns activity into reviewable institutional memory.

## H1. Report Families

| Report type | Who creates | Who reviews | Who receives | Who archives |
|---|---|---|---|---|
| Operational Reports | Control Lite / operator / admin surface | Control + relevant department | Owner, Technical, affected function | Knowledge & Archive Office or manual archive holder |
| Trust Reports | Trust Function | Owner for high-risk/appeal cases | Owner, Control, affected party where appropriate | Knowledge & Archive Office |
| Support Reports | Support Continuity / Control | Owner + Legal if consent-sensitive | Owner, Control, Support | Knowledge & Archive Office |
| Survey Reports | Human analyst / Analytics delegate | Owner + relevant department | Owner, departments | Knowledge & Archive Office |
| Analytics Reports | Analytics delegate / system summary | Control + department | Owner, departments | Knowledge & Archive Office |
| Archive Reports | Knowledge & Archive Office | Owner | Owner Room, future departments | Knowledge & Archive Office |
| Technical Reports | Technical / Development | Owner + Control if operational risk | Owner, relevant departments | Knowledge & Archive Office |
| Finance Reports | Finance delegate or admin finance surface | Owner + future Finance | Owner, Legal if needed | Knowledge & Archive Office |
| Legal/Rights Reports | Legal delegate or Owner until mature | Owner | Owner, relevant department | Knowledge & Archive Office |
| Library Reports | Library/Content delegate | Owner + Legal if sensitive | Owner, Marketing/Content, Support | Knowledge & Archive Office |

## H2. Report Movement

```text
Operational fact
↓
Report draft
↓
Human review
↓
Department routing
↓
Owner review if required
↓
Archive package
```

## H3. Report Minimum Standard

Every meaningful report should identify:

- source
- period/date
- scope
- facts
- analysis
- recommendation or no-action note
- reviewer
- unresolved issues
- archive label

---

# PART I: Escalation Flow

All escalation types follow:

```text
Trigger
↓
Review
↓
Recommendation
↓
Ratification
↓
Execution
↓
Archive
```

## I1. Operational Escalation

Trigger:

- stuck queue
- failed booking/session flow
- repeated registration failure
- unresolved user block
- operational contradiction

Review:

- Control Lite and relevant operator
- Technical if system issue

Recommendation:

- manual correction
- technical investigation
- user response
- process change

Ratification:

- Owner only if high-risk, cross-domain, or policy-changing

Execution:

- admin/operator action or technical fix within authority

Archive:

- incident note, action taken, outcome, unresolved risk

## I2. Trust Escalation

Trigger:

- missing or conflicting evidence
- unknown applicant risk
- known partner exception
- complaint against provider
- suspension/reactivation
- appeal

Review:

- Trust Function
- Owner for high-risk/appeal/suspension

Recommendation:

- approve, reject, needs review, suspend, reactivate, request evidence

Ratification:

- Owner for exceptions, appeals, suspensions, contested cases

Execution:

- update trust status through current approved surface/process

Archive:

- TRUST_VERIFICATION_RECORD and decision package

## I3. Legal Escalation

Trigger:

- privacy or consent concern
- rights complaint
- dispute
- legal hold need
- sensitive content claim
- finance/legal conflict

Review:

- Legal delegate where present
- Owner until legal department is mature

Recommendation:

- response wording
- hold/restrict action
- archive/protected memory requirement
- external legal review later if needed

Ratification:

- Owner required for material legal/rights decisions

Execution:

- manual response, restriction, documentation, future legal action

Archive:

- legal/rights report, evidence, decision, response

## I4. Technical Escalation

Trigger:

- app failure
- permission-denied pattern
- data mismatch
- security/rules concern
- broken workflow
- analytics/health anomaly

Review:

- Technical/Development
- Control for operational impact

Recommendation:

- bug fix
- test plan
- rollback/hold
- no-code/manual workaround
- future implementation plan

Ratification:

- Owner if authority, trust, finance/legal, or constitutional boundary changes

Execution:

- implementation only after approved scope

Archive:

- technical report, verification result, release/closeout note

## I5. Support Escalation

Trigger:

- distress signal
- complaint about support
- support request outside scope
- repeated non-response
- opt-out or consent conflict
- issue requiring clinician/trust/legal review

Review:

- Support Continuity
- Control
- Trust/Legal if relevant

Recommendation:

- respond
- close
- escalate to clinician/support resource
- stop follow-up
- refer to external emergency/support pathway where appropriate

Ratification:

- Owner only for high-risk, policy, legal, or cross-domain cases

Execution:

- support response, opt-out, escalation, closure

Archive:

- support continuity record, consent status, outcome

---

# PART J: Development Flow

Official development flow:

```text
Issue
↓
Analysis
↓
Human Recommendation
↓
AI Recommendation
↓
Development Review
↓
Owner Ratification
↓
Implementation
↓
Verification
↓
Archive
```

## J1. Issue

Issue may originate from:

- bug
- pilot feedback
- survey report
- support complaint
- trust workflow gap
- technical audit
- permission-denied report
- constitutional/flow gap
- owner request

## J2. Analysis

Analysis defines:

- current reality
- affected users
- risk level
- implementation surface
- authority boundary
- data/rules implications
- manual workaround possibility
- no-action option

## J3. Human Recommendation

Human recommendation should include:

- safest operational option
- tradeoffs
- risk
- affected flows
- tests or verification needed
- whether Owner ratification is required

## J4. AI Recommendation

AI may assist with:

- options
- code/readiness analysis
- risk mapping
- drafting patches
- test ideas
- documentation drafts

AI does not decide.

## J5. Development Review

Development reviews:

- technical feasibility
- existing codebase patterns
- implementation blast radius
- rules/security impact
- rollback/hold options
- whether change belongs now or later

## J6. Owner Ratification

Owner ratifies when the change affects:

- authority
- trust
- finance/legal
- protected memory
- user rights/consent
- pilot launch readiness
- constitutional doctrine
- cross-domain policy

No direct owner design doctrine:

```text
Owner selects from recommendations.
Owner does not invent solutions.
```

The Owner chooses among prepared options with consequences described. Owner judgment ratifies direction; it does not replace analysis.

## J7. Implementation

Implementation occurs only after:

- scope is defined
- authority boundary is clear
- affected flow is known
- verification path exists

## J8. Verification

Verification includes:

- tests where available
- manual scenario check
- permission/rules check where relevant
- UI/access check where relevant
- archive note or closeout report for meaningful changes

## J9. Archive

Development archive package:

- issue
- analysis
- human recommendation
- AI recommendation if used
- accepted option
- implementation summary
- verification result
- unresolved risk
- follow-up decision

---

# PART K: Quarterly Governance Review Flow

Official quarterly governance flow:

```text
Department Reports
↓
Human Analysis
↓
AI Analysis
↓
Governance Meeting
↓
Recommendations
↓
Department Action Packages
↓
Owner Ratification
↓
Execution
↓
Archive
```

## K1. Department Reports

Reports may come from:

- Control
- Trust
- Support
- Technical
- Library/Content
- Analytics
- Finance delegate
- Legal delegate
- Archive
- Owner notes

## K2. Human Analysis

Human analysis reviews:

- reality
- risk
- user impact
- institutional maturity
- authority drift
- dormant domains
- repeated complaints
- pilot readiness
- support/trust/legal concerns

## K3. AI Analysis

AI may assist with:

- summarizing reports
- detecting patterns
- comparing prior quarter
- drafting options
- identifying unresolved contradictions

AI does not decide.

## K4. Governance Meeting

Governance meeting asks:

- What changed?
- What broke?
- What worked?
- What stayed manual?
- What should remain frozen?
- What should become a department action package?
- What requires Owner ratification?

## K5. Recommendations

Recommendations must be grouped:

- keep
- fix
- freeze
- activate
- defer
- archive
- escalate

## K6. Department Action Packages

Action packages include:

- responsible function
- evidence
- action
- risk
- deadline/review point
- archive label

## K7. Owner Ratification

Owner ratifies:

- accepted recommendations
- rejected recommendations
- deferred recommendations
- department activation/renewal
- authority boundary changes
- constitutional amendments if any

## K8. Execution

Execution may be:

- manual process
- documentation
- technical implementation
- staffing/delegation
- freeze continuation
- pilot action

## K9. Archive

Quarterly archive package:

- department reports
- human analysis
- AI analysis if used
- comparison notes
- meeting notes
- recommendations
- Owner ratification
- action packages
- execution status

---

# PART L: Future Department Hooks

These hooks are document-only placeholders. They do not create implementation or authority.

## L1. Finance

Future flow hook:

```text
Payment / payout / accounting signal
↓
Operational Finance review
↓
Entity Finance decision when protected memory exists
↓
Owner ratification for policy/high-risk
↓
Archive
```

Current state: partial/frozen inside admin finance surfaces.

## L2. Legal

Future flow hook:

```text
Rights / consent / dispute / compliance signal
↓
Legal review
↓
Recommendation
↓
Owner ratification if material
↓
Response / hold / policy
↓
Archive
```

Current state: constitutional/manual, no mature legal department runtime.

## L3. HR

Future flow hook:

```text
Staffing / accountability / delegation issue
↓
HR or Legal+HR review
↓
Recommendation
↓
Owner ratification
↓
Action
↓
Archive
```

Current state: concept only.

## L4. Marketing

Future flow hook:

```text
Campaign / content / public communication proposal
↓
Marketing & Content review
↓
Legal/Owner review where sensitive
↓
Publication or hold
↓
Analytics
↓
Archive
```

Current state: preview/planning surfaces only.

## L5. Digital Clinics

Future flow hook:

```text
Digital clinic proposal
↓
Trust + Technical + Legal review
↓
Operational readiness package
↓
Owner ratification
↓
Pilot or hold
↓
Archive
```

Current state: future hook only.

## L6. Educational Platforms

Future flow hook:

```text
Educational program proposal
↓
Content + Library + Legal review
↓
Pilot content package
↓
Usage/feedback review
↓
Owner ratification for expansion
↓
Archive
```

Current state: library/content adjacency only.

## L7. Children Support

Future flow hook:

```text
Children support proposal or signal
↓
Specialized safety/legal review
↓
Content/support boundary review
↓
Owner ratification
↓
Pilot or hold
↓
Archive
```

Current state: dormant/conceptual.

## L8. Deaf Support

Future flow hook:

```text
Deaf support proposal or need signal
↓
Accessibility + content + support review
↓
Specialist/community validation
↓
Owner ratification
↓
Pilot or hold
↓
Archive
```

Current state: dormant/conceptual.

## L9. Special Needs

Future flow hook:

```text
Special needs support signal
↓
Support + Trust + Content review
↓
Family/support boundary package
↓
Owner ratification where high-risk
↓
Pilot action
↓
Archive
```

Current state: partial family-support runtime; not a mature specialized department.

---

# PART M: Operational Flow Matrix

| Event | Origin | Control | Department | Owner | Archive | Output |
|---|---|---|---|---|---|---|
| Client registration | Client/app | Observe registration health if needed | Support/Technical if issue | Only if policy/high-risk | Pilot registration summary if relevant | Client account or correction path |
| Clinician registration | Clinician/app/web | Queue visibility | Trust reviews | Ratifies high-risk/appeal/exception | TRUST_VERIFICATION_RECORD | Approved, rejected, needs review |
| Center registration | Center/app/web | Queue visibility | Trust reviews | Ratifies high-risk/appeal/exception | TRUST_VERIFICATION_RECORD | Approved, rejected, needs review |
| Known partner verification | Trust intake | Track exception | Trust reviews evidence/context | Ratifies exception if needed | Known partner trust record | Conditional approval or review |
| Unknown applicant verification | Trust intake | Track risk | Trust applies stricter review | Ratifies high-risk cases | Full trust record | Approve/reject/needs review |
| Trust appeal | Applicant/entity | Track appeal | Trust re-reviews | Ratifies final/high-risk outcome | Appeal package | Upheld, revised, approved, rejected |
| Re-submission | Applicant/entity | Track reopened case | Trust compares evidence | If high-risk or prior serious rejection | Resubmission record | New decision |
| Suspension | Complaint/trust/system | Escalate immediately | Trust/Legal review | Usually required | Suspension record | Restricted/suspended status |
| Reactivation | Trust/entity | Track review date | Trust verifies blocker removed | Required if high-risk | Reactivation record | Active or still restricted |
| User complaint | User/support/chat/survey | Classify and queue | Relevant department reviews | If high-risk/cross-domain | Complaint package | Response and closure/outcome |
| Support request | User/app | Queue and severity | Support Continuity | If high-risk | Support record | Response, escalation, closure |
| Chat escalation | Chat/system/user | Escalation queue | Support/Trust/Clinician as relevant | If high-risk/policy | Escalation report | Assignment, resolution, follow-up |
| Follow-up consent | User/manual | Track exceptions | Support/Legal if sensitive | If policy issue | Consent evidence | Allowed, denied, opt-out |
| Follow-up trigger | Registry/campaign/manual | Observe queue | Support Continuity | Not normally | Follow-up log | Contact attempt |
| Follow-up response | User | Classify outcome | Support/Legal/Trust if needed | If high-risk | Outcome record | Close, continue, opt-out, escalate |
| Survey answer | User/operator | Route signal | Analytics/human reviewer | Not per answer | Survey data/export package | Analysis input |
| Survey analysis | Human/AI/manual | Aggregate | Analytics + relevant department | Reviews recommendations | Analysis package | Department recommendations |
| Quarterly review | Departments/archive | Package signals | All relevant functions | Ratifies decisions | Quarterly archive | Action packages |
| Content proposal | Owner/content/support/survey | Visibility if risk/usage | Library/Content review | For high-risk/public strategy | Content review package | Publish, revise, hold, reject |
| Content usage signal | Analytics/system | Aggregate | Library/Content reviews | If strategic/policy | Library quarterly review | Content decision |
| Technical issue | System/user/operator | Classify impact | Technical reviews | If authority/policy/high-risk | Technical report | Fix, hold, workaround |
| Permission-denied pattern | Runtime/user/operator | Escalate | Technical + affected department | If authority/rules change | Technical/rules report | Fix plan or manual workaround |
| Payment proof issue | Client/admin | Observe finance signal | Operational Finance delegate | If policy/high-risk | Finance report | Review, correction, hold |
| Legal/rights concern | User/survey/support | Escalate | Legal delegate | Usually required if material | Legal/rights package | Response, hold, policy |
| Admin authority drift | Control/Technical/Archive | Report | Technical/Governance review | Required | Governance report | Freeze, extract, or defer |
| Archive package creation | Any department | Verify completeness | Archive Office | Accepts quarterly/major packages | Archive index/package | Institutional memory |
| Development request | Owner/user/report | Classify operational impact | Technical/Development | Selects from recommendations | Development package | Implementation, hold, or defer |
| AI policy concern | System/support/content | Route signal | AI governance/Technical | Ratifies policy change | AI policy report | Update, hold, or caveat |
| Library complaint | User/survey/support | Classify content risk | Library/Content + Legal if needed | If high-risk | Content complaint package | Revise, hold, respond |
| Dormant domain request | User/Owner/strategy | Record as signal | Relevant future hook | Ratifies pilot/hold | Future hook record | Defer, research, or pilot package |

---

# PART N: Final Verdict

## N1. Official Flows

The official flows are:

- Foundational flow: information up, authority down, archive across time.
- Registration flow: registration, trust verification, decision, archive, notification.
- Trust flow: input, review, decision, archive, notification.
- Complaint flow: complaint, capture, control queue, analysis, department review, Owner ratification if required, response, archive.
- Survey flow: survey answer, human analysis, AI analysis, comparison, recommendation, department package, quarterly archive.
- Follow-up flow: consent, trigger, support contact, response, outcome, archive.
- Library flow: proposal, review, publication, usage analytics, quarterly review, archive.
- Report flow: create, review, receive, archive.
- Escalation flow: trigger, review, recommendation, ratification, execution, archive.
- Development flow: issue, analysis, human recommendation, AI recommendation, development review, Owner ratification, implementation, verification, archive.
- Quarterly governance flow: reports, human analysis, AI analysis, meeting, recommendations, action packages, Owner ratification, execution, archive.
- Future department hooks for domains not mature yet.

## N2. Flows That Exist Today

Today, the project has partial runtime support for:

- client, clinician, and center registration;
- clinician and center approval/trust status review;
- support requests;
- chat and chat escalation;
- booking/session/payment operational flows;
- session ratings;
- external follow-up registry/templates/campaigns;
- admin reports/archive pages;
- analytics summaries if configured;
- documentation archive.

## N3. Flows That Are Manual

Manual today:

- trust verification record creation;
- known-partner exception handling;
- unknown-applicant evidence judgment;
- appeals/resubmissions;
- broad pilot survey collection;
- survey analysis package;
- human/AI comparison notes;
- consent-aware follow-up discipline;
- quarterly governance review;
- archive package indexing;
- Owner ratification records;
- finance/legal decisions beyond simple admin visibility.

## N4. Flows That Are Constitutional Only

Constitutional only or mostly doctrinal:

- mature Control Room;
- mature Trust Department;
- mature Finance and Entity Finance;
- mature Legal + HR;
- protected memory;
- Knowledge & Archive Office as formal department;
- full department activation lifecycle;
- full quarterly governance institution;
- mature AI governance process;
- digital clinics;
- children support;
- deaf support;
- specialized special-needs department.

## N5. Flows That Are Pilot-Ready

Pilot-ready with manual process:

- clinician trust verification;
- center trust verification;
- support continuity if consent is explicit;
- follow-up if consent/outcome/archive are explicit;
- survey analysis if survey collection is manual/external and archived;
- library usage as educational/support content;
- complaint routing if Control Lite records and escalates.

Pilot-ready only after verification:

- client registration write path;
- clinician/center registration write path;
- custom claims for all pilot roles;
- evidence/document handling process;
- permission-denied scenarios.

## N6. Future Hooks

Future hooks:

- Finance
- Legal
- HR
- Marketing
- Digital Clinics
- Educational Platforms
- Children Support
- Deaf Support
- Special Needs

These hooks are named so future departments can plug into the flow without retroactively rewriting the constitution or operational doctrine.

## N7. Complete Operational Flow Verdict

Mental Smile's operational flow is now defined as a circulation system:

```text
Reality produces signals.
Control organizes signals.
Departments analyze signals.
Owner ratifies high-risk or strategic decisions.
Execution follows approved authority.
Archive preserves institutional memory.
```

Today, several flows exist as partial runtime. Several are manual. Several are constitutional-only. That is acceptable for a limited pilot if no one mistakes manual discipline for mature automation.

Final law:

```text
No signal becomes authority without review.
No recommendation becomes action without legitimacy.
No meaningful decision disappears without archive.
```

---

## Commands Executed By Codex

None.

