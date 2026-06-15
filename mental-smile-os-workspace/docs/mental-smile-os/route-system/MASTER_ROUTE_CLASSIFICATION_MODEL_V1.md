# MASTER_ROUTE_CLASSIFICATION_MODEL_V1

Status: REGISTERED

## Classification Fields

| Field | Required |
|---|---|
| Route ID | YES |
| Route Name | YES |
| Route Type | YES |
| Producer | YES |
| Consumer | YES |
| Owner | YES |
| Source Zone | YES |
| Target Zone | YES if cross-zone |
| Allowed Flow | YES |
| Forbidden Flow | YES |
| Lifecycle State | YES |
| Archive Policy | YES |
| Compliance Status | YES |
| Runtime Status | YES |

## Route Types

| Type | Description |
|---|---|
| INTERNAL_ROUTE | Route remains inside one zone. |
| GATEWAY_ROUTE | Route terminates at local zone gateway. |
| CROSS_ZONE_ROUTE | Route travels gateway to gateway through approved pipe. |
| MONITORING_ROUTE | Route carries observation or health visibility. |
| STRATEGIC_ROUTE | Route carries summaries or analysis inputs. |
| ARCHIVE_ROUTE | Route carries snapshots, records, or clone packages. |
| EMERGENCY_ROUTE | Route is dormant and used only for catastrophic gateway failure. |
| CONTINUITY_ROUTE | Route preserves and replays packages through a local capsule. |

## Runtime Status Values

- DOCUMENTED_ONLY
- REGISTERED_NOT_IMPLEMENTED
- IMPLEMENTATION_READY
- ACTIVE
- SUSPENDED
- RETIRED
- ARCHIVED

## Compliance Classification

- COMPLIANT
- COMPLIANT_WITH_WARNINGS
- BLOCKED
- CONSTITUTIONAL_VIOLATION
- UNKNOWN
