# Clean Core Protected Field Authority Model

Draft protected field authority model.

## Protected Field Categories

- Admin decisions.
- Approval status.
- Booking lifecycle status.
- Payment status.
- Payment proof review status.
- Session review status.
- Payout status.
- Escalation status.
- Moderation and safety verdicts.
- Provider governance state.
- Runtime activation state.
- Policy publication state.
- Release/bootstrap state.

## Authority Rules

- Client can request.
- Backend decides.
- Audit links required where sensitive.
- Review markers required where sensitive.
- Missing authority fails closed.
- No direct trusted client mutation.

## Client Request Shape Later

Future client requests may include:

- Intent type.
- Resource reference.
- Actor reference.
- Sanitized reason.
- Consent/policy reference.
- Review marker.
- Audit placeholder.

Requests are not trusted outcomes.

## Backend Decision Shape Later

Future backend decisions may include:

- Decision result.
- Authority marker.
- Audit reference.
- Policy snapshot reference.
- Reviewer reference if applicable.
- Expiration/validity if temporary.

## Explicit Non-Action

No Firestore rules or protected-field enforcement code was changed.
