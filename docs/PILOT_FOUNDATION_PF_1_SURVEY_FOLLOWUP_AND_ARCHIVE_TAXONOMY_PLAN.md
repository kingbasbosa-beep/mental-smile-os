# PILOT-FOUNDATION / PF-1 REPORT
# Pilot Survey + Follow-up Data Plan
# Archive Taxonomy Foundation

Project: Mental Smile  
Era: Pilot Foundation  
Status: Inventory/design only  
Runtime effect: None

---

# PART A — Pilot Survey Data Plan

## A1. Pilot Survey V1 Purpose

Pilot Survey V1 should collect structured pilot feedback without pretending a mature survey runtime already exists.

The survey should support:

- technical feedback
- trust feedback
- operations feedback
- support feedback
- content/library feedback
- legal/rights feedback

Pilot Survey V1 should be simple enough to run manually or through an external/manual tool if in-app survey runtime is not confirmed before launch.

## A2. Recommended Survey Structure

| Section | Purpose | Example Question Direction | Primary Owner |
| ------- | ------- | -------------------------- | ------------- |
| technical feedback | Discover app/runtime issues. | Did anything fail, block, confuse, or slow you? | Technical |
| trust feedback | Evaluate verification confidence. | Did the center/clinician verification feel clear and fair? | Trust & Verification |
| operations feedback | Understand booking/registration workflow. | Was the process understandable and complete? | Control Lite / Operations |
| support feedback | Evaluate follow-up and support continuity. | Did support feel respectful and useful? | Support Continuity |
| content/library feedback | Evaluate content usefulness and safety. | Was content clear, helpful, and trustworthy? | Library Governance |
| legal/rights feedback | Track consent, privacy, and rights concerns. | Did you understand consent, data use, and your choices? | Legal + Owner delegate |

## A3. Respondent Type Map

| Respondent Type | Survey Scope | Notes |
| --------------- | ------------ | ----- |
| client | registration, support, content, rights, experience | Sensitive answers may require anonymization option. |
| clinician | verification, app workflow, trust, content, support | Useful for trust and operational readiness. |
| center | center verification, operations, support, finance-adjacent concerns | Center feedback may include organizational data. |
| internal operator | admin/control usability, process risks, manual burden | Useful for pilot readiness and governance gaps. |
| owner/development reviewer | technical/governance observations | Should be separated from participant feedback. |

## A4. Answer Type Map

| Answer Type | Use | Storage Target | Archive Target |
| ----------- | --- | -------------- | -------------- |
| rating scale | quick trend analysis | manual/external survey export or future survey answers | Pilot analysis package |
| yes/no | consent/clarity/completion checks | manual/external survey export | Pilot analysis package |
| multiple choice | categorization | manual/external survey export | Pilot analysis package |
| short text | qualitative feedback | manual/external survey export with privacy review | Redacted pilot package if sensitive |
| issue report | operational defect/risk | Control Lite report / technical note | Technical + Pilot archive |
| rights concern | privacy/consent/legal signal | Legal/Owner delegated review | Legal/governance archive |
| support concern | continuity/support issue | Support Continuity report | Support pilot package |

## A5. What Must Be Platform-Held

Must be platform-held or formally archived if collected:

- submitted survey response timestamp
- respondent type
- survey version
- consent/anonymity choice
- rights/legal concern
- support escalation concern
- technical defect report
- final survey analysis package
- human review summary
- AI analysis summary if used
- comparison layer notes
- recommendations

## A6. What May Be Exported

May be exported:

- raw survey response CSV/spreadsheet
- anonymized response summary
- respondent-safe feedback summaries
- pilot analysis package
- department recommendation package

Exports must preserve confidentiality and anonymity promises.

## A7. What May Remain Manual

May remain manual during pilot:

- survey tool selection
- response export
- manual anonymization review
- human analysis summary
- AI-assisted summary
- department recommendation mapping
- archive package creation

Manual is acceptable if the archive is disciplined.

---

# PART B — Pilot Follow-up Data Plan

## B1. Minimum Follow-up Dataset

| Category | Minimum Data | Must Retain? | Archive Treatment |
| -------- | ------------ | ------------ | ----------------- |
| consent | consent status, consent timestamp, allowed channel, opt-out state | Yes | Consent evidence summary in pilot package |
| communication | date/time, channel, message type, template/campaign reference | Yes | Follow-up activity log |
| response | responded/no response, response category, response timestamp | Yes | Follow-up outcome summary |
| escalation | escalation created, reason, linked support/chat case, status | Yes if escalation occurs | Support/control archive |
| outcome | completed, pending, opted out, escalated, closed | Yes | Pilot follow-up report |

## B2. Follow-up Data Boundaries

Must be retained:

- consent status
- opt-out status
- outreach timestamp
- channel used
- response status
- escalation status
- closure outcome

Must be archived:

- weekly follow-up summary
- consent exceptions
- escalation cases
- unresolved follow-up items
- participant complaints about outreach

May remain operational only:

- draft message text before sending
- internal scheduling reminders
- non-sensitive operator notes not used for decisions

Must not be casual:

- consent changes
- opt-outs
- support escalation
- rights complaints
- distress signals

Follow-up doctrine:

```text
Follow-up may support continuity.
It must not become pressure, therapy continuation, or emotional ownership.
```

---

# PART C — Pilot Analysis Package

## C1. Package Flow

```text
Survey / Follow-up Data
↓
Human Analysis
↓
AI Analysis
↓
Comparison Layer
↓
Recommendation Layer
↓
Archive Package
```

## C2. Human Analysis

Human analysis must review:

- context
- emotional sensitivity
- rights/consent concerns
- operational feasibility
- participant harm signals
- trust implications
- content risks

## C3. AI Analysis

AI analysis may assist with:

- summarization
- clustering feedback
- identifying repeated issues
- drafting category summaries
- comparing sentiment and themes

AI must not decide pilot success, user risk, legal outcome, or operational enforcement.

## C4. Comparison Layer

The comparison layer records:

- where AI and human analysis agree
- where they disagree
- what human reviewer accepted/rejected
- what requires owner review
- what requires technical/support/trust/legal review

## C5. Recommendation Layer

Recommendations should be grouped by:

- technical
- trust
- support
- content/library
- legal/rights
- operations
- archive/process

Each recommendation should include:

- evidence source
- severity
- owner/department
- pilot impact
- next action

## C6. Archive Package

The archive package should include:

- survey version
- response count
- respondent types
- raw/exported data reference
- human analysis
- AI analysis if used
- comparison notes
- recommendations
- unresolved issues
- follow-up outcomes
- escalation summary
- owner review notes

---

# PART D — Archive Taxonomy Foundation

Top-level archive domains:

| Domain | Purpose |
| ------ | ------- |
| CONSTITUTION | Highest governing documents and amendments. |
| GOVERNANCE | Governance topology, maturity, reviews, decision packages. |
| TRUST | Verification, approvals, appeals, document review summaries. |
| CONTROL | Monitoring, complaints, disputes, reports, operational signals. |
| SUPPORT | Support continuity, follow-up, escalation, humane continuity records. |
| LIBRARY | Content, publication, knowledge assets, review notes. |
| FINANCE | Finance governance, payment/payout/accounting reports, freezer docs. |
| LEGAL | Compliance, retention, legal/rights, disputes, consent governance. |
| TECHNICAL | Technical audits, runtime inventories, implementation reports. |
| ANALYTICS | Survey analysis, metrics, summaries, trend reports. |
| ARCHIVE | Archive indexes, backup manifests, package registers. |
| PILOT | Pilot planning, execution, data, analysis, closeout. |
| WAVES | Grounding, sovereign, exploration, construction wave reports. |
| MIGRATIONS | Future migration plans and records. |
| EXTRACTIONS | Admin authority extraction, route/data extraction maps. |

Archive doctrine:

```text
Archive taxonomy exists to preserve institutional memory,
not to create paperwork for its own sake.
```

---

# PART E — Label Registry

| Label | Purpose | Owner | Archive Location | Maturity Level |
| ----- | ------- | ----- | ---------------- | -------------- |
| CONSTITUTION | Supreme governing documents. | Owner Room | `/constitution` | Level 2 |
| CONSTITUTION_V1 | Historical founding constitution. | Owner Room | `/constitution` | Level 2 |
| CONSTITUTION_V2 | Current supreme constitution. | Owner Room | `/constitution` | Level 2 |
| PILOT | Pilot foundation/execution records. | Owner + Control Lite | `/pilot` | Level 1 |
| PILOT_SURVEY | Survey data/plans/packages. | Analytics delegate | `/pilot` or `/analytics` | Level 1 |
| PILOT_FOLLOWUP | Follow-up pilot data/plans. | Support Continuity delegate | `/pilot` or `/support` | Level 1 |
| PILOT_ANALYSIS | Human/AI/comparison analysis. | Analytics + Owner | `/pilot` or `/analytics` | Level 1 |
| TRUST | Trust governance records. | Trust & Verification | `/trust` | Level 1 |
| TRUST_VERIFICATION | Center/clinician verification records. | Trust & Verification | `/trust` | Level 1 |
| CONTROL | Control Room/Control Lite records. | Control Lite | `/control` | Level 1 |
| CONTROL_REPORT | Monitoring/reporting outputs. | Control Lite | `/control` | Level 1 |
| SUPPORT | Support records. | Support Continuity | `/support` | Level 1 |
| SUPPORT_CONTINUITY | Follow-up and continuity reports. | Support Continuity | `/support` | Level 1 |
| ARCHIVE | Archive governance and indexes. | Knowledge & Archive Office | `/archive` | Level 1 |
| ARCHIVE_PACKAGE | Quarterly/pilot/governance packages. | Knowledge & Archive Office | `/archive` | Level 1 |
| ANALYTICS | Metrics and analysis. | Analytics delegate | `/analytics` | Level 1 |
| ANALYTICS_REPORT | Analysis reports. | Analytics delegate | `/analytics` | Level 1 |
| WAVE | Grounding/exploration wave documents. | Knowledge & Archive Office | `/waves` | Level 1 |
| EXTRACTION | Extraction maps and reports. | Owner + Technical | `/extractions` | Level 1 |
| MIGRATION | Future migration plans/records. | Technical | `/migrations` | Level 0 |
| TECHNICAL_AUDIT | Technical inventory/audit reports. | Technical | `/technical` | Level 1 |
| FINANCE | Finance governance records. | Finance delegate | `/finance` | Level 0-1 |
| LEGAL | Legal/compliance records. | Legal delegate | `/legal` | Level 0-1 |
| HR | Staffing/policy records. | Legal + HR delegate | `/legal` or `/governance` | Level 0 |
| OWNER | Owner ratification/governance records. | Owner Room | `/governance` | Level 1 |
| DELEGATED | Temporary responsibility records. | Owner + Archive | `/governance` | Level 1 |
| LIBRARY | Library/content governance. | Library Governance | `/library` | Level 1 |
| CONTENT_REVIEW | Publication/content review records. | Marketing & Content | `/library` | Level 1 |
| RIGHTS | Consent/privacy/rights concerns. | Legal delegate | `/legal` | Level 0-1 |
| CONSENT | Consent evidence and policies. | Legal + Support | `/legal` or `/support` | Level 0-1 |
| QUARTERLY_REVIEW | Quarterly governance package. | Owner + Archive | `/governance` and `/archive` | Level 1 |

---

# PART F — Document Ownership Map

| Document Category | Who Creates It? | Who Reviews It? | Who Receives It? | Who Archives It? | Who Owns It? |
| ----------------- | --------------- | --------------- | ---------------- | ---------------- | ------------ |
| surveys | Analytics delegate / Owner during pilot | Owner + relevant department delegate | Owner, Technical, Trust, Support as relevant | Knowledge & Archive Office | Analytics delegate |
| analyses | Human reviewer + AI assistance if used | Owner + comparison reviewer | Owner + relevant department | Knowledge & Archive Office | Analytics / Owner |
| follow-up reports | Support Continuity delegate | Owner + Legal if consent-sensitive | Owner + Control Lite | Knowledge & Archive Office | Support Continuity |
| trust decisions | Trust & Verification delegate | Owner for appeals/high-risk | Owner, Control Lite, affected party where appropriate | Knowledge & Archive Office | Trust & Verification |
| governance reports | Control Lite / departments | Owner | Owner Room | Knowledge & Archive Office | Owner Room |
| constitutional reports | Owner / Development / Archive delegate | Owner | All future governance units | Knowledge & Archive Office | Owner Room |
| migration reports | Technical | Owner + Archive | Owner + Technical | Knowledge & Archive Office | Technical |
| extraction reports | Owner + Technical | Owner | Owner + future rooms/departments | Knowledge & Archive Office | Owner Room |
| quarterly reviews | Knowledge & Archive Office | Owner | Owner + governance units | Knowledge & Archive Office | Owner Room |
| pilot closeouts | Owner + Control Lite + Technical | Owner | governance units | Knowledge & Archive Office | Owner Room |

---

# PART G — Existing Docs Classification

| Document Family | Classification | Notes |
| --------------- | -------------- | ----- |
| Constitution V1 | KEEP | Historical constitutional baseline, superseded by V2. |
| Constitution V2 | KEEP | Current highest constitutional reference. |
| MASTER-1 | KEEP | Reconciliation and construction realism source. |
| MASTER-2 | KEEP | Governance topology source. |
| MASTER-3 | KEEP | Construction program source. |
| Grounding Waves | KEEP | Technical grounding history and implementation context. |
| Extraction Waves | KEEP | Authority and data extraction history. |
| Sovereign Reports | KEEP | Finance/legal boundary and memory doctrine. |
| Freeze Reports | KEEP | Legacy/freezer governance history. |
| Audit Reports | KEEP | Audit/protected memory doctrine source. |
| Exploration Waves | FUTURE_MERGE | Useful source material; may later be summarized into archive packages. |
| W5/Wave implementation docs | KEEP | Runtime change history. |
| Closeout reports | KEEP | Wave completion evidence. |
| Legacy aliases docs | FREEZE | Keep until burial verification. |
| Duplicate future doctrine drafts | FUTURE_MERGE | Merge into quarterly or constitutional packages later. |

No files should be renamed, buried, or merged during PF-1.

---

# PART H — Future Archive Structure

Target conceptual structure:

```text
/constitution
/governance
/trust
/control
/support
/library
/technical
/finance
/legal
/analytics
/archive
/pilot
/waves
/extractions
/migrations
```

Mapping:

| Document Family | Target Archive Domain |
| --------------- | --------------------- |
| Constitution V1/V2 | `/constitution` |
| MASTER reports | `/governance` and `/constitution` |
| Grounding Waves | `/waves` and `/technical` |
| Extraction Waves | `/extractions` |
| Sovereign Reports | `/finance`, `/legal`, `/governance` |
| Freeze Reports | `/governance`, `/extractions` |
| Audit Reports | `/archive`, `/governance`, `/technical` |
| Pilot Foundation | `/pilot` |
| Survey Plans/Analysis | `/pilot`, `/analytics` |
| Follow-up Plans/Reports | `/pilot`, `/support` |
| Trust Verification | `/trust` |
| Control Reports | `/control` |
| Technical Audits | `/technical` |
| Migration Plans | `/migrations` |

This is conceptual only. No folders should be created by this plan.

---

# PART I — Naming Standard

## I1. Prefix Standard

Future documents should use clear prefixes:

```text
CONSTITUTION_*
MASTER_*
PILOT_*
TRUST_*
CONTROL_*
SUPPORT_*
LIBRARY_*
ANALYTICS_*
ARCHIVE_*
WAVE_*
EXTRACTION_*
MIGRATION_*
TECHNICAL_*
FINANCE_*
LEGAL_*
```

## I2. Naming Rules

Rules:

- Use uppercase domain prefix.
- Include wave/stage identifier when relevant.
- Include short purpose.
- Include version only when document supersedes prior reference.
- Avoid vague names like `notes`, `final`, `new`, `updated`.
- Do not rename old documents during active pilot unless necessary.
- Closeout documents should end with `CLOSEOUT`.
- Inventory documents should include `INVENTORY`.
- Plans should include `PLAN`.
- Specifications should include `SPECIFICATION`.
- Checklists should include `CHECKLIST`.

Examples:

```text
PILOT_SURVEY_V1_PLAN.md
PILOT_FOLLOWUP_WEEKLY_REPORT_TEMPLATE.md
TRUST_VERIFICATION_PILOT_CHECKLIST.md
ANALYTICS_PILOT_SURVEY_ANALYSIS_PACKAGE.md
ARCHIVE_QUARTERLY_PACKAGE_INDEX.md
```

---

# PART J — Archive Readiness Assessment

## J1. Already Organized

Already organized:

- constitutional documents
- MASTER documents
- grounding wave reports
- extraction/sovereign reports
- freezer and audit doctrine documents
- pilot foundation documents beginning now

## J2. Duplicated

Possible duplication:

- Constitution V1 vs V2
- MASTER reports vs V2
- multiple exploration reports feeding the same doctrine
- freezer doctrine across several waves
- audit/protected memory doctrine across general and sovereign docs

Duplication is acceptable temporarily because it preserves discovery history.

## J3. Legacy

Legacy document categories:

- early freeze reports superseded by later registries
- exploration waves superseded by MASTER and Constitution V2
- route/admin legacy maps superseded by extraction maps

Do not delete. Preserve as history.

## J4. Should Never Be Created Again

Avoid:

- undocumented final decisions
- unnamed scratch governance docs
- implementation without closeout
- pilot data without archive package
- AI summaries without human comparison
- finance/legal decisions without memory category
- follow-up reports without consent status

## J5. Missing Labels

Missing or newly required labels:

- PILOT_FOLLOWUP
- RIGHTS
- CONSENT
- CONTENT_REVIEW
- QUARTERLY_REVIEW

## J6. Missing Archive Domains

Potentially missing or immature domains:

- `/pilot`
- `/analytics`
- `/archive`
- `/trust`
- `/support`

These may remain conceptual until archive execution begins.

---

# PART K — Final Verdict

## Pilot Data Verdict

Pilot survey and follow-up data can proceed if treated as a disciplined manual/archive-backed process, not as mature runtime.

Minimum safe rule:

```text
No pilot feedback without version, timestamp, respondent type, analysis, and archive package.
```

## Follow-up Verdict

Follow-up can support pilot continuity only if consent and outcome tracking are explicit.

Minimum safe rule:

```text
No follow-up without consent status and closure outcome.
```

## Archive Verdict

Documentation is currently the strongest archive. That is acceptable for pilot if archive packages are deliberate and labeled.

Minimum safe rule:

```text
Manual archive is valid only when it is structured, owned, and reviewable.
```

## Label Verdict

The label registry is sufficient for pilot documentation discipline. It should be used before creating more documents, reports, or packages.

## Recommended Next Step

Chosen option:

```text
Option A: Pilot Trust Verification Checklist
```

Justification:

PF-0 found center and clinician verification are the most immediately pilot-capable lines, but they require manual discipline. PF-1 now gives survey/follow-up/archive structure. The next safest pilot action is to create the checklist that makes center and clinician verification consistent, fair, and reviewable before participants enter the pilot.

---

## Commands Executed By Codex

None

