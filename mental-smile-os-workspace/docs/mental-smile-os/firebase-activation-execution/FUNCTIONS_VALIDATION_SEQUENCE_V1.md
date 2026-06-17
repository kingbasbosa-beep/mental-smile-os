# FUNCTIONS_VALIDATION_SEQUENCE_V1

## Objective

Validate Firebase Functions readiness without deployment.

## Known Warning

Functions write `analytics_summaries`, while Firestore client rules currently deny general client access to that collection.

## Exact Execution Sequence

1. Inspect `functions` source.
2. Identify every Firestore collection written by Functions.
3. Identify every Storage path written by Functions.
4. Confirm Functions do not depend on legacy admin user authority.
5. Confirm Firebase Admin SDK usage is server infrastructure, not client authority.
6. Confirm `analytics_summaries` policy:
   - server-only
   - monitoring-readable
   - archive-readable
   - not used in Generation 1 runtime
7. Validate environment variables and secrets requirements.
8. Validate package installation.
9. Run Functions lint/test/build if configured.
10. Run deploy dry-run only if supported and owner-approved.
11. Stop before deployment.

## Validation Points

```powershell
firebase deploy --only functions --dry-run
```

## Approval Gate

Owner must approve whether `analytics_summaries` remains server-only or receives explicit monitoring/archive read policy.

