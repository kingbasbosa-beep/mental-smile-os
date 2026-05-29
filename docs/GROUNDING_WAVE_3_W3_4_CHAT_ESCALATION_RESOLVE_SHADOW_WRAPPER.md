# GROUNDING-WAVE-3 / W3-4 Chat Escalation Resolve Shadow Wrapper

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

## 1. Scope

W3-4 expands the passive chat escalation wrapper to one method only:

```text
ChatFirestoreService.resolveEscalation
```

Future shadow command name:

```text
chat.escalation.resolve
```

No wrapper was added for escalation creation, safety reports, or chat message sending.

## 2. Files Modified

| File | Change |
| ---- | ------ |
| `lib/features/chat/data/commands/chat_escalation_command_wrapper.dart` | Added passive `resolveEscalation` wrapper support, diagnostic envelope creation, non-blocking warnings, and minimal shadow logs. |
| `lib/features/admin_surface/pages/chat_escalations_page.dart` | Wired only the current resolve action to call the passive wrapper and delegate to `ChatFirestoreService.resolveEscalation`. |

## 3. Files Created

| File | Purpose |
| ---- | ------- |
| `docs/GROUNDING_WAVE_3_W3_4_CHAT_ESCALATION_RESOLVE_SHADOW_WRAPPER.md` | Documents W3-4 wiring scope, method signature, behavior guarantee, rollback, and manual verification commands. |

## 4. Confirmed Method Signature

Confirmed service method signature:

```dart
Future<void> resolveEscalation({
  required String escalationId,
  required String threadId,
  required String resolverUid,
})
```

There is no resolution note in the current contract.

Confirmed current UI caller:

```text
lib/features/admin_surface/pages/chat_escalations_page.dart
_resolveEscalation(...)
```

## 5. Wiring Confirmation

Wrapper was wired.

Current path:

```text
ChatEscalationsPage._resolveEscalation
 -> ChatEscalationCommandWrapper.resolveEscalation
 -> ChatFirestoreService.resolveEscalation
 -> Firestore transaction
```

Only resolve was wired.

Untouched methods:

- `createEscalation`
- `createSafetyReport`
- chat message sending

## 6. Behavior Guarantee

No behavior changes are intended.

The wrapper:

- Builds a shadow-only `ChatEscalationCommandEnvelope`.
- Computes diagnostic warnings only.
- Logs minimal `CHAT_ESCALATION_COMMAND_SHADOW` output.
- Delegates to the existing `ChatFirestoreService.resolveEscalation`.
- Preserves current exceptions and UI behavior.

The wrapper does not:

- Enforce validation.
- Block resolution.
- Write audit collections.
- Write command collections.
- Change Firestore rules.
- Add custom claims.
- Add backend functions.
- Change the resolution transaction payload.
- Touch create escalation, safety report, or chat message behavior.

## 7. Rollback Path

Rollback is local and simple.

In `lib/features/admin_surface/pages/chat_escalations_page.dart`, change resolve action from:

```dart
await _escalationCommandWrapper.resolveEscalation(
  escalationId: escalation.id,
  threadId: escalation.threadId,
  resolverUid: uid,
  delegate: () => _service.resolveEscalation(
    escalationId: escalation.id,
    threadId: escalation.threadId,
    resolverUid: uid,
  ),
);
```

back to:

```dart
await _service.resolveEscalation(
  escalationId: escalation.id,
  threadId: escalation.threadId,
  resolverUid: uid,
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

