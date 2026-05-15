# Clean Core Policy Rule Engine Plan

Draft rule engine plan for future policy governance.

## Rule Engine Principle

Rules should be deterministic, auditable, and fail-closed. The rule engine should resolve contracts and decisions, not execute runtime/provider behavior.

## Conceptual Rule Layers

### Static Rules

- Hard deny defaults.
- Protected field restrictions.
- No provider execution by default.
- No runtime activation by default.

### Environment Rules

- Local/dev restrictions.
- Staging restrictions.
- Production restrictions.
- Restricted review environment rules.
- Fallback-only environment rules.

### Legal/Safety Rules

- Required consent versions.
- AI safety disclosure requirements.
- Crisis/emergency disclaimer boundaries.
- Non-diagnostic and non-medical constraints.

### Escalation Rules

- Escalation-required action detection.
- Human review requirements.
- Backend-governed escalation transitions.

### Provider Rules

- Provider blocked by default.
- Capability restrictions.
- Provider onboarding requirements.
- Provider isolation and observability requirements.

### Review Rules

- Manual review requirements.
- Audit-link requirements.
- Restricted visibility requirements.

### Capability Rules

- Runtime capability restrictions.
- Environment capability restrictions.
- Provider capability restrictions.
- Governance capability restrictions.

### Emergency Shutdown Rules

- Emergency shutdown outranks provider execution.
- Runtime disabled state outranks local allow.
- Missing authority results in blocked/fallback-only behavior.

## Expectations

- Deterministic behavior.
- Audit-linked decisions.
- No silent bypass.
- No client-side privilege escalation.
- No runtime execution.
- No provider execution.

## Explicit Non-Action

No rule engine was implemented.
