# Clean Core AI Safety Runtime Flow

Draft conceptual runtime flow. This is architecture only.

## Conceptual Flow

User input
→ consent/policy gate
→ rate/abuse gate
→ input safety filter
→ injection guard
→ risk classifier
→ policy governor
→ decision matrix
→ safe context builder
→ provider permission check
→ output validation
→ response constraint enforcement
→ fallback/escalation/review signal
→ audit/observability contract

## Gate Expectations

### Consent/Policy Gate

- Verify required legal consent versions.
- Verify policy snapshot/reference.
- Fail closed if missing.

### Rate/Abuse Gate

- Detect abuse/rate-limit markers conceptually.
- Escalate to fallback/review if limits are unknown or unsafe.

### Input Safety Filter

- Identify unsafe categories without storing raw sensitive content.
- Prefer sanitized previews and risk markers.

### Injection Guard

- Detect attempts to bypass policy, act as a doctor, reveal prompts, disable safety, or ignore rules.

### Risk Classifier

- Classify into safe risk levels.
- Low confidence fails safer.
- No diagnosis labels.

### Policy Governor

- Applies deny-by-default and fail-closed decisions.
- Backend authority outranks local state.

### Provider Permission Check

- Confirms provider governance, isolation, observability, audit, and backend authority.
- If missing, provider remains blocked.

### Output Validation

- Validates response constraints before user-visible delivery.
- Unsafe output is blocked or rewritten through safe fallback.

## Explicit Non-Action

No runtime flow was implemented.
