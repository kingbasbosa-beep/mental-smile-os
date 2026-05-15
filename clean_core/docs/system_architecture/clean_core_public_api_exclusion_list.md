# Clean Core Public API Exclusion List

Draft exclusion list for future package extraction.

## App-Owned Exclusions

The following should not be exported in the initial clean_core public API:

- Flutter UI pages and widgets.
- App shell and navigation scaffolding.
- Router files, route constants, deferred route implementations, and navigation adapters.
- Firebase initialization and Firebase options.
- Firestore-backed UI flows.
- Firebase Auth state management.
- Firebase Storage and Functions runtime implementation.
- Generated localization files.
- Generated Firebase/plugin/config files.
- Assets and asset-generated files.
- Android, iOS, web, and desktop platform setup.
- App-specific dependency injection runtime.

## Runtime Exclusions

The following remain deferred and inactive:

- Runtime AI execution.
- Provider execution.
- Provider SDKs and API clients.
- OpenAI/Gemini/local provider integrations.
- Chat AI runtime.
- Crisis automation.
- Escalation automation.
- Cloud Functions runtime orchestration.
- Telemetry/analytics runtime.
- Deployment/store release activation.

## Internal-Only Exclusions

Do not expose early:

- Temporary orchestration placeholders.
- Internal lock/seal/readiness markers.
- Unstable topology internals.
- Architecture freeze internals.
- Runtime bootstrap/release internals unless reviewed.
- Any placeholder whose semantics are not stable enough for semantic versioning.

## Adapter Implementation Exclusions

clean_core may define future contracts, but implementation should remain outside the exported core:

- Firebase adapters.
- Auth adapters.
- Routing adapters.
- Localization adapters.
- Environment/config adapters.
- Observability pipeline adapters.
- Provider SDK adapters.

## Required Notes For Future Export

If a currently excluded area is reconsidered:

- Define ownership first.
- Add adapter boundary first.
- Verify import graph.
- Preserve fail-closed defaults.
- Keep backend authority over sensitive governance.
- Do not activate runtime/provider behavior during export.

## Explicit Non-Action

This exclusion list does not delete, move, hide, or export files.
