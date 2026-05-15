# Clean Core Export-Safe Surface Summary

Draft summary of future export-safe surfaces.

## Export-Safe Candidates

Likely future export-safe areas after import verification:

- Pure Dart contracts.
- Legal consent and legal disclaimer contracts.
- Safety contracts.
- Governance contracts.
- Policy contracts.
- Audit/review contracts.
- Backend-boundary contracts.
- Trusted backend and trusted pipeline contracts.
- Provider governance contracts after semantic review.
- Runtime-disabled governance markers after stability review.
- Adapter contracts after ownership review.

## Export Rules

- Curated exports only.
- No broad export-all barrels.
- Stable contracts first.
- Internal markers hidden unless stabilized.
- Fail-closed defaults preserved.
- Runtime/provider execution disabled.
- Backend authority documented.

## Deferred / Non-Exportable Systems

Do not export in the initial surface:

- Firebase runtime.
- Provider SDKs.
- Routing/navigation implementation.
- Localization generation.
- Assets.
- Generated files.
- Flutter UI.
- App shell.
- Platform setup.
- Orchestration runtime.
- AI execution.
- Networking.
- Deployment/runtime activation.

## Explicit Non-Action

No export surface was created.
