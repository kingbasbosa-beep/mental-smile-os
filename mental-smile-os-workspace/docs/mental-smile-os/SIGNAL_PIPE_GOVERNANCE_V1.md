# Signal Pipe Governance V1

Status: ACTIVE_SIGNAL_PIPE_GOVERNANCE
Prompt Asset: PROMPT_ASSET_029
Latest Foundational Gateway Prompt: PROMPT_ASSET_031
Latest App Room Internal Network Prompt: PROMPT_ASSET_032
Latest Federation Authority Prompt: PROMPT_ASSET_033

## 1. Signal Pipe Rule

Signals move only through this path:

Zone Gateway -> Signal Pipe -> Target Zone Gateway.

No direct room-to-library.

No direct tool-to-provider.

No direct content-to-client.

No direct center-to-client.

## 2. App Room Zone Outbound Pipes

APP_ROOM_ZONE_GATEWAY may send only to:

- LIBRARY_WEB_ZONE_GATEWAY.
- PROVIDER_WEB_ZONE_GATEWAY.
- CENTER_WEB_ZONE_GATEWAY.
- ADMIN_OWNER_ZONE_GATEWAY.
- SMART_ARCHIVE_ZONE_GATEWAY.

Registered pipe IDs:

- PIPE_TO_LIBRARY_WEB_ZONE.
- PIPE_TO_PROVIDER_WEB_ZONE.
- PIPE_TO_CENTER_WEB_ZONE.
- PIPE_TO_ADMIN_OWNER_ZONE.
- PIPE_TO_SMART_ARCHIVE_ZONE.

No additional APP_ROOM_ZONE_GATEWAY outbound pipes are approved.

## 2A. App Room Internal Routing Boundary

App Room internal surfaces may not access these pipes directly.

All App Room signal packages must first terminate at APP_ROOM_ZONE_GATEWAY.

## 3. Library Web Zone Example

Library Web Zone may record:

Received: 500 tool-related signals.

Sent: 500 eligible content candidate signals.

The Library Gateway distributes signals internally to library sections.

Library sections do not talk directly to Client Room.

## 4. Forbidden

- Direct component-to-zone signal transfer.
- Direct tool-to-provider signal transfer.
- Direct content-to-client signal transfer.
- Direct center-to-client signal transfer.
- Signal execution engines.
- Runtime queues.
- Firebase persistence.

## 5. Federation Signal Authority

Signals belong to the source zone, not the destination zone.

Forwarding through a Signal Pipe does not transfer ownership.

Signal Pipes transport packages only. They do not authorize, govern, execute, or mutate data.
