# SOVEREIGN-WAVE / FIN-LEGAL-2 REPORT
# Finance & Legal Audit Boundary Specification

Project: Mental Smile  
Era: Sovereign Finance & Legal Separation  
Status: Audit boundary specification only  
Runtime effect: None

---

## 1. Executive Summary

Sovereign Finance and Sovereign Legal cannot safely exist without Sovereign Memory.

Finance and legal authority create institutional truth: who paid, who was rejected, what payout was confirmed, what settlement was ready, what evidence existed, what legal hold applied, what dispute was reviewed, and what archive became final.

That truth cannot depend on mutable admin history, UI state, or scattered operational logs.

Audit is not merely observability.

```text
Audit = Protected Memory
```

Observability helps operators see what is happening. Audit protects the institution's memory of what happened, who caused it, under what authority, and what correction or consequence followed.

Sovereign authority without protected memory becomes dangerous because it can:

- approve without trace
- reject without accountability
- correct without evidence
- archive without defensibility
- settle without review
- delete without consequence
- rewrite institutional history

Core doctrine:

```text
Finance and legal truth may be corrected.
It must not be erased.
```

---

## 2. Finance Audit Domains

| Event | Why Must Be Remembered | Risk If Missing |
| ----- | ---------------------- | --------------- |
| payment approval | Establishes that payment evidence was accepted and booking/service lifecycle may proceed. | Disputes, fraudulent approval, unsupported session/payout readiness. |
| payment rejection | Establishes why payment evidence was rejected and who rejected it. | User harm, unsupported denial, dispute escalation without evidence. |
| accounting review | Confirms reconciliation state and settlement readiness. | Mismatch between completed services and financial records. |
| payout confirmation | Establishes financial obligation/finality for center or clinician payout. | Duplicate payout, unpaid obligation, fraud, irreconcilable finance state. |
| settlement readiness | Marks that payment/accounting/payout conditions are sufficient for settlement. | Premature settlement or blocked legitimate settlement. |
| refunds | Records financial correction or compensation to user/tenant. | Hidden financial loss, dispute exposure, untraceable compensation. |
| finance corrections | Records that prior finance truth was corrected and why. | Silent rewriting, abuse, inability to defend updated state. |
| reconciliation actions | Records mismatch review and resolution. | Accumulated financial debt, accounting drift, unresolved obligations. |
| financial archive transitions | Records movement into financial finality/retention state. | Premature archive, missing financial evidence, legal defensibility failure. |

Finance memory principle:

```text
Every financial finality event must be remembered as evidence,
not merely reflected as a current field.
```

---

## 3. Legal Audit Domains

| Event | Why Must Be Remembered | Risk If Missing |
| ----- | ---------------------- | --------------- |
| legal holds | Establishes why records are preserved/restricted and who authorized it. | Evidence loss, unlawful deletion, operational confusion. |
| compliance evidence | Preserves proof of compliance-related decisions or artifacts. | Compliance failure, inability to defend institution. |
| dispute evidence | Records what evidence existed during a dispute. | Manipulation, missing facts, unfair resolution. |
| consent evidence | Shows user consent or non-consent for continuity/outreach flows. | Unwanted contact, legal/ethical exposure, emotional safety risk. |
| retention policy decisions | Records why memory is kept, redacted, archived, or restricted. | Arbitrary deletion/retention, regulatory risk. |
| legal archive transitions | Records movement into legal archive/finality state. | Evidence mishandling, irreversible archive without basis. |
| legal risk reviews | Records legal interpretation or risk classification. | Hidden legal judgment, inconsistent decisions. |
| contract decisions | Records creation, approval, change, or termination of contracts. | Unauthorized obligations, unclear entity commitments. |
| tax/legal document actions | Records generation, correction, archive, or review of tax/legal documents. | Tax/legal exposure, unverifiable documents. |

Legal memory principle:

```text
Legal memory protects evidence, context, and defensibility.
It is not a convenience log.
```

---

## 4. Immutable vs Correctable Memory

| Event Type | Immutable? | Correctable? | Notes |
| ---------- | ---------- | ------------ | ----- |
| payment approval event | Yes | Yes, by correction event | Original approval remains; correction explains changed truth. |
| payment rejection event | Yes | Yes, by correction event | Original rejection remains; later acceptance/correction is additive. |
| accounting review event | Yes | Yes, by reconciliation/correction event | Do not overwrite original accounting decision. |
| payout confirmation event | Yes | Usually only compensable/correctable | Payout may be hard to reverse; prefer compensation record. |
| settlement readiness event | Yes | Yes | Correction must explain invalid readiness or updated readiness. |
| refund event | Yes | Usually not rollback; correction/compensation | Financial movement must remain traceable. |
| financial archive transition | Yes | Highly constrained correction | Archive finality cannot be casually reversed. |
| legal hold event | Yes | Yes, by release/update event | Hold history remains even after release. |
| compliance evidence event | Yes | Yes, by superseding evidence | Prior evidence remains part of history. |
| dispute evidence event | Yes | Yes, by addendum | Evidence record should not be erased. |
| consent evidence event | Yes | Yes, by later consent update | Consent history matters; latest state does not erase prior state. |
| retention policy decision | Yes | Yes, by policy version/update | Old policy remains historically relevant. |
| contract decision | Yes | Yes, by amendment/termination | Original contract decision remains. |
| tax/legal document action | Yes | Yes, by corrected document/addendum | Prior document action remains traceable. |

Correction is not deletion.

```text
Correction
!=
Deletion
```

Correction is not history rewrite.

```text
Correction
!=
History Rewrite
```

Corrected truth differs from erased truth because corrected truth preserves:

- original event
- correction event
- actor
- reason
- time
- authority
- affected records
- downstream reconciliation

Erased truth destroys the institution's ability to explain itself.

---

## 5. Audit Visibility Matrix

| Role | Can View | Can Redact | Can Correct | Can Delete |
| ---- | -------- | ---------- | ----------- | ---------- |
| Control Room | Redacted signals, anomaly summaries, operational impact status. | No | No | No |
| Owner Room | Governance summaries, high-risk decision history, policy-level audit by scope. | No direct redaction; may approve redaction policy. | Policy-level correction approval only where required. | No |
| Sovereign Finance | Finance audit within scope: payment, accounting, payout, settlement, reconciliation. | Limited redaction request, not silent redaction. | Yes, through correction/compensation events. | No |
| Sovereign Legal | Legal/compliance/dispute/retention audit within scope. | May approve redaction under legal policy; action must be audited. | Yes, through legal correction/addendum/release events. | No |
| Backend/System | Technical append/read as required for execution and integrity. | No policy redaction; executes approved redaction process only. | No autonomous correction. | No |
| Support/Continuity | Consent/outreach/support audit summaries by scope. | No | No | No |
| Tenant | Tenant-safe financial/legal summaries where permitted. | No | No | No |
| Client | User-facing evidence/status relevant to their case, redacted. | No | Request correction through process only. | No |
| Clinician | Clinician-relevant payout/session/dispute summaries, redacted. | No | Request correction through process only. | No |

Deletion rule:

```text
No ordinary role may delete sovereign audit memory.
```

If legal erasure or data rights obligations ever apply, they must be handled as a governed legal process with preservation of lawful deletion evidence, not as silent removal.

---

## 6. Redaction Boundary

Redaction is not deletion.

| Concept | Meaning |
| ------- | ------- |
| Hidden | Not shown to a role or room because they lack scope or need. Data still exists. |
| Redacted | Shown partially with sensitive portions masked or summarized. Data still exists. |
| Deleted | Removed from storage or made unrecoverable. Dangerous and usually forbidden for sovereign audit except under lawful governed process. |

What may be hidden or redacted:

- payment evidence
- payment attachment references
- dispute attachments
- legal documents
- tax information
- consent records
- sensitive identity details
- support details not needed by finance
- finance details not needed by support
- legal reasoning not needed by Control Room
- personally sensitive evidence

Redaction principles:

```text
Hide by default where scope is absent.
Redact where visibility is necessary but full detail is not.
Delete only under governed legal process.
```

Control Room should see signals, not raw sovereign evidence.

---

## 7. Retention Boundary

| Memory Type | Suggested Retention Philosophy | Why |
| ----------- | ------------------------------ | --- |
| payment evidence | Retain as long as needed for dispute, reconciliation, tax, and financial defensibility. | Payment decisions must be explainable. |
| payout history | Long-lived financial memory. | Prevent duplicate/missing payout and support tax/settlement proof. |
| accounting decisions | Long-lived reconciliation memory. | Accounting truth must survive operational changes. |
| settlement readiness | Retain with finance lifecycle history. | Settlement finality must be defensible. |
| refunds | Retain as financial correction/compensation memory. | Refunds are financial events and dispute evidence. |
| financial corrections | Retain with original and corrected events. | Correction cannot erase original truth. |
| legal holds | Retain hold, modification, and release history. | Legal preservation must be defensible. |
| disputes | Retain evidence, decisions, and resolution history by legal/compliance need. | Disputes require institutional memory. |
| consent evidence | Retain enough to prove consent state and changes over time. | Continuity/outreach must be consent-aware. |
| legal archive transitions | Long-lived archive/finality memory. | Archive affects legal defensibility and retention. |
| retention policy decisions | Versioned long-lived policy memory. | Future reviewers need to know what policy existed at the time. |

No exact durations are defined here. This specification defines philosophy only.

Retention law:

```text
Sovereign memory must outlive operational convenience.
```

---

## 8. Correction Doctrine

| Term | Meaning | Example |
| ---- | ------- | ------- |
| Correction | Add a new event that states prior recorded truth was wrong or incomplete. | Payment approval corrected to invalid after evidence review. |
| Compensation | Add a new action that offsets a prior real-world effect. | Refund or adjustment after financial mistake. |
| Rollback | Restore operational state to a prior state. | Move payment status back to pending review, if no downstream finality depends on it. |
| Reversal | Explicitly reverse a prior decision while preserving history. | Revoke a legal hold or reverse a rejection decision. |
| Replacement | Supersede a document, policy, or evidence record with a new version. | Corrected tax/legal document replaces prior version for future use. |

Finance correction:

```text
Finance Correction
!=
History Deletion
```

A finance correction must record:

- original event
- corrected event
- reason
- actor
- approval authority
- affected records
- downstream reconciliation

Legal correction:

```text
Legal Correction
!=
Evidence Erasure
```

A legal correction must preserve:

- original evidence existence
- corrected/additional evidence
- reason for correction
- legal authority
- visibility/redaction changes
- retention impact

Rollback should be rare for sovereign domains. Correction and compensation are safer than pretending the past did not happen.

---

## 9. Audit Event Families

| Family | Priority | Why |
| ------ | -------- | --- |
| `finance.payment.*` | Critical | Payment approval/rejection creates financial lifecycle truth. |
| `finance.accounting.*` | Critical | Accounting review drives reconciliation and settlement readiness. |
| `finance.payout.*` | Critical | Payout is high-risk financial finality. |
| `finance.settlement.*` | High | Settlement readiness/finality must be defensible. |
| `finance.refund.*` | High | Refunds are correction/compensation memory. |
| `finance.reconciliation.*` | Critical | Reconciliation prevents hidden finance debt. |
| `finance.archive.*` | Critical | Financial archive affects finality and retention. |
| `legal.hold.*` | Critical | Holds preserve/restrict evidence under legal authority. |
| `legal.dispute.*` | Critical | Dispute memory must be defensible and protected. |
| `legal.retention.*` | Critical | Retention policy governs memory survival. |
| `legal.compliance.*` | High | Compliance evidence protects institutional accountability. |
| `legal.contract.*` | High | Contracts define legal obligations. |
| `legal.document.*` | High | Tax/legal document actions must be traceable. |
| `legal.consent.*` | High | Consent evidence protects humane and legal continuity boundaries. |
| `sovereign.redaction.*` | Critical | Redaction itself is a sovereign act and must be remembered. |
| `sovereign.correction.*` | Critical | Corrections must be additive, governed, and visible by scope. |

Audit family rule:

```text
The audit family must reveal the domain of authority,
not just the technical collection touched.
```

---

## 10. Sovereign Memory Risks

| Risk | Description | Consequence |
| ---- | ----------- | ----------- |
| evidence suppression | Evidence is hidden, removed, or made inaccessible without governed process. | Legal/financial defensibility collapse. |
| silent correction | State is changed without additive correction memory. | History rewrite and abuse risk. |
| audit rewriting | Prior memory is edited instead of superseded. | Institutional memory corruption. |
| owner abuse | Owner uses policy authority to override finance/legal memory. | New super-admin/monarchy risk. |
| admin abuse | Admin mutates finance/legal truth through compatibility paths. | Sovereign authority remains trapped in admin. |
| legal deletion | Legal evidence is deleted under operational pressure. | Legal exposure and dispute manipulation. |
| financial deletion | Payment/payout/accounting evidence disappears. | Fraud, duplicate payout, unpaid obligations. |
| dispute manipulation | Evidence order, content, or visibility is altered to affect outcome. | Unfair dispute resolution. |
| retention abuse | Records are kept too long, deleted too early, or hidden through policy misuse. | Privacy/legal/compliance risk. |
| redaction abuse | Redaction used to hide accountability instead of protect scope. | Governance opacity. |
| backend invisibility | System execution appends/changes memory without human-visible authority. | Hidden backend dictatorship. |

Sovereign memory must protect against both operational abuse and institutional convenience.

---

## 11. Current Runtime Gap

Current reality:

```text
booking_requests
admin residue
no immutable audit
no sovereign command runtime
no sovereign memory layer
```

Readiness:

| Area | Readiness |
| ---- | --------- |
| finance/legal authority recognition | PARTIAL |
| finance freezer labels | READY |
| legal freezer labels | READY |
| sovereign audit doctrine | PARTIAL |
| immutable audit runtime | BLOCKED |
| finance command runtime | BLOCKED |
| legal command runtime | BLOCKED |
| backend sovereign execution | BLOCKED |
| redaction policy | LOW |
| retention policy | LOW |
| correction doctrine | PARTIAL |
| reconciliation ledger | LOW |
| Control Room visibility boundary | PARTIAL |
| Owner/Sovereign approval matrix | PARTIAL |
| shared document field ownership | LOW |

Gap summary:

```text
The project can describe sovereign memory now.
It cannot safely enforce sovereign memory yet.
```

---

## 12. Recommended Next Wave

Options:

| Option | Assessment |
| ------ | ---------- |
| A. Finance Command Boundary Specification | Strong next step if focused on request/authority boundaries, not execution. |
| B. Legal Command Boundary Specification | Important, but many legal flows are less concretely implemented today. |
| C. Unified Sovereign Command Boundary Specification | Best next step because finance/legal overlap in archive, disputes, correction, retention, and settlement. |
| D. Owner Room Boundary Exploration | Useful later; owner boundaries should follow sovereign command/memory clarity. |

Recommendation:

```text
Option C: Unified Sovereign Command Boundary Specification
```

Justification:

Finance and legal authority share several high-risk boundaries: financial archive, disputes, refunds, retention, correction, settlement, and audit redaction. Separate command specs too early may create inconsistent authority models. A unified sovereign command boundary can define what all sovereign commands must require before finance/legal-specific command families are designed.

Recommended next wave:

```text
SOVEREIGN-WAVE / FIN-LEGAL-3
Unified Sovereign Command Boundary Specification
```

---

## 13. Final Doctrine

Complete doctrine:

```text
No Sovereign Authority
Without Sovereign Memory
```

Expanded doctrine:

```text
No finance or legal authority may become executable
until its memory is protected,
its correction path is additive,
its visibility is scoped,
its retention is governed,
and its audit cannot be silently rewritten.
```

Final statement:

```text
Sovereign memory is the price of sovereign power.
Without it, finance and legal rooms would only recreate admin authority
with more dangerous consequences.
```

---

## Commands Executed By Codex

None

