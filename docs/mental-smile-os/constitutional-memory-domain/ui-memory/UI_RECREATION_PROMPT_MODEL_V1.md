# UI Recreation Prompt Model V1

Status: ACTIVE_MEMORY_MODEL
Domain: Constitutional Memory Domain
Memory area: ui-memory

## 1. Purpose

UI Recreation Prompt Model defines how UI assets connect to prompts that can recreate or regenerate them.

## 2. Required Fields

| Field | Requirement |
| --- | --- |
| Prompt ID | Stable recreation prompt identifier. |
| Related UI Asset | UI asset this prompt can recreate. |
| Prompt Text | Prompt text or prompt reference. |
| Style Rules | Visual style requirements. |
| Avoid Rules | Negative prompt or forbidden visual behavior. |
| Output Use | Intended asset usage. |
| Version | Prompt version. |
| Ownership Card | Related ownership card. |
| Lineage Status | Lineage status. |
| Validation Status | Validation status. |

## 3. Boundary

This model preserves regeneration memory only. It does not generate assets in this step.
