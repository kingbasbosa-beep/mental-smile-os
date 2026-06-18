# Archive Card: Saved Destinations V1

Archive Card ID: ARCHIVE_CARD_SAVED_DESTINATIONS_V1
Status: REMOVED_FROM_RUNTIME
Source Operation: OP-SAVED-DESTINATIONS-EXTRACTION-V1
Date: 2026-06-18
Runtime Effect: saved destination storage, repository, UI save actions, and `destination_saved` producer removed

## Old Purpose

`saved_destinations` preserved session-scoped saved providers, centers, library items, or tools so a person could return to them later.

## Old Collection / Repository / Signals

- Collection: `saved_destinations`
- Repository: `SavedDestinationRepository`
- Model: `SavedDestination`
- Signal: `destination_saved`
- Runtime write methods: `saveDestination`
- Runtime read method: `watchSessionDestinations`
- Former UI write points: provider details save action and center details save action

## Previous User Journey

The previous journey allowed a session actor to save a provider or center from a details page. The save created a Firestore record and emitted `destination_saved`.

## Why It Became Incompatible

The saved destination layer became incompatible with Fresh Signals doctrine because it stores past intent and can make monitoring treat old recall memory as current demand.

It also conflicts with session-first client access by preserving a durable client-like memory surface after client identity extraction.

## What Replaces It

The replacement is fresh session signal behavior:

- provider profile opened signal;
- center profile opened signal;
- provider contact requested signal;
- center contact requested signal;
- accessible contact requested and completed signals;
- accessibility resource opened signals;
- session/visitor signal capability.

## Reintroduction Rule

No silent resurrection.

Any future saved destination feature must be approved through a new card, guide, capsule, finding/decision record, registry update, and Owner approval before runtime restoration.

## Archive Classification

SAVED_DESTINATIONS_REMOVED_FROM_RUNTIME

## Related Records

- `SAVED_DESTINATIONS_EXTRACTION_DECISION_V1.md`
- `FINDING_SAVED_DESTINATIONS_CONFLICTS_WITH_FRESH_SIGNALS_V1.md`
- `SAVED_DESTINATIONS_EXTRACTION_REPORT_V1.md`
- OP-SAVED-DESTINATIONS-EXTRACTION-V1
