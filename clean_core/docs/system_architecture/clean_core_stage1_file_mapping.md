# Clean Core Stage 1 File Mapping

Draft source-to-future package mapping. No files were moved.

## Mapping Principle

Current paths should map to a future package structure only after import and semantic review.

## Candidate Mapping

| Current Source Path | Future Package Area | Stage 1 Status |
| --- | --- | --- |
| `lib/core/backend_boundaries/` | `src/backend_boundaries/` | Stage 1 candidate |
| `lib/core/policy_runtime/` | `src/policy_runtime/` | Stage 1 candidate |
| `lib/core/safety_decision/` | `src/safety_decision/` | Stage 1 candidate |
| `lib/core/trusted_backend/` | `src/trusted_backend/` | Stage 1 candidate |
| `lib/core/trusted_pipeline/` | `src/trusted_pipeline/` | Stage 1 candidate |
| `lib/core/governance_kernel/` | `src/governance/kernel/` | Stage 1 after review |
| `lib/core/governance_lifecycle/` | `src/governance/lifecycle/` | Stage 1 after review |
| `lib/core/governance_compliance/` | `src/governance/compliance/` | Stage 1 after review |
| `lib/core/governance_federation/` | `src/governance/federation/` | Stage 1 after review |
| `lib/core/governance_capability/` | `src/governance/capability/` | Stage 1 after review |
| `lib/core/provider_governance/` | `src/provider_governance/` | After semantic review |
| `lib/core/provider_onboarding/` | `src/provider_onboarding/` | After semantic review |
| `lib/core/runtime_environment/` | `src/runtime_governance/environment/` | After semantic review |
| `lib/core/runtime_execution/` | `src/runtime_governance/execution_boundary/` | After semantic review |
| `lib/core/runtime_activation/` | `src/runtime_governance/activation/` | Runtime-deferred contract review |
| `lib/core/runtime_wiring/` | `src/runtime_governance/wiring/` | Runtime-deferred contract review |
| `lib/core/runtime_enablement/` | `src/runtime_governance/enablement/` | Runtime-deferred contract review |
| `lib/core/execution_routing/` | `src/runtime_governance/routing/` | Runtime-deferred contract review |
| `lib/core/runtime_rollback/` | `src/runtime_governance/rollback/` | Runtime-deferred contract review |
| `lib/core/runtime_observability/` | `src/runtime_governance/observability/` | Runtime-deferred contract review |
| `lib/core/runtime_isolation/` | `src/runtime_governance/isolation/` | Runtime-deferred contract review |
| `lib/core/runtime_release/` | `src/runtime_governance/release/` | Internal/deferred review |
| `lib/core/runtime_bootstrap/` | `src/runtime_governance/bootstrap/` | Internal/deferred review |
| `lib/core/architecture_manifest/` | `src/architecture_manifest/` | Internal/public decision required |
| `lib/core/system_topology/` | `src/system_topology/` | Internal/public decision required |

## Partial Mapping Only

These directories require file-by-file decisions:

- `lib/core/ai_safety/`
- `lib/core/audit/`
- `lib/core/human_review/`
- `lib/core/legal/`

Reason: some files are pure contracts, while others import `cloud_firestore`.

## Must Not Enter Stage 1

- `lib/main.dart`
- `lib/firebase_options.dart`
- `lib/app/**`
- `lib/l10n/**`
- `lib/features/**`
- `lib/shared/ui_kit/**`
- `lib/core/auth/**`
- `lib/core/storage/**`
- `assets/**`
- Existing app-coupled tests.

## Explicit Non-Action

This mapping is conceptual only and does not move files.
