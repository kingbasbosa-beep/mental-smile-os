# Clean Core Firestore Authority Model

Draft Firestore authority model for future reconnect.

## Authority Principle

Firestore writes that affect governance, lifecycle, payment, review, escalation, safety, moderation, provider, or admin state must be backend-governed. Client-side direct trusted writes should fail closed.

## Protected Field Expectations

Protected fields include, but are not limited to:

- Admin decisions.
- Approval status after creation.
- Active/verified role state.
- Payment status and payment proof review state.
- Booking lifecycle workflow state.
- Session/review/payout state.
- Escalation state and severity.
- AI safety and moderation outcomes.
- Runtime/provider activation state.
- Policy publication state.

## Backend-Governed Writes

Future backend-governed writes should be:

- Signed or otherwise trusted by backend authority.
- Audit-linked.
- Policy-linked.
- Review-aware where required.
- Deny-by-default if authority is missing.

## Legal Consent Boundaries

Legal consent records should remain immutable-oriented:

- User acceptance payloads can be created according to rules.
- Accepted records should not be client-edited after creation.
- No diagnosis, raw crisis content, provider prompts, or AI conversation data should be stored as legal consent.

## Review And Escalation Boundaries

Review-required and escalation-required actions should:

- Preserve human review requirements.
- Avoid client-controlled outcomes.
- Avoid emergency guarantees.
- Require backend-owned state transitions.

## Provider-Governed Actions

Provider-related Firestore state should:

- Remain blocked by default.
- Require provider governance approval.
- Require audit and observability boundaries.
- Avoid raw prompts or full conversation persistence.

## Explicit Non-Action

No Firestore rules or app code were changed.
