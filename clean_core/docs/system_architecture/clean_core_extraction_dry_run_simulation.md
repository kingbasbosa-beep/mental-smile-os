# clean_core Extraction Dry-Run Simulation

## Status

This is a simulation-only plan. It does not create package files, move source files, rewrite imports, activate runtime systems, or enable provider execution.

## Simulation Objective

The dry run models Wave 1 extraction as if it were executed, so risks can be found before real package creation. The simulation focuses on:

- file movement impact
- import rewrite impact
- barrel/export exposure
- rollback checkpoints
- host-app stability
- hidden extraction risks

## Simulated Wave 1 Scope

Simulated batches:

- Batch 1: `lib/core/backend_boundaries/`, `lib/core/safety_decision/`
- Batch 2: `lib/core/policy_runtime/`
- Batch 3: `lib/core/trusted_backend/`, `lib/core/trusted_pipeline/`
- Batch 4: `lib/core/governance_kernel/`, `lib/core/governance_lifecycle/`, `lib/core/governance_compliance/`
- Batch 5: `lib/core/governance_capability/`, `lib/core/governance_federation/`

## Simulated Acceptance Criteria

The dry run is considered acceptable only if the simulated package remains:

- pure Dart
- contract-only
- Firebase-free
- Flutter UI-free
- generated-file-free
- provider SDK-free
- networking-free
- runtime-disabled
- provider-blocked
- backend-authority preserving
- fail-closed
- deny-by-default

## Hidden Risk Themes

Risks to watch during the real move:

- package identity mismatch
- sibling import breakage
- barrel overexposure
- internal marker exposure
- runtime naming confusion
- provider governance misinterpretation
- Firebase timestamp/reference leakage
- test import coupling
- docs implying runtime readiness

## Simulation Verdict

Wave 1 remains feasible only as a staged, checkpointed extraction. A single broad move would increase contamination risk and weaken rollback clarity.
