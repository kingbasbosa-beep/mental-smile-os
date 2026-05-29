# GROUNDING-WAVE-3 / W3-3 Chat Escalation Forward Shadow Wrapper

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

## 1. Scope

W3-3 expands the passive chat escalation wrapper to one method only:

```text
ChatFirestoreService.forwardEscalationToClinician
```

Future shadow command name:

```text
chat.escalation.forward_to_clinician
```

No wrapper was added for resolving, escalation creation, safety reports, or chat message sending.

## 2. Files Modified

| File | Change |
| ---- | ------ |
| `lib/features/chat/data/commands/chat_escalation_command_wrapper.dart` | Added passive `forwardEscalationToClinician` wrapper support, diagnostic envelope creation, non-blocking warnings, and minimal shadow logs. |
| `lib/features/admin_surface/pages/chat_escalations_page.dart` | Wired only the current forward action to call the passive wrapper and delegate to `ChatFirestoreService.forwardEscalationToClinician`. |

## 3. Files Created

| File | Purpose |
| ---- | ------- |
| `docs/GROUNDING_WAVE_3_W3_3_CHAT_ESCALATION_FORWARD_SHADOW_WRAPPER.md` | Documents W3-3 wiring scope, method signature, behavior guarantee, rollback, and manual verification commands. |

## 4. Confirmed Method Signature

Confirmed service method signature:

```dart
Future<void> forwardEscalationToClinician({
  required String escalationId,
  required String threadId,
  required String clinicianUid,
})
```

Confirmed current UI caller:

```text
lib/features/admin_surface/pages/chat_escalations_page.dart
forward clinician selection flow
```

## 5. Wiring Confirmation

Wrapper was wired.

Current path:

```text
ChatEscalationsPage forward action
 -> ChatEscalationCommandWrapper.forwardEscalationToClinician
 -> ChatFirestoreService.forwardEscalationToClinician
 -> Firestore transaction
```

Only forward was wired.

Untouched methods:

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
- Delegates to the existing `ChatFirestoreService.forwardEscalationToClinician`.
- Preserves current exceptions and UI behavior.

The wrapper does not:

- Enforce validation.
- Block forwarding.
- Write audit collections.
- Write command collections.
- Change Firestore rules.
- Add custom claims.
- Add backend functions.
- Change the forwarding transaction payload.
- Touch resolve, create, safety report, or chat message behavior.

## 7. Rollback Path

Rollback is local and simple.

In `lib/features/admin_surface/pages/chat_escalations_page.dart`, change the forward action from:

```dart
await _escalationCommandWrapper.forwardEscalationToClinician(
  escalationId: escalation.id,
  threadId: escalation.threadId,
  clinicianUid: selected.id,
  delegate: () => _service.forwardEscalationToClinician(
    escalationId: escalation.id,
    threadId: escalation.threadId,
    clinicianUid: selected.id,
  ),
);
```

back to:

```dart
await _service.forwardEscalationToClinician(
  escalationId: escalation.id,
  threadId: escalation.threadId,
  clinicianUid: selected.id,
);
```

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

