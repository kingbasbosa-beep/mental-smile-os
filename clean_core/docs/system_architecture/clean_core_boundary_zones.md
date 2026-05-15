# Clean Core Boundary Zones

Draft package-boundary classification for future extraction. No extraction was performed.

## Export-Safe Zone

Export-safe means suitable for future public package surface after import verification.

Examples:

- Pure Dart contracts.
- Governance contracts.
- Policy systems.
- Audit and review contracts.
- Runtime governance placeholders.
- Provider governance placeholders.
- Backend-boundary contracts.
- Legal consent models/helpers.
- Architecture manifests and documentation.

Rules:

- No Firebase imports.
- No Flutter UI imports unless explicitly placed in a future UI package layer.
- No generated config/localization imports.
- No route/app shell imports.
- No parent-path or legacy package imports.
- No runtime activation, provider execution, networking, or deployment behavior.

## Internal-Only Zone

Internal-only means useful for architecture planning but not stable enough to export as public API yet.

Examples:

- Experimental runtime planning structures.
- Temporary orchestration placeholders.
- Internal governance markers.
- Unstable topology structures.
- Internal readiness/sealing/lock markers that may change shape.

Rules:

- Keep package-private by documentation and future export discipline.
- Do not rely on these as external API until versioned.
- Keep them fail-closed and backend-governed.

## App-Owned Zone

App-owned means it should remain inside the host application.

Examples:

- Firebase initialization.
- Firebase options and generated config.
- Routing and navigation.
- Localization generation.
- Assets and asset manifests.
- Flutter UI pages and app shell.
- Generated files.
- Platform setup.
- Firestore-backed UI flows.
- Deferred admin/chat/payment/AI/legal/crisis feature screens.

Rules:

- Do not export as part of the first package surface.
- Wrap access through adapters if contracts need to reference them.
- Keep deployment and platform behavior app-owned.

## Adapter-Required Zone

Adapter-required means clean_core contracts may define interfaces/placeholders, but the host app must provide implementation later.

Examples:

- Firebase access.
- Auth access.
- Routing access.
- Localization access.
- Environment/config access.
- Observability bridges.
- Provider bridges.
- Asset resolution.
- Emulator/test setup.

Rules:

- Define contracts only in clean_core.
- Implement runtime adapters in the host app.
- Keep adapter contracts backend-governed where they touch sensitive workflows.
- Do not introduce live runtime behavior during boundary hardening.
