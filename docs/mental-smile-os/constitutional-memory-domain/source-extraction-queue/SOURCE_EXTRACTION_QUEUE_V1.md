# Source Extraction Queue V1

Status: ACTIVE_MEMORY_QUEUE
Domain: Constitutional Memory Domain
Memory area: source-extraction-queue

## 1. Purpose

Source Extraction Queue tracks what will be extracted from Mental Smile Core.

It records source candidates only. It does not extract, copy, migrate, or activate source material.

## 2. Classification Options

| Classification | Meaning |
| --- | --- |
| USE_AFTER_PURIFICATION | Candidate may be used only after purification and reclassification. |
| REBUILD_FROM_SCRATCH | Candidate informs a rebuild but is not reused directly. |
| REMOVE | Candidate should be removed or excluded from the new OS path. |
| NOT_RELEVANT | Candidate is outside scope. |
| MISSING_CREATE_NEW | Required object does not exist and must be created later. |

## 3. Global Import Rule

```text
Extract -> Purify -> Reclassify -> Rebuild -> Register
```

## 4. Boundary

No source candidates are queued in this step.
