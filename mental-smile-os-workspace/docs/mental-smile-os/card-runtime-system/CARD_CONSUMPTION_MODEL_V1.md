# CARD_CONSUMPTION_MODEL_V1

Status: REGISTERED

## Consumption Doctrine

Runtime consumes card definitions. Runtime does not become card authority.

## Consumption Flow

```text
Runtime Consumer
-> Reads Approved Card
-> Applies Runtime Boundary
-> Emits Consumption Evidence
```

## Consumer Types

- Screen.
- Route.
- Gateway.
- Signal family.
- Asset loader.
- Localization loader.
- Firebase rules implementation.
- Runtime service.
- Archive process.

## Required Consumption Fields

- Card ID.
- Card version.
- Consumer ID.
- Consumer zone.
- Consumption purpose.
- Runtime status.
- Compliance status.

## Forbidden Consumption

- Runtime invents card behavior.
- Runtime consumes unregistered card.
- Runtime consumes retired card as active.
- Runtime changes card owner.
