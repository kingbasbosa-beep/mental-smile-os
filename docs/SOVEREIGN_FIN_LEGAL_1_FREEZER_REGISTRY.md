# SOVEREIGN-WAVE / FIN-LEGAL-1 REPORT
# Finance & Legal Freezer Registry

Project: Mental Smile  
Era: Sovereign Finance & Legal Separation  
Status: Freezer registry only  
Runtime effect: None

---

## 1. Executive Summary

Finance and legal authority are frozen as future expansion sources inside generic admin.

This does not mean existing compatibility behavior is deleted. It means no new finance, legal, payout, settlement, archive finality, compliance, or sovereign evidence authority should be added under `/admin/*`.

The separation remains conceptual because Mental Smile does not yet have:

- sovereign command runtime
- immutable audit runtime
- backend execution boundary
- finance/legal approval matrix in runtime
- sovereign room visibility/redaction model
- reconciliation ledger
- rollback/correction/compensation model

Current rule:

```text
Admin may remain compatibility.
Admin must not accumulate new sovereign authority.
```

Finance and legal authority must be classified now so future work can move deliberately instead of allowing the old admin cockpit to grow deeper roots.

---

## 2. Freezer Labels

| Label | Meaning |
| ----- | ------- |
| ACTIVE_STABLE | Existing runtime behavior remains stable and may receive narrow bug fixes. |
| FROZEN_NO_EXPANSION | Existing behavior may remain, but no new authority or scope may be added. |
| DANGEROUS_SHARED_AUTHORITY | Authority is mixed across admin/finance/legal/operations and must be separated. |
| SOVEREIGN_FINANCE_CANDIDATE | Future owner should be Sovereign Finance. |
| SOVEREIGN_LEGAL_CANDIDATE | Future owner should be Sovereign Legal. |
| SOVEREIGN_FINANCE_LEGAL_CANDIDATE | Future boundary requires both finance and legal treatment. |
| COMMAND_REQUIRED_FUTURE | Future mutation must become command-governed. |
| AUDIT_REQUIRED_FUTURE | Future mutation must require immutable audit. |
| CONTROL_VISIBLE_ONLY | Control Room may see status/anomaly, not mutate. |
| OWNER_APPROVAL_REQUIRED | Owner approval required for policy-level or broad high-risk decisions. |
| BACKEND_EXECUTION_REQUIRED | Future execution should not be client/admin-owned. |
| BURIAL_CANDIDATE | Legacy path may later be removed after verification and replacement. |

---

## 3. Finance Authority Registry

| Authority | Current Location | Risk | Labels | Future Owner |
| --------- | ---------------- | ---- | ------ | ------------ |
| payment approval | Admin payment/booking paths, `approvePayment`-style adapter authority | Critical | FROZEN_NO_EXPANSION, DANGEROUS_SHARED_AUTHORITY, SOVEREIGN_FINANCE_CANDIDATE, COMMAND_REQUIRED_FUTURE, AUDIT_REQUIRED_FUTURE, BACKEND_EXECUTION_REQUIRED | Sovereign Finance |
| payment rejection | Admin payment/booking paths, `rejectPayment`-style adapter authority | Critical | FROZEN_NO_EXPANSION, DANGEROUS_SHARED_AUTHORITY, SOVEREIGN_FINANCE_CANDIDATE, COMMAND_REQUIRED_FUTURE, AUDIT_REQUIRED_FUTURE, BACKEND_EXECUTION_REQUIRED | Sovereign Finance |
| accounting review | Admin accounting paths, `confirmCenterAccountingReview` authority | Critical | FROZEN_NO_EXPANSION, DANGEROUS_SHARED_AUTHORITY, SOVEREIGN_FINANCE_CANDIDATE, COMMAND_REQUIRED_FUTURE, AUDIT_REQUIRED_FUTURE, BACKEND_EXECUTION_REQUIRED | Sovereign Finance |
| payout confirmation | Admin booking/payment paths, center/clinician payout confirmation | Critical | FROZEN_NO_EXPANSION, DANGEROUS_SHARED_AUTHORITY, SOVEREIGN_FINANCE_CANDIDATE, COMMAND_REQUIRED_FUTURE, AUDIT_REQUIRED_FUTURE, BACKEND_EXECUTION_REQUIRED | Sovereign Finance |
| settlement readiness | Implied through payment/accounting/payout lifecycle fields | Critical | FROZEN_NO_EXPANSION, SOVEREIGN_FINANCE_CANDIDATE, AUDIT_REQUIRED_FUTURE, BACKEND_EXECUTION_REQUIRED | Sovereign Finance |
| refunds | Present/future refund-like authority, not confirmed as separated | Critical | FROZEN_NO_EXPANSION, SOVEREIGN_FINANCE_CANDIDATE, COMMAND_REQUIRED_FUTURE, AUDIT_REQUIRED_FUTURE, OWNER_APPROVAL_REQUIRED for policy-level refunds | Sovereign Finance |
| commission logic | Finance/accounting-derived calculation logic if present/future | High | FROZEN_NO_EXPANSION, SOVEREIGN_FINANCE_CANDIDATE, AUDIT_REQUIRED_FUTURE, BACKEND_EXECUTION_REQUIRED | Sovereign Finance + Backend/System Authority |
| financial archive | Admin financial archive transition paths | Critical | FROZEN_NO_EXPANSION, SOVEREIGN_FINANCE_LEGAL_CANDIDATE, COMMAND_REQUIRED_FUTURE, AUDIT_REQUIRED_FUTURE, BACKEND_EXECUTION_REQUIRED | Sovereign Finance + Sovereign Legal |
| finance correction | Future correction of financial decisions | Critical | FROZEN_NO_EXPANSION, SOVEREIGN_FINANCE_CANDIDATE, COMMAND_REQUIRED_FUTURE, AUDIT_REQUIRED_FUTURE, OWNER_APPROVAL_REQUIRED for broad impact | Sovereign Finance |
| reconciliation | Future settlement/accounting mismatch handling | Critical | FROZEN_NO_EXPANSION, SOVEREIGN_FINANCE_CANDIDATE, AUDIT_REQUIRED_FUTURE, BACKEND_EXECUTION_REQUIRED | Sovereign Finance |
| finance anomaly visibility | Admin/control dashboards and queue signals | Medium | CONTROL_VISIBLE_ONLY, ACTIVE_STABLE | Control Room observe-only; Sovereign Finance owns action |

---

## 4. Legal Authority Registry

| Authority | Current Location | Risk | Labels | Future Owner |
| --------- | ---------------- | ---- | ------ | ------------ |
| legal holds | Future/legal-adjacent authority if added under admin | Critical | FROZEN_NO_EXPANSION, SOVEREIGN_LEGAL_CANDIDATE, COMMAND_REQUIRED_FUTURE, AUDIT_REQUIRED_FUTURE, OWNER_APPROVAL_REQUIRED for broad scope | Sovereign Legal |
| compliance evidence | System/admin/compliance-adjacent evidence | High | FROZEN_NO_EXPANSION, SOVEREIGN_LEGAL_CANDIDATE, AUDIT_REQUIRED_FUTURE | Sovereign Legal |
| contracts | Future contract authority if added | Critical | FROZEN_NO_EXPANSION, SOVEREIGN_LEGAL_CANDIDATE, AUDIT_REQUIRED_FUTURE, OWNER_APPROVAL_REQUIRED | Sovereign Legal |
| dispute evidence | Support/chat/payment/session evidence used in disputes | High | FROZEN_NO_EXPANSION, SOVEREIGN_LEGAL_CANDIDATE, AUDIT_REQUIRED_FUTURE, CONTROL_VISIBLE_ONLY for signal | Sovereign Legal |
| retention policy | Archive and evidence retention rules | Critical | FROZEN_NO_EXPANSION, SOVEREIGN_LEGAL_CANDIDATE, OWNER_APPROVAL_REQUIRED, AUDIT_REQUIRED_FUTURE | Sovereign Legal + Owner |
| tax/legal documents | Tax/legal document authority if present/future | Critical | FROZEN_NO_EXPANSION, SOVEREIGN_FINANCE_LEGAL_CANDIDATE, AUDIT_REQUIRED_FUTURE | Sovereign Legal + Sovereign Finance |
| legal archive | Archive finality with legal implications | Critical | FROZEN_NO_EXPANSION, SOVEREIGN_LEGAL_CANDIDATE, COMMAND_REQUIRED_FUTURE, AUDIT_REQUIRED_FUTURE, BACKEND_EXECUTION_REQUIRED | Sovereign Legal |
| legal risk review | Legal/compliance concern classification | High | FROZEN_NO_EXPANSION, SOVEREIGN_LEGAL_CANDIDATE, OWNER_APPROVAL_REQUIRED for platform impact | Sovereign Legal |
| consent evidence | External follow-up and continuity consent evidence | High | FROZEN_NO_EXPANSION, SOVEREIGN_LEGAL_CANDIDATE, AUDIT_REQUIRED_FUTURE, CONTROL_VISIBLE_ONLY for signal | Sovereign Legal + Support/Continuity Governance |

---

## 5. Shared Sovereign Lines

| Authority | Why Shared | Risk | Future Boundary |
| --------- | ---------- | ---- | --------------- |
| financial archive | Combines financial finality with retention/legal memory. | Critical | Finance approves financial eligibility; Legal governs retention/finality; backend executes; audit records. |
| settlement disputes | Financial disagreement may become legal dispute. | Critical | Finance owns reconciliation; Legal owns dispute/evidence; Owner governs policy impact. |
| refund disputes | Refund decision is financial, but dispute evidence and obligation can be legal. | High | Finance decides refund; Legal reviews dispute/legal risk; audit required. |
| compliance evidence | Compliance may affect finance, legal, tenant trust, and archive. | High | Legal owns evidence policy; Finance owns financial consequence; Control sees signals only. |
| audit-linked financial actions | Financial actions require legally defensible memory. | Critical | Finance executes/governs financial decision; Legal defines evidence/retention; Audit immutable. |
| tax/legal documents | Tax records are financial and legal. | Critical | Finance owns financial data; Legal owns document legality and retention. |
| payout correction | Correction affects financial obligation and possible legal dispute. | Critical | Finance owns correction; Legal reviews dispute/impact; Owner if broad policy issue. |

Shared boundary law:

```text
Finance decides money truth.
Legal protects evidence, retention, and liability truth.
Neither may silently rewrite audit memory.
```

---

## 6. Control Room Visibility Registry

| Signal | Visible To Control? | Can Mutate? | Notes |
| ------ | ------------------- | ----------- | ----- |
| payment anomaly | Yes | No | Control may create/forward finance case. |
| payment queue backlog | Yes | No | Visibility only; finance owns approval/rejection. |
| payment rejected/approved count | Yes, aggregated/scoped | No | Avoid exposing sensitive evidence unnecessarily. |
| payout delay | Yes | No | Control may escalate delay impact. |
| payout confirmation status | Yes, scoped | No | No payout mutation under Control. |
| accounting backlog | Yes | No | Control may report operational bottleneck. |
| settlement mismatch | Yes, as anomaly | No | Finance/legal own reconciliation/dispute. |
| financial archive stuck | Yes | No | Control may raise archive case. |
| legal/compliance concern | Yes, signal only | No | Legal owns action. |
| legal hold status | Limited/scoped | No | Visibility depends on legal sensitivity. |
| consent evidence issue | Yes, redacted signal | No | Support/Legal review required. |
| dispute evidence exists | Yes, redacted signal | No | Legal owns evidence handling. |
| finance/legal closure status | Yes | No | Control tracks operational impact. |

Visibility rule:

```text
Visible often yes.
Mutation almost always no.
```

---

## 7. Owner Approval Registry

| Decision Category | Owner Only | Finance Only | Legal Only | Owner + Finance | Owner + Legal | Owner + Finance + Legal |
| ----------------- | ---------- | ------------ | ---------- | --------------- | ------------- | ----------------------- |
| ordinary payment approval/rejection | No | Yes | No | No | No | No |
| payout confirmation | No | Yes | No | Only if broad/exceptional | No | No |
| accounting review completion | No | Yes | No | Only if policy-level | No | No |
| finance correction for one record | No | Yes | No | If broad impact | If legal dispute | If legal/financial broad impact |
| settlement policy change | No | No | No | Yes | No | Sometimes |
| refund policy change | No | No | No | Yes | If legal implications | Sometimes |
| legal hold on one case | No | No | Yes | No | If broad impact | No |
| platform-wide legal hold | No | No | No | No | Yes | If financial implications |
| retention policy change | No | No | No | No | Yes | If financial/tax archive impact |
| financial archive eligibility rule | No | No | No | Yes | Yes | Prefer joint if legal retention involved |
| tax/legal document policy | No | No | No | Yes | Yes | Yes |
| finance pipeline freeze/reopen | No | No | No | Yes | If legal impact | Sometimes |
| legal/compliance pipeline freeze/reopen | No | No | No | If financial impact | Yes | Sometimes |
| audit suppression/deletion | Forbidden | Forbidden | Forbidden | Forbidden | Forbidden | Forbidden |

Owner-only decisions should be rare and mostly policy/strategy decisions. Owner must not become the sovereign executor.

---

## 8. Frozen Expansion Rules

### Finance No-Expansion Rules

- No new finance authority under generic admin.
- No new payment approval/rejection authority under generic admin.
- No new payout authority under generic admin.
- No new settlement authority under generic admin.
- No new refund authority under generic admin.
- No new accounting finalization under generic admin.
- No new financial correction path without future command/audit design.
- No new financial archive finality under generic admin.

### Legal No-Expansion Rules

- No new legal authority under generic admin.
- No new legal hold authority under generic admin.
- No new compliance mutation under generic admin.
- No new contract authority under generic admin.
- No new tax/legal document mutation under generic admin.
- No new evidence suppression/removal authority under generic admin.
- No new retention policy mutation under generic admin.

### Control Room Rules

- Control may see finance/legal signals only by scope.
- Control may create or forward cases.
- Control may not approve, reject, confirm, archive, hold, suppress, settle, or correct sovereign truth.

### Owner Rules

- Owner may govern policy and high-risk legitimacy.
- Owner must not directly execute routine finance/legal truth.
- Owner must not be the only key for sovereign mutation.

---

## 9. Extraction Readiness

| Authority | Extraction Readiness |
| --------- | -------------------- |
| payment approval | NEEDS_COMMAND_SPEC |
| payment rejection | NEEDS_COMMAND_SPEC |
| accounting review | NEEDS_COMMAND_SPEC |
| payout confirmation | NEEDS_COMMAND_SPEC |
| settlement readiness | NEEDS_AUDIT_SPEC |
| refunds | NEEDS_COMMAND_SPEC |
| commission logic | NEEDS_BACKEND_BOUNDARY |
| financial archive | NEEDS_AUDIT_SPEC |
| finance correction | NEEDS_AUDIT_SPEC |
| reconciliation | NEEDS_AUDIT_SPEC |
| finance anomaly visibility | READY |
| legal holds | NEEDS_COMMAND_SPEC |
| compliance evidence | NEEDS_AUDIT_SPEC |
| contracts | BLOCKED |
| dispute evidence | NEEDS_AUDIT_SPEC |
| retention policy | NEEDS_AUDIT_SPEC |
| tax/legal documents | BLOCKED |
| legal archive | NEEDS_AUDIT_SPEC |
| legal risk review | READY |
| consent evidence | NEEDS_AUDIT_SPEC |

Readiness summary:

```text
Visibility separation is ready to define.
Mutation separation is not ready to execute.
Finance/legal execution needs command and audit boundaries first.
```

---

## 10. Future Dependency Map

| Authority | Command Runtime | Audit Runtime | Backend Execution | Owner Governance | Finance Governance | Legal Governance |
| --------- | --------------- | ------------- | ----------------- | ---------------- | ------------------ | ---------------- |
| payment approval | Required | Required | Required | Policy-level only | Required | Optional if dispute/legal risk |
| payment rejection | Required | Required | Required | Policy-level only | Required | Optional if dispute/legal risk |
| accounting review | Required | Required | Required | Policy-level only | Required | Optional |
| payout confirmation | Required | Required | Required | Exceptional/broad only | Required | Optional if dispute/legal issue |
| settlement readiness | Required | Required | Required | Policy-level | Required | Optional |
| refunds | Required | Required | Required | Policy-level/exceptional | Required | Required for disputes |
| commission logic | Optional as command, required as governed calculation | Required | Required | Policy-level | Required | Optional |
| financial archive | Required | Required | Required | Policy-level | Required | Required |
| finance correction | Required | Required | Required | Broad/exceptional | Required | If dispute/legal impact |
| reconciliation | Required | Required | Required | Policy-level if broad | Required | If dispute/legal impact |
| legal holds | Required | Required | Required | Broad/platform impact | Optional | Required |
| compliance evidence | Optional as command, required as audit/registry | Required | Optional/required by action | Required for policy | Optional | Required |
| contracts | Required if workflow exists | Required | Required | Required | If financial contract | Required |
| dispute evidence | Optional as command | Required | Optional | If policy/platform impact | If financial dispute | Required |
| retention policy | Registry/policy command required | Required | Backend enforcement later | Required | If financial retention | Required |
| tax/legal documents | Required | Required | Required | Required for policy | Required | Required |
| legal archive | Required | Required | Required | Policy-level | If financial archive | Required |
| legal risk review | Optional as case command | Required | Optional | Required if platform impact | If financial issue | Required |
| consent evidence | Optional as case command | Required | Optional | Policy-level | No | Required |

---

## 11. Recommended Next Wave

Options:

| Option | Assessment |
| ------ | ---------- |
| A. Finance Command Specification | Useful, but too early without audit boundaries for sovereign-grade finance. |
| B. Legal Command Specification | Useful later; legal authority is less concretely implemented than finance today. |
| C. Finance/Legal Audit Boundary Specification | Best next step. Finance/legal cannot safely separate without memory, retention, redaction, and correction rules. |
| D. Owner Room Boundary Exploration | Important, but sovereign audit requirements should be clearer first. |

Recommendation:

```text
Option C: Finance/Legal Audit Boundary Specification
```

Justification:

Finance and legal actions are not safe because they are high-risk, hard to roll back, and often dispute-sensitive. Before command specs define how action is requested, the project needs to define what must be remembered, who can see it, what cannot be mutated, and how corrections differ from history rewriting.

Recommended next wave:

```text
SOVEREIGN-WAVE / FIN-LEGAL-2
Finance & Legal Audit Boundary Specification
```

---

## 12. Final Verdict

Question:

```text
What must happen before
Sovereign Finance Room
or
Sovereign Legal Room
can safely exist?
```

Checklist:

- Finance/legal freezer labels exist and are accepted.
- Sovereign visibility boundaries are defined.
- Control Room observe-only finance/legal signals are defined.
- Owner vs Finance vs Legal approval matrix is defined.
- Finance/legal audit boundary specification exists.
- Immutable audit requirements are defined for payment, payout, accounting, archive, dispute, and legal evidence.
- Redaction and retention rules are defined.
- Command specifications exist for payment approval/rejection, accounting review, payout confirmation, financial archive, legal hold, and correction flows.
- Backend execution boundary is defined.
- Reconciliation and correction doctrine exists.
- Rollback vs correction vs compensation doctrine exists.
- No generic admin expansion of finance/legal authority is allowed.
- No room UI is created before authority, audit, and command boundaries are understood.

Final doctrine:

```text
Sovereign rooms may not be born as new cockpits.
They must be born after sovereign memory, authority, and execution boundaries exist.
```

---

## Commands Executed By Codex

None

