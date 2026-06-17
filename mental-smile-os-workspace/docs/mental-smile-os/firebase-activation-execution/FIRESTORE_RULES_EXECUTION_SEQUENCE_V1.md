# FIRESTORE_RULES_EXECUTION_SEQUENCE_V1

## Objective

Prepare Firestore rules for Generation 1 activation without deploying.

## Exact Execution Sequence

1. Open `firestore.rules`.
2. Confirm no active rule grants access through `admin`, `admins`, `administrator`, super-admin, or wildcard authority.
3. Confirm privileged owner access is claim-based.
4. Remove duplicate `isMonitoringOperator()` helper only after confirming both definitions are identical or safely mergeable.
5. Confirm monitoring helpers do not authorize mutation outside monitoring scope.
6. Confirm deny-all fallback remains active.
7. Confirm `signal_events` access aligns with signal federation doctrine.
8. Confirm runtime collections are either approved or explicitly mapped:
   - `clients`
   - `clinicians`
   - `centers`
   - `support_requests`
   - `signal_events`
   - `chat_threads`
   - `analytics_summaries`
9. Decide policy for `analytics_summaries`:
   - server-only retention
   - archive/monitoring read
   - no client access
10. Run Firestore rules validation.
11. Stop before deployment.

## Validation Points

```powershell
firebase deploy --only firestore:rules --dry-run
firebase deploy --only firestore:indexes --dry-run
```

## Approval Gate

Owner must approve:

- duplicate helper cleanup
- final collection authority map
- `analytics_summaries` policy
- deployment timing

