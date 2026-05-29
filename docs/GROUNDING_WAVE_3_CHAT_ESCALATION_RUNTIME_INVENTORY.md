# GROUNDING-WAVE-3 / W3-0 Chat Escalation Runtime Inventory

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Status: inventory only. No code was modified, no wrappers were created, no audit runtime was implemented, no command runtime was implemented, no collections were created, no Firebase rules or claims were changed, and no backend behavior was changed.

## 1. Chat Runtime Overview

The current chat runtime is Firebase/Firestore based. Chat conversations are stored under:

```text
chat_threads
chat_threads/{threadId}/messages
chat_escalations
chat_escalations/{escalationId}/reports
```

The primary runtime service identified during Grounding inventory is:

```text
lib/features/chat/data/services/chat_firestore_service.dart
```

Admin-facing escalation UI is surfaced through:

```text
lib/features/admin_surface/pages/chat_escalations_page.dart
```

Related routes identified in the route inventory:

```text
/chat
/chat/escalations
/chat/escalation/report
/admin/support-chats
```

Current runtime authority remains hybrid:

- Signed-in participants can create chat messages.
- Signed-in actors can create escalation/report artifacts in some flows.
- Admins can assign, forward, and resolve escalation records.
- Firestore rules and custom claims remain the actual runtime authority.
- There is no command runtime, no audit runtime, and no append-only escalation memory yet.

Chat escalation is operationally sensitive because it is close to support continuity, safety escalation, case handling, and possible clinical-adjacent communication. It should be treated as Control Room case/governance territory, not as generic admin mutation authority.

## 2. Escalation Authority Map

| Action | Current Actor / Entry | Current Authority Source | Current Runtime Meaning | Risk |
| ------ | --------------------- | ------------------------ | ----------------------- | ---- |
| Create escalation | Signed-in actor/service through chat flow | Firestore rules + service logic | Opens an escalation record linked to chat/support context | High |
| Create safety report | Signed-in actor/service through report flow | Firestore rules + service logic | Adds report under escalation context | Medium |
| Assign escalation | Admin UI/service | Admin custom claim + `ChatFirestoreService` transaction | Assigns an escalation to an admin and updates related thread metadata | High |
| Forward escalation to clinician | Admin UI/service | Admin custom claim + `ChatFirestoreService` transaction | Moves escalation toward clinician handling/visibility | High |
| Resolve escalation | Admin UI/service | Admin custom claim + `ChatFirestoreService` transaction | Marks escalation and related thread state as resolved/closed | High |
| Update thread state | Chat service/admin/support flows | Participant/admin rules + service logic | Changes lifecycle/risk/status fields on chat thread | Medium/High |
| Archive thread | Chat service/admin/support flows | Participant/admin rules + service logic | Marks chat thread archived/closed | Medium |
| Send message | Signed-in participant | Participant checks + thread existence | Adds message and updates thread metadata | Medium |

Authority conclusion:

Escalation mutation authority is still admin-centric for assign/forward/resolve. The Control Room doctrine is not yet enforced. These actions should eventually become case-linked commands with audit, but W3-0 does not implement that.

## 3. Mutation Paths

| Method / Flow | Collection(s) Touched | Operation Type | Authority Level | Risk Level |
| ------------- | --------------------- | -------------- | --------------- | ---------- |
| `ChatFirestoreService.createThread` | `chat_threads/{threadId}` | `set` | Signed-in app actor / service | Medium |
| `ChatFirestoreService.sendMessage` | `chat_threads/{threadId}/messages`, `chat_threads/{threadId}` | transaction `set` + `update` | Participant/service | Medium |
| `ChatFirestoreService.updateThreadState` | `chat_threads/{threadId}` | `update` | Participant/admin/service depending caller | Medium/High |
| `ChatFirestoreService.archiveThread` | `chat_threads/{threadId}` | `update` | Participant/admin/service depending caller | Medium |
| `ChatFirestoreService.linkBookingToThread` | `chat_threads/{threadId}` | `update` | Booking/chat service | Medium |
| `ChatFirestoreService.assignEscalationToAdmin` | `chat_escalations/{id}`, `chat_threads/{threadId}` | transaction `update` + `update` | Admin direct | High |
| `ChatFirestoreService.forwardEscalationToClinician` | `chat_escalations/{id}`, `chat_threads/{threadId}` | transaction `update` + `update` | Admin direct | High |
| `ChatFirestoreService.resolveEscalation` | `chat_escalations/{id}`, `chat_threads/{threadId}` | transaction `update` + `update` | Admin direct | High |
| `ChatFirestoreService.createEscalation` | `chat_escalations` | `add` | Signed-in actor/service | High |
| `ChatFirestoreService.createSafetyReport` | `chat_escalations/{id}/reports` | `add` | Signed-in actor/service | Medium/High |
| `chat_page.dart` message send flow | `chat_threads/{threadId}/messages`, `chat_threads/{threadId}` | `add` + `update` | Signed-in participant | Medium |
| `booking_legacy_chat_adapter.dart` chat bridge | `chat_threads`, `chat_threads/{threadId}/messages` | `set`/`add`/`update` | Booking service compatibility | Medium |

Highest-risk mutation paths:

- `assignEscalationToAdmin`
- `forwardEscalationToClinician`
- `resolveEscalation`
- `createEscalation`
- `createSafetyReport`

The highest-risk admin paths are assign/forward/resolve because they mutate escalation lifecycle state and thread state together.

## 4. Candidate Shadow Commands

Proposed future shadow command names only:

| Current Method / Flow | Candidate Shadow Command | Notes |
| --------------------- | ------------------------ | ----- |
| `createEscalation` | `chat.escalation.create` | Case opening / escalation request. |
| `assignEscalationToAdmin` | `chat.escalation.assign` | Admin assignment command candidate. |
| `forwardEscalationToClinician` | `chat.escalation.forward_to_clinician` | Higher sensitivity because clinician visibility/continuity may be involved. |
| `resolveEscalation` | `chat.escalation.resolve` | High sensitivity because it closes/settles a case state. |
| `createSafetyReport` | `chat.escalation.report.create` | Append/report artifact candidate. |
| `updateThreadState` | `chat.thread.state_update` | Broader thread lifecycle command candidate. |
| `archiveThread` | `chat.thread.archive` | Archive/finality candidate. |
| `linkBookingToThread` | `chat.thread.link_booking` | Cross-domain link candidate. |

Do not implement these in W3-0.

## 5. Safest First Candidate

Safest first escalation mutation candidate:

```text
chat.escalation.assign
```

Current likely source method:

```text
ChatFirestoreService.assignEscalationToAdmin
```

Why this is the lowest-risk escalation wrapper candidate:

- It is admin/case routing oriented rather than resolution/finality.
- It does not appear to finalize an escalation.
- It does not appear to forward authority into clinician handling.
- It can be observed as a case ownership/routing action.
- A passive wrapper can generate an envelope and warnings while preserving the existing transaction.

Why not start with `chat.escalation.resolve`:

- Resolution closes or finalizes an escalation state.
- It has stronger audit and case-finality implications.

Why not start with `chat.escalation.forward_to_clinician`:

- Forwarding to clinician may touch support continuity vs clinical continuation boundaries.
- It may expose escalation context beyond admin/control scope.

Why not start with `chat.escalation.create`:

- Creation may be initiated by signed-in users/services, not just admin UI.
- Entry points may be broader and should be mapped more carefully first.

## 6. Frozen Areas

These escalation/chat areas should remain untouched during first wrapper portability work:

- Escalation resolution/finality.
- Clinician forwarding.
- Safety report creation.
- Chat message content creation.
- Booking-chat legacy adapter behavior.
- Thread archive behavior.
- Cross-domain booking-thread link behavior.
- Firestore rules for chat/escalation.
- Claims/role model for chat/escalation.
- Backend command execution.
- Audit collection creation.
- Any clinical-continuation semantics.

Control Room doctrine reminder:

Escalation handling should become case/audit oriented. It should not become a generic admin mutation cockpit.

## 7. W3-1 Recommendation

Recommended first escalation wrapper candidate:

```text
chat.escalation.assign
```

W3-1 should be:

```text
GROUNDING-WAVE-3 / W3-1 - Passive Shadow Wrapper for Chat Escalation Assignment
```

Scope recommendation:

- One method only: `ChatFirestoreService.assignEscalationToAdmin`.
- Passive shadow only.
- Envelope only.
- Diagnostic warnings only.
- Minimal logs only.
- Delegate to existing service method.
- Preserve current transaction, exceptions, and UI behavior.

Do not include in W3-1:

- `forwardEscalationToClinician`
- `resolveEscalation`
- `createEscalation`
- `createSafetyReport`
- Audit writes
- Command collections
- Rules/claims/backend changes

## Final Inventory Result

Chat escalation is a plausible next domain for passive command portability, but it should begin with assignment/routing only. Resolution, forwarding, safety reports, and message content should remain frozen until the assignment wrapper pattern is assessed.

Commands Executed By Codex:
None

