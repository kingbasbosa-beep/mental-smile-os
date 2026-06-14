# Zone Continuity Capsule Lifecycle V1

Status: ACTIVE_CONTINUITY_LIFECYCLE
Prompt Asset: PROMPT_ASSET_034

## Lifecycle

Zone Offline

↓

Gateway Active

↓

Capsule Recording

↓

Zone Restored

↓

Replay

↓

Verification

↓

Auto Purge

## Lifecycle States

| State | Meaning |
| --- | --- |
| IDLE | Zone available; capsule is not actively preserving packages. |
| RECORDING | Zone unavailable; capsule records incoming signal packages temporarily. |
| REPLAYING | Zone restored; capsule replays pending packages. |
| VERIFYING | Replay success is being confirmed. |
| PURGED | Replay succeeded and stored packages were purged. |

## Boundary

Lifecycle states are constitutional only. No runtime state machine is created.

