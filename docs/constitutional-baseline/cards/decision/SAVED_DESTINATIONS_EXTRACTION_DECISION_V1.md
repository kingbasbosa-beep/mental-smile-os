# Saved Destinations Extraction Decision V1

Status: ACTIVE_DECISION_CARD
Classification: FRESH_SIGNALS_DOCTRINE_REMOVAL
Owner Decision: REMOVE
Source Operation: OP-SAVED-DESTINATIONS-EXTRACTION-V1
Date: 2026-06-18
Runtime effect: removes saved destination storage and its runtime signal producer

## Decision

The Owner decided to remove `saved_destinations` from active runtime.

Stored saved destinations conflict with the Fresh Signals doctrine and session-first client access. Mental Smile should measure repeated current intent through session actions, profile openings, contact requests, accessible contact requests, and accessibility resource openings, not preserve stale client memory as a durable behavioral proxy.

## Why Stored Destinations Create Stale Analytics

A saved destination records that a user once wanted to remember a provider, center, tool, or resource. That stored value can stay alive after the user's current need changes.

If analytics treat saved destinations as durable demand, the system may over-count past interest and under-count current repeated behavior.

Examples:

| Stored destination | Fresh signal replacement | Doctrine reading |
| --- | --- | --- |
| A provider saved once | Provider profile opened repeatedly, provider contact requested | Repeated discovery/contact is fresher than old save memory. |
| A center saved once | Center profile opened repeatedly, center contact requested | Current center engagement is stronger than stored recall. |
| A resource saved once | Accessibility resource opened repeatedly | Repeated access shows current barrier-removal intent. |

## Why Repeated Selection Is Better

Repeated destination, contact, and tool selections show active intent in the current session context.

Fresh signals are better because they:

- reflect current need instead of historical storage;
- avoid silently recreating a client memory layer;
- preserve session-first access without account/profile persistence;
- reduce stale monitoring noise;
- keep analytics closer to current behavior.

## Future Restoration Rule

Saved destinations must not return silently.

Any future restoration requires:

- new capsule or card;
- new guide;
- new finding or decision record;
- explicit Owner approval;
- updated collection, signal, route, memory, and archive registries;
- clear doctrine explaining why the restored feature does not recreate stale client memory.

## Related Records

- `ARCHIVE_CARD_SAVED_DESTINATIONS_V1.md`
- `FINDING_SAVED_DESTINATIONS_CONFLICTS_WITH_FRESH_SIGNALS_V1.md`
- `SAVED_DESTINATIONS_EXTRACTION_REPORT_V1.md`
- OP-SAVED-DESTINATIONS-EXTRACTION-V1
