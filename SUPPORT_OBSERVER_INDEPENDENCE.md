# Support Observer Independence

## Purpose

Wave C-4 ends the doctrine that support depends on admin authority.

Support is not administration, approval, assignment, booking control, payment
control, or provider/center control.

Support is:

```text
Observe
Help
Follow Up
Escalate
Document
```

## Support Observer Claim

Firestore Rules now require the explicit custom claim:

```text
role = support_observer
```

`isSupportObserver()` no longer inherits `isAdmin()`.

## Support Can

- read and follow support requests
- update support request status where scoped by rules
- observe provider and center contact requests for support continuity
- observe saved destinations when support context requires it
- observe and update support chat threads
- observe and update support escalations
- document support-side follow-up notes where supported by existing schemas

## Support Cannot

- approve providers
- approve centers
- schedule sessions
- operate booking lifecycle
- operate payment lifecycle
- operate assignment lifecycle
- control client journeys
- own external follow-up registries

## Support Collections

Moved to independent support observer authority:

- `support_requests`
- `provider_contact_requests`
- `center_contact_requests`
- `saved_destinations`
- `chat_threads`
- `chat_escalations`

## Follow-Up Doctrine

Support may use follow-up templates and campaign information, but does not own
them.

The following remain registry stewardship responsibilities:

- `external_follow_up_registry`
- `external_follow_up_message_templates`
- `external_follow_up_campaigns`

## Escalation Classification

`chat_escalations` is classified as support escalation for C-4.

It must not become operational escalation for booking, assignment, session, or
payment control. Any escalation touching those domains belongs to the legacy
island until purge.

## Legacy Isolation

C-4 does not modify:

- `booking_requests`
- `sessionRatings`
- `admins`
- payment authority
- session authority
- declaration review
- monitoring
- registry

## Remaining Admin Surface

After C-4, `isAdmin()` should remain only for:

- legacy booking authority
- legacy session/payment/review authority
- legacy admin compatibility surfaces
- client account management until a separate access/safety role is introduced
