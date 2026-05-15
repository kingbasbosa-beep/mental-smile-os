# Clean Core Safe Context Builder Plan

Draft safe context boundary plan for future AI safety runtime.

## Context Principle

Context should be minimal, sanitized, policy-bound, and session-scoped by default. It must not create unsafe long-term psychological profiles.

## Allowed Context

- Current-session risk marker.
- Response mode.
- Safe user goal.
- Last safe step.
- Escalation status.
- Policy/version reference.
- Consent marker.
- Audit/reference id.
- Sanitized preview when necessary.

## Forbidden Context

- Diagnosis.
- Permanent labels.
- Trauma narrative.
- Full raw crisis content.
- Medication details.
- Harmful technical details.
- Psychological profiling.
- Cross-session profiling.
- Raw prompt history.
- Full conversation transcript.
- Emergency guarantee state.

## Context Construction Rules

- Prefer references and hashes over raw content.
- Keep context short.
- Use current session unless backend policy allows otherwise.
- Remove unsafe details before provider boundary.
- Do not include protected governance fields as user-controlled context.
- Fail closed if required context integrity is missing.

## Provider Boundary

Safe context is not permission to call a provider. Provider calls still require:

- Policy approval.
- Backend authority.
- Provider governance approval.
- Isolation readiness.
- Observability/audit readiness.

## Explicit Non-Action

No context builder was implemented.
