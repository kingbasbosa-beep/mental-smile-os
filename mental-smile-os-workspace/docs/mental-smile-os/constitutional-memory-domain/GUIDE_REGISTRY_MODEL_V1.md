# Guide Registry Model V1

Status: ACTIVE_MEMORY_REGISTRY_MODEL
Domain: Constitutional Memory Domain
Owning unit: Memory Registry
Registry type: guide traceability registry

## 1. Purpose

Guide Registry Model defines how constitutional guide assets are registered and traced.

It is a memory registry model only. It does not create a Guide Domain, authorize expansion, govern future domains, or replace DNA Vault authority.

## 2. Required Registry Entry

Every guide registry entry must include:

- Guide ID.
- Guide Name.
- Guide Type.
- Birth Prompt.
- Birth Authority.
- Birth Lineage.
- Owner Domain.
- Consumer Domains.
- Creation Date.
- Status.
- Validation Status.
- Related Cards.
- Related Signals.
- Related Registries.
- Related Descendants.

## 3. Registration Rule

Upon creation:

```text
Guide -> Registers in Guide Registry
```

The registry entry must exist before the guide may be treated as a constitutional object.

## 4. Registry Status Values

| Status | Meaning |
| --- | --- |
| REGISTERED | Guide entry exists. |
| LINEAGE_ESTABLISHED | Guide lineage is complete. |
| VALIDATED | Guide passed memory validation. |
| BLOCKED_ORPHAN | Guide lacks prompt, authority, registry entry, lineage, or validation. |
| SUPERSEDED | Guide was replaced by a newer guide record. |
| RETIRED | Guide is inactive but lineage remains preserved. |

## 5. Required Traceability Questions

Guide Registry must always answer:

- Who created this?
- Why was it created?
- Which prompt created it?
- Which authority approved it?
- Which cards were generated from it?
- Which signals reference it?
- Which descendants consume it?
