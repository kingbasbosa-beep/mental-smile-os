# Signal Asset Model V1

Status: ACTIVE_MEMORY_MODEL
Domain: Constitutional Memory Domain
Owning registry: Signal Registry Model
Asset class: constitutional signal asset

## 1. Purpose

Signal Asset Model defines how signals are born, traced, registered, and validated inside Mental Smile OS.

A signal is a constitutional object only when its source, consumer, trigger, expected outcome, birth prompt, registry entry, and lineage are known.

## 2. Required Fields

| Field | Requirement |
| --- | --- |
| Signal ID | Stable identifier for the signal asset. |
| Signal Name | Human-readable signal name. |
| Signal Type | Constitutional signal class. |
| Signal Source | Domain, unit, or authority that emits the signal. |
| Signal Consumer | Domain, unit, or authority permitted to consume the signal. |
| Trigger Condition | Condition that causes signal emission. |
| Expected Outcome | Bounded result expected from the signal. |
| Birth Prompt | Prompt asset that generated the signal. |
| Birth Authority | DNA authority, domain authority, or doctrine authority that permitted signal creation. |
| Birth Lineage | Prompt, authority, justification, and registry chain. |
| Status | Current signal status. |

## 3. Signal Types

| Signal Type | Meaning |
| --- | --- |
| DNA_SIGNAL | Signal emitted by DNA Vault authority. |
| MEMORY_SIGNAL | Signal emitted by Constitutional Memory Domain for continuity state. |
| CARD_SIGNAL | Signal connected to card birth, validation, replacement, or removal. |
| REGISTRY_SIGNAL | Signal connected to registry entry, mismatch, or validation. |
| DESCENDANT_SIGNAL | Signal connected to constitutional descendant birth or lineage. |

## 4. Status Values

| Status | Meaning |
| --- | --- |
| REGISTERED | Signal has a registry entry. |
| ACTIVE | Signal may be emitted within its defined boundary. |
| VALIDATED | Signal passed required traceability checks. |
| SUPERSEDED | Signal has been replaced and remains traceable. |
| REJECTED | Signal failed constitutional traceability or authority checks. |

## 5. Forbidden Signal Forms

- Anonymous Signal.
- Signal Without Source.
- Signal Without Consumer.
- Signal Without Trigger.
- Signal Without Registry Entry.
- Signal Without Lineage.
