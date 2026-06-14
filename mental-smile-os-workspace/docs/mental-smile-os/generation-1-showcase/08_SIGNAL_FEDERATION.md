# Signal Federation

Mental Smile OS avoids direct dependencies between zones.

Instead, it uses signal federation.

## Signal Packages

A signal package is a structured message that describes activity, intent, status, or a transfer request.

Examples:

- A client selects a tool.
- A library district identifies eligible content.
- A provider public profile receives discovery activity.
- A gateway summarizes zone traffic.

## Gateways

Every zone has one primary gateway.

The gateway can:

- Receive.
- Count.
- Classify.
- Summarize.
- Forward.
- Buffer.

The gateway cannot:

- Govern.
- Authorize.
- Execute.
- Mutate another zone.

## Signal Pipes

Signals move through approved pipes:

Zone Gateway -> Signal Pipe -> Target Zone Gateway

No direct room-to-library dependency.

No direct tool-to-provider dependency.

No direct content-to-client dependency.

## Continuity

If a zone is temporarily unavailable, its continuity capsule can preserve signal packages for short-term replay.

This creates a simple survival rule:

Zone failure does not equal city failure.

