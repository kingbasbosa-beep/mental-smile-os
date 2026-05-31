# SOVEREIGN-WAVE / FIN-LEGAL-0 REPORT
# Sovereign Finance & Legal Separation Map

Project: Mental Smile  
Era: Sovereign Finance & Legal Separation  
Status: Conceptual separation only  
Runtime effect: None

---

## 1. Executive Summary

Finance and legal authority must leave generic admin.

The current `/admin/*` surface still contains finance/legal residue through payment approval/rejection, accounting review, payout confirmation, settlement readiness, financial archive, and compliance/legal-adjacent evidence. These are not ordinary admin operations. They define financial truth, legal memory, settlement readiness, and potential institutional liability.

This separation is conceptual first. No Sovereign Finance Room, Sovereign Legal Room, route, claim, backend command, audit runtime, or UI implementation should be created yet.

Control Room may observe finance/legal anomalies, delays, backlogs, and risk signals. It must not own finance/legal truth.

Core doctrine:

```text
Control may observe finance/legal risk.
Sovereign authority reviews finance/legal truth.
Owner governs constitutional legitimacy.
Trusted execution happens only after command/audit boundaries exist.
```

The immediate goal is not to move buttons. The goal is to prevent the old admin cockpit from remaining the conceptual home of sovereign authority.

---

## 2. Current Finance Authority Inventory

| Authority | Current Surface / Service | Collection / Fields | Current Actor | Risk | Future Target |
| --------- | ------------------------- | ------------------- | ------------- | ---- | ------------- |
| payment approval | Admin payment/booking decision paths, `AdminBookingDecisionAdapter.approvePayment` | `booking_requests`, payment evidence/status fields | admin | Critical | Sovereign Finance |
| payment rejection | Admin payment/booking decision paths, `AdminBookingDecisionAdapter.rejectPayment` | `booking_requests`, payment rejection/status fields | admin | Critical | Sovereign Finance |
| accounting review | Admin accounting paths, `confirmCenterAccountingReview` | `booking_requests`, accounting/review fields | admin | Critical | Sovereign Finance |
| payout confirmation | Admin booking/payment paths, `confirmCenterPayout`, `confirmClinicianPayout` | `booking_requests`, payout status fields | admin | Critical | Sovereign Finance |
| settlement readiness | Implied through payment/accounting/payout state | `booking_requests`, settlement-adjacent lifecycle fields | admin/system-adjacent | Critical | Sovereign Finance |
| refunds | Not confirmed as active in this map; future/refund-like authority is finance-grade | payment/refund-related fields if present | admin if present | Critical | Sovereign Finance |
| commission calculation | Finance/accounting-adjacent logic if present or derived | booking/settlement/accounting fields | admin/system-adjacent | High | Sovereign Finance / Backend/System Authority |
| financial archive | Admin archive path, `sendToFinancialArchive` | `booking_requests`, archive/finalization fields | admin | Critical | Sovereign Finance + Sovereign Legal |
| finance anomaly visibility | Admin dashboards/health/queues | summaries, booking/payment/accounting status | admin | Medium | Control observe-only |
| payment queue visibility | Admin payment/booking surfaces | payment evidence/status projections | admin | Medium | Control observe-only + Sovereign Finance review |
| payout delay visibility | Admin accounting/payment/operations surfaces | payout readiness/status projections | admin | Medium | Control observe-only + Sovereign Finance |
| accounting backlog visibility | Admin accounting/operations surfaces | accounting state/backlog | admin | Medium | Control observe-only + Sovereign Finance |

Current finance risk summary:

```text
Finance truth is still too close to generic admin mutation.
```

The most dangerous line is payout/accounting/payment authority living beside ordinary operational admin actions.

---

## 3. Current Legal / Compliance Authority Inventory

| Authority | Current Surface / Service | Evidence / Data | Current Actor | Risk | Future Target |
| --------- | ------------------------- | --------------- | ------------- | ---- | ------------- |
| legal holds | Not confirmed as active; future/legal-adjacent authority | affected records, archive locks, dispute evidence | admin if added under current pattern | Critical | Sovereign Legal |
| compliance evidence | System/admin/compliance-adjacent data and records | compliance artifacts, operational evidence, policy evidence | admin/system-adjacent | High | Sovereign Legal |
| financial archive retention | Admin financial archive paths | finalized financial lifecycle records | admin | Critical | Sovereign Finance + Sovereign Legal |
| tax/legal documents | Not confirmed as active; future/legal/tax document authority | tax summaries, legal documents, receipts, contracts | admin if added under current pattern | Critical | Sovereign Legal / Finance |
| contracts | Not confirmed as active; future entity/legal document authority | contract documents, agreement metadata | admin if added under current pattern | Critical | Sovereign Legal |
| dispute evidence | Chat/support/payment/session evidence if dispute arises | evidence references, audit trail, support records | admin/control-visible today | High | Sovereign Legal |
| audit visibility | Admin/system visibility where present/future | audit-like records, lifecycle history | admin | High | Sovereign Legal/Sovereign Finance scoped visibility |
| consent-related continuity evidence | External follow-up, support/continuity records | outreach consent, communication history, continuity state | admin/support | High | Sovereign Legal + Support/Continuity Governance |
| legal risk review | Not separated today; likely admin/owner conceptual line | risk flags, compliance notes, dispute context | admin/owner-adjacent | High | Sovereign Legal + Owner governance |

Current legal/compliance risk summary:

```text
Legal authority is less explicit than finance authority,
but the risk is already present wherever archive, consent, dispute, compliance, or evidence records exist.
```

Legal authority must not be added later under generic admin just because there is no legal room yet.

---

## 4. Future Sovereign Finance Scope

Sovereign Finance should conceptually own:

- payment evidence governance
- payment approval/rejection
- accounting review
- payout readiness
- payout confirmation
- settlement
- refund authority
- finance reconciliation
- financial archive eligibility
- finance pipeline freeze/reopen recommendation
- finance anomaly classification
- duplicate payout prevention
- finance correction/compensation decisions
- finance audit visibility by scope

Sovereign Finance must not own:

- clinical/session truth
- support case handling
- legal interpretation by itself
- tenant micromanagement
- AI policy governance
- product/development priority setting
- unilateral global shutdown authority
- silent correction of financial history
- raw admin-style mutation without command/audit boundaries

Finance doctrine:

```text
Sovereign Finance owns financial truth.
It does not own the whole operational lifecycle.
```

---

## 5. Future Sovereign Legal Scope

Sovereign Legal should conceptually own:

- legal holds
- contracts
- compliance evidence
- legal risk review
- tax/legal archive policy
- dispute evidence
- retention policy
- legal finality review
- legally sensitive audit access
- consent evidence governance
- legal review of irreversible archive/finality
- legal/compliance pipeline freeze recommendation

Sovereign Legal must not own:

- ordinary support operations
- day-to-day booking decisions
- financial execution alone
- product prioritization alone
- clinical judgment
- broad user surveillance
- generic admin mutation
- rewriting audit history
- using legal concern as unlimited authority

Legal doctrine:

```text
Sovereign Legal protects legal memory, risk, and evidence.
It must not become a universal veto room for ordinary operations.
```

---

## 6. Control Room Visibility

Control Room needs enough visibility to detect issues and protect operations, but not enough mutation authority to become finance/legal owner.

| Signal Visible To Control | Allowed Control Action | Forbidden Control Action |
| ------------------------- | ---------------------- | ------------------------ |
| payment anomaly visible | Create/forward finance anomaly case. | Approve/reject payment. |
| payment queue backlog | Report backlog and operational impact. | Bypass finance review. |
| payout delay visible | Escalate to Sovereign Finance. | Confirm payout. |
| accounting backlog visible | Flag operational delay and notify finance. | Mark accounting complete. |
| settlement mismatch visible | Raise reconciliation concern. | Resolve settlement directly. |
| financial archive status visible | Identify stuck archive candidate. | Send to financial archive. |
| legal/compliance concern visible | Forward to Sovereign Legal. | Apply legal hold. |
| dispute evidence exists | Preserve/flag evidence reference. | Edit or suppress evidence. |
| consent continuity concern visible | Create support/legal review case. | Continue outreach against consent boundary. |
| finance pipeline closure visible | Monitor operational impact. | Reopen finance pipeline. |

Control Room doctrine:

```text
Control sees risk.
Control raises cases.
Control does not own sovereign truth.
```

---

## 7. Owner Room Relationship

Owner Room governs constitutional legitimacy and high-level authority boundaries. It should not become the sole finance/legal decision-maker.

| Decision | Required Authority | Why |
| -------- | ------------------ | --- |
| ordinary payment approval | Sovereign Finance | Financial evidence decision, not owner strategy. |
| ordinary payment rejection | Sovereign Finance | Financial dispute/user impact requires finance governance. |
| payout confirmation | Sovereign Finance | High-risk financial execution/finality. |
| accounting review completion | Sovereign Finance | Reconciliation authority. |
| refund approval | Sovereign Finance; Owner only for exceptional policy cases | Refunds are finance operations unless policy-changing. |
| settlement policy change | Owner + Sovereign Finance | Changes financial rules, not just one case. |
| financial archive eligibility rule | Sovereign Finance + Sovereign Legal; Owner if policy-level | Financial/legal finality overlap. |
| legal hold | Sovereign Legal | Legal evidence preservation. |
| legal hold affecting platform-wide operations | Owner + Sovereign Legal | Entity-wide operational consequence. |
| compliance policy change | Owner + Sovereign Legal | Constitutional/platform policy impact. |
| tax/legal document policy | Sovereign Legal + Sovereign Finance; Owner for entity policy | Tax/legal/finance overlap. |
| finance pipeline freeze/reopen | Sovereign Finance + Owner for high-risk or broad scope | Closure affects operations and obligations. |
| legal/compliance pipeline freeze/reopen | Sovereign Legal + Owner for broad/high-risk scope | Legal risk plus operational impact. |
| emergency finance containment | Temporary emergency authority + Sovereign Finance + post-review Owner visibility | Damage containment must not become routine bypass. |

Must never be owner-only:

- payout confirmation
- legal hold finality
- settlement correction
- tax/legal document alteration
- audit suppression or deletion
- financial archive rewrite
- sovereign evidence mutation

Owner doctrine:

```text
Owner governs legitimacy.
Sovereign rooms govern domain truth.
Neither may silently rewrite memory.
```

---

## 8. Sovereign vs Operational Boundary

| Action | Operational? | Sovereign? | Why |
| ------ | ------------ | ---------- | --- |
| viewing payment queue | Yes | No, unless sensitive evidence visibility is broad | Queue visibility supports operations. |
| approving payment | No | Yes | Creates financial truth. |
| rejecting payment | No | Yes | Creates financial/user-impacting truth. |
| confirming payout | No | Yes | Financial finality/high-risk obligation. |
| seeing payout delay | Yes | No | Operational signal only. |
| resolving accounting mismatch | No | Yes | Reconciliation truth. |
| viewing accounting backlog | Yes | No | Operational visibility. |
| marking accounting review complete | No | Yes | Settlement readiness impact. |
| archiving financial record | No | Yes | Financial/legal finality. |
| applying legal hold | No | Yes | Legal evidence restriction. |
| viewing legal/compliance concern | Yes, scoped | Yes if evidence-sensitive | Control can see signal, Legal owns action. |
| changing compliance policy | No | Yes + Owner governance | Platform/legal policy impact. |
| creating support case from finance anomaly | Yes | No | Case creation is operational escalation. |
| correcting financial record | No | Yes | Must be finance/audit governed. |
| suppressing/removing evidence | No | Yes, usually forbidden without legal process | Memory and legal integrity risk. |

Boundary rule:

```text
Observation of sovereign risk is operational.
Mutation of sovereign truth is sovereign.
```

---

## 9. Frozen Lines

Current admin lines that must freeze immediately as future expansion sources:

- admin direct payout confirmation
- admin financial archive mutation
- admin accounting finalization
- admin payment approval/rejection expansion
- admin refund authority
- admin settlement authority
- admin legal/compliance authority
- admin tax/legal document mutation
- admin legal hold authority
- admin consent/evidence suppression
- admin finance correction without audit
- admin sovereign pipeline closure/reopen

Freeze doctrine:

```text
Existing compatibility may remain stable.
No new sovereign authority should be added under generic admin.
```

---

## 10. Future Room Shape Options

| Option | Pros | Cons | Risk | Recommendation |
| ------ | ---- | ---- | ---- | -------------- |
| A. Separate Sovereign Finance Room + Separate Sovereign Legal Room | Clean separation, strong scope, clearer audit boundaries, prevents legal/finance confusion. | More navigation and governance overhead. Requires mature authority design. | Medium if created too early; low long-term. | Best long-term target. |
| B. Single Sovereign Room with Finance/Legal tabs | Simpler UX, easier early conceptual grouping, fewer surfaces. | Can blur finance/legal boundaries and create one sovereign super-room. | High if tabs share mutation authority. | Acceptable only as conceptual documentation, not runtime room yet. |
| C. Owner Room sub-sections for Finance/Legal | Easy to centralize governance. | Very likely to make Owner Room a super-admin. Domain expertise gets diluted. | Critical. | Not recommended. |
| D. No UI room yet; backend/system authority only | Avoids premature UI and room authority. Keeps focus on command/audit boundaries. | Harder for humans to reason about future operations without visual separation. | Low now, but incomplete long-term. | Recommended for now. |

Recommendation:

```text
Use Option D now.
Target Option A later.
```

Do not create a finance/legal room yet. First define command, audit, visibility, authority, and freezer boundaries.

---

## 11. First Safe Step

Options:

| Option | Assessment |
| ------ | ---------- |
| A. Create finance/legal room UI | Too early. Risks making a new cockpit before authority is safe. |
| B. Create sovereign command specs | Useful soon, but needs freezer labels first to prevent expansion. |
| C. Create finance/legal freezer labels | Safest first step. It prevents new admin expansion without implementing runtime. |
| D. Create finance/legal authority extraction closeout | Useful after freezer labels. |

Chosen first safe step:

```text
C. Create finance/legal freezer labels
```

Reason:

The most urgent need is to stop future expansion of sovereign authority inside admin. Freezer labels can define what is forbidden, what remains compatibility-only, and which lines require future sovereign command/audit design.

Recommended next wave:

```text
SOVEREIGN-WAVE / FIN-LEGAL-1
Finance & Legal Freezer Labels
```

---

## 12. Final Verdict

Question:

```text
Should Sovereign Finance/Legal become a separate section now,
or remain conceptual until command/audit boundaries exist?
```

Answer:

```text
Remain conceptual until command/audit boundaries exist.
```

Justification:

Creating a Sovereign Finance or Legal UI now would be premature. It could accidentally create a new high-risk cockpit before the platform has:

- sovereign command definitions
- immutable audit requirements
- finance/legal freezer labels
- visibility/redaction boundaries
- reconciliation rules
- rollback/correction doctrine
- owner/sovereign approval matrix
- backend execution boundaries

The correct near-term move is:

```text
separate conceptually
freeze expansion
define command/audit boundaries
then design sovereign surfaces
```

Final doctrine:

```text
Finance and legal authority must leave generic admin,
but sovereign rooms must not be born before sovereign memory and command boundaries exist.
```

---

## Commands Executed By Codex

None

