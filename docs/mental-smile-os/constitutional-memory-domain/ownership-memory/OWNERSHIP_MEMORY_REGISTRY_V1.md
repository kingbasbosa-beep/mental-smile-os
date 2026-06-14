# Ownership Memory Registry V1

Status: ACTIVE_MEMORY_REGISTRY
Domain: Constitutional Memory Domain
Memory area: ownership-memory

## 1. Purpose

Ownership Memory Registry tracks ownership, rights, licenses, authorship, creation prompts, third-party sources, attribution, commercial rights, modification rights, and usage boundaries.

## 2. Boundary

This registry does not approve legal status. It preserves ownership memory and evidence for future review.

## 3. Required Ownership Card Fields

| Field | Requirement |
| --- | --- |
| Ownership ID | Stable ownership record identifier. |
| Asset ID | Related asset identifier. |
| Asset Name | Human-readable asset name. |
| Asset Class | UI, localization, content, code, image, prompt, guide, card, signal, or other class. |
| Owner | Claimed owner. |
| Author / Creator | Creator or generation process. |
| Source Type | Original, generated, third-party, legacy source candidate, or unknown. |
| Creation Prompt | Prompt used to create or recreate the asset. |
| License Type | License or rights type. |
| Usage Rights | Allowed use. |
| Modification Rights | Allowed modification. |
| Commercial Rights | Commercial usage boundary. |
| Attribution Required | Attribution requirement. |
| Evidence | Evidence reference. |
| Lineage Status | Lineage status. |
| Validation Status | Validation status. |

## 4. Global Import Rule

```text
Extract -> Purify -> Reclassify -> Rebuild -> Register
```

## 5. Registered Ownership Cards

| Ownership ID | Asset ID | Asset Name | Asset Class | Owner | Author / Creator | Source Type | Creation Prompt | License Type | Usage Rights | Modification Rights | Commercial Rights | Attribution Required | Evidence | Lineage Status | Validation Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| OWNERSHIP-CLIENT-ROOM-BACKGROUND | CLIENT_ROOM_BACKGROUND | Client Room Background | UI background family | Mental Smile OS | Legacy source candidate plus PROMPT_ASSET_009 rebuild doctrine | Legacy candidate, purified | RP-CLIENT-ROOM-BACKGROUND | Internal project asset pending final rights review | Use inside Mental Smile OS after purification. | May modify/recreate under OS visual rules. | Allowed only after ownership review remains valid. | No external attribution known; verify before release. | ASSET-0105/0106/0107 docs and source paths. | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| OWNERSHIP-CLIENT-TOOL-BOARD | CLIENT_TOOL_BOARD | Client Tool Board | UI component | Mental Smile OS | PROMPT_ASSET_009 | Rebuilt logical asset | RP-CLIENT-TOOL-BOARD | Generated/internal doctrine asset | Use inside future Client Room only. | May modify with accessibility preservation. | Allowed after build approval. | No | Code-rendered source concept in client dashboard. | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| OWNERSHIP-CLIENT-TV-PANEL | CLIENT_TV_PANEL | Client TV Panel | UI component | Mental Smile OS | PROMPT_ASSET_009 | Rebuilt logical asset | RP-CLIENT-TV-PANEL | Generated/internal doctrine asset | Use as content display frame only. | May modify; content rights stay separate. | Allowed after build approval. | No | Client Room visual system doctrine. | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| OWNERSHIP-CLIENT-NOTE-WIDGET | CLIENT_NOTE_WIDGET | Client Motivational Note Widget | UI component | Mental Smile OS | PROMPT_ASSET_009 | Rebuilt logical asset | RP-CLIENT-NOTE-WIDGET | Generated/internal doctrine asset | Use for non-clinical motivational notes. | May modify with language safety review. | Allowed after build approval. | No | Notebook/note source concept and client dashboard note icon. | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| OWNERSHIP-CLIENT-EXIT-CUP | CLIENT_EXIT_CUP | Client Exit Cup | UI navigation control | Mental Smile OS | PROMPT_ASSET_009 | Rebuilt logical asset | RP-CLIENT-EXIT-CUP | Generated/internal doctrine asset | Use as calm exit navigation. | May modify if silhouette and accessibility remain stable. | Allowed after build approval. | No | Client Room visual system doctrine. | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| OWNERSHIP-CLIENT-ROOM-LAYOUT | CLIENT_ROOM_LAYOUT | Client Room Layout | UI layout contract | Mental Smile OS | PROMPT_ASSET_009 | Rebuilt logical asset | RP-CLIENT-ROOM-LAYOUT | Generated/internal doctrine asset | Use as future layout guide. | May modify through guide/card updates. | Allowed after build approval. | No | Client Room visual system and dashboard layout source. | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
