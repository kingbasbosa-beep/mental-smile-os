# ROUTE_SMOKE_VALIDATION_V1

## Objective

Validate active route registration and basic reachability.

## Route Sources

- `lib/app/router/routes.dart`
- `lib/app/router/app_router.dart`

## Smoke Validation Groups

| Group | Example Routes | Expected Result |
| --- | --- | --- |
| Public portal | `/`, `/about`, `/library`, `/contact` | Opens public pages |
| App entry | `/splash`, `/login`, `/home`, `/menu` | Opens entry surfaces |
| Registration | `/register/client`, `/register/clinician`, `/register/center` | Opens registration surfaces |
| Library | `/web/library`, `/web/library/policy`, `/module/library` | Opens library surfaces |
| Client | `/client/dashboard`, `/s/personal-space` | Requires signed-in client where protected |
| Provider | `/clinician/room`, `/clinician/chat-inbox` | Requires clinician role |
| Center | `/center/dashboard`, `/center/room` | Requires center role |
| Owner | `/s/owner`, `/owner/os/construction-workbench` | Requires owner role |
| Monitoring | `/s/capital/signal-monitoring-room`, `/s/capital/reports` | Requires monitoring role |

## Exact Sequence

1. Launch runtime locally after successful build.
2. Open each public route.
3. Confirm protected routes redirect unauthenticated users to login.
4. Confirm role-protected routes reject wrong roles.
5. Confirm unknown routes return safe not-found/fallback behavior.
6. Record route failures.

## Pass Criteria

- Public routes open.
- Protected routes do not leak protected pages.
- Wrong-role access is blocked.
- No route throws runtime exception during navigation.

