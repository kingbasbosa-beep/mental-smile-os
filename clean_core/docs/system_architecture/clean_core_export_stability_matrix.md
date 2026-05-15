# Clean Core Export Stability Matrix

Draft stability matrix for future public API review.

| Area | Stability Class | Export Guidance |
| --- | --- | --- |
| Legal consent models | Stable candidate | Export after import verification and legal review notes remain draft-safe. |
| Legal text copy | Review required | Arabic-first copy is reusable, but final legal wording needs counsel review. |
| AI safety enums/contracts | Stable candidate | Export as runtime-disabled, non-diagnostic contracts. |
| Audit contracts | Stable candidate | Export privacy-first shapes with sanitized previews and references. |
| Backend boundary contracts | Stable candidate | Export contracts only, no Cloud Functions/runtime implementation. |
| Human review/escalation contracts | Review required | Export after visibility and authority semantics are reviewed. |
| Runtime policy profiles | Stable candidate | Export stable policies and modes with fail-closed defaults. |
| Runtime governance layers | Review required | Export curated subset; many markers may remain internal. |
| Provider governance contracts | Review required | Export governance only; SDK/provider execution remains app/backend-owned. |
| Provider onboarding contracts | Review required | Export only after capability naming and approval semantics settle. |
| Governance topology/readiness/federation | Unstable/internal | Keep internal until topology shape stabilizes. |
| Runtime bootstrap/release/rollback internals | Unstable/internal | Keep internal unless a stable external integration need is proven. |
| Flutter UI | App-owned only | Do not export in first package surface. |
| Firebase setup/options | App-owned only | Do not export. |
| Router/navigation | App-owned only | Adapter required before export. |
| Localization/generated files | App-owned only | Adapter/package l10n strategy required before export. |
| Assets/platform setup | App-owned only | Do not export until package asset strategy exists. |
| Provider SDK adapters | Deferred until runtime activation phase | No SDK integration before backend-governed approval. |

## Stability Labels

- Stable candidate: likely suitable for public API after import verification.
- Review required: may be exportable, but semantics or ownership need review.
- Unstable/internal: keep hidden from public API for now.
- App-owned only: remains in host app.
- Adapter-required: export contracts only; implementation stays app/backend-owned.
- Deferred until runtime activation phase: do not export yet.

## Explicit Non-Action

This matrix does not create exports or change package structure.
