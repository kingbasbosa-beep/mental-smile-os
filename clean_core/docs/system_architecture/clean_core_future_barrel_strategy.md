# Clean Core Future Barrel Strategy

Draft barrel/export guidance. No real barrel files were created.

## Barrel Principle

Barrel files should be curated API boundaries, not convenience export dumps. Every exported file should be reviewed for stability, ownership, and extraction safety.

## Future Barrel Types

### Stable Public Barrels

Purpose: expose reviewed stable contracts.

Rules:

- Export only pure Dart contracts.
- Prefer stable enums, value objects, policies, guards, fallbacks, and references.
- Do not export internal markers, temporary topology details, generated files, UI, Firebase setup, or runtime adapters.

### Experimental Barrels

Purpose: optional future channel for unstable contracts.

Rules:

- Keep separate from stable API.
- Clearly mark as unstable.
- Avoid using for app-critical behavior.
- Do not include runtime execution or provider SDKs.

### Internal Barrels

Purpose: local organization only.

Rules:

- Do not expose as package public API.
- May include internal markers and planning structures.
- Should remain hidden until reviewed.

## Avoid

- `export 'src/everything.dart';` style broad surfaces.
- Wildcard-style public APIs by folder.
- Exporting all `lib/core/*` automatically.
- Exporting Flutter UI, Firebase, generated files, platform setup, routing, assets, or localization generation.
- Exporting runtime/provider execution paths.

## Suggested Future Barrel Groups

- `legal.dart`
- `safety.dart`
- `governance.dart`
- `audit.dart`
- `provider_governance.dart`
- `runtime_governance.dart`
- `review.dart`
- `backend_boundaries.dart`
- `observability.dart`
- `environment.dart`
- `policy_runtime.dart`

These names are planning candidates only.

## Explicit Non-Action

No barrel files were created. No export graph was changed.
