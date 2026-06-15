# CARD_REGISTRY_BINDING_MODEL_V1

Status: REGISTERED

## Binding Rule

Every card must bind to one registry before runtime consumption.

## Registry Types

| Registry | Card Family |
|---|---|
| Master Guide Card Registry | Master guide cards and doctrine cards. |
| Route Registry | Route cards. |
| Asset Registry | UI and runtime asset cards. |
| Localization Registry | Term and text cards. |
| Signal Registry | Signal cards. |
| Firestore Collection Registry | Data collection cards. |
| Ownership Registry | Ownership cards. |
| Prompt Memory Registry | Prompt-born card lineage. |

## Required Binding Fields

- Registry ID.
- Card ID.
- Card version.
- Owner.
- Validation status.
- Runtime status.
- Archive status.

## Forbidden Binding

- Orphan card.
- Duplicate active card without replacement link.
- Runtime card without registry.
- Registry row without ownership.
