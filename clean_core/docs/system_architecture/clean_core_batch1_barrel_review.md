# clean_core Batch 1 Barrel Review

## Reviewed File

- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

## Barrel Shape

The root barrel is explicit and narrow. It exports individual files only.

Confirmed:

- no wildcard exports
- no directory-wide exports
- no Batch 2 exports
- no runtime folders
- no provider folders
- no Firebase adapters
- no networking adapters
- no generated files
- no app-owned files

## Exported Backend Boundary Contracts

The barrel exports approved backend-boundary files:

- `ai_governance_boundary.dart`
- `backend_governed_action.dart`
- `booking_lifecycle_boundary.dart`
- `cloud_function_boundary.dart`
- `escalation_boundary_contract.dart`
- `protected_collection_contract.dart`
- `protected_governance_fields.dart`
- `server_owned_fields.dart`
- `trusted_operation_contract.dart`
- `trusted_operation_type.dart`
- `trusted_runtime_mode.dart`

## Exported Safety Decision Contracts

The barrel exports approved safety-decision files:

- `safety_decision.dart`
- `safety_decision_audit_link.dart`
- `safety_decision_confidence.dart`
- `safety_decision_fallback.dart`
- `safety_decision_guard.dart`
- `safety_decision_priority.dart`
- `safety_decision_reason.dart`
- `safety_decision_result.dart`
- `safety_decision_rule.dart`
- `safety_decision_scope.dart`
- `safety_decision_state.dart`
- `safety_decision_verdict.dart`

## Hidden File

`safety_decision_engine.dart` remains hidden from the root barrel.

Reason:

- It is closer to decision behavior than a passive contract surface.
- Keeping it hidden preserves a conservative Stage 1 export posture.
- Future export should require semantic review.

## Future Barrel Rule

Any future barrel addition requires review for:

- export stability
- runtime implication
- provider implication
- app-owned dependency leakage
- internal/deferred exposure
- fail-closed and deny-by-default preservation
