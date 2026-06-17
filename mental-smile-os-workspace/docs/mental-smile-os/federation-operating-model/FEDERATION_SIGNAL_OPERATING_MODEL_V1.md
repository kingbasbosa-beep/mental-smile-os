# FEDERATION_SIGNAL_OPERATING_MODEL_V1

## Purpose

Define how signals operate inside Generation 1.

## Signal Ownership

Signals belong to their source zone. Forwarding does not transfer ownership.

## Signal Flow

```text
Producer Surface or District
↓
Local Signal Package
↓
Local Zone Gateway
↓
Approved Signal Pipe
↓
Target Zone Gateway
↓
Target Zone Consumer
```

## Signal Operations

- Create.
- Classify.
- Count.
- Route.
- Monitor.
- Archive.
- Retain.
- Replay.
- Expire.

## Forbidden

- No direct room-to-library signals.
- No direct district-to-app signals.
- No direct content-to-client signals.
- No cross-zone mutation through signals.
- No ownership transfer through forwarding.
