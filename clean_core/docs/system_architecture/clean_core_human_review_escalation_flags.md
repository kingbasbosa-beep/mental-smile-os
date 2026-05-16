# clean_core Human Review Escalation Flags

This document reviews escalation-sensitive semantics.

## Escalation Labels

- `EscalationLevel`: none, low, medium, high, urgent.
- `EscalationReason`: safety concern, crisis risk, policy violation, provider failure, fallback loop, manual support request.
- `EscalationState`: pending review, assigned, in review, resolved, rejected, archived.

## Interpretation Rules

- Labels are not authority.
- References are not execution.
- Review state is not approval power.
- Queue eligibility is not assignment execution.
- Escalation resolution fields are not backend final authority.

## Sensitive Concepts

- crisis risk
- provider failure
- fallback loop
- resolved/rejected states
- urgent priority
- safety team visibility

## Escalation Verdict

Escalation labels are valuable contract vocabulary, but execution, assignment, notification, moderation, and override behavior must remain host/backend-owned.
