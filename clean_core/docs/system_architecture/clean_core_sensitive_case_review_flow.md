# Clean Core Sensitive Case Review Flow

Draft sensitive-case review flow for future governance.

## Sensitive Case Categories

- Crisis-related conversations.
- Repeated unsafe attempts.
- High-risk emotional states.
- Emergency-language patterns.
- Policy bypass attempts.
- Unsafe provider behavior later.
- Escalation loops.
- Blocked or fallback-only cases.

## Review Flow

1. Detect review-required signal.
2. Attach policy and audit references.
3. Preserve sanitized preview only.
4. Mark visibility scope.
5. Route to appropriate review owner.
6. Keep user-facing behavior fallback-only or blocked where needed.
7. Resolve only through backend-governed authority.
8. Archive with audit linkage.

## Handling Rules

- Preserve audit linkage.
- Preserve review markers.
- Preserve backend authority.
- Avoid permanent profiling.
- Avoid diagnosis labels.
- Avoid raw crisis content persistence.
- Fail closed when uncertain.

## Provider-Related Sensitive Cases

If future provider behavior is unsafe:

- Block provider path.
- Require review.
- Emit audit/incident signal.
- Do not silently switch providers.
- Do not retry from the client.

## Explicit Non-Action

No sensitive-case runtime or persistence flow was implemented.
