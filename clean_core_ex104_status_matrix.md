# EX-104 Status Matrix

## Package-Safe

| Label | Family |
| --- | --- |
| `safety_concern_observed` | Queue intent |
| `policy_issue_observed` | Queue intent |
| `manual_support_requested` | Queue intent |
| `review_priority_low` | Queue priority |
| `review_priority_medium` | Queue priority |
| `review_priority_high` | Queue priority |
| `review_state_pending` | Queue lifecycle |
| `visibility_restricted_label` | Queue visibility |
| `visibility_audit_reference_label` | Queue visibility |
| `policy_reference_present` | Boundary governance |
| `audit_reference_present` | Boundary governance |
| `review_boundary_observed` | Boundary governance |
| `emergency_capability_not_guaranteed` | Emergency posture |
| `emergency_support_guidance_present` | Emergency posture |
| `human_support_encouraged` | Emergency posture |
| `provider_issue_reported` | Provider report |
| `provider_capability_gap_reported` | Provider report |
| `fallback_loop_observed` | Fallback observation |
| `fallback_recommended_label` | Fallback observation |
| `fail_safe_posture_label` | Fallback observation |

## Needs Future Redesign

| Label | Family | Reason |
| --- | --- | --- |
| `crisis_risk_observed` | Queue intent | Emergency-adjacent; needs strong caveats. |
| `review_priority_urgent` | Queue priority | Can imply timing/emergency handling. |
| `visibility_safety_review_label` | Queue visibility | Can imply team ownership. |
| `backend_governance_asserted` | Boundary governance | Can imply enforcement proof. |
| `provider_unavailable_reported` | Provider report | Can imply verified outage. |
| `provider_policy_block_reported` | Provider report | Can imply backend enforcement. |
| `fallback_only_mode_reported` | Fallback observation | Can imply runtime enforcement. |

## Host-Only

| Label | Family |
| --- | --- |
| `review_state_assignment_recorded` | Queue lifecycle |
| `review_state_in_review_reported` | Queue lifecycle |
| `review_state_resolution_recorded` | Queue lifecycle |
| `review_state_rejection_recorded` | Queue lifecycle |
| `review_state_archived_recorded` | Queue lifecycle |
| `outcome_write_policy_external` | Boundary write policy |
| `assignment_record_external` | Boundary write policy |
| `reviewer_record_external` | Boundary write policy |
| `resolver_record_external` | Boundary write policy |
| `outcome_record_external` | Boundary write policy |

## Backend-Only

| Label or concept | Reason |
| --- | --- |
| `visibility_backend_policy_label` | Backend policy context can imply access control. |
| backend governance verification | Enforcement authority. |
| queue admission enforcement | Routing/admission authority. |
| emergency workflow ownership | Emergency governance authority. |
| provider causality adjudication | Runtime/provider authority. |

## Blocked

| Concept | Reason |
| --- | --- |
| `EscalationQueue.accepts` | Routing/admission predicate. |
| accepts predicates | Routing/admission guarantee. |
| routing predicates | Execution/policy decision. |
| `emergencyGuarantee` | Emergency promise. |
| `clientOutcomeWritesAllowed` | Client outcome write authority. |
| `backendGoverned` as package proof | Backend enforcement claim. |
| team ownership guarantees | Staffing/ownership promise. |
| provider causality claims | Runtime/provider diagnosis. |
| fallback recovery claims | Recovery/routing promise. |
