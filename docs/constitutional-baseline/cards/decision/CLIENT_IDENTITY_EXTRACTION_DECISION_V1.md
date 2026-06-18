# Client Identity Extraction Decision V1

Status: ACTIVE_DECISION_CARD
Classification: CLIENT_IDENTITY_EXTRACTION_ERA_DOCUMENTATION
Phase: 7A
Runtime effect: none

## Decision

Client login, client profile persistence, and registration-time preference capture are constitutional simplification candidates.

This decision does not remove login, profile, preferences, collections, routes, or runtime code. It records the doctrine that client identity should be reduced where possible and that fresh repeated intent signals should be preferred over stale stored preferences when analytics or personalization depend on current user need.

## Why Client Login Became A Candidate For Removal

Client login became a candidate for removal because several client experiences can be understood through session-room behavior instead of long-lived profile identity.

The candidate reasoning is:

- A person may enter a room with a current need that is different from a stored profile.
- Login can make the system treat old preferences as durable identity.
- Profile fields can drift from support need into unnecessary identity weight.
- Registration-time signals can become stale before the user actually uses a room.
- Stateless or lighter client rooms can reduce stored data while still preserving useful intent through repeated interactions.

This is a candidate doctrine only. Any actual removal requires separate Owner approval, runtime audit, migration plan, validation, and operation registration.

## Why Session Rooms Produce Fresher Signals

Session rooms produce fresher signals because they observe what the user repeatedly chooses in context.

A stored preference says what the user once saved. A repeated intent signal says what the user keeps choosing when the need is active.

Freshness matters because Mental Smile signal federation should reflect lived interaction, not only historical profile data.

Examples:

- A client saved "sleep support" during registration, but enters breathing tools three times this week. The repeated breathing selections are fresher than the old saved sleep preference.
- A client once selected "family support", but repeatedly opens private journaling and quiet content. The repeated room behavior is stronger evidence of current need.
- A client never saved an accessibility preference, but repeatedly opens simplified content mode. The repeated selection is a stronger accessibility signal than the absence of a stored preference.

## Saved Preference Vs Repeated Intent Signal

| Concept | Meaning | Strength | Risk |
| --- | --- | --- | --- |
| Saved Preference | A user-selected value stored in profile, registration, or settings. | Useful for remembered convenience. | Can become stale, over-identifying, or treated as permanent. |
| Repeated Intent Signal | A repeated user action in a room, tool, or content surface. | Stronger evidence of current need when repeated over time. | Must be privacy-bounded and not over-inferred. |

## Examples

| Scenario | Saved Preference | Repeated Intent Signal | Doctrine Reading |
| --- | --- | --- | --- |
| Tool choice | User saved "motivation notes". | User repeatedly opens grounding exercises. | Current grounding intent should outweigh old saved preference for analytics. |
| Room entry | User selected "community support" during registration. | User repeatedly enters private personal space. | Current private-space intent is fresher. |
| Accessibility | User saved no accessibility option. | User repeatedly chooses simplified reading. | Repeated mode selection is a fresh communication preference signal. |
| Content | User saved "children" interest once. | User repeatedly opens anxiety education content. | Repeated content use should not be hidden by the old stored interest. |

## Governance Boundary

This card does not authorize:

- Login removal.
- Client profile deletion.
- Preference collection removal.
- Firestore schema changes.
- Route changes.
- Runtime implementation.
- Firebase changes.

It only records the decision doctrine for the Client Identity Extraction Era.

## Related Records

- `FINDING_FRESH_SIGNALS_OVER_STORED_PREFERENCES_V1.md`
- `ARCHIVE_CARD_CLIENT_PROFILE_COMPLEXITY_V1.md`
- `MEMORY_REGISTRY_V1.md`
- `FINDING_REGISTRY_V1.md`
- `OP-PHASE-7A-CLIENT-IDENTITY-EXTRACTION-DOCUMENTATION-V1`
