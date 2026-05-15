# Clean Core Contamination Freeze Rules

Draft freeze rules for preserving extraction readiness.

## Hard Freeze Rules

Do not introduce into export-safe areas:

- New Firebase imports.
- `BuildContext` imports.
- Flutter UI dependencies.
- Generated file imports.
- Provider SDK imports.
- Router/navigation ownership.
- Platform bootstrapping.
- Asset bundle access.
- Network clients.
- Cloud Functions runtime.
- AI execution.
- Runtime activation.
- Orchestration execution.

## Import Rules

- No parent-path imports from export-safe contracts.
- No `../lib` imports.
- No legacy app package identity coupling.
- No generated localization imports in pure contracts.
- No Firebase options imports in core contracts.

## Authority Rules

- No privileged client writes.
- No client-side admin decisions.
- No client-side payment/review/payout decisions.
- No client-side risk/moderation/escalation authority.
- No provider-controlled runtime activation.
- Backend authority remains required for governance-sensitive operations.

## Runtime Rules

- Runtime disabled by default.
- Provider blocked by default.
- Review required by default where sensitive.
- Audit required by default where governance-sensitive.
- Fail closed if authority or boundary is missing.

## Explicit Non-Action

These rules are documentation-only and were not enforced by tooling in this phase.
