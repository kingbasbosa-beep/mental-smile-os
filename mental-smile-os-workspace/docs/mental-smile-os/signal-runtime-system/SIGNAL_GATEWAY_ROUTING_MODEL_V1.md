# SIGNAL_GATEWAY_ROUTING_MODEL_V1

Status: REGISTERED

## Gateway Routing Rule

All signals must terminate first at their local zone gateway before any cross-zone movement.

## Routing Flow

```text
Source Component
-> Local Signal Package
-> Local Zone Gateway
-> Classification
-> Count
-> Optional Summary
-> Approved Pipe
-> Target Gateway
```

## Gateway May

- Receive.
- Classify.
- Count.
- Summarize.
- Forward.
- Buffer.
- Replay from local continuity capsule.

## Gateway May Not

- Govern.
- Authorize.
- Execute.
- Own foreign signals.
- Mutate foreign zone data.
- Bypass approved pipes.

## Compliance Rule

Cross-zone signal routing without a local gateway is forbidden.
