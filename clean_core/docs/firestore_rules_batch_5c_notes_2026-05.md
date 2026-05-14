# Firestore Rules Batch 5C Notes

Date: 2026-05-14  
Target: Mental Smile `clean_core`  
Batch: Conservative chat boundary review and minimal rules posture

## Chat Usage Found

Clean-core references chat-related data in:

- `lib/features/booking/data/services/booking_legacy_chat_adapter.dart`
  - reads existing `chat_threads` for reusable booking follow-up threads
  - creates or updates `chat_threads`
  - creates `chat_threads/{threadId}/messages`
  - updates counters and previews on the parent thread
  - writes governance/safety/admin-like fields:
    - `assignedAdminUid`
    - `assignedClinicianUid`
    - `handoffState`
    - `lifecycleState`
    - `safetyState`
    - `riskScore`
    - `riskLevel`
    - `strategyMode`
    - `lastEmotionalStates`
    - `lastDetectedRole`
    - `messageCount`
    - `lastMessagePreview`
- `lib/features/booking/presentation/pages/booking_request_page.dart`
  - imports `BookingLegacyChatAdapter`
  - stores returned `threadId` on booking request payloads
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
  - no direct `chat_threads` read; support count uses `support_requests`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
  - no direct `chat_threads` read; support count uses `support_requests`
  - `chat_escalations` count remains denied in rules

## Chosen Posture

Option B was chosen: participant-only read access with all chat writes denied.

Option C was rejected because current client-side adapter writes safety/governance/admin-like metadata. Opening narrow message creates safely would require a reviewed chat schema, sender validation, moderation boundaries, counter updates, and AI Safety OS decisions.

## Reads Opened

`chat_threads/{threadId}` reads are allowed only for:

- admin helper
- thread participants where one of these fields matches `request.auth.uid`:
  - `ownerUid`
  - `officialClientUid`
  - `clientId`
  - `clinicianId`
  - `assignedClinicianUid`
  - `centerId`
- assigned admin only when `assignedAdminUid == request.auth.uid` and `isAdmin()` is true

`chat_threads/{threadId}/messages/{messageId}` reads are allowed only when the parent thread is readable by the same participant/admin rule.

No public reads are allowed.

## Writes Denied

The following remain denied:

- chat thread create
- chat thread update
- chat thread delete
- message create
- message update
- message delete

This intentionally conflicts with `BookingLegacyChatAdapter` writes. Safety wins over convenience for this batch.

## Governance Fields Protected

Because all chat writes are denied, users cannot directly control:

- `riskScore`
- `riskLevel`
- `safetyState`
- `strategyMode`
- `handoffState`
- `escalationStatus`
- `assignedAdminUid`
- `assignedClinicianUid`
- `adminNotes`
- `systemMessage`
- `messageCount`
- `lastMessagePreview`
- `lifecycleState`

These fields should remain admin/server/Cloud Function controlled.

## App-Code Conflicts Noticed

`BookingLegacyChatAdapter` currently writes:

- thread creation/update payloads
- message documents
- counters/previews
- admin/handoff state
- safety/risk metadata

With Batch 5C, those writes will be denied by rules. The booking flow may still create booking requests, but chat thread creation/linking should be moved behind a trusted backend boundary before production.

## Cloud Function Recommendations

Future backend functions should own:

- creating booking follow-up chat threads
- linking booking requests to chat threads
- appending user/admin/system messages
- updating `messageCount`
- updating `lastMessagePreview`
- assigning admins/clinicians
- mutating `handoffState`
- mutating `safetyState`, `riskScore`, `riskLevel`, and `strategyMode`
- writing audit logs
- dispatching notifications
- escalating to AI Safety OS later

## AI Safety Deferral

No AI Safety collections were opened.

Crisis escalation, safety traces, AI policy runtime data, and raw sensitive chat governance remain deferred to the AI Safety OS phase.

Raw sensitive chat data must not become broadly readable.

## Collections Still Denied

Still denied:

- `bookingRequests` legacy fallback
- `chat_escalations`
- AI Safety collections
- `legalConsents`
- payment proof flows
- broad admin writes
- lifecycle orchestration
- chat writes

## Next Recommended Batch 6

Batch 6 should focus on legal consent and AI Safety placeholders/design, not broad access:

- keep AI safety logs admin/server-only
- design immutable legal consent create if product/legal approves
- define Cloud Function boundaries for crisis/safety escalation
- preserve deny-by-default until AI Safety OS is reviewed

