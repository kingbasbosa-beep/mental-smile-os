# Accessible Communication Execution Card V1

Status: ACTIVE_CARD
Date: 2026-06-18
Related Operation: OP-PHASE-9-ACCESSIBLE-COMMUNICATION-V1
Domain: ACCESSIBILITY / COMMERCIAL / SIGNALS
Runtime effect: provider and center pages expose accessible contact actions

## Purpose

Create the first runtime accessible communication foundation on provider and center pages.

## Doctrine

Mental Smile does not classify users.

Mental Smile removes barriers.

Accessible communication collects needs, not labels.

## Provider Fields

- `accessible_communication_ready`
- `accessible_communication_capabilities`

Supported capability labels:

- Text Friendly
- WhatsApp Friendly
- Video Friendly
- Sign Friendly
- Easy Language Friendly

## Provider Page Behavior

Provider detail pages show:

- Contact provider
- 🤟 Accessible Contact

The accessible contact path emits accessible provider/contact signals and reuses the existing provider contact request flow.

## Center Page Behavior

Center detail pages show:

- Contact center
- 🤟 Accessible Contact

The accessible contact path emits accessible center/contact signals and reuses the existing center contact request flow.

## Signals

- `accessible_contact_requested`
- `accessible_contact_completed`
- `accessible_provider_selected`
- `accessible_center_selected`

## Constraints

- No Firebase action.
- No route removal.
- No user classification.
- No diagnosis collection.
- No commit, push, or tag.

## Verification State

Formatting/analyze/runtime checks are OWNER_MANUAL_PENDING because the Owner requested command execution manually.
