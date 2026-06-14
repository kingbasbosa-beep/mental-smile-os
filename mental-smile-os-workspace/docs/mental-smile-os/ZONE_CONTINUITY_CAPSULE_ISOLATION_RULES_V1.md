# Zone Continuity Capsule Isolation Rules V1

Status: ACTIVE_CAPSULE_ISOLATION_RULES
Prompt Asset: PROMPT_ASSET_034

## Isolation Rule

Capsule belongs to Local Zone Gateway Only.

No foreign zone access.

No direct reads.

No direct writes.

## Forbidden

- Foreign zone capsule reads.
- Foreign zone capsule writes.
- Direct component access.
- Strategic Planning direct access.
- Archive direct access.
- Owner bypass of capsule lifecycle.
- Permanent storage behavior.
- Analytics.
- AI analysis.
- Reports.

## Required Access Path

Signal Package -> Local Zone Gateway -> Local Continuity Capsule.

Replay Path:

Local Continuity Capsule -> Local Zone Gateway -> Restored Zone.

