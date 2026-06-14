# Asset Recreation Prompt Registry V1

Status: ACTIVE_MEMORY_REGISTRY
Domain: Constitutional Memory Domain
Memory area: asset-recreation-prompts

## 1. Purpose

Asset Recreation Prompt Registry preserves prompts that can recreate or regenerate assets.

## 2. Boundary

This registry does not generate assets in this step. It preserves future regeneration memory only.

## 3. Required Recreation Prompt Card Fields

| Field | Requirement |
| --- | --- |
| Prompt ID | Stable prompt identifier. |
| Asset ID | Related asset identifier. |
| Asset Name | Asset name. |
| Asset Type | Asset class or format. |
| Prompt Text | Prompt text or prompt reference. |
| Style Rules | Required style constraints. |
| Negative Prompt / Avoid Rules | What generation must avoid. |
| Output Use | Intended use. |
| Version | Prompt version. |
| Related UI Asset | UI asset reference. |
| Related Ownership Card | Ownership record reference. |
| Lineage Status | Lineage status. |
| Validation Status | Validation status. |

## 4. Global Import Rule

```text
Extract -> Purify -> Reclassify -> Rebuild -> Register
```
