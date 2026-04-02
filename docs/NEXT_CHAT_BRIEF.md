# Brief for Next Chat — Mental Key

We are continuing Mental Key from a stable checkpoint.

## Core product rules
- Non-medical
- Non-diagnostic
- Supportive
- Safety-first
- Family-aware

## Already completed
- login basics
- specialists setup
- booking flow (client/admin/clinician)
- admin booking queue
- clinician booking inbox
- chat
- AI response loop
- risk escalation
- assign escalation to admin
- forward escalation to clinician
- resolve escalation
- safety escalation report generation in Firestore

## Important collections
- clinicians
- booking_requests
- chat_threads
- chat_escalations
- chat_escalations/{id}/reports

## Important files
- lib/features/chat/data/services/chat_firestore_service.dart
- lib/features/chat/controller/chat_controller.dart
- lib/features/chat/presentation/pages/chat_escalations_page.dart
- lib/app/router/routes.dart
- lib/app/router/app_router.dart
- firestore.rules

## Working style
Prefer:
- full-file replacement
- or one/two clean short patches

Avoid:
- fragmented manual edits
- reopening core philosophy from zero

## Main caution
Check Firestore rules with every new collection or subcollection.

## Next task
[WRITE THE EXACT TASK FOR THIS CHAT HERE]
