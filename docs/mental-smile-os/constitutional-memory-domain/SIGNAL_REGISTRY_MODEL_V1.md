# Signal Registry Model V1

Status: ACTIVE_MEMORY_REGISTRY_MODEL
Domain: Constitutional Memory Domain
Owning unit: Memory Registry
Registry type: signal traceability registry

## 1. Purpose

Signal Registry Model defines how constitutional signal assets are registered and traced.

It is a memory registry model only. It does not create a Signal Domain, authorize expansion, govern signal meaning beyond traceability, or replace DNA Vault authority.

## 2. Required Registry Entry

Every signal registry entry must include:

- Signal ID.
- Signal Name.
- Signal Type.
- Signal Source.
- Signal Consumer.
- Trigger Condition.
- Expected Outcome.
- Birth Prompt.
- Birth Authority.
- Birth Lineage.
- Status.
- Validation Status.

## 3. Registration Rule

Upon creation:

```text
Signal -> Registers in Signal Registry
```

The registry entry must exist before the signal may be treated as a constitutional object.

## 4. Registry Status Values

| Status | Meaning |
| --- | --- |
| REGISTERED | Signal entry exists. |
| ACTIVE | Signal may be emitted within its defined boundary. |
| LINEAGE_ESTABLISHED | Signal lineage is complete. |
| VALIDATED | Signal passed memory validation. |
| BLOCKED_ANONYMOUS | Signal lacks source, consumer, trigger, registry entry, or lineage. |
| SUPERSEDED | Signal was replaced by a newer signal record. |

## 5. Traceability Questions

Signal Registry must always answer:

- Who created this?
- Why was it created?
- Which prompt created it?
- Which signal authorized it?
- Which registry tracks it?
- Which consumer may receive it?
