# FIREBASE_PURITY_AUDIT_V1

## Purpose

Compare Generation 1 Firebase constitution against actual Firebase state.

## Actual Firebase State

| Component | Actual State | Classification |
| --- | --- | --- |
| `firebase.json` | Functions, Firestore rules/indexes, Storage rules, Hosting `build/web`, Flutter project mapping | KEEP_WITH_WARNINGS |
| `.firebaserc` | Default project `mental-smile-app-clean` | KEEP_WITH_REVIEW |
| `firestore.rules` | Custom-claim authority with scoped collection rules and deny-all fallback | KEEP_WITH_WARNINGS |
| `storage.rules` | Owner authority only for public asset writes; clinician/center fallback role docs remain | KEEP_WITH_WARNINGS |
| `firestore.indexes.json` | Indexes for profile requests, support, chat, messages, signal events | KEEP |
| `functions/index.js` | Scheduled BigQuery analytics summary writer to `analytics_summaries` | KEEP_WITH_REVIEW |
| `functions/package.json` | Firebase Admin, Functions, BigQuery dependencies | KEEP_WITH_REVIEW |

## Admin Zero Verification

Admin Zero: PASS.

No Firestore rule grants authority through:

- `admin` claim.
- `admins` collection.
- `super_admin`.
- `god_mode`.
- wildcard admin authority.

Storage Admin Zero: PASS.

Storage helper is `isOwnerAuthority()` and allows only `request.auth.token.role == 'owner'`.

## Owner Claim Verification

Owner claim exists in:

- `firestore.rules`: `isOwner()` via `hasRole('owner')`.
- `storage.rules`: `isOwnerAuthority()` via `request.auth.token.role == 'owner'`.

## Monitoring Separation Verification

Monitoring is separated through `monitoring_operator` in Firestore rules.

Monitoring can read signal aggregates and signal events but cannot write them from client rules.

## Signal Federation Verification

Signal collections:

- `signal_events`: client-created only by actor matching `actorId == uid()`, with strict fields.
- `signal_aggregates`: read by Owner/Monitoring only; client writes disabled.

Signal Federation Status: PARTIAL_RUNTIME_READY.

## Forbidden Collection Verification

No active rule allows booking, payment, session, admin, or hidden owner collections.

Catch-all denies undefined collections.

## Result

Firebase purity is activation-ready with warnings.
