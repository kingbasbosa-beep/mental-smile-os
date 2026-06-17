# Signal Pipe Model V1

Status: ACTIVE_CONNECTION_MODEL
Connection Type: SIGNAL_PIPE

## 1. Purpose

Signal Pipe is a controlled communication channel between surfaces for state, request, review, validation, or package readiness notices.

It is not runtime execution and not shared business logic.

## 2. Required Fields

- Signal Pipe ID.
- Signal Source Surface.
- Signal Consumer Surface.
- Trigger Condition.
- Expected Outcome.
- Related Prompt.
- Related Card Package.
- Memory Registration Target.
- Status.

## 3. Rules

Every Signal Pipe must:

- Have a named source.
- Have a named consumer.
- Have a trigger condition.
- Have an expected outcome.
- Register in memory when constitutionally relevant.

Forbidden:

- Anonymous signals.
- Hidden cross-surface state mutation.
- Runtime execution through Signal Pipe.
- Authorization by signal alone without DNA or Owner authority.

## 4. Zone Gateway Transfer Rule

Signals move only through:

Zone Gateway -> Signal Pipe -> Target Zone Gateway.

No internal component may send directly to another zone.

No direct room-to-library, tool-to-provider, content-to-client, or center-to-client transfer is allowed.

## 5. Gateway Reporting And Buffering

Signal Pipe packages may be counted, classified, summarized, buffered, and replayed only by approved Zone Gateways as defined in:

- ZONE_GATEWAY_REPORTING_MODEL_V1.
- ZONE_EMERGENCY_BUFFER_MODEL_V1.

This model still does not create runtime, queues, Firebase, signal execution, or AI analysis.
