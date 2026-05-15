# Clean Core Adapter Failure Boundaries

Draft failure boundary guidance for future adapters.

## Global Failure Rules

- Fail closed.
- Do not silently escalate privileges.
- Do not silently activate runtime systems.
- Do not bypass review requirements.
- Do not switch to provider execution during failure.
- Preserve backend-governed authority.

## Adapter Unavailable

Expected behavior:

- Mark operation unavailable.
- Return fallback/review-required contract where appropriate.
- Do not attempt direct app-owned runtime access from clean_core.

## Backend Unavailable

Expected behavior:

- Block trusted operation.
- Preserve audit-required state.
- Avoid client-side governance decisions.
- Use fallback-only state where supported.

## Provider Unavailable

Expected behavior:

- Provider remains blocked.
- No alternate provider selection unless backend-governed policy allows it.
- No client-side provider retries.
- Use safe fallback/review path.

## Environment Missing

Expected behavior:

- Use runtime-disabled/fallback-only profile.
- Do not assume production/staging permissions.
- Block activation and provider execution.

## Localization Unavailable

Expected behavior:

- Use safe fallback copy for critical legal/support text.
- Do not block safety-critical UI solely due to missing text when fallback exists.
- Do not fetch remote copy from clean_core.

## Auth Unavailable

Expected behavior:

- Treat identity as unknown.
- Block governance-sensitive operations.
- Do not infer role or permission from client state.

## Observability Unavailable

Expected behavior:

- If audit/observability is required, block or require review.
- Do not store raw sensitive data as fallback.
- Do not silently disable audit requirements.

## Explicit Non-Action

No failure handling runtime was implemented.
