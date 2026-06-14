# Provider No Dead Placeholder Rule V1

Status: ACTIVE_NO_DEAD_PLACEHOLDER_RULE
Scope: Provider Registration Web Zone and Provider Public Web Zone
Prompt Asset: PROMPT_ASSET_041

## 1. No Dead Placeholder Rule

After any modification:

- No unused placeholder may remain.
- No old field may remain without function.
- No old UI placeholder may remain.
- No deprecated registration field may remain active.
- No deprecated public profile field may remain active.
- No duplicate field path may remain.
- No temporary field may remain without expiry.

## 2. Placeholder Removal Model

| Decision | Meaning |
| --- | --- |
| REMOVE_IMMEDIATELY | Remove inactive placeholder from active zone documentation and future runtime scope. |
| REPLACE_WITH_NEW_FIELD | Replace placeholder with a mapped field that has parity, owner, and mutation source. |
| ARCHIVE_AS_SOURCE_EVIDENCE | Preserve only as source evidence in memory, not active zone. |
| NEVER_KEEP_IN_ACTIVE_ZONE | Dead placeholders may not survive inside active zone package. |

## 3. Rule

Provider Registration and Provider Public zones must not keep placeholders as active constitutional fields.

