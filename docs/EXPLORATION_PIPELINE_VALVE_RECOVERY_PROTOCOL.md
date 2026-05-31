# EXPLORATION-WAVE REPORT
# Pipeline Valve & Recovery Protocol

Project: Mental Smile  
Era: Post-Grounding / Pipeline Architecture Exploration  
Status: Architecture exploration and critique only  
Runtime effect: None

---

## 1. Pipeline-Level Closure Soundness

Pipeline-level closure is technically sound as a failure-isolation doctrine, but it is not automatically safe.

The basic model is realistic:

```text
Close Payment Pipeline.
Keep Session Pipeline running.
```

```text
Close Accounting Pipeline.
Keep Support and Review running.
```

```text
Close Payout Pipeline.
Keep Session, Chat, and Support running.
```

This maps to real operational systems through circuit breakers, scoped feature freezes, state transition gates, incident modes, and degraded-service operation. The model is especially useful when one domain is broken but the rest of the platform can still serve users safely.

However, pipeline closure is only safe when the platform understands three things:

1. Which pipeline owns which truth.
2. Which other pipelines depend on that truth.
3. What debt accumulates while the pipeline is closed.

If those are not known, closure can create silent corruption.

### Example: Close Payment, Keep Sessions Running

This can be safe if existing valid sessions do not require new payment approval. It becomes unsafe if session completion creates payment obligations that nobody can reconcile later.

Safe continuation:

- chat
- support
- already-approved sessions
- read-only payment visibility
- non-payment clinical/session preparation

Must stop:

- new payment approval
- payment rejection
- payment-dependent booking completion
- payment-to-payout eligibility

Debt created:

- sessions awaiting payment validation
- bookings stuck between clinical and financial readiness
- manual review queue after reopening

### Example: Close Accounting, Keep Support/Review Running

This is realistic and useful. Accounting failure should not stop support or review collection.

Safe continuation:

- support cases
- reviews
- sessions not requiring accounting finalization
- payment evidence intake if not accounting-dependent

Must stop:

- settlement readiness
- accounting confirmation
- financial archive
- payout release based on accounting completion

Debt created:

- completed sessions awaiting reconciliation
- payout candidates blocked by accounting
- center/clinician financial state uncertainty

### Example: Close Payout, Keep Session/Chat/Support Running

This is not only realistic; it is probably necessary. Payout is sovereign-grade and should fail closed without freezing humane operational care.

Safe continuation:

- sessions
- support
- chat escalation
- reviews
- payment intake
- accounting staging

Must stop:

- payout confirmation
- payout execution
- settlement closure
- financial archive finalization

Debt created:

- payable obligations
- delayed settlement communication
- finance review backlog

Conclusion:

```text
Pipeline closure is sound only if closure produces visible reconciliation debt.
```

Without reconciliation, closure is just hidden disorder with a formal name.

---

## 2. Valve Closure Request

A Valve Closure Request is a governed request to restrict a pipeline, scope, transition, or authority path for a defined reason and duration.

It is not an admin button. It is not a silent feature flag. It is not a panic switch without memory.

Conceptual fields:

| Field | Purpose |
| ----- | ------- |
| requester | Who is asking for closure. |
| requesterRole | Current operational identity of the requester. |
| reason | Why closure is needed. Required. |
| targetPipeline | Payment, Session, Payout, Accounting, Archive, etc. |
| affectedScope | Tenant, center, user, route, command family, or global scope. |
| closureType | Freeze, pause, read-only, soft close, hard close, emergency close, rollback request. |
| expectedDuration | Time-box for closure. No indefinite closure by default. |
| severity | Operational severity and risk tier. |
| rollbackNeed | Whether closure requires rollback, correction, compensation, or no recovery. |
| reopenCondition | Concrete condition required before reopening. |
| auditRequirement | What must be recorded before, during, and after closure. |
| reconciliationOwner | Who owns accumulated debt review. |
| affectedDependencies | Other pipelines expected to accumulate obligations. |
| postReviewRequired | Whether a post-incident review is mandatory. |

Closure types:

| Type | Meaning | Typical Use | Risk |
| ---- | ------- | ----------- | ---- |
| Freeze | Stop state changes, allow visibility. | Suspicious payout state, legal hold. | Medium to high. |
| Pause | Temporarily delay execution while accepting intake. | Accounting review backlog. | Medium. |
| Read-only | Allow reads, block writes. | Audit review, data integrity concern. | Medium. |
| Soft close | Block risky transitions but allow safe low-risk updates. | Payment approval disabled, evidence upload still visible. | Medium. |
| Hard close | Block all mutation inside pipeline. | Severe corruption or breach. | High. |
| Emergency close | Immediate containment before full approval. | Active abuse, suspected financial breach. | Critical. |
| Rollback request | Request to restore or reverse pipeline state. | Incorrect payment approval, bad state transition. | Critical. |

Important distinction:

```text
Closure prevents new movement.
Rollback changes or compensates prior movement.
They are not the same authority.
```

---

## 3. Two-Key Approval Model

The proposed model:

```text
Admin requests.
Owner approves.
Audit records.
Constitution limits.
```

This is better than admin direct closure, but it is not sufficient for all pipelines.

The weakness is simple: the Owner can become the new super-admin unless approval is scoped by domain. Some closures are operational. Some are sovereign. Some are technical. Some are compliance/legal. They should not all route through one human authority pattern.

Recommended approval matrix:

| Pipeline | Closure Type | Approval Model |
| -------- | ------------ | -------------- |
| Payment | Soft close/read-only | Owner + finance/sovereign review. |
| Payment | Hard close/rollback | Owner + finance + audit review. |
| Session | Soft close | Operational lead or owner, depending on scope. |
| Session | Hard close/global | Owner + technical review. |
| Review | Soft close | Operational lead or owner. |
| Review | Hard close | Owner + compliance if review affects trust/payout. |
| Payout | Any closure affecting execution | Owner + finance/sovereign authority. |
| Payout | Rollback/correction | Owner + finance + audit/legal review. |
| Accounting | Pause/soft close | Owner + finance/accounting authority. |
| Accounting | Hard close | Owner + finance + technical if data integrity issue. |
| Archive | Read-only/freeze | Owner + compliance/legal depending on archive type. |
| Archive | Rollback | Usually avoid rollback; prefer correction event with legal review. |
| Support | Soft close | Operational lead, with owner visibility for broad scope. |
| Registration | Freeze approvals | Owner + trust/governance review. |
| Trust | Blocking/approval freeze | Owner + compliance/trust review. |
| Compliance | Any closure | Owner + compliance authority. |

Emergency threshold:

Some closures must be possible before full approval if active damage is occurring. But emergency closure must be:

- time-bound
- audit-bound
- visible
- post-reviewed
- narrow by default
- automatically escalated

Better model:

```text
Admin may request.
Emergency may temporarily contain.
Domain authority must approve.
Audit must record.
Constitution must limit.
Post-review must judge.
```

---

## 4. Pipeline-Specific Backups

The idea:

```text
Each pipeline has its own backup/snapshot every 12 hours.
```

This is conceptually useful but technically premature in the current runtime.

### Feasibility With Shared Documents

Pipeline-specific backup is difficult when multiple domains are stored inside shared documents like `booking_requests`.

If one document contains:

- booking status
- session fields
- payment fields
- payout fields
- accounting fields
- review fields
- archive fields

then a "Payment Pipeline snapshot" is not a clean document backup. It is a field-level or projection-level snapshot.

That creates problems:

- Which fields belong to payment?
- Which computed states depend on non-payment fields?
- What happens if payment snapshot restores a field that session logic has since depended on?
- Can a partial field restore violate document invariants?

### What Counts As a Pipeline Snapshot?

A pipeline snapshot should not mean "copy the whole database."

Possible meanings:

| Snapshot Type | Usefulness | Risk |
| ------------- | ---------- | ---- |
| Full document snapshot | Easy to conceptualize, bad for pipeline rollback. | Can overwrite unrelated pipeline truth. |
| Field-group snapshot | Better for shared documents. | Requires exact ownership map. |
| Event snapshot | Strong for audit/replay. | Needs event discipline. |
| Projection snapshot | Good for recovery views. | May not restore source truth. |
| Ledger checkpoint | Strong for finance/accounting. | Requires reconciliation model. |

### Is 12 Hours Appropriate?

Not universally.

| Pipeline | Snapshot Window |
| -------- | --------------- |
| Payout | Shorter than 12 hours, plus immutable event evidence. |
| Payment | Shorter or event-based around approvals/rejections. |
| Accounting | 12 hours may be acceptable for staging, not final settlement. |
| Session | Event-based around lifecycle transitions. |
| Support | 12 hours may be acceptable if no critical safety content is lost. |
| Archive | Snapshot is less important than immutable retention history. |
| Audit | Must not be rollback-based; it is append-only memory. |

The deeper correction:

```text
High-risk pipelines need event memory more than periodic snapshots.
```

Snapshots are recovery aids. Audit is truth memory. They must not be confused.

---

## 5. Pipeline Rollback

The phrase "rollback Payment Pipeline without rolling back Session Pipeline" is attractive and dangerous.

It is safe only when the rolled-back state has not become a dependency for another pipeline's irreversible truth.

### Safe Cases

Payment rollback may be safe when:

- payment approval was recent
- no payout was prepared
- no accounting closure occurred
- no archive finalization occurred
- session status can tolerate payment re-review
- audit records both original action and correction

### Dangerous Cases

Payment rollback becomes dangerous when:

- payout has already been confirmed
- accounting has already reconciled
- archive has been finalized
- tenant/client communication has been sent
- legal/financial documents were generated
- review or trust decisions depended on the payment state

### Rollback vs Correction vs Compensation

| Concept | Meaning | Example |
| ------- | ------- | ------- |
| Rollback | Restore prior pipeline state. | Payment returns from approved to pending review. |
| Correction | Add an official correction without pretending history did not happen. | Payment approval marked erroneous and replaced by corrected decision. |
| Compensation | Create a new action to offset an already-real effect. | Refund, adjustment, settlement correction. |

High-risk domains should prefer correction and compensation over rollback.

Core rule:

```text
Rollback may restore operational state.
It may not rewrite federation memory.
```

And:

```text
Rollback must not silently rewrite another pipeline's truth.
```

---

## 6. Reconciliation Ledger

A reconciliation ledger is not optional. It is the mechanism that prevents isolation from becoming amnesia.

When a pipeline is closed or rolled back, the system creates obligations. Those obligations need ownership, visibility, and closure criteria.

The ledger answers:

- what debt was created?
- which records are affected?
- who owns reconciliation?
- what must be reviewed before reopening?
- which items need manual judgment?
- which downstream pipelines may have stale assumptions?
- what can never be automated?

Examples:

### Accounting Closed While Sessions Continue

Debt created:

- sessions completed while accounting unavailable
- payments needing reconciliation
- payout candidates blocked
- financial archive delayed

Owner:

- finance/accounting authority

Before reopening:

- review all accumulated accounting candidates
- verify no payout was incorrectly released
- classify deferred settlement state

### Payment Rolled Back While Reviews Exist

Debt created:

- review may belong to a session whose payment is no longer valid
- booking lifecycle state may be inconsistent
- client/clinician communication may require correction

Owner:

- payment authority with operational review

Cannot be automated:

- human-facing correction communication
- judgment about whether review remains valid

### Payout Paused While Sessions Complete

Debt created:

- payable obligations accumulate
- financial expectations may need communication
- accounting queue grows

Owner:

- sovereign finance authority

Before reopening:

- validate payable candidates
- verify no duplicate payout risk
- confirm settlement ordering

### Archive Frozen While Workflows Finish

Debt created:

- completed workflows remain unarchived
- retention deadlines may approach
- active surfaces may show stale completed records

Owner:

- compliance/archive authority

Before reopening:

- verify archive eligibility
- ensure legal hold and retention requirements
- process backlog in governed order

Reconciliation law:

```text
A closed valve must create a reconciliation obligation.
```

---

## 7. Failure Isolation Modes

| Pipeline | Failure Mode | What Stops | What Continues | Debt Created | Reopen Requirement |
| -------- | ------------ | ---------- | -------------- | ------------ | ------------------ |
| Payment | Evidence validation, approval, or rejection unsafe. | New approvals/rejections, payment-dependent completion, payment-to-payout readiness. | Sessions already cleared, support, chat, registration, read-only payment visibility. | Pending payment decisions, sessions awaiting financial readiness, communication follow-up. | Payment integrity verified, backlog reviewed, audit/reconciliation complete. |
| Session | Lifecycle transitions unreliable. | Scheduling, progress/completion changes, session archive readiness. | Support, chat, payment review for already stable sessions, registration. | Unsynced session obligations, delayed reviews, delayed payout readiness. | State map verified, affected bookings reviewed, dependent pipelines notified. |
| Review | Review capture or validation unsafe. | New review finalization, review-dependent trust scoring, review-based payout rules. | Sessions, support, payment/accounting if independent. | Missing reviews, stale quality signals, delayed trust updates. | Review backlog classified, trust/payout dependencies checked. |
| Payout | Payout eligibility or execution unsafe. | Payout confirmation, payout execution, settlement closure. | Sessions, support, chat, payment intake, accounting staging. | Payable obligations, settlement backlog, finance communication needs. | Finance review, duplicate risk check, immutable audit readiness. |
| Accounting | Reconciliation or center review unsafe. | Accounting completion, settlement readiness, financial archive. | Sessions, support, reviews, payment intake. | Reconciliation backlog, payout blockers, financial uncertainty. | Backlog reconciliation, finance approval, mismatch resolution. |
| Archive | Finalization/retention unsafe. | Session archive, financial archive, irreversible retention actions. | Active workflows, support, chat, registration. | Completed-but-unarchived records, retention backlog, stale active views. | Archive eligibility review, legal/compliance check, backlog plan. |
| Support | Case handling or continuity workflow unsafe. | New support case transitions, outbound continuity, escalation closure. | Sessions, payment, registration, accounting if independent. | Unresolved cases, delayed outreach, user communication backlog. | Case queue review, humane communication plan, escalation triage. |
| Registration | Onboarding/approval unsafe. | New approvals, trust activation, registration finalization. | Existing sessions, support, chat, payment/accounting for existing users. | Pending applicants, delayed center/clinician onboarding. | Identity/trust review, pending request classification. |
| Trust | Approval/blocking/trust state unsafe. | Clinician/center activation, blocking, trust escalation decisions. | Existing safe operations, support, read-only trust visibility. | Trust review backlog, authority uncertainty, blocked onboarding. | Trust audit, policy confirmation, affected actors reviewed. |
| Compliance | Policy/evidence validation unsafe. | Compliance-gated actions, legal/financial finalization, high-risk approvals. | Low-risk operations not requiring compliance gate. | Compliance evidence backlog, legal review obligations. | Compliance review, policy confirmation, legal/audit signoff. |

---

## 8. Valve Ownership & Abuse Prevention

The recovery protocol creates a serious new risk:

```text
Whoever controls closures can become more powerful than the old admin.
```

The system must prevent "valve authority" from becoming a new God-mode.

Risks:

- owner becomes super-admin
- admin pressures owner to approve everything
- emergency close becomes routine
- pipelines get frozen forever
- closures hide accountability
- rollbacks hide mistakes
- closure is used politically instead of operationally
- users are harmed by invisible operational freezes

Safeguards:

| Safeguard | Rule |
| --------- | ---- |
| No eternal closure | Every closure has expected duration and review date. |
| Reason required | No reason, no closure. |
| Scope required | Global closure must be exceptional. |
| Audit required | Closure, rejection, extension, reopen, and rollback are all recorded. |
| Reopen condition required | Closure cannot be approved without a defined exit path. |
| Post-review required | Emergency and high-risk closures require after-action review. |
| Escalation visibility | Relevant rooms see closure status within scope. |
| No silent rollback | Rollback creates memory, not erasure. |
| No closure laundering | Closure cannot be used to hide failed operations. |
| Time-boxed emergency | Emergency closure expires or escalates. |
| Separation of approval | Sovereign closures require sovereign participation. |

Strong law:

```text
The power to close a pipeline is itself a high-risk authority.
```

Therefore it must be more governed than ordinary mutation, not less.

---

## 9. Current Runtime Feasibility

Current Mental Smile reality:

```text
booking_requests as shared state
broad admin residue
passive shadow wrappers
no command runtime
no audit runtime
no independent pipeline storage
no immutable backup infrastructure
```

This means the full protocol is not feasible today.

What can be documented now:

- pipeline candidate definitions
- closure type vocabulary
- rollback vs correction vs compensation doctrine
- reconciliation ledger concept
- failure isolation expectations
- approval matrix by domain
- "do not implement yet" boundaries

What must not be implemented yet:

- real pipeline closure enforcement
- real rollback
- automated pipeline snapshots
- finance/payout/accounting closure authority
- emergency close buttons
- owner-operated global valve console
- silent field-level restore from shared documents

Distance assessment:

| Capability | Current Readiness |
| ---------- | ----------------- |
| Pipeline vocabulary | Medium |
| Domain ownership map | Low to medium |
| Passive command shadowing | Medium |
| Audit memory | Low |
| Registry-defined valve rules | Low |
| Pipeline storage separation | Low |
| Safe rollback | Very low |
| Reconciliation ledger | Concept only |
| Closure approval governance | Concept only |

Current feasible status:

```text
Doctrine only.
Not runtime authority.
```

---

## 10. Minimal Future Shape

These artifacts may be needed later, but not all should be created immediately.

| Future Artifact | Purpose | Necessary? | Prematurity Risk |
| --------------- | ------- | ---------- | ---------------- |
| pipeline_valve_requests | Request/approval record for closure, pause, read-only, rollback. | Likely necessary later. | Premature before pipeline boundaries are defined. |
| pipeline_closure_events | Immutable memory of actual closure lifecycle. | Necessary if closures become real. | Duplicates audit if not modeled carefully. |
| pipeline_snapshots | Recovery or comparison snapshots. | Useful, but risky. | Dangerous with shared documents and unclear field ownership. |
| pipeline_recovery_events | Records correction, compensation, rollback, reopen. | Necessary for recovery maturity. | Premature before audit design. |
| pipeline_reconciliation_tasks | Tracks operational debt created by closure/rollback. | Strongly necessary. | Could become noisy if every closure creates too many tasks. |
| pipeline_reopen_reviews | Confirms reopen conditions were met. | Necessary for high-risk closures. | Too heavy for low-risk pauses. |
| pipeline_dependency_map | Declares downstream obligations and affected pipelines. | Necessary before real closure. | Hard to maintain if manual only. |
| pipeline_debt_ledger | Tracks deferred obligations. | Necessary for accounting/payout/archive domains. | High complexity. |

Minimum conceptual artifact set before any real closure:

```text
pipeline definitions
closure type definitions
approval matrix
reconciliation rules
audit event vocabulary
rollback/correction/compensation distinction
```

Do not start with snapshots. Start with meaning.

---

## 11. Conceptual Migration Strategy

### What Comes First

1. Define pipeline candidates conservatively.
2. Define which fields belong to each pipeline.
3. Define closure types and severity levels.
4. Define dependency and debt rules.
5. Define rollback vs correction vs compensation.
6. Define who may request closure.
7. Define who may approve by pipeline and scope.
8. Define audit memory requirements.
9. Define reopen conditions.
10. Define what must remain forbidden.

### What Comes Later

1. Shadow registry of pipeline definitions.
2. Shadow closure request records with no enforcement.
3. Shadow reconciliation task generation.
4. Observability-only closure dashboards.
5. Low-risk read-only closure simulations.
6. Audit-linked closure lifecycle.

### What Comes Last

1. Real closure enforcement.
2. Real rollback.
3. Pipeline backup automation.
4. Sovereign financial recovery.
5. Emergency closure authority.
6. Tenant-scoped closure automation.
7. Cross-pipeline reconciliation automation.

Migration law:

```text
Define ownership before closure.
Define debt before isolation.
Define memory before rollback.
```

---

## 12. Final Verdict

Choice:

```text
B) Useful but premature
```

Justification:

The protocol is valuable because Mental Smile has already discovered real cross-domain coupling. Payment, session, payout, accounting, review, archive, and workflow state are entangled enough that failure isolation will eventually be necessary.

The protocol is also premature because the current runtime does not yet have:

- independent pipeline storage
- immutable audit runtime
- command execution runtime
- registry-owned valve rules
- reliable field ownership maps
- reconciliation ledger
- backup boundaries
- safe rollback semantics

The idea should survive as doctrine, not activate as runtime.

Best current formulation:

```text
Pipeline closure and rollback are future high-risk authorities.
They must be designed now,
but not executed until ownership, audit, reconciliation, and scope are real.
```

The strongest parts of the model:

- admin cannot close pipelines directly
- closure must be scoped and time-bound
- rollback cannot rewrite federation memory
- closure creates reconciliation obligations
- high-risk pipelines require domain-specific approval

The weakest parts:

- pipeline-specific backup is not clean with shared documents
- rollback can corrupt dependent truth
- owner approval alone can recreate super-admin
- emergency closure can become routine
- reconciliation can become unowned operational debt

Final architectural position:

```text
The Pipeline Valve & Recovery Protocol is useful but premature.
It should be documented as a future recovery doctrine,
not implemented as runtime authority during the current grounding phase.
```

---

## Commands Executed By Codex

None

