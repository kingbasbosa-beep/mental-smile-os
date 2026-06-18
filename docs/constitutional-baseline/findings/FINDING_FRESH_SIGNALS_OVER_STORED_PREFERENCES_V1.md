# Finding Fresh Signals Over Stored Preferences V1

Status: ACTIVE_FINDING_CARD
Classification: SIGNAL_DOCTRINE_FINDING
Phase: 7A
Runtime effect: none

## Problem

Stored tools and saved preferences can create stale analytics.

When a preference is stored once and reused as a durable representation of the client, the system may continue to analyze, recommend, or classify from old intent even after the user's actual repeated behavior has changed.

## Finding

Repeated selection creates stronger signals.

Repeated room, tool, mode, or content selections are fresher indicators of present intent than registration-time preferences or profile fields, provided the signals remain privacy-bounded and are not converted into diagnosis, clinical labels, or permanent identity.

## Evidence Logic

The finding is doctrinal and documentation-only:

- Stored preferences preserve past choices.
- Repeated signals show current behavior.
- Current behavior is more useful for signal federation when the goal is timely support, personalization, and room-level analytics.
- Repetition is stronger than a single click because it shows continuity of intent.

## Examples

| Stored Value | Repeated Signal | Finding |
| --- | --- | --- |
| Saved "sleep" as a preference. | Opens breathing support repeatedly. | Breathing support is the fresher current intent. |
| Saved "tool board" interest. | Repeatedly opens private space. | Private space should be recognized as current usage intent. |
| Saved no accessibility preference. | Repeatedly selects simplified content. | Repeated simplified mode is a meaningful communication signal. |
| Saved "community" once. | Repeatedly avoids shared surfaces and uses quiet tools. | Current repeated room behavior is stronger than old preference. |

## Governance Rule

Analytics should not treat stored client preferences as permanent identity.

Repeated intent signals should be preferred for freshness, while stored preferences should remain convenience memory only unless Owner-approved doctrine says otherwise.

## Related Decision

`CLIENT_IDENTITY_EXTRACTION_DECISION_V1.md`
