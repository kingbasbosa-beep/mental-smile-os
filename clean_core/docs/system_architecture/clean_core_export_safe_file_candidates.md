# Clean Core Export-Safe File Candidates

Draft Stage 1 candidate inventory from manual import scan. This list is not an extraction action and does not create exports.

## Stage 1 Candidate Principle

Stage 1 should include only pure Dart contracts that do not import Flutter UI, Firebase, generated files, router/app shell, provider SDKs, networking, or platform setup.

## Strong Stage 1 Candidate Directories

These directories appeared to be primarily sibling-import pure Dart contract surfaces during the scan:

- `lib/core/architecture_manifest/`
- `lib/core/backend_boundaries/`
- `lib/core/conversation_session/`
- `lib/core/environment_activation/`
- `lib/core/execution_routing/`
- `lib/core/governance_capability/`
- `lib/core/governance_compliance/`
- `lib/core/governance_federation/`
- `lib/core/governance_kernel/`
- `lib/core/governance_lifecycle/`
- `lib/core/policy_runtime/`
- `lib/core/provider_governance/`
- `lib/core/provider_onboarding/`
- `lib/core/response_composition/`
- `lib/core/runtime_activation/`
- `lib/core/runtime_bootstrap/`
- `lib/core/runtime_enablement/`
- `lib/core/runtime_environment/`
- `lib/core/runtime_execution/`
- `lib/core/runtime_isolation/`
- `lib/core/runtime_observability/`
- `lib/core/runtime_readiness/`
- `lib/core/runtime_release/`
- `lib/core/runtime_rollback/`
- `lib/core/runtime_wiring/`
- `lib/core/safety_decision/`
- `lib/core/safety_memory/`
- `lib/core/safety_registry/`
- `lib/core/secure_runtime_envelope/`
- `lib/core/system_topology/`
- `lib/core/trusted_backend/`
- `lib/core/trusted_pipeline/`

## Stage 1 Candidate With Partial Review

These areas include useful pure contracts but also contain blocked files:

- `lib/core/ai_safety/`
- `lib/core/audit/`
- `lib/core/human_review/`
- `lib/core/legal/`

Export only the files that do not import `cloud_firestore`, or defer the whole directory until adapter abstraction is complete.

## Documentation Candidates

Safe as documentation artifacts:

- `docs/system_architecture/**`
- `docs/legal/**`
- `docs/compliance/**`
- `docs/store_review/**`

## Test/Fixture Candidates

Not Stage 1 package tests yet:

- `test/contracts/**`
- `test/emulator/**`
- `test/safety/**`

These need package-import cleanup and separation into pure contract tests versus host/emulator tests.

## Required Manual Confirmation

Before extracting any candidate:

- Confirm imports are sibling/Dart-only.
- Confirm no Firebase or Flutter UI imports.
- Confirm no generated localization/config imports.
- Confirm no router or asset dependency.
- Confirm no runtime/provider execution path.
