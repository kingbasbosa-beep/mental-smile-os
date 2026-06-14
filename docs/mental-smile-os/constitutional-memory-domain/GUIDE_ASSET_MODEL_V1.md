# Guide Asset Model V1

Status: ACTIVE_MEMORY_MODEL
Domain: Constitutional Memory Domain
Owning registry: Guide Registry Model
Asset class: constitutional guide asset

## 1. Purpose

Guide Asset Model defines how guide assets are born, traced, registered, validated, and related to future cards inside Mental Smile OS.

A guide is a constitutional parent object. Future cards may be generated from guides, but no card may survive without parent guide lineage.

## 2. Required Fields

| Field | Requirement |
| --- | --- |
| Guide ID | Stable identifier for the guide asset. |
| Guide Name | Human-readable guide name. |
| Guide Type | Constitutional guide class. |
| Birth Prompt | Prompt asset that generated the guide. |
| Birth Authority | DNA authority, domain authority, or doctrine authority that permitted guide creation. |
| Birth Lineage | Prompt, authority, justification, registry, and validation chain. |
| Owner Domain | Domain accountable for guide meaning. |
| Consumer Domains | Domains allowed to consume or reference the guide. |
| Creation Date | Date the guide entered constitutional memory. |
| Status | Current guide status. |
| Validation Status | Current validation result. |
| Related Cards | Cards generated from or constrained by the guide. |
| Related Signals | Signals linked to guide creation, alignment, replacement, retirement, or validation. |
| Related Registries | Registries that track the guide. |
| Related Descendants | Descendant records generated from or linked to the guide. |

## 3. Guide Types

| Guide Type | Meaning |
| --- | --- |
| MASTER_GUIDE | Supreme guide for cross-domain constitutional language or doctrine. |
| DOMAIN_GUIDE | Guide that constrains a specific domain. |
| DOCTRINE_GUIDE | Guide that defines constitutional doctrine or interpretation. |
| REGISTRY_GUIDE | Guide that governs registry structure and traceability. |
| WORKFLOW_GUIDE | Guide that constrains constitutional workflow without creating operations authority. |
| ASSET_GUIDE | Guide that governs asset classes such as cards, signals, prompts, or descendants. |

## 4. Status Values

| Status | Meaning |
| --- | --- |
| REGISTERED | Guide has a registry entry. |
| VALIDATION_PENDING | Guide awaits memory validation. |
| VALIDATED | Guide passed required traceability checks. |
| SUPERSEDED | Guide has been replaced and remains traceable. |
| RETIRED | Guide is no longer active but remains preserved in lineage. |
| REJECTED | Guide failed constitutional traceability or authority checks. |

## 5. Forbidden Guide Forms

- Guide Without Birth Prompt.
- Guide Without Registry Entry.
- Guide Without Lineage.
- Guide Without Validation.
- Orphan Guide.
