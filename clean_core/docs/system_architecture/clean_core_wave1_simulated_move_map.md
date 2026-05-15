# clean_core Wave 1 Simulated Move Map

## Batch 1: Backend Boundaries and Safety Decision

| Current path | Future package path | Default visibility | Import rewrite expectation | Risk level | Rollback checkpoint |
| --- | --- | --- | --- | --- | --- |
| `lib/core/backend_boundaries/` | `mental_smile_clean_core/lib/src/backend_boundaries/` | Public after review | Internal sibling imports become package-local; host imports later become curated package imports | Low | After backend-boundary files move |
| `lib/core/safety_decision/` | `mental_smile_clean_core/lib/src/safety_decision/` | Public after review | Internal sibling imports become package-local; host imports later become curated package imports | Low | After safety-decision files move |

## Batch 2: Policy Runtime

| Current path | Future package path | Default visibility | Import rewrite expectation | Risk level | Rollback checkpoint |
| --- | --- | --- | --- | --- | --- |
| `lib/core/policy_runtime/` | `mental_smile_clean_core/lib/src/policy_runtime/` | Public after semantic review | Policy imports should remain package-local; host imports later target policy barrel | Medium | After policy files move and semantics are reviewed |

## Batch 3: Trusted Backend and Trusted Pipeline

| Current path | Future package path | Default visibility | Import rewrite expectation | Risk level | Rollback checkpoint |
| --- | --- | --- | --- | --- | --- |
| `lib/core/trusted_backend/` | `mental_smile_clean_core/lib/src/trusted_backend/` | Public after review | Boundary imports become package-local; host imports later target trusted backend barrel | Low-medium | After trusted backend files move |
| `lib/core/trusted_pipeline/` | `mental_smile_clean_core/lib/src/trusted_pipeline/` | Public after review | Pipeline imports become package-local; host imports later target trusted pipeline barrel | Low-medium | After trusted pipeline files move |

## Batch 4: Governance Kernel, Lifecycle, Compliance

| Current path | Future package path | Default visibility | Import rewrite expectation | Risk level | Rollback checkpoint |
| --- | --- | --- | --- | --- | --- |
| `lib/core/governance_kernel/` | `mental_smile_clean_core/lib/src/governance/kernel/` | Public after review | Governance imports become package-local; public exports remain curated | Medium | After kernel files move |
| `lib/core/governance_lifecycle/` | `mental_smile_clean_core/lib/src/governance/lifecycle/` | Public after review | Lifecycle imports become package-local; deferred references remain references only | Medium | After lifecycle files move |
| `lib/core/governance_compliance/` | `mental_smile_clean_core/lib/src/governance/compliance/` | Public after review | Compliance imports become package-local; legal/audit coupling must remain non-runtime | Medium | After compliance files move |

## Batch 5: Governance Capability and Federation

| Current path | Future package path | Default visibility | Import rewrite expectation | Risk level | Rollback checkpoint |
| --- | --- | --- | --- | --- | --- |
| `lib/core/governance_capability/` | `mental_smile_clean_core/lib/src/governance/capability/` | Review-required | Capability imports become package-local; public exposure requires semantic review | Medium-high | After capability files move |
| `lib/core/governance_federation/` | `mental_smile_clean_core/lib/src/governance/federation/` | Internal by default until review | Federation imports become package-local; export only after internal/public decision | Medium-high | Final Wave 1 rollback checkpoint |

## Simulated Exclusions

Do not simulate as Wave 1 moved files:

- `lib/core/ai_safety/`
- `lib/core/audit/`
- `lib/core/human_review/`
- `lib/core/legal/`
- `lib/core/auth/**`
- `lib/core/storage/**`
- app shell, UI, Firebase, generated, asset, and feature paths
