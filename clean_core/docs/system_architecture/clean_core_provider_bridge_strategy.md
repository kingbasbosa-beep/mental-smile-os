# clean_core Provider Bridge Strategy

This strategy defines future provider bridge isolation without implementing provider execution.

## Provider Ownership

Provider lifecycle and execution remain outside clean_core.

The backend/host owns:

- provider SDKs
- API keys
- networking
- request execution
- model/provider selection
- provider health checks
- provider isolation
- provider shutdown

## clean_core Role

clean_core may define future pure contracts for:

- provider capability scopes
- provider approval markers
- provider onboarding state
- provider blocked results
- provider audit/review references
- fallback-only states

clean_core must not import:

- OpenAI/Gemini/provider SDKs
- HTTP clients
- streaming clients
- credential managers
- provider runtime packages

## Provider Bridge Flow

1. Host/backend receives a provider-intent candidate.
2. Policy/governance contracts are consulted.
3. Backend authority decides whether execution may occur.
4. Provider bridge executes externally if approved.
5. Result returns through validation/fallback/audit contracts.

## Provider Failure Behavior

If provider unavailable or blocked:

- no hidden provider switching
- no client-side bypass
- fallback-only state
- review required where sensitive
- audit signal later if required

## Strategy Verdict

Provider adapters may consume clean_core contracts, but provider runtime remains externally owned and blocked until governance approves activation.
