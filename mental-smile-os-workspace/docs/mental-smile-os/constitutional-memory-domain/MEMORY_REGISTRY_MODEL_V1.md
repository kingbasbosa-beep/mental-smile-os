# Memory Registry Model V1

Status: ACTIVE_CONSTITUTION
Domain: Constitutional Memory Domain
Unit: Memory Registry

## 1. Purpose

Memory Registry tracks constitutional memory assets. It is not a general registry center and does not replace DNA Vault, Master Registry Doctrine, or future domain registries.

## 2. Required Fields

| Field | Requirement |
| --- | --- |
| Memory ID | Stable identifier for the constitutional memory asset. |
| Source Type | Constitution, Guide, Card, Registry, Signal, Authority, Alignment, Removal, Expansion, Validation. |
| Origin | Purified origin reference; may cite source repository location as evidence only. |
| Status | Current memory state. |
| Custodian | Memory unit responsible for continuity preservation. |
| Superseded By | Memory ID that replaces this asset, if any. |
| Related Signals | DNA or Memory signals tied to the asset. |
| Related Guides | Guide memory references tied to the asset. |
| Related Registries | Registry memory references tied to the asset. |

## 3. Registry Status Values

| Status | Meaning |
| --- | --- |
| REGISTERED | Memory asset is tracked. |
| LINEAGE_ESTABLISHED | Origin and chain are intact. |
| LINEAGE_BROKEN | Chain has a missing or invalid segment. |
| MEMORY_GAP | Expected history is missing. |
| SUPERSEDED | Replacement has been recorded. |
| VALIDATED | Integrity validation passed. |
| INVALID | Integrity validation failed. |

## 4. Registry Rules

- Every memory asset must have a Memory ID.
- Every source-origin claim must be purified and reclassified before placement.
- A memory record may link to source repository evidence but may not activate it.
- Supersession must preserve both old and new IDs.
- Memory Registry cannot authorize domain creation.

## 5. Example Identifier Pattern

```text
MEM-<SOURCE_TYPE>-<YYYYMMDD>-<SEQUENCE>
```

This pattern is a registry convention only. It is not a domain creation rule.
