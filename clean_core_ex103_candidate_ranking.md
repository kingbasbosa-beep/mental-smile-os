# EX-103 Candidate Ranking

## Ranking Levels

- Package-safe: candidate is suitable as passive metadata after normal naming
  review.
- Needs renaming: current term is too operational or declarative.
- Needs detox caveats: term can survive only with explicit non-authoritative
  meaning.
- Blocked: term should not become package-facing vocabulary.
- Host/backend-only forever: term implies write, enforcement, or ownership
  authority.

## Package-Safe Candidates

- `review_priority_low`
- `review_priority_medium`
- `review_state_pending`
- `policy_reference_present`
- `audit_reference_present`
- `review_boundary_observed`
- `emergency_capability_not_guaranteed`
- `human_support_encouraged`

## Needs Renaming

- `policyViolation` to `policy_issue_observed`
- `providerFailure` to `provider_issue_reported`
- `fallbackLoop` to `fallback_loop_observed`
- `safetyTeam` to `visibility_safety_review_label`
- `assigned` to `review_state_assignment_recorded`
- `inReview` to `review_state_in_review_reported`

## Needs Detox Caveats

- `crisis_risk_observed`
- `review_priority_high`
- `review_priority_urgent`
- `visibility_restricted_label`
- `visibility_audit_reference_label`
- `backend_governance_asserted`
- `emergency_support_guidance_present`
- `provider_unavailable_reported`
- `provider_policy_block_reported`
- `fallback_only_mode_reported`
- `fallback_recommended_label`
- `fail_safe_posture_label`

## Blocked

- `EscalationQueue.accepts`
- accepts predicates
- routing predicates
- queue admission labels
- emergency guaranteed labels
- team ownership guarantees
- backend enforcement claims
- provider causality claims
- fallback recovery claims

## Host/Backend-Only Forever

- `clientOutcomeWritesAllowed`
- assignment writes
- review writes
- resolution writes
- outcome writes
- state transition authority
- backend governance verification
- queue admission enforcement
- emergency workflow ownership

## Ranking Verdict

The safest candidates are passive labels that name observed facts without verbs
like accept, route, assign, resolve, guarantee, enforce, or recover. Any label
that grants power, promises handling, or proves enforcement is blocked or
host/backend-only.
