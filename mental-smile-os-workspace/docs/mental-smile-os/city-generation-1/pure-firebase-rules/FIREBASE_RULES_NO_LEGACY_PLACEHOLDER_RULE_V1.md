# Firebase Rules No Legacy Placeholder Rule V1

Status: ACTIVE_PURITIY_RULE
Prompt Asset: PROMPT_ASSET_045

## Rule

No Firebase rule placeholder may remain active unless it has a declared zone, authority source, owner, purpose, expiry, and validation status.

## Required Actions

| Placeholder Type | Required Action |
| --- | --- |
| Legacy collection without owner | REMOVE_IMMEDIATELY |
| Temporary rule without expiry | REMOVE_IMMEDIATELY |
| Deprecated path still active | REPLACE_WITH_REGISTERED_BOUNDARY |
| Duplicate legacy/new path | KEEP_REGISTERED_OS_PATH_ONLY |
| Unknown admin rule | ARCHIVE_AS_SOURCE_EVIDENCE |
| Undefined wildcard rule | NEVER_KEEP_IN_ACTIVE_RULESET |

## Boundary

This rule does not edit Firebase.

It controls future Firebase rule purification.

