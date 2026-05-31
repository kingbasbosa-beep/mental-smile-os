# PILOT-FOUNDATION / PF-2 REPORT
# Pilot Trust Verification Checklist

Project: Mental Smile  
Era: Pilot Foundation  
Status: Checklist / governance discipline only  
Runtime effect: None

---

# PART A — Trust Function Reality

## A1. Current Trust Reality

During the pilot, trust verification is a function, not a mature department.

Current reality:

- verification is founder-led or founder-supervised.
- review is manual.
- some pilot centers/clinicians may be known partners.
- some future applicants may be unknown external applicants.
- existing admin surfaces may support approval/status workflows.
- protected trust audit does not exist yet.
- verification decisions must therefore be manually archived with discipline.

Core distinction:

```text
Trust Function
!=
Trust Department
```

The Trust Function exists now as a delegated, manual operating function. A Trust Department may exist later when there are people, process, records, review cycles, and authority boundaries.

## A2. Human Review Requirement

Trust decisions require human review.

System checks, AI assistance, or document completeness checks may help, but they do not replace human judgment.

Human review is required for:

- approval
- rejection
- suspension
- appeal
- document inconsistency
- expired license
- unknown applicant escalation
- known-partner exception review

---

# PART B — Verification Outcomes

| Status | Meaning | Who May Assign It | Pilot Usage | Archive Impact |
| ------ | ------- | ----------------- | ----------- | -------------- |
| PENDING | Application or verification record exists but review is not complete. | Trust Function reviewer / founder delegate | Default intake state. | Record intake date and missing items if known. |
| APPROVED | Minimum threshold met and reviewer accepts pilot participation. | Founder or delegated Trust reviewer under owner awareness | Allows pilot participation under current process. | Must create `TRUST_VERIFICATION_RECORD`. |
| REJECTED | Applicant does not meet pilot trust threshold or evidence is unacceptable. | Founder or delegated Trust reviewer | Blocks pilot participation unless appealed/resubmitted. | Must archive reason and evidence reviewed. |
| NEEDS_REVIEW | Evidence is incomplete, inconsistent, unclear, expired, or requires clarification. | Trust Function reviewer | Pauses decision; asks for clarification or escalation. | Must archive review reason and requested clarification. |
| SUSPENDED | Previously approved entity is temporarily restricted due to risk or new information. | Founder/Owner with Trust review | High-risk pilot use only. | Must archive reason, scope, and review condition. |

Status law:

```text
A verification status is not just a field.
It is a trust decision that must be explainable later.
```

---

# PART C — Center Verification Checklist

## C1. Identity

Required checks:

- center name
- responsible person
- responsible person's role
- contact phone
- contact email if available
- basic ownership/management clarity

Questions:

- Is the center clearly identifiable?
- Is there a responsible person?
- Can the responsible person be contacted?
- Does the name match submitted documents or public presence?

## C2. Location

Required checks:

- city
- address
- map/location evidence
- service area if remote/hybrid

Questions:

- Is the location plausible and consistent?
- Does location match license/registration documents?
- Is there enough information for pilot accountability?

## C3. Documents

Required checks:

- license if applicable
- registration documents
- supporting documents
- expiration dates if present
- document owner/name match

Questions:

- Are documents readable?
- Are documents current?
- Do documents match center identity?
- Are any documents missing?

## C4. Presence

Recommended checks:

- photos
- website
- social links
- public listing if present
- basic service description

Questions:

- Does the public presence support the submitted identity?
- Are photos or links consistent with the center?
- Is there any mismatch requiring clarification?

## C5. Trust Notes

Record:

- reviewer notes
- clarification requests
- known-partner context if applicable
- missing evidence
- risk concerns
- final decision rationale

## C6. Minimum Approval Threshold

Minimum threshold for pilot approval:

- center identity is clear.
- responsible person is known or contactable.
- location is plausible and documented.
- required license/registration evidence is present or founder-known exception is documented.
- no unresolved high-risk contradiction exists.
- reviewer records decision and evidence reviewed.

## C7. Automatic Review Triggers

Set status to `NEEDS_REVIEW` when:

- license/registration is missing.
- document is unreadable.
- center name conflicts with document name.
- location conflicts with document/public info.
- responsible person is unclear.
- contact information is invalid.
- public presence conflicts with submitted info.
- license appears expired.

## C8. Manual Review Triggers

Escalate to founder/Owner review when:

- known partner lacks documents.
- applicant is unknown and evidence is incomplete.
- document authenticity is uncertain.
- complaint or dispute exists.
- center asks for exception.
- suspension is considered.
- rejection may affect partnership relationship.

---

# PART D — Clinician Verification Checklist

## D1. Identity

Required checks:

- full name
- profile name consistency
- contact phone/email
- identity consistency across documents

Questions:

- Is the clinician clearly identifiable?
- Do submitted documents match the name?
- Is there a clear way to contact the clinician?

## D2. Specialty

Required/recommended checks:

- specialty
- service category
- relevant experience
- role/scope of practice if known

Questions:

- Does specialty align with documents or stated experience?
- Is the specialty appropriate for pilot listing/workflow?

## D3. License

Required checks:

- license document or license reference
- license number if present
- expiration date if present
- issuing body if present

Questions:

- Is the license readable?
- Is it current?
- Does it match clinician identity?
- Does it support the claimed specialty or role?

## D4. Certificates

Recommended checks:

- certificates
- training documents
- continuing education evidence if relevant

Questions:

- Are certificates relevant?
- Are they consistent with specialty?
- Are they used only as supporting evidence, not sole approval?

## D5. Affiliation

Checks:

- center affiliation if applicable
- independent/center-associated status
- center confirmation if needed

Questions:

- Is the affiliation clear?
- Does the center know or approve the affiliation where required?

## D6. Contact

Checks:

- phone
- email
- preferred contact method
- availability or response expectation if relevant

## D7. Trust Notes

Record:

- reviewer notes
- missing evidence
- clarification requests
- known-partner context
- risk concerns
- final decision rationale

## D8. Minimum Approval Threshold

Minimum threshold for pilot approval:

- clinician identity is clear.
- contact information is usable.
- specialty is stated.
- license or equivalent evidence is present, or known-partner exception is documented.
- no unresolved contradiction exists.
- affiliation is clear if relevant.
- reviewer records decision and evidence reviewed.

## D9. Automatic Review Triggers

Set status to `NEEDS_REVIEW` when:

- license is missing.
- license is expired or unclear.
- name mismatch appears.
- specialty is unclear.
- affiliation is unclear.
- certificates conflict with claimed specialty.
- profile data is incomplete.
- contact information fails.

## D10. Manual Review Triggers

Escalate to founder/Owner review when:

- license authenticity is uncertain.
- unknown applicant lacks strong evidence.
- known partner has incomplete documents.
- appeal is submitted.
- suspension/blocking is considered.
- profile change materially affects trust.

---

# PART E — Known Partner Doctrine

## E1. Definition

```text
KNOWN_PARTNER
```

A known partner is a center or clinician personally known to the founder/Owner or institution before pilot verification.

## E2. Purpose

Known partner status reduces uncertainty. It does not eliminate documentation.

Allowed usage:

- prioritize review.
- allow documented exception where some evidence is delayed.
- rely on founder context as supporting evidence.
- permit pilot participation if minimum safety threshold is met.

Limitations:

- cannot bypass identity record.
- cannot bypass final status decision.
- cannot bypass archive record.
- cannot bypass consent/data requirements.
- cannot become permanent trust status without documentation.

Required documents:

- identity/contact record.
- license/registration where applicable, or documented reason for delayed evidence.
- reviewer note explaining known-partner basis.

Review requirements:

- known-partner status must be noted in the `TRUST_VERIFICATION_RECORD`.
- missing documents must be tracked.
- exception must have review date.

Known partner law:

```text
Known partner may reduce risk.
It may not erase process.
```

---

# PART F — Unknown Applicant Doctrine

## F1. Definition

```text
UNKNOWN_APPLICANT
```

An unknown applicant is a center or clinician without prior trusted relationship to founder/Owner/institution.

## F2. Required Evidence

Unknown applicants require:

- clear identity.
- valid contact information.
- license/registration evidence where applicable.
- supporting documents.
- location or affiliation clarity.
- reviewer notes.

## F3. Review Path

Path:

```text
PENDING
-> evidence review
-> APPROVED / REJECTED / NEEDS_REVIEW
```

## F4. Escalation Path

Escalate when:

- evidence appears forged.
- documents conflict.
- identity is unclear.
- license is expired.
- applicant requests exception.
- risk signal appears.

## F5. Rejection Path

Reject when:

- required evidence is absent after clarification.
- documents appear invalid.
- identity cannot be verified.
- material contradiction remains unresolved.
- applicant refuses required clarification.

Rejection must include reason and archive record.

---

# PART G — Appeals & Re-Submission

## G1. Appeal

Trigger:

- applicant disputes rejection or suspension.

Reviewer:

- founder/Owner or delegated Trust reviewer not solely responsible for original rejection where possible.

Archive artifact:

- appeal note
- original decision
- new evidence
- final appeal decision

## G2. Clarification Request

Trigger:

- missing document.
- unclear document.
- inconsistent data.
- incomplete profile.
- contact/location ambiguity.

Reviewer:

- Trust Function reviewer.

Archive artifact:

- clarification request note
- requested item
- due/review expectation if applicable
- response status

## G3. Re-Submission

Trigger:

- applicant supplies corrected/new documents after `NEEDS_REVIEW` or `REJECTED`.

Reviewer:

- Trust Function reviewer; founder/Owner if high-risk or prior rejection was serious.

Archive artifact:

- resubmission record
- changed evidence
- new decision
- reason for status update

Appeal doctrine:

```text
Trust decisions must be firm enough to protect users
and reviewable enough to remain fair.
```

---

# PART H — Verification Archive Package

Every verification decision must generate:

```text
TRUST_VERIFICATION_RECORD
```

## H1. Minimum Fields

| Field | Purpose |
| ----- | ------- |
| entity type | center or clinician |
| entity id/name | identifies subject |
| applicant type | KNOWN_PARTNER or UNKNOWN_APPLICANT |
| decision | PENDING, APPROVED, REJECTED, NEEDS_REVIEW, SUSPENDED |
| reviewer | who reviewed |
| date | decision/review date |
| evidence reviewed | documents, license, profile, links, notes |
| missing evidence | what remains absent |
| notes | reviewer reasoning |
| status | current verification status |
| next review date | if needed |
| appeal/resubmission link | if applicable |

## H2. Archive Location

Conceptual archive target:

```text
/trust
/archive
/pilot
```

Labels:

```text
TRUST
TRUST_VERIFICATION
ARCHIVE_PACKAGE
PILOT
```

## H3. Pilot Archive Rule

During pilot, a manual verification package is acceptable if it is:

- consistent
- reviewable
- dated
- owned
- archived
- linked to decision status

---

# PART I — Pilot Trust Risk Register

| Risk | Risk Level | Mitigation |
| ---- | ---------- | ---------- |
| forged documents | High | Require human review, note uncertainty, escalate unknown applicants. |
| incomplete documents | High | Use `NEEDS_REVIEW`, clarification request, missing evidence tracking. |
| known-partner bias | Medium | Known partner still needs documentation and archive note. |
| approval inconsistency | High | Use same checklist for all applicants. |
| reviewer fatigue | Medium | Limit review batches, require notes, defer unclear cases. |
| missing evidence | High | Do not approve unknown applicants without minimum evidence. |
| expired license | High | Automatic `NEEDS_REVIEW` unless documented exception. |
| trust drift | Medium | Add review date for exceptions and known-partner incomplete files. |
| unclear affiliation | Medium | Require center/clinician relationship note. |
| no appeal path | High | Record appeal and re-submission process. |
| admin shortcut pressure | High | Checklist required before decision. |

---

# PART J — Pilot Trust Readiness Assessment

## J1. Is Center Verification Ready?

Status:

```text
READY_WITH_MANUAL_PROCESS
```

Center verification is ready for pilot if the checklist is used and every decision creates a `TRUST_VERIFICATION_RECORD`.

Still manual:

- document review
- known-partner context
- clarification requests
- approval/rejection decision
- archive package

Missing:

- protected trust audit runtime
- automated document validation
- mature Trust Department

## J2. Is Clinician Verification Ready?

Status:

```text
READY_WITH_MANUAL_PROCESS
```

Clinician verification is ready for pilot if license/specialty/identity checks are performed and archived.

Still manual:

- license review
- certificate review
- affiliation confirmation
- appeal handling
- archive package

Missing:

- protected trust audit runtime
- automated license verification
- mature Trust Department

## J3. What Must Exist Before Pilot Launch?

Minimum requirements:

- verification checklist accepted.
- `KNOWN_PARTNER` and `UNKNOWN_APPLICANT` status used.
- decision statuses defined.
- reviewer assigned.
- manual archive package location/process selected.
- no approval without decision note.
- no rejection without reason.
- no known-partner bypass without documentation.

---

# PART K — Final Verdict

## Center Verification Verdict

Center verification can proceed in pilot with manual review, provided that identity, location, documents, presence, notes, and decision record are completed.

## Clinician Verification Verdict

Clinician verification can proceed in pilot with manual review, provided that identity, specialty, license, affiliation/contact, notes, and decision record are completed.

## Trust Function Verdict

The Trust Function is ready as a delegated pilot function.

It is not yet a Trust Department.

## Pilot Readiness Verdict

Trust verification is one of the most pilot-ready lines, but only under checklist discipline and manual archive.

## Recommended Next Step

Chosen option:

```text
Option B: Pilot Registration Safety Plan
```

Justification:

Trust verification can operate manually now. The next pilot risk is whether registration/profile write paths and permission rules will allow participants to enter the pilot without `permission-denied` failures or inconsistent data capture. Registration safety should be checked before cohort execution.

---

## Commands Executed By Codex

None

