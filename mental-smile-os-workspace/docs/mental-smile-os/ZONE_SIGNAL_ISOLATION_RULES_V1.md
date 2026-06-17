# Zone Signal Isolation Rules V1

Status: ACTIVE_SIGNAL_ISOLATION_RULES
Prompt Asset: PROMPT_ASSET_029

## 1. Isolation Rule

Internal components may communicate with their local Zone Gateway only.

They may not send signals directly to:

- Another zone.
- Another zone gateway.
- Another surface.
- Another surface component.
- Library sections.
- Provider public profile sections.
- Center public profile sections.
- Smart Archive records.
- Admin Owner rooms.

## 2. Required Transfer Path

Internal Component -> Local Zone Gateway -> Signal Pipe -> Target Zone Gateway -> Target Internal Distribution.

## 3. Forbidden Transfers

- Room to Library direct.
- Tool to Provider direct.
- Content to Client direct.
- Center to Client direct.
- Provider to Client direct.
- Library section to Client Room direct.
- Component to Smart Archive direct.
- Component to Strategic Planning direct.

## 4. Boundary

These rules create governance language only. They do not create runtime enforcement, signal engines, queues, Firebase rules, or code.

