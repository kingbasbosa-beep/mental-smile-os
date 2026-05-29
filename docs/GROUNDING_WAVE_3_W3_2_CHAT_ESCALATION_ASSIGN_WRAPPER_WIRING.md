# GROUNDING-WAVE-3 / W3-2 Chat Escalation Assign Wrapper Wiring

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

## 1. Scope

W3-2 wires the existing passive chat escalation assignment wrapper into the current admin escalation assignment path.

Only this method is in scope:

```text
ChatFirestoreService.assignEscalationToAdmin
```

Future shadow command name:

```text
chat.escalation.assign
```

No forwarding, resolving, escalation creation, safety report, chat message, audit, command collection, Firebase rules, claims, or backend behavior was touched.

## 2. Files Modified

| File | Change |
| ---- | ------ |
| `lib/features/admin_surface/pages/chat_escalations_page.dart` | Imported `ChatEscalationCommandWrapper`, added a static wrapper instance, and wired `_assignToMe` to call the passive wrapper. |

## 3. Files Created

| File | Purpose |
| ---- | ------- |
| `docs/GROUNDING_WAVE_3_W3_2_CHAT_ESCALATION_ASSIGN_WRAPPER_WIRING.md` | Documents W3-2 wiring scope, method signature, behavior guarantee, rollback, and manual verification commands. |

## 4. Confirmed Method Signature

Confirmed service method signature:

```dart
Future<void> assignEscalationToAdmin({
  required String escalationId,
  required String threadId,
  required String adminUid,
})
```

Confirmed current UI caller:

```text
lib/features/admin_surface/pages/chat_escalations_page.dart
_assignToMe(...)
```

## 5. Wiring Confirmation

Wrapper was wired.

Current path:

```text
ChatEscalationsPage._assignToMe
 -> ChatEscalationCommandWrapper.assignEscalationToAdmin
 -> ChatFirestoreService.assignEscalationToAdmin
 -> Firestore transaction
```

Only assignment was wired.

Untouched methods:

- `forwardEscalationToClinician`
- `resolveEscalation`
- `createEscalation`
- `createSafetyReport`
- chat message sending

## 6. Behavior Guarantee

No behavior changes are intended.

The wrapper:

- Builds a shadow-only `ChatEscalationCommandEnvelope`.
- Computes diagnostic warnings only.
- Logs minimal `CHAT_ESCALATION_COMMAND_SHADOW` output.
- Delegates to the existing `ChatFirestoreService.assignEscalationToAdmin`.
- Preserves current exceptions and UI behavior.

The wrapper does not:

- Enforce validation.
- Block assignment.
- Write audit collections.
- Write command collections.
- Change Firestore rules.
- Add custom claims.
- Add backend functions.
- Change the assignment transaction payload.
- Touch forward, resolve, create, safety report, or chat message behavior.

## 7. Rollback Path

Rollback is local and simple.

In `lib/features/admin_surface/pages/chat_escalations_page.dart`, change `_assignToMe` from:

```dart
await _escalationCommandWrapper.assignEscalationToAdmin(
  escalationId: escalation.id,
  threadId: escalation.threadId,
  adminUid: uid,
  delegate: () => _service.assignEscalationToAdmin(
    escalationId: escalation.id,
    threadId: escalation.threadId,
    adminUid: uid,
  ),
);
```

back to:

```dart
await _service.assignEscalationToAdmin(
  escalationId: escalation.id,
  threadId: escalation.threadId,
  adminUid: uid,
);
```

Then remove the unused wrapper import/field if desired.

No data migration, Firestore cleanup, Firebase rules rollback, custom claims rollback, or backend rollback is required.

## 8. Manual Commands Required

Manual operator commands:

```powershell
dart format lib\features\chat\data\commands\chat_escalation_command_wrapper.dart lib\features\admin_surface\pages\chat_escalations_page.dart
```

```powershell
flutter analyze
```

## 9. Final Status

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

