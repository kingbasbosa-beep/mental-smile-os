# Clean Core Stage 1 Extraction Candidate List

Draft candidate list for Stage 1 extraction. This is documentation only and does not perform extraction.

## Stage 1 Goal

Extract only pure Dart, governance-first, fail-closed contracts that do not require host app runtime systems.

## Candidate Groups

### Strong Candidates

- `lib/core/backend_boundaries/`
- `lib/core/policy_runtime/`
- `lib/core/safety_decision/`
- `lib/core/trusted_backend/`
- `lib/core/trusted_pipeline/`
- `lib/core/provider_governance/`
- `lib/core/provider_onboarding/`
- `lib/core/conversation_session/`
- `lib/core/response_composition/`
- `lib/core/safety_memory/`
- `lib/core/safety_registry/`
- `lib/core/runtime_environment/`
- `lib/core/runtime_execution/`
- `lib/core/architecture_manifest/`
- `lib/core/system_topology/`
- `lib/core/governance_kernel/`
- `lib/core/governance_lifecycle/`
- `lib/core/governance_compliance/`
- `lib/core/governance_federation/`
- `lib/core/governance_capability/`

### Runtime Governance Candidates

Candidate after semantic review:

- `lib/core/runtime_activation/`
- `lib/core/runtime_wiring/`
- `lib/core/runtime_enablement/`
- `lib/core/execution_routing/`
- `lib/core/environment_activation/`
- `lib/core/runtime_rollback/`
- `lib/core/runtime_observability/`
- `lib/core/runtime_isolation/`
- `lib/core/runtime_release/`
- `lib/core/runtime_bootstrap/`
- `lib/core/runtime_readiness/`
- `lib/core/secure_runtime_envelope/`

### Partial Candidates

Export file-by-file only:

- `lib/core/ai_safety/`
- `lib/core/audit/`
- `lib/core/human_review/`
- `lib/core/legal/`

Reason: each contains some Firestore-coupled files that should be blocked or adapted before Stage 1.

## Excluded From Stage 1

- `lib/main.dart`
- `lib/firebase_options.dart`
- `lib/app/**`
- `lib/l10n/**`
- `lib/features/**`
- `lib/shared/ui_kit/**`
- `lib/core/auth/**`
- `lib/core/storage/**`
- `assets/**`
- Current `test/contracts/**` and `test/emulator/**` until import/package cleanup.

## Stage 1 Review Checklist

Before extraction:

- Confirm every selected file imports only Dart SDK or sibling clean_core files.
- Exclude any file importing Firebase, Flutter UI, generated l10n/config, router, assets, provider SDKs, networking, or app package paths.
- Confirm fail-closed and deny-by-default defaults remain intact.
- Confirm runtime/provider execution remains disabled.
