# Card Asset Model V1

Status: ACTIVE_MEMORY_MODEL
Domain: Constitutional Memory Domain
Owning registry: Card Registry Model
Asset class: constitutional card asset

## 1. Purpose

Card Asset Model defines how card assets are born, traced, registered, and validated inside Mental Smile OS.

A card is a constitutional object only when it has a parent guide, birth prompt, birth signal, birth authority, registry entry, validation status, and lineage.

## 2. Required Fields

| Field | Requirement |
| --- | --- |
| Card ID | Stable identifier for the card asset. |
| Card Name | Human-readable card name. |
| Card Type | Constitutional card class. |
| Parent Guide | Guide or doctrine that contains and constrains the card. |
| Birth Prompt | Prompt asset that generated the card. |
| Birth Signal | Signal or foundation event that authorized birth. |
| Birth Authority | DNA authority, domain authority, or doctrine authority that permitted creation. |
| Owner Domain | Domain accountable for the card's constitutional meaning. |
| Consumer Domain | Domain allowed to consume or reference the card. |
| Creation Date | Date the card entered constitutional memory. |
| Status | Current card status. |
| Lineage Status | Completeness of card lineage. |
| Related Signals | Signals linked to the card's birth, use, replacement, or validation. |
| Related Registries | Registries that track the card. |
| Related Descendants | Descendant records generated from or linked to the card. |

## 3. Card Types

| Card Type | Meaning |
| --- | --- |
| DOCTRINE_CARD | Card that represents a constitutional doctrine object. |
| GUIDE_CARD | Card derived from a validated guide. |
| REGISTRY_CARD | Card that summarizes or references registry-controlled constitutional data. |
| SIGNAL_CARD | Card that packages signal meaning for traceability. |
| DESCENDANT_CARD | Card that records a constitutional descendant relationship. |

## 4. Status Values

| Status | Meaning |
| --- | --- |
| REGISTERED | Card has a registry entry. |
| VALIDATION_PENDING | Card awaits memory validation. |
| VALIDATED | Card passed required traceability checks. |
| SUPERSEDED | Card has been replaced and remains traceable. |
| REJECTED | Card failed constitutional traceability or authority checks. |

## 5. Forbidden Card Forms

- Orphan Card.
- Card Without Parent Guide.
- Card Without Birth Prompt.
- Card Without Registry Entry.
- Card Without Lineage.
