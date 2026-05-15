# Clean Core Adapter-Only Contracts

Draft adapter-only contract guidance.

## Adapter-Only Areas

Future adapter-only contracts may cover:

- Firebase bridges.
- Auth/session bridges.
- Routing bridges.
- Localization bridges.
- Environment/config bridges.
- Provider bridges.
- Backend bridges.
- Observability bridges.
- Analytics bridges.
- Release/deployment bridges.
- Emulator/test bridges.

## Ownership Rules

- clean_core owns contracts only.
- Host app owns UI, routing, Firebase setup, localization, assets, platform setup, and environment loading.
- Backend owns trusted operations, provider execution, privileged writes, policy publication, and runtime orchestration if later approved.
- Test harness owns emulator startup.

## Implementation Rules

Adapter implementations must remain outside clean_core unless a later architecture phase explicitly approves otherwise.

Adapters must not:

- Hide runtime execution.
- Hide provider execution.
- Create signed authority client-side.
- Bypass review/audit requirements.
- Perform privileged client writes.

## Failure Rules

If an adapter is missing or unavailable:

- Fail closed.
- Preserve review-required state.
- Preserve audit requirements.
- Do not fallback to direct runtime access.

## Explicit Non-Action

No adapter contracts or implementations were created.
