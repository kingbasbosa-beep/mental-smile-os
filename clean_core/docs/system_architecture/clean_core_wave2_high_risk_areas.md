# clean_core Wave 2 High-Risk Areas

This document records high-risk areas that should not be moved without deeper review.

## High-Risk Areas

| Area | Risk | Required Treatment |
| --- | --- | --- |
| `core/ai_runtime/` | Runtime/provider naming and guard semantics. | Block until runtime phase. |
| `core/ai_safety/` Firestore models | Direct `cloud_firestore` imports in several safety event/snapshot/trace files. | Split pure contracts from Firebase models first. |
| `core/runtime_*` | Names imply activation, execution, bootstrap, release, wiring, and observability. | Keep runtime-deferred/internal until runtime governance phase. |
| `core/provider_governance/` | Provider approval/capability semantics could imply execution authority. | Adapter-boundary review required. |
| `core/provider_onboarding/` | Onboarding could be misread as provider activation. | Adapter-boundary review required. |
| `core/system_topology/` | Federation/runtime topology may imply distributed authority. | Manual semantic review. |
| `core/secure_runtime_envelope/` | Runtime envelope language is activation-sensitive. | Defer until runtime bridge review. |
| `core/auth/` | Firebase/Auth/Flutter/user-session coupling. | Host-owned. |
| `core/storage/` | Shared preferences runtime dependency. | Host-owned. |
| `features/**` | UI/Firebase/routing/l10n/assets app flows. | Host-owned. |

## Specific Risk Themes

- Runtime orchestration.
- Distributed execution.
- Provider activation.
- Hidden runtime activation.
- Firebase execution leakage.
- Analytics leakage.
- Privilege escalation.
- Authority illusion from guards/policies.
- Safety data privacy leakage.

## High-Risk Verdict

High-risk areas should remain blocked or deferred until they are split into pure contracts, adapter boundaries, and host/backend-owned implementations.
