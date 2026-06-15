# SIGNAL_REPLAY_MODEL_V1

Status: REGISTERED

## Replay Purpose

Replay restores temporarily preserved signal packages after zone or gateway recovery.

## Replay Flow

```text
Package Buffered
-> Gateway or Zone Restored
-> Replay Attempt
-> Target Receives
-> Verification
-> Auto Purge
```

## Replay Rules

- Replay must preserve original source zone.
- Replay must preserve original signal owner.
- Replay must preserve original timestamp.
- Replay must not duplicate ownership.
- Replay must not bypass gateway routing.
- Replay must purge temporary package after verification.

## Forbidden Replay

- Replay to a foreign zone without approved gateway.
- Replay after expiration.
- Replay as new source signal without trace.
- Replay from archive as active runtime without approval.
