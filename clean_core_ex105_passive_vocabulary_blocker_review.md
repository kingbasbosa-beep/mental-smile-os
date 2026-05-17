# EX-105 Passive Vocabulary Blocker Review

## Scope

This document reviews migration blockers before any package introduction.

## Candidate Review

| Candidate | Status | Blocker finding |
| --- | --- | --- |
| `safety_concern_observed` | Approved | Safe if observation-only and no moderation ownership. |
| `policy_issue_observed` | Approved | Safe if not represented as confirmed violation. |
| `manual_support_requested` | Approved | Safe if no support availability or queue admission claim. |
| `review_state_pending` | Approved | Safe if no guaranteed review or admission claim. |
| `policy_reference_present` | Approved | Safe if no policy enforcement or validity claim. |
| `audit_reference_present` | Approved | Safe if no audit enforcement or trace verification claim. |
| `review_boundary_observed` | Approved | Safe if no routing, ownership, or enforcement claim. |
| `emergency_capability_not_guaranteed` | Approved | Safe because it is negative posture, not emergency capability. |
| `provider_issue_reported` | Approved with caveat | Must remain a report, not provider causality. |
| `fallback_loop_observed` | Approved with caveat | Must remain observation, not recovery or routing. |

## Remaining Blockers

Blocked before any package introduction:

- any accepts predicate
- any queue routing or queue admission function
- any field implying team ownership
- any emergency guarantee
- any backend enforcement proof
- any client outcome write permission
- any provider causality claim
- any fallback recovery claim
- any mapper for governance/write semantics

## Candidates Needing Renaming

No reviewed final candidate requires renaming before freeze.

Names outside the reviewed candidate set that still require redesign:

- `crisis_risk_observed`
- `review_priority_urgent`
- `visibility_safety_review_label`
- `backend_governance_asserted`
- `provider_unavailable_reported`
- `provider_policy_block_reported`
- `fallback_only_mode_reported`

## Blocker Verdict

The reviewed ten candidates are not blocked as passive labels. Package
introduction remains blocked if EX-106 includes contracts, mappers, routing
logic, imports/exports, or consumer migration.
