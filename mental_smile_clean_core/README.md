# mental_smile_clean_core

Pure Dart governance and boundary contracts for Mental Smile.

This package is declarative-only, non-executing, fail-closed, and deny-by-default. It contains governance, policy, safety, backend-boundary, trusted-boundary, and extraction-safe contract surfaces only.

## Package Posture

- Internal/private package.
- Pure Dart contracts only.
- Runtime remains host-owned.
- Backend execution remains backend-owned.
- Provider execution remains blocked.
- Governance and policy semantics are contract-only.

## This Package Is Not

- Not a runtime engine.
- Not a provider runtime.
- Not a Firebase implementation.
- Not an orchestration framework.
- Not a Flutter UI package.
- Not a networking layer.
- Not a deployment or activation system.

## Boundary Rules

The host app owns Firebase, auth, routing, localization, UI, platform setup, assets, analytics, telemetry, print/PDF/share runtimes, and provider SDK integrations. Backend systems own trusted execution and privileged authority.

This package may define stable contract language for those boundaries, but it must not execute them.
