# Clean Core Client Restriction Model

Draft client restriction model for future backend-governed architecture.

## Client May Do

Client-side clean_core or host app may:

- Render safe state.
- Submit intents.
- Show fallback.
- Collect consent.
- Collect feedback.
- Show review status.
- Submit non-trusted requests.
- Display backend-approved outcomes.

## Client Must Not Do

Client-side clean_core or host app must not create:

- Final approval decisions.
- Admin outcomes.
- Moderation outcomes.
- Payment proof approval.
- Payment status decisions.
- Escalation resolution.
- Provider activation.
- Runtime activation.
- Policy publication.
- Release/bootstrap activation.
- Privileged Firestore writes.
- Hidden authority.

## Runtime Restrictions

Client must not:

- Execute providers.
- Perform AI runtime activation.
- Bypass policy governor.
- Switch providers silently.
- Create signed authority.
- Override review requirements.

## Safe Client Behavior

If authority is missing:

- Show fallback.
- Show review-required state.
- Block action.
- Submit a non-trusted request if allowed.
- Preserve audit/review markers.

## Explicit Non-Action

No client restriction enforcement was implemented.
