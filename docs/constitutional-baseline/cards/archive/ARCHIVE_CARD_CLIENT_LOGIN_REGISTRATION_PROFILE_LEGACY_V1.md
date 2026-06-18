# Archive Card Client Login Registration Profile Legacy V1

Status: ACTIVE_ARCHIVE_CARD
Classification: CLIENT_IDENTITY_EXTRACTION_LEGACY_CANDIDATE
Archive type: Client identity transition evidence
Runtime effect: none

## Subject

Client Login, Client Registration, and Client Profile persistence.

## Archive Reason

These surfaces became `LEGACY_CANDIDATE` because Mental Smile is moving toward account-free first access and fresh session-room intent.

The legacy surfaces are not removed in Phase 8. They are retained temporarily to avoid breaking account, dashboard, and downstream data flows.

## Evidence Value

This archive card preserves why these surfaces are candidates for future extraction:

- login-first entry can block early access
- registration can collect stale profile preferences
- profile persistence can become heavier than the user's current need
- dashboards may depend on old client registration fields

## Rule

Do not delete or remove these surfaces until:

```text
Finding
-> Decision
-> Archive
-> Owner Approval
-> Migration Plan
-> Runtime Implementation
-> Verification
-> Operation Registration
```

## Related Records

- `CLIENT_ACCESS_EXECUTION_DECISION_V1.md`
- `FINDING_CLIENT_ACCESS_ACCOUNT_FIRST_BARRIER_V1.md`
- `CLIENT_IDENTITY_EXTRACTION_DECISION_V1.md`
