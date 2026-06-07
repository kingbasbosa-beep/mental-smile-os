# Booking Authority Freeze P-2

## Firestore Authority

`booking_requests` is now legacy read/update only. New document creation is
denied in client Firestore rules.

`bookingRequests` remains an archive-dead mirror with all reads and writes
denied.

## Admin Authority

Admin booking, payment, and session decision adapters are retained only for
legacy compatibility records created before the authority freeze cutoff. They
must not be used to create or progress a new booking lifecycle.

## Rating Doctrine Separation

`sessionRatings` is legacy. It exists only for historical review and archive
integrity.

Future public feedback must not depend on sessions, booking requests, payment
states, assignments, or admin lifecycle decisions. The future doctrine is an
optional public feedback surface such as `public_feedback`,
`provider_feedback`, or `center_feedback`, connected to public profiles only.

## Signal Alignment

Modern contact CTAs must produce contact semantics only:

- `provider_contact_started`
- `center_contact_started`
- `contact_opened`

They must not produce booking/session semantics such as:

- `booking_created`
- `request_created`
- `session_requested`
