# UI Asset Card Model V1

Status: ACTIVE_MEMORY_MODEL
Domain: Constitutional Memory Domain
Memory area: ui-memory

## 1. Purpose

UI Asset Card Model defines the required structure for future purified UI asset cards.

## 2. Required Fields

| Field | Requirement |
| --- | --- |
| Asset ID | Stable UI asset identifier. |
| Asset Name | Human-readable name. |
| Asset Type | UI asset class. |
| Source Candidate | Source evidence reference only. |
| Visual Purpose | Why this asset exists in Mental Smile OS. |
| Related Room | Related OS room, if any. |
| Related Domain | Related OS domain, if any. |
| Recreation Prompt | Prompt card reference for regeneration. |
| Usage Rules | Allowed and forbidden use. |
| Ownership Status | Ownership memory status. |
| Lineage Status | Lineage status. |
| Validation Status | Validation status. |

## 3. Forbidden States

- UI asset without source or creation prompt.
- UI asset without ownership status.
- UI asset without lineage.
- UI asset copied directly from Mental Smile Core.
