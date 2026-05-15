# clean_core Stage 1 Barrel Layout

## Barrel Principle

Stage 1 barrels should be curated and narrow. They should export stable contract surfaces only, never whole directories blindly.

## Root Barrel

Conceptual file:

- `lib/mental_smile_clean_core.dart`

Should export:

- stable backend-boundary contracts
- stable safety-decision contracts
- stable policy contracts
- stable trusted-backend contracts
- stable trusted-pipeline contracts
- reviewed governance contract barrels

Should not export:

- app-owned files
- Firebase/runtime files
- Flutter UI files
- generated files
- assets
- provider SDK integrations
- networking/runtime orchestration
- internal lock/seal/topology details unless explicitly promoted

## Backend Boundary Barrel

Conceptual file:

- `lib/src/backend_boundaries/backend_boundaries.dart`

Should export:

- backend request/result contracts
- authority references
- blocked/fallback result contracts
- audit/review linkage contracts

Should remain hidden:

- backend runtime clients
- networking bridges
- Cloud Functions implementation details

## Policy Barrel

Conceptual file:

- `lib/src/policy_runtime/policy_runtime.dart`

Should export:

- policy state contracts
- policy guard contracts
- policy decision contracts
- policy references
- fail-closed policy defaults

Requires semantic review first:

- any file named like a runtime engine
- any rule surface that might imply client-side authority
- any permissive fallback behavior

## Trusted Backend Barrel

Conceptual file:

- `lib/src/trusted_backend/trusted_backend.dart`

Should export:

- trusted backend boundary contracts
- request/response contracts
- guard/policy contracts
- runtime marker placeholders
- audit/review/fallback contracts

Should remain hidden:

- any future backend runtime
- networking or Firebase bridges
- authority execution logic

## Trusted Pipeline Barrel

Conceptual file:

- `lib/src/trusted_pipeline/trusted_pipeline.dart`

Should export:

- pipeline request/result contracts
- pipeline state/stage contracts
- guard/policy contracts
- audit/review/fallback contracts

Should remain hidden:

- orchestration runtime
- provider execution
- routing/execution runtime

## Governance Barrel

Conceptual file:

- `lib/src/governance/governance.dart`

Should export after review:

- governance kernel contracts
- lifecycle contracts
- compliance contracts
- capability contracts
- federation contracts only if stable enough

Requires semantic review first:

- federation surfaces
- capability semantics
- lock/seal internals
- topology-sensitive references

## Runtime Governance Barrel

Conceptual file:

- `lib/src/runtime_governance/runtime_governance.dart`

Stage 1 default:

- do not export unless explicitly reviewed.

Reason:

- runtime governance names are easy to misread as activation capability.
- runtime remains intentionally disabled.

## Provider Governance Barrel

Conceptual file:

- `lib/src/provider_governance/provider_governance.dart`

Stage 1 default:

- do not export provider onboarding/runtime provider surfaces until semantic review.

Reason:

- provider execution remains blocked.
- provider SDK integrations remain excluded.
