# Clean Core Public API Surface Matrix

Draft API surface matrix for future extraction.

| Area | Visibility Level | Notes |
| --- | --- | --- |
| Legal/compliance contracts | Public/export-safe | Export after legal/import review. |
| Safety contracts | Public/export-safe | Runtime-disabled and non-diagnostic. |
| Policy contracts | Public/export-safe | Fail-closed and version-aware. |
| Audit/review contracts | Public/export-safe | Privacy-first and sanitized. |
| Backend-boundary contracts | Public/export-safe | Contracts only, no backend runtime. |
| Signed-operation contracts | Public/export-safe | Shape only, no signing implementation. |
| Feedback/control-room contracts | Public/export-safe after review | Operational contracts only, no dashboards/runtime. |
| Provider governance | Public/export-safe after semantic review | No SDKs or execution. |
| Human escalation/review | Public/export-safe after review | Backend-governed authority required. |
| Firebase bridges | Adapter-only | Host/backend implemented. |
| Auth/session bridges | Adapter-only | Host app implemented. |
| Routing/localization bridges | Adapter-only | Host app implemented. |
| Environment/config bridges | Adapter-only | Host app implemented. |
| Provider/backend bridges | Adapter-only | Backend/host implemented. |
| Runtime orchestration | Runtime-deferred | Not public API now. |
| Provider execution | Runtime-deferred | Not public API now. |
| Cloud Functions orchestration | Runtime-deferred | Backend-owned. |
| Flutter UI/app shell | Host-app-owned | Do not export. |
| Generated files/assets/platform setup | Host-app-owned | Do not export. |
| Internal topology/readiness/freeze markers | Internal-only | Hide until stabilized. |

## Versioning Expectations

- Stable contracts should follow semantic versioning after extraction.
- Additive changes should be preferred.
- Fail-closed behavior changes are breaking changes.
- Authority model changes are breaking changes.
- Runtime/provider activation changes require a separate approval phase.

## Deprecation Expectations

- Deprecate unstable placeholders before removal.
- Document replacement contracts.
- Avoid changing enum meanings after export.
- Keep audit-sensitive and review-sensitive contracts clearly documented.

## Explicit Non-Action

No API visibility was enforced in code.
