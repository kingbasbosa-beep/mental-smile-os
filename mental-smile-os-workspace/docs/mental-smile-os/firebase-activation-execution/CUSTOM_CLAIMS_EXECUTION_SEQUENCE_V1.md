# CUSTOM_CLAIMS_EXECUTION_SEQUENCE_V1

## Objective

Prepare custom claims for Generation 1 without mutating production users.

## Approved Claim Families

| Claim | Purpose | Status |
| --- | --- | --- |
| `owner` | Owner authority | REQUIRED |
| `client` | Client runtime identity | REQUIRED |
| `clinician` | Provider runtime identity currently used by code/rules | REQUIRED_RUNTIME_NAME |
| `center` | Center runtime identity | REQUIRED |
| `monitoring` | Monitoring observation role | REQUIRED_IF_MONITORING_ACTIVE |
| `archive` | Archive access role | REQUIRED_IF_ARCHIVE_ACTIVE |
| `strategic` | Strategic intelligence access role | REQUIRED_IF_STRATEGIC_ACTIVE |

## Naming Decision

Current runtime uses `clinician`.

Doctrine previously used `provider` conceptually. Before activation, Owner must either:

- accept `clinician` as the Generation 1 runtime claim name, or
- authorize a separate provider/clinician claim alignment patch.

## Exact Execution Sequence

1. Inventory active custom claim usage in rules and code.
2. Confirm no `admin` claim is required.
3. Confirm no fallback admin authority exists.
4. Confirm owner authority maps to `role == 'owner'` where used.
5. Confirm monitoring role cannot authorize owner actions.
6. Create non-production claim assignment script or console checklist.
7. Test claims on non-production users first.
8. Validate access paths by role.
9. Stop before production claim mutation.

## Forbidden

- No `admin` claim.
- No `superAdmin` claim.
- No hidden owner collection.
- No wildcard authority.
- No production claim mutation without Owner confirmation.

