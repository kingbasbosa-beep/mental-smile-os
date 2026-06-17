# Center Field Change Audit Rule V1

Status: ACTIVE_FIELD_CHANGE_AUDIT_RULE
Prompt Asset: PROMPT_ASSET_042

## Audit Rule

Every center field modification must check:

- Field parity mapping.
- Public display source.
- Privacy status.
- Review status.
- Owner.
- Allowed mutation source.
- Placeholder removal status.
- Duplicate field path status.
- Temporary field expiry status.

## Forbidden

- Unmapped public fields.
- Active dead placeholders.
- Deprecated active fields.
- Duplicate field paths.
- Temporary fields without expiry.

