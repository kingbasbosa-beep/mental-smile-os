# Clean Core Routing Boundary Plan

Draft routing boundary plan for future extraction. No routing adapter, import rewrite, package extraction, runtime activation, or command execution was performed.

## Routing Ownership

Routing and navigation remain host-app owned.

Host app owns:

- Router configuration.
- Route tables.
- Navigation stack.
- `BuildContext` navigation.
- Deferred placeholder route handling.
- Dialog/sheet/page presentation.

clean_core may define:

- Navigation intent records.
- Escalation intent contracts.
- Review-required route intents.
- Backend-blocked route intents.
- Safe fallback route intent markers.

## Boundary Rules

- No router imports inside pure contracts.
- No `BuildContext` assumptions inside pure contracts.
- No UI navigation execution inside clean_core.
- No route table ownership in clean_core.
- No direct Navigator/router calls in exported contracts.
- Host app maps intents to actual screens.

## Future Adapter Reconnect

Future routing adapter may accept:

- Route intent key.
- Required review marker.
- Block reason.
- Fallback route marker.
- Visibility scope.

Adapter implementation remains host-app owned.

## Failure Expectations

If routing adapter is unavailable:

- Preserve blocked/review-required state.
- Use safe placeholder if host app chooses.
- Do not activate runtime systems.
- Do not bypass governance review.

## Explicit Non-Action

No routing contracts or adapter implementations were created.
