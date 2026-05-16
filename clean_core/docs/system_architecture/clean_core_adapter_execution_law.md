# clean_core Adapter Execution Law

This law defines what future adapters may and must not do.

## Adapter May

- Translate clean_core contract intents into host/backend requests.
- Return safe result envelopes.
- Return blocked/fallback/review-required results.
- Attach audit/review references.
- Preserve visibility scopes.
- Enforce local preflight checks where safe.

## Adapter Must

- Fail closed on missing authority.
- Preserve deny-by-default behavior.
- Treat clean_core as contract source, not runtime authority.
- Defer trusted decisions to backend authority.
- Avoid hidden retries into privileged operations.
- Keep provider execution externally owned.

## Adapter Must Not

- Create authority.
- Bypass governance.
- Perform privileged client writes.
- Activate runtime independently.
- Switch providers silently.
- Import Firebase/provider SDKs inside clean_core.
- Expose hidden clean_core internals as runtime controls.
- Convert fallback into allow.

## Authority Law

Backend authority outranks host convenience. Governance decisions outrank adapter availability. Deny outranks allow. Review-required outranks automatic action.

## Execution Verdict

Adapters are controlled translators, not authorities.
