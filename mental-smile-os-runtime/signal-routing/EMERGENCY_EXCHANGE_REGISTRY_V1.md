# EMERGENCY_EXCHANGE_REGISTRY_V1

Status: REGISTERED_DORMANT_NOT_IMPLEMENTED

## Registry Entry

| Exchange ID | Purpose | Default State | Activation Condition | Retention | Status |
|---|---|---|---|---|---|
| FEDERATION_EMERGENCY_EXCHANGE | Emergency signal exchange for catastrophic gateway failure only. | DORMANT | Catastrophic gateway failure where a local gateway cannot receive or forward required signal packages. | 24 hours maximum | REGISTERED_DORMANT_NOT_IMPLEMENTED |

## Allowed Responsibilities

FEDERATION_EMERGENCY_EXCHANGE may:

- Receive emergency signal packages.
- Buffer emergency signal packages.
- Forward emergency signal packages to restored or replacement gateways.
- Log emergency exchange metadata.

## Forbidden Responsibilities

FEDERATION_EMERGENCY_EXCHANGE may not:

- Govern.
- Analyze.
- Execute.
- Approve.
- Replace gateways.
- Become normal runtime routing.
- Own signals.
- Mutate source zones.
- Mutate target zones.

## Dormancy Rule

The emergency exchange is dormant by default. It is not part of normal signal routing and must not be used to bypass local zone gateways.

## Retention Rule

Emergency exchange retention is 24 hours maximum. After successful forwarding or restoration, buffered emergency packages must be purged.

## Implementation Boundary

This registry creates no runtime exchange, no queue, no Firebase configuration, and no executable emergency service.
