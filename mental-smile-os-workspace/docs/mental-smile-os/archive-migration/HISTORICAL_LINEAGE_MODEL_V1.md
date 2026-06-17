# Historical Lineage Model V1

Status: LINEAGE_MODEL_CREATED
Prompt Asset: PROMPT_ASSET_051

## Purpose

Define how historical artifacts preserve origin, evolution, replacement, successor, archive status, and retention status.

## Lineage Fields

| Field | Meaning |
| --- | --- |
| Origin | Where the artifact came from. |
| Evolution | How the artifact changed over time. |
| Replacement | What replaced it, if replaced. |
| Successor | Current active successor package or concept. |
| Archive Status | Active, candidate, preserved, museum, unknown. |
| Retention Status | Permanent, long-term, optional, future deletion candidate. |

## Historical Chain Rule

No artifact may be archived without preserving:

- Origin.
- Replacement or reason no replacement exists.
- Successor if one exists.
- Archive classification.
- Retention classification.

## Example Chain

Old source screen -> Source evidence -> Purified OS package -> Active screen card.

