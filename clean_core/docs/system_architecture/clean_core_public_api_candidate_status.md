# Clean Core Public API Candidate Status

Draft status table for future public API candidates.

| Area | Candidate Status | Public API Guidance |
| --- | --- | --- |
| Legal | Stable public candidate | Export pure consent/disclaimer contracts after legal/import review. |
| Safety | Stable public candidate | Export non-diagnostic, runtime-disabled contracts. |
| Audit | Stable public candidate | Export privacy-first audit/reference contracts. |
| Backend boundaries | Stable public candidate | Export server-owned/protected-field contracts only. |
| Policy runtime | Stable public candidate | Export stable policy profiles and guards with fail-closed defaults. |
| Safety decision | Stable public candidate | Export deterministic decision contracts only. |
| Review/escalation | Review required | Confirm visibility, authority, and backend-governed semantics. |
| Trusted backend | Stable public candidate | Export boundary contracts, not backend runtime. |
| Trusted pipeline | Stable public candidate | Export pipeline contracts, not orchestration runtime. |
| Provider governance | Review required | Export governance-only subset after capability semantics settle. |
| Provider onboarding | Review required | Export candidate/profile contracts only after approval semantics settle. |
| Runtime governance | Review required | Export curated subset; many markers may remain internal. |
| Runtime activation/enablement | Deferred runtime candidate | Keep inactive and backend-governed; export only if needed as planning contracts. |
| Runtime wiring/routing | Deferred runtime candidate | Do not export active wiring/routing; contracts require review. |
| Runtime rollback/observability/isolation | Review required | Export only sanitized, inert governance contracts. |
| Runtime release/bootstrap | Internal or deferred | Keep internal until release/startup semantics stabilize. |
| Governance kernel/lifecycle/compliance | Review required | Export stable top-level contracts only. |
| Safety registry/capability | Review required | Avoid exposing registry internals as public API early. |
| Architecture manifest | Review required | Export docs and stable manifest entries; keep freeze internals internal. |
| Topology/readiness/federation | Internal-only candidate | Keep hidden until topology is stable. |
| Conversation/session | Review required | Export sanitized references only; avoid chat/runtime API. |
| Response composition | Review required | Export static support/fallback composition contracts only. |
| Safety memory | Review required | Export privacy-first boundary contracts only. |
| Flutter UI | App-owned exclusion | Do not export. |
| Firebase setup | App-owned exclusion | Do not export. |
| Routing/navigation | App-owned exclusion | Do not export. |
| Generated files | App-owned exclusion | Do not export. |
| Provider SDKs | Deferred runtime candidate | Do not export. |

## Status Definitions

- Stable public candidate: likely exportable after import verification.
- Review required: potentially exportable, but needs ownership/semantics review.
- Internal-only candidate: should remain hidden from public API.
- App-owned exclusion: should stay in host app.
- Adapter-required candidate: export contracts only, implementation remains host/backend-owned.
- Deferred runtime candidate: do not export until future runtime activation phase.

## Explicit Non-Action

No public API files, barrel exports, package identity changes, or runtime systems were created.
