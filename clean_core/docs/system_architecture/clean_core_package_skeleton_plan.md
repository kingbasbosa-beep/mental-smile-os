# Clean Core Package Skeleton Plan

Draft package skeleton plan for future extraction. No package files, pubspec changes, export barrels, file movement, import rewrites, runtime activation, Firebase setup, provider integration, or validation commands were performed.

## Future Package Name Options

Candidate package names:

- `mental_smile_clean_core`
- `mental_smile_core`
- `mental_smile_contracts`
- `mental_smile_governance_core`

Recommended first choice: `mental_smile_clean_core`

Reason:

- Clear project ownership.
- Describes extraction scope.
- Avoids implying runtime execution.
- Leaves room for future app/UI packages.

## Future Package Folder Shape

Conceptual shape:

```text
mental_smile_clean_core/
  lib/
    mental_smile_clean_core.dart
    src/
      backend_boundaries/
      policy_runtime/
      safety_decision/
      trusted_backend/
      trusted_pipeline/
      governance/
      provider_governance/
      runtime_governance/
      architecture_manifest/
      system_topology/
      internal/
      adapters/
      runtime_deferred/
  test/
    contracts/
  docs/
    system_architecture/
```

## Package Constraints

Stage 1 package must remain:

- Pure Dart first.
- No Flutter UI dependency.
- No Firebase dependency.
- No generated l10n/config/assets.
- No provider SDK dependency.
- No networking dependency.
- No runtime activation.
- No Cloud Functions runtime.

## Ownership Model

- Package owns contracts.
- Host app owns UI, Firebase, routing, generated files, assets, platform setup, environment runtime, and provider SDKs.
- Backend owns trusted operations, privileged writes, runtime/provider execution if later approved.

## Explicit Non-Action

This document does not create a package skeleton.
