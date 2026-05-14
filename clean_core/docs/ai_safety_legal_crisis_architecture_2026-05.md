# Mental Smile AI Safety / Legal / Crisis Architecture

Date: 2026-05-14  
Target: `C:/mental_smile_workspace/app/mental-smile-app-clean2/clean_core`  
Mode: Design only. No rules, Flutter code, AI runtime, legal UI, or crisis flow implementation.

## 1. Executive Verdict

AI Safety, Legal, and Crisis functionality should remain design-only until the rules model, legal review, and backend boundaries are ready.

The current clean-core rules posture is intentionally conservative:

- deny-by-default remains the foundation.
- chat writes are denied.
- AI Safety collections are reserved and denied.
- legal consent writes are not opened yet.
- crisis escalation is not implemented.

This is the correct posture. Mental Smile should not expose AI/crisis/legal flows from client code until Cloud Functions, security rules, policy wording, data retention, and human review workflows are designed and approved.

## 2. AI Safety Scope

Mental Smile AI must be scoped as:

- wellness and emotional support only.
- non-medical.
- non-diagnostic.
- not an emergency service.
- not a therapist, clinician, or doctor replacement.
- not a substitute for local emergency support.
- not a provider of treatment plans, diagnosis, prescriptions, or crisis guarantees.

AI support may:

- offer calm, grounding, and supportive language.
- encourage the user to contact trusted people or local emergency services when safety risk is present.
- suggest using verified app resources when appropriate.
- route high-risk cases to human review when a reviewed escalation system exists.

AI support must not:

- diagnose conditions.
- claim to assess or treat addiction, trauma, psychosis, suicidality, or medical conditions.
- store raw crisis details by default.
- generate harmful technical instructions.
- imply guaranteed rescue, monitoring, or emergency intervention.

## 3. Required Collections

### `aiSafetyEvents`

Purpose:

- Minimal record that an AI safety-relevant event occurred.
- Useful for audit counts, safety monitoring, and escalation triggers.

Allowed creator:

- Prefer Cloud Function/server.
- User client may create only a narrow sanitized event stub later, if product/legal approves.

Allowed reader:

- Admin/safety operator only.
- Server only for automation.
- User read is not recommended by default.

Allowed updater:

- Server/admin only.

Sensitive fields:

- `userId`
- `threadId`
- `eventType`
- `riskLevel`
- `severity`
- `policyVersion`
- `createdAt`
- sanitized preview/hash fields

Raw content policy:

- Do not store raw crisis text by default.
- Store sanitized category, hash, or minimal preview only if necessary.

Retention note:

- Retain according to legal/privacy policy.
- Separate operational retention from anonymized aggregate analytics.

Admin/server boundary:

- Risk classification, severity, policy references, and escalation routing must be server/admin controlled.

### `aiEscalationCases`

Purpose:

- Human review case created from a safety event or chat/support concern.

Allowed creator:

- Cloud Function/server only.
- Admin/safety operator only for manual creation if reviewed later.

Allowed reader:

- Admin/safety operator.
- Assigned clinician only if product/legal approves and assignment is explicit.

Allowed updater:

- Admin/safety operator or Cloud Function only.

Sensitive fields:

- `status`
- `assignedAdminUid`
- `assignedClinicianUid`
- `priority`
- `riskLevel`
- `slaDueAt`
- `humanOverrideRecommended`
- review notes

Raw content policy:

- No raw conversation body by default.
- Use sanitized summary, event ids, hashes, and reference ids.

Retention note:

- Requires legal retention decision.
- Safety cases may need longer retention than routine chat metadata.

Admin/server boundary:

- Status transitions, assignment, closure, and escalation are server/admin controlled.

### `aiSafetyTraces`

Purpose:

- Internal decision trace for AI safety logic, policy matching, routing, and model/runtime behavior.

Allowed creator:

- Server only.

Allowed reader:

- Admin/safety operator only.
- No user reads by default.

Allowed updater:

- None after create, or server-only append model.

Sensitive fields:

- policy decisions
- model/runtime ids
- risk classifiers
- prompt/result fingerprints
- internal rule outcomes

Raw content policy:

- Avoid raw user text.
- Prefer hashes, classifiers, redacted snippets, and policy ids.

Retention note:

- Short operational retention unless legal requires otherwise.

Admin/server boundary:

- Client must never write traces.

### `aiSafetyIncidents`

Purpose:

- System-level incident records, such as safety pipeline failure, escalation outage, policy misconfiguration, or severe review event.

Allowed creator:

- Server/admin only.

Allowed reader:

- Admin/safety operator only.

Allowed updater:

- Admin/server only.

Sensitive fields:

- `incidentType`
- `severity`
- `affectedUserIds`
- `status`
- `rootCause`
- `mitigation`
- `reviewedBy`

Raw content policy:

- No raw user content.
- Use sanitized references.

Retention note:

- Compliance/audit retention required. Needs legal decision.

Admin/server boundary:

- Fully admin/server controlled.

### `aiSafetySystemAlerts`

Purpose:

- Runtime monitoring alert for safety infrastructure health.

Allowed creator:

- Server only.

Allowed reader:

- Admin/safety operator only.

Allowed updater:

- Server/admin only.

Sensitive fields:

- `alertType`
- `severity`
- `serviceName`
- `triggeredAt`
- `resolvedAt`
- `resolution`

Raw content policy:

- No raw user content.

Retention note:

- Operational retention, then aggregate.

Admin/server boundary:

- Server controlled.

### `aiSafetyPolicyRuntimeConfig`

Purpose:

- Current active safety configuration used by backend/runtime.

Allowed creator:

- Server/admin only.

Allowed reader:

- Server/admin only.
- Public/client reads denied.

Allowed updater:

- Server/admin only with audit trail.

Sensitive fields:

- thresholds
- escalation settings
- policy mode
- model/runtime controls
- feature flags

Raw content policy:

- No user content.

Retention note:

- Snapshot changes separately before updates.

Admin/server boundary:

- Direct client access denied.

### `aiSafetyPolicySnapshots`

Purpose:

- Immutable snapshot of policy/runtime configuration at release or policy change time.

Allowed creator:

- Server/admin only.

Allowed reader:

- Admin/safety operator.
- Limited public/legal export only if approved.

Allowed updater:

- Deny after create.

Sensitive fields:

- policy version
- runtime config
- reviewer/admin metadata

Raw content policy:

- No user content.

Retention note:

- Long retention for audit/compliance.

Admin/server boundary:

- Immutable admin/server record.

### `legalConsents`

Purpose:

- Immutable receipt that a user accepted required legal and safety documents.

Allowed creator:

- Signed-in user creates own consent receipt later, or Cloud Function records it.

Allowed reader:

- Owner user.
- Admin/compliance.

Allowed updater:

- Deny. Old receipts are immutable.
- New policy version requires a new receipt.

Sensitive fields:

- `userId`
- `termsVersion`
- `privacyVersion`
- `medicalDisclaimerVersion`
- `aiSafetyVersion`
- `acceptedAt`
- `acceptedLocale`
- `appVersion`
- `platform`
- `revokedAt`

Raw content policy:

- No chat/support/crisis content.
- Store version ids, timestamps, locale, and platform only.

Retention note:

- Legal retention required.
- Revocation should be a separate event or nullable field controlled by server/admin, depending on legal design.

Admin/server boundary:

- Users may create own receipt only with safe fields.
- Users cannot edit old receipts.
- Admin/compliance can read for audit.

## 4. Raw Sensitive Content Policy

Default policy:

- no raw crisis messages by default.
- no diagnosis labels.
- no trauma detail storage.
- no medication details.
- no harmful technical details.
- no raw self-harm method details.
- no full prompt/completion traces containing sensitive user text.

Allowed minimal storage, if needed:

- sanitized category, such as `safety_support_requested`.
- risk tier, such as `low`, `medium`, `high`, `critical`, only if generated by server policy.
- hash/fingerprint of content for deduplication.
- short redacted preview with explicit redaction rules.
- reference id to original chat message only if the original record is already access-controlled.

Sensitive content must not be copied into multiple collections. If review requires access, reviewers should access the original protected source through strict admin/safety permissions.

## 5. Consent Model

### Immutable Consent Receipt

Recommended fields:

- `userId`
- `termsVersion`
- `privacyVersion`
- `medicalDisclaimerVersion`
- `aiSafetyVersion`
- `acceptedAt`
- `acceptedLocale`
- `appVersion`
- `platform`
- `source`
- `revokedAt` optional, server/admin controlled if used

Rules philosophy:

- user can create a consent receipt for self.
- user cannot edit old receipt.
- user cannot backdate `acceptedAt` unless server timestamp validation is implemented later.
- new legal version requires a new receipt.
- admin/compliance can read for audit.
- revoke/withdraw behavior needs legal decision before implementation.

Consent documents should not contain:

- chat text.
- health details.
- diagnosis or symptoms.
- crisis details.
- raw device identifiers beyond approved platform/app metadata.

## 6. Escalation Model

### `aiEscalationCases`

Recommended lifecycle:

- `new`
- `triage`
- `assigned`
- `human_review`
- `resolved`
- `closed`
- `false_positive`
- `escalated_external` only if legally approved

Recommended fields:

- `caseId`
- `userId`
- `sourceCollection`
- `sourceId`
- `eventIds`
- `status`
- `riskLevel`
- `priority`
- `humanOverrideRecommended`
- `assignedAdminUid`
- `assignedClinicianUid` optional later
- `createdAt`
- `triageStartedAt`
- `slaDueAt`
- `resolvedAt`
- `closedAt`
- `reviewSummarySanitized`

Rules:

- admin-only review.
- no raw conversation storage by default.
- optional clinician assignment only after product/legal review.
- user should not create, assign, update, close, or delete escalation cases directly.

SLA:

- SLA timestamps should be server-calculated.
- overdue alerts should be system-generated in `aiSafetySystemAlerts`.

## 7. Safety Events / Traces

### `aiSafetyEvents`

Minimal event record.

Example purpose:

- "high risk pattern detected"
- "user requested human support"
- "safety policy fallback triggered"

Contains minimal metadata and redacted references.

### `aiSafetyTraces`

Internal decision trace.

Example purpose:

- policy rule matched.
- risk threshold selected.
- escalation route considered.
- model/runtime version used.

This is not user-facing and should be server/admin-only.

### `aiSafetyIncidents`

System-level incident.

Example purpose:

- policy config failure.
- escalation queue outage.
- false negative review.
- manual safety investigation.

This is compliance/admin-only.

### `aiSafetySystemAlerts`

Operational alert.

Example purpose:

- safety function failed.
- queue backlog exceeded SLA.
- runtime config missing.
- escalation notification failed.

This is monitoring/admin-only.

## 8. Crisis UX Boundary

The app may say:

- calm, supportive, non-judgmental language.
- "You do not have to handle this alone."
- "Please contact a trusted person nearby."
- "If you may be in immediate danger, contact your local emergency number now."
- "Mental Smile is not an emergency service."
- "A human review option may be available when configured."

The app must not say:

- "We will save you."
- "A therapist is monitoring you now" unless literally true.
- "You are diagnosed with..."
- "You should take/stop medication."
- "This is guaranteed confidential" without legal backing.
- "Do not contact emergency services."

No abandonment:

- The app should avoid ending with only "I cannot help."
- It should provide safe next steps, such as trusted human contact and local emergency support.

No guarantees:

- The app must not promise response time, rescue, or clinical intervention unless operationally guaranteed.

## 9. Firestore Rules Requirements

### `aiSafetyEvents`

Initial posture:

- deny all user reads.
- deny user updates/deletes.
- optional user create only after legal/product approval.
- prefer server-only create.

Server/admin-only fields:

- `riskLevel`
- `severity`
- `policyVersion`
- `reviewStatus`
- `assignedToUid`
- `adminNotes`
- `escalationCaseId`

Denied fields for users:

- all governance and routing fields.
- raw content fields.

### `aiEscalationCases`

Initial posture:

- server/admin create.
- admin/safety read.
- server/admin update.
- deny user read/write.

Server/admin-only fields:

- all fields.

Denied fields for users:

- all fields.

### `aiSafetyTraces`

Initial posture:

- server-only create.
- admin/safety read.
- no user access.
- no updates except server if append model is chosen.

Denied fields for users:

- all fields.

### `aiSafetyIncidents`

Initial posture:

- admin/server only.

Denied fields for users:

- all fields.

### `aiSafetySystemAlerts`

Initial posture:

- server create.
- admin/safety read/update.
- user denied.

Denied fields for users:

- all fields.

### `aiSafetyPolicyRuntimeConfig`

Initial posture:

- server/admin read/write only.
- no public/client reads.

Denied fields for users:

- all fields.

### `aiSafetyPolicySnapshots`

Initial posture:

- server/admin create.
- admin/safety read.
- immutable after create.
- no user access.

Denied fields for users:

- all fields.

### `legalConsents`

Initial posture:

- owner create only if product/legal approves.
- owner read own receipts.
- admin/compliance read.
- update/delete denied.

User allowed fields:

- `userId`
- `termsVersion`
- `privacyVersion`
- `medicalDisclaimerVersion`
- `aiSafetyVersion`
- `acceptedAt`
- `acceptedLocale`
- `appVersion`
- `platform`

Server/admin-only fields:

- `revokedAt`
- `revokedBy`
- `auditExportedAt`
- `complianceNotes`

Denied fields:

- raw health or chat content.
- admin/compliance notes by user.
- retroactive version mutation.

## 10. Cloud Functions Boundary

Future backend functions:

- `createSafetyEvent`
  - accepts sanitized event input.
  - writes server-controlled risk/policy metadata.

- `createEscalationCase`
  - creates admin-review case from safety event.
  - sets status, priority, SLA, and assignment placeholders.

- `writeSafetyTrace`
  - writes internal decision trace.
  - no raw sensitive content by default.

- `updateEscalationStatus`
  - admin/server transition function.
  - validates lifecycle, role, audit metadata.

- `publishPolicySnapshot`
  - stores immutable policy/runtime snapshot.

- `updateRuntimePolicyConfig`
  - admin/server controlled runtime config update.
  - writes audit trail and snapshot.

- `createIncident`
  - creates system-level safety incident.

- `createSystemAlert`
  - creates runtime alert for safety operations.

- `recordLegalConsent`
  - creates immutable legal consent receipt.
  - validates versions and auth identity.

Additional future functions:

- `redactSafetyPreview`
- `closeEscalationCase`
- `assignEscalationCase`
- `exportComplianceAudit`
- `purgeExpiredSafetyTrace`
- `notifySafetyOperator`

## 11. Compatibility With Existing Rules Batches

OS-2 must preserve:

- deny-by-default posture.
- protected account fields.
- provider approval safety.
- pending registration rules.
- booking participant rules.
- booking lifecycle and payment restrictions.
- no public raw ratings.
- no public raw chat.
- chat writes denied until Cloud Functions boundary exists.
- AI Safety collections denied until reviewed.
- legal consent denied until consent model is approved.

OS-2 must not weaken:

- public provider read restrictions.
- booking participant checks.
- session rating participant-only reads.
- support request ownership rules.
- profile change request owner-create/admin-review model.

## 12. Implementation Plan

### OS-2B: Legal Consent Rules Only

Goal:

- implement immutable `legalConsents` owner-create/owner-read/admin-read rules.

Allowed:

- `firestore.rules`
- legal consent notes doc

Forbidden:

- legal UI
- AI runtime
- crisis flow

Stop condition:

- no AI safety collections opened.

### OS-2C: AI Safety Placeholder Rules

Goal:

- keep AI collections reserved and denied or server/admin-only.
- define helper field lists.

Allowed:

- rules placeholders
- notes doc

Forbidden:

- user-facing AI safety create flows.
- raw content storage.

Stop condition:

- no client writable safety governance fields.

### OS-2D: Safety Core Code Skeleton

Goal:

- add server-bound service interfaces/stubs only.
- no runtime AI behavior yet.

Allowed:

- typed contracts and adapters.

Forbidden:

- model calls.
- crisis copy.
- direct Firestore AI safety writes from UI.

Stop condition:

- compiles with no active runtime behavior.

### OS-2E: Crisis UI / Design

Goal:

- human-reviewed crisis UX copy and safe routing design.

Allowed:

- design spec.
- reviewed copy.

Forbidden:

- auto-escalation without backend and policy review.

Stop condition:

- legal/product signoff obtained.

### OS-2F: Cloud Functions Boundary

Goal:

- implement trusted functions for safety events, traces, escalation cases, legal consent recording, and audit logs.

Allowed:

- Cloud Functions.
- emulator/rules tests.

Forbidden:

- client-side governance writes.

Stop condition:

- emulator tests prove client cannot spoof risk/admin/safety fields.

### OS-2G: Legal / Store Docs

Goal:

- produce policy, privacy, medical disclaimer, AI safety disclaimer, and store review wording.

Allowed:

- docs and reviewed UI copy.

Forbidden:

- auto-generated legal/crisis wording without human review.

Stop condition:

- legal/product approval recorded.

## 13. Open Questions

Legal/product questions before implementation:

1. What exact terms, privacy, medical disclaimer, and AI safety versions are required before beta?
2. Is Mental Smile legally allowed to store safety event metadata, and for how long?
3. Who can read escalation cases: admins only, or assigned clinicians too?
4. Can the app promise human review, or only say review may be available?
5. What local emergency wording is appropriate per launch country?
6. Should legal consent be revocable inside the app, and what happens after revocation?
7. Should AI safety traces be retained, redacted, or purged on a schedule?
8. Can support/chat text be referenced from escalation cases, or must all review summaries be manually sanitized?
9. What counts as a crisis event for this product?
10. Is clinician notification allowed for safety cases without explicit user consent?
11. What audit export format is required for compliance?
12. Should policy runtime config be editable from admin UI or deployment-only?
13. What age/guardian consent policy applies?
14. What country-specific emergency resources should be shown?
15. Are ratings/support/chat records part of the same retention policy as AI safety records?

## Final Recommendation

Do not implement AI Safety, Legal, or Crisis runtime yet.

The next safe step is OS-2B only: immutable legal consent rules, if product/legal approves the data shape. AI safety collections should remain denied or server/admin-only placeholders until Cloud Functions, emulator tests, reviewed crisis UX, and legal policy documents are ready.

Mental Smile should treat AI Safety OS as a backend-governed compliance layer, not a client-side feature. The client can display reviewed safety UX later, but risk scoring, escalation, traces, policy config, incident creation, and legal audit records must be controlled by server/admin boundaries.

