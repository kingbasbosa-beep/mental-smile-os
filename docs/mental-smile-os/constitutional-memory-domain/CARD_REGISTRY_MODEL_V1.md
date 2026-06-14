# Card Registry Model V1

Status: ACTIVE_MEMORY_REGISTRY_MODEL
Domain: Constitutional Memory Domain
Owning unit: Memory Registry
Registry type: card traceability registry

## 1. Purpose

Card Registry Model defines how constitutional card assets are registered and traced.

It is a memory registry model only. It does not create a Card Domain, authorize card use, govern future domains, or replace DNA Vault authority.

## 2. Required Registry Entry

Every card registry entry must include:

- Card ID.
- Card Name.
- Card Type.
- Parent Guide.
- Birth Prompt.
- Birth Signal.
- Birth Authority.
- Owner Domain.
- Consumer Domain.
- Creation Date.
- Status.
- Lineage Status.
- Related Signals.
- Related Registries.
- Related Descendants.
- Validation Status.

## 3. Registration Rule

Upon creation:

```text
Card -> Registers in Card Registry
```

The registry entry must exist before the card may be treated as a constitutional object.

## 4. Registry Status Values

| Status | Meaning |
| --- | --- |
| REGISTERED | Card entry exists. |
| LINEAGE_ESTABLISHED | Card lineage is complete. |
| VALIDATED | Card passed memory validation. |
| BLOCKED_ORPHAN | Card lacks parent guide, prompt, authority, or lineage. |
| SUPERSEDED | Card was replaced by a newer card record. |

## 5. Traceability Questions

Card Registry must always answer:

- Who created this?
- Why was it created?
- Which prompt created it?
- Which signal authorized it?
- Which guide contains it?
- Which registry tracks it?
