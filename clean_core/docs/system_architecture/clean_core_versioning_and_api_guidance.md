# Clean Core Versioning And API Guidance

Draft versioning guidance for a future extracted clean_core package.

## Versioning Expectations

Use semantic versioning after extraction:

- Patch: documentation clarifications, non-breaking helper additions, typo fixes.
- Minor: new stable contracts, new enum values that are fail-closed by default, new optional fields.
- Major: renamed contracts, removed fields, changed guard semantics, changed authority assumptions, or changed default safety posture.

## Governance Contract Evolution

- Prefer additive changes.
- Avoid changing enum meanings after export.
- Do not reuse removed enum names for new meanings.
- Keep default constructors and safe defaults stable when possible.
- Document any new runtime/provider capability as disabled by default.

## Deprecation Rules

- Mark unstable placeholders as internal before exporting.
- If an exported placeholder needs replacement, deprecate it before removal.
- Explain migration paths for renamed policy, guard, marker, and reference types.
- Avoid breaking changes while extraction is still settling.

## Safety And Authority Expectations

Exported APIs should preserve:

- Fail-closed behavior.
- Deny-by-default posture.
- Backend-governed authority.
- No client-side admin/governance/payment/risk authority.
- No provider execution by default.
- No runtime AI activation by default.

## Adapter Ownership Expectations

- Firebase/Auth adapters are host-app owned.
- Routing adapters are host-app owned.
- Localization adapters are host-app owned until a package l10n strategy exists.
- Provider adapters are backend/app owned and require future approval.
- Observability adapters must remain privacy-first and sanitized.

## Breaking Change Triggers

Treat these as major-version candidates after extraction:

- Changing fail-closed defaults to permissive defaults.
- Exposing runtime/provider execution.
- Moving backend authority to client-side code.
- Changing audit or review semantics.
- Exporting app-owned dependencies as public package API.

## Explicit Non-Action

No version was changed. No public API was created. No package extraction, runtime activation, provider integration, or deployment work was performed.
