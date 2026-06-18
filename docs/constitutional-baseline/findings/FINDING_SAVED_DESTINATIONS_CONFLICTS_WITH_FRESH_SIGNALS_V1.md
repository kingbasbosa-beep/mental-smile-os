# Finding Saved Destinations Conflicts With Fresh Signals V1

Status: ACTIVE_FINDING_CARD
Classification: FRESH_SIGNALS_DOCTRINE_FINDING
Source Operation: OP-SAVED-DESTINATIONS-EXTRACTION-V1
Date: 2026-06-18
Runtime effect: supports removal of saved destination runtime and signal producer

## Problem

`saved_destinations` creates stored recall memory that can outlive the user's current need.

When monitoring or analytics can observe saved destinations, the system may count old stored intent as if it were current repeated behavior.

## Finding

Saved destinations conflict with Fresh Signals doctrine.

Repeated provider openings, center openings, contact requests, accessible contact requests, and accessibility resource openings are fresher indicators of current intent than a stored destination record.

## Evidence

Before extraction, active runtime contained:

- Firestore `/saved_destinations/{savedId}` rules;
- `SavedDestinationRepository.saveDestination`;
- `SavedDestinationRepository.watchSessionDestinations`;
- `SavedDestination` model and barrel export;
- provider details save action;
- center details save action;
- `SignalPackageFactory.destinationSaved`;
- `SignalTypeRegistry.destinationSaved`;
- monitoring validator and adapter mappings for `destination_saved`.

## Governance Reading

The system should not keep a dormant client memory layer after client identity extraction.

Fresh session actions should remain observable; stale saved memory should not remain active unless a future Owner-approved doctrine restores it.

## Related Records

- `SAVED_DESTINATIONS_EXTRACTION_DECISION_V1.md`
- `ARCHIVE_CARD_SAVED_DESTINATIONS_V1.md`
- `SAVED_DESTINATIONS_EXTRACTION_REPORT_V1.md`
- OP-SAVED-DESTINATIONS-EXTRACTION-V1
