# Clean Core Feedback Privacy And Review Rules

Draft privacy and review rules for future feedback systems.

## Privacy Rules

- Prefer sanitized previews.
- Avoid raw crisis-content exposure.
- Avoid broad public staff exposure.
- Restrict visibility by sensitivity.
- Preserve audit-linked moderation.
- Avoid unsafe profiling.
- Avoid hidden ranking manipulation.
- Require review for sensitive submissions.

## Sensitive Feedback Handling

Sensitive submissions include:

- Crisis or emergency language.
- Abuse/spam reports.
- Provider misconduct or quality concerns.
- Legal/compliance concerns.
- Personal health or identity details.
- Safety/escalation concerns.

Expected behavior:

- Restricted visibility.
- Review-required marker.
- Audit link.
- Sanitized preview.
- Backend-governed routing.

## Anonymous Feedback Later

Future anonymous feedback should:

- Preserve privacy expectations.
- Avoid fake guarantees of anonymity if backend metadata exists.
- Use minimal safe metadata.
- Still support abuse/spam review.
- Avoid exposing identity to department queues unless required and authorized.

## Retention And Deletion Expectations Later

Future retention should:

- Define category-specific retention.
- Support privacy deletion requests where legally appropriate.
- Preserve required audit records when necessary.
- Avoid retaining raw sensitive content by default.

## Moderation Rules

- Moderation must be audit-linked.
- Sensitive moderation requires review.
- No hidden moderation that changes user-facing outcomes without trace.
- No automatic punitive action without backend-governed review.

## Explicit Non-Action

No privacy runtime, moderation runtime, or retention implementation was created.
