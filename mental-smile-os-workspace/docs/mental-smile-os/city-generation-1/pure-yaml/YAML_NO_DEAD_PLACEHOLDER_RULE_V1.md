# YAML No Dead Placeholder Rule V1

Status: ACTIVE_YAML_PURITY_RULE
Prompt Asset: PROMPT_ASSET_045

## Rule

No YAML entry may remain active unless it maps to a registered OS asset, localization card, zone, owner, status, and lifecycle purpose.

## Required Actions

| Placeholder Type | Required Action |
| --- | --- |
| Unused asset path | REMOVE_IMMEDIATELY |
| Duplicate old/new path | REMOVE_OLD_PATH |
| Deprecated placeholder | REMOVE_IMMEDIATELY |
| Temporary entry without expiry | ADD_EXPIRY_OR_REMOVE |
| Legacy asset without OS name | ARCHIVE_AS_SOURCE_EVIDENCE |
| Localization key without card | REGISTER_OR_REMOVE |

## Boundary

This rule does not edit YAML.

It governs future YAML purification.

