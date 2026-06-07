# Signal Federation Runtime Foundation

## Wave

Wave S-1.5 - Signal Federation Runtime Scaffold.

## What Was Created

This wave creates the first in-code runtime language for constitutional
signals in Mental Smile.

Created components:

- `SignalPackage`
- `SignalCategoryRegistry`
- `SignalTypeRegistry`
- `SignalRoutingTarget`
- `SignalRetentionClass`
- `SignalPrivacyLevel`
- `ForbiddenSignalSourceGuard`
- `SignalPackageFactory`
- `SignalEmitter`
- `NoopSignalEmitter`

## What Was Not Activated

This wave does not activate:

- Signal Gateway
- Tool Meter
- Safety Valve
- Monitoring UI
- Reports
- Analytics
- Firebase writes
- Firestore collections
- Firestore rules
- User-facing workflow changes

## Forbidden Sources

The runtime foundation explicitly blocks SignalPackage creation from these
constitutional contaminants:

- `booking_requests`
- `bookingRequests`
- `sessionRatings`
- `payment proof`
- `payout states`
- `assignment states`
- `session states`
- `admin lifecycle decisions`
- `admin booking decisions`
- `admin payment decisions`
- `admin session decisions`

## Supported Signal Types In S-1.5

Only these first ten constitutional signal types are included:

- `goal_selected`
- `interest_selected`
- `accessibility_interest`
- `communication_preference_selected`
- `destination_saved`
- `provider_contact_started`
- `center_contact_started`
- `support_started`
- `library_category_opened`
- `provider_profile_opened`

## What Comes In S-2

Wave S-2 can safely connect selected clean sources to a real emitter or
repository, if Firestore rules and privacy boundaries are approved first.

Candidate sources:

- Client signals
- Saved destinations
- Provider contact requests
- Center contact requests
- Support request metadata
- Library category opens
- Provider profile opens

Legacy booking, payment, session, payout, assignment, and admin decision
sources must remain excluded.
