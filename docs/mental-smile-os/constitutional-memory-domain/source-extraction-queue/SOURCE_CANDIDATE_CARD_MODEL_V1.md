# Source Candidate Card Model V1

Status: ACTIVE_MEMORY_MODEL
Domain: Constitutional Memory Domain
Memory area: source-extraction-queue

## 1. Purpose

Source Candidate Card Model defines how future Mental Smile Core source candidates are recorded before extraction.

## 2. Required Fields

| Field | Requirement |
| --- | --- |
| Candidate ID | Stable source candidate identifier. |
| Candidate Name | Human-readable candidate name. |
| Source Path | Source repository path or evidence reference. |
| Source Type | UI, localization, asset, prompt, guide, card, signal, code, Firebase, storage, content, or other type. |
| Requested By | Room or authority requesting extraction. |
| Related Strategy | Strategy or build package reference. |
| Classification | USE_AFTER_PURIFICATION, REBUILD_FROM_SCRATCH, REMOVE, NOT_RELEVANT, or MISSING_CREATE_NEW. |
| Purification Need | What must be cleaned or transformed. |
| Rebuild Need | What must be rebuilt. |
| Ownership Need | Ownership or rights check required. |
| Lineage Status | Lineage status. |
| Validation Status | Validation status. |

## 3. Boundary

Source candidate cards do not import source assets. They only prepare extraction memory.
