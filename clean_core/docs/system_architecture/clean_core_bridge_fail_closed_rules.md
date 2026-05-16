# clean_core Bridge Fail-Closed Rules

Future bridge behavior must preserve fail-closed and deny-by-default posture.

## Failure Cases

| Failure | Required Behavior |
| --- | --- |
| Adapter unavailable | Return blocked/fallback-only state. |
| Backend unavailable | Block trusted operation and require retry/review. |
| Firebase unavailable | Do not mutate protected state. |
| Auth/session missing | Treat as unauthenticated and deny sensitive action. |
| Provider unavailable | Fallback-only; no hidden provider switch. |
| Unsigned operation | Block. |
| Missing audit link | Block if audit required. |
| Governance validation failure | Deny or review-required. |
| Localization unavailable | Safe fallback copy; no runtime activation. |
| Print/export unavailable | Keep report visible only if allowed; no silent data leak. |

## Denied Reconnect Behavior

If reconnect is denied:

- keep current host behavior stable
- do not create alternate runtime route
- document blocked reason
- preserve rollback path

## Missing Bridge Behavior

If a bridge has not been implemented:

- contract remains inert
- runtime remains disabled
- feature should show safe unavailable/fallback state where applicable

## Rule Verdict

Bridge failure must reduce capability, not increase it.
