# clean_core Scoped Reconnect Plan

This plan defines how the host app may reconnect to the extracted package after package identity exists.

## Reconnect Principles

- Reconnect only through curated exports.
- Keep host app runtime ownership intact.
- Keep runtime disabled and provider execution blocked.
- Reconnect contracts before adapters.
- Reconnect adapters before runtime bridges.

## Approved First Reconnect Candidates

- Backend boundary contract tests.
- Safety decision contract tests.
- Pure governance contract references after semantic review.
- Trusted backend/pipeline reference models where declarative-only.

## Deferred Reconnect Areas

- Firebase adapters.
- Auth/session adapters.
- Routing adapters.
- Localization/text adapters.
- Print/PDF/report export adapters.
- Observability/analytics adapters.
- Provider bridge adapters.
- Runtime orchestration bridges.

## Reconnect Sequence

1. Add local path dependency later.
2. Reconnect tests to the package barrel.
3. Reconnect host app references one small area at a time.
4. Preserve direct host runtime ownership.
5. Introduce adapter contracts only after boundary review.
6. Defer runtime bridges until governance approval.

## Reconnect Stop Conditions

- Broad import rewrite requested.
- Host app runtime depends on package hidden internals.
- Package imports host app code.
- Package imports Firebase/Flutter/generated files.
- Runtime/provider execution appears.
- Fail-closed defaults weaken.

## Verdict

Scoped reconnect is feasible after pubspec/path dependency approval. Broad reconnect is not approved.
