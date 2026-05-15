# Clean Core Export Barrel Plan

Draft barrel strategy for future package extraction. No barrel files were created.

## Barrel Philosophy

Export barrels should be curated public contracts, not convenience dumps.

## Recommended Future Barrels

Conceptual barrels:

- `mental_smile_clean_core.dart`
- `src/backend_boundaries.dart`
- `src/policy_runtime.dart`
- `src/safety_decision.dart`
- `src/trusted_backend.dart`
- `src/trusted_pipeline.dart`
- `src/governance.dart`
- `src/provider_governance.dart`
- `src/runtime_governance.dart`
- `src/architecture_manifest.dart`

## Barrel Rules

- Review every export line.
- Keep internal-only files hidden.
- Keep adapter implementations hidden.
- Keep runtime-deferred implementations absent.
- Avoid exporting files that import Firebase, Flutter UI, generated files, app shell, provider SDKs, or networking.
- Avoid export-all by directory.
- Avoid exposing unstable markers unless intentionally public.

## Suggested Export Order

1. Stable enums and value objects.
2. Policy/guard/fallback contracts.
3. Audit/review reference contracts.
4. Backend boundary contracts.
5. Provider/runtime governance contracts after semantic review.
6. Architecture/topology contracts only after internal/public decision.

## Explicit Non-Action

No export barrels were created or modified.
