# CARD_DISTRIBUTION_MODEL_V1

Status: REGISTERED

## Distribution Purpose

Card distribution makes validated governance cards available to approved runtime consumers.

## Distribution Flow

```text
Validated Card
-> Registry Binding
-> Distribution Package
-> Approved Runtime Consumer
-> Consumption Log
```

## Distribution Rules

- Only validated cards may be distributed.
- Distribution does not transfer ownership.
- Distribution must preserve card ID and version.
- Distribution must identify consumer.
- Distribution must declare allowed use.

## Distribution Status

- NOT_DISTRIBUTED
- READY_FOR_DISTRIBUTION
- DISTRIBUTED
- SUSPENDED
- RETIRED

## Forbidden Distribution

- Distributing unvalidated cards.
- Distributing orphan cards.
- Distributing cards without owner.
- Distributing cards as executable authority.
