# YAML Purification Queue V1

Status: PURIFICATION_QUEUE
Prompt Asset: PROMPT_ASSET_045

## Purpose

Track asset and localization YAML candidates that must be purified before future implementation.

## Queue

| Candidate | Risk | Required Action | Status |
| --- | --- | --- | --- |
| Old splash asset paths | Direct legacy dependency | RENAME_AND_REGISTER_OR_REMOVE | QUEUED |
| Old home asset paths | Direct legacy dependency | RENAME_AND_REGISTER_OR_REMOVE | QUEUED |
| Old client-room assets | Direct legacy dependency | RENAME_AND_REGISTER_OR_REMOVE | QUEUED |
| Duplicate old/new asset paths | Ambiguous runtime source | KEEP_OS_REGISTERED_PATH_ONLY | QUEUED |
| Deprecated placeholders | Dead placeholder risk | REMOVE_IMMEDIATELY | QUEUED |
| Temporary asset entries without expiry | Unbounded residue | REMOVE_OR_ASSIGN_EXPIRY | QUEUED |
| Localization placeholder keys | Unknown language ownership | REGISTER_OR_REMOVE | QUEUED |
| Unmapped image folders | Unknown asset ownership | EXTRACT_PURIFY_RECLASSIFY | QUEUED |

## Lifecycle

Extract.

Purify.

Reclassify.

Rebuild.

Register.

Only registered OS assets may enter future YAML.

