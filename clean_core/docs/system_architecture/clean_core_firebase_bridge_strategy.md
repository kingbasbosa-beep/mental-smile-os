# clean_core Firebase Bridge Strategy

This strategy defines future Firebase bridge philosophy without implementing Firebase reconnect.

## Core Rule

No direct Firebase imports or Firebase runtime behavior may exist inside `mental_smile_clean_core`.

## Firebase Ownership

The host app/backend owns:

- Firebase initialization
- Firebase options/config
- Firestore runtime
- Firebase Auth runtime
- Cloud Functions runtime
- Storage runtime
- Analytics runtime
- Emulator setup
- security rules deployment

## clean_core Boundary

clean_core may define future pure Dart contracts for:

- safe data access intents
- protected field metadata
- trusted operation requests
- signed-operation placeholders
- audit/review markers
- blocked/fallback results

## Bridge Access Flow

1. Host app receives user/runtime event.
2. Host app creates a clean_core contract-shaped intent.
3. Governance validates intent before Firebase access.
4. Host/backend adapter executes Firebase interaction.
5. Backend validates authority for trusted writes.
6. Adapter returns safe result/fallback/block envelope.

## Authority Validation

Firebase bridge adapters must externalize:

- signed-operation enforcement
- protected field validation
- audit-link requirements
- review-required transitions
- backend-governed writes

## Denied Behavior

If authority is missing, stale, unsigned, or policy-conflicting:

- deny write
- preserve safe read-only state where allowed
- require review if applicable
- emit audit signal later if required
- never fall back to privileged client writes

## Strategy Verdict

Firebase reconnect is future host/backend work. clean_core remains Firebase-free and contract-only.
