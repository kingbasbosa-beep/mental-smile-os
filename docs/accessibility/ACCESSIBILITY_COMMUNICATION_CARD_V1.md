# Accessibility Communication Card V1

Status: ACTIVE_GOVERNANCE_CARD
Classification: ACCESSIBLE_COMMUNICATION_FOUNDATION
Phase: 7B
Runtime effect: none

## Purpose

Define accessible communication governance before implementation.

Accessible communication gives people alternate contact paths without requiring identity labels.

## Accessible Communication Ready Flag

Future contact surfaces may use an `accessibleCommunicationReady` flag to indicate that a destination can receive accessible communication requests.

The flag means the contact pathway is prepared. It does not classify the user and does not certify medical capability.

## Normal Contact Button

The normal contact button remains the default contact route.

It should be available to everyone and must not become a privileged path.

## Accessible Contact Button

The accessible contact button is an alternate access route.

It may allow the user to request:

- written communication
- simplified communication
- slower response pacing
- visual support
- phone avoidance
- WhatsApp preference
- caregiver-assisted contact

## Collect Needs Not Labels Doctrine

Accessible contact should collect the need for the interaction, not a label for the person.

Examples:

| Collect | Do Not Collect As Identity |
| --- | --- |
| "I prefer written messages." | "User is disabled." |
| "I need simplified instructions." | "User has cognitive impairment." |
| "Please avoid phone calls." | "User has anxiety." |
| "I need visual support." | "User is visually impaired." |

## Boundary

This card does not create contact UI, Firestore fields, storage, signals, or routing.
