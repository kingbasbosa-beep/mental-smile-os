# GROUNDING-WAVE-3 / W3-1 Chat Escalation Assign Shadow Wrapper

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Verification Status:
Pending Manual Operator Execution

## 1. Scope

W3-1 creates an isolated passive wrapper candidate for:

```text
ChatFirestoreService.assignEscalationToAdmin
```

Future shadow command name:

```text
chat.escalation.assign
```

No wrapper was added for forwarding, resolving, escalation creation, safety reports, or chat message sending.

## 2. Files Modified

No existing runtime file was modified.

Reason:

- Codex was instructed not to run repository commands.
- Without inspecting the exact `ChatFirestoreService.assignEscalationToAdmin` signature and UI caller shape, wiring would risk behavior or compile errors.
- The safe choice was to create an isolated wrapper only and document that it is not wired.

## 3. Files Created

| File | Purpose |
| ---- | ------- |
| `lib/features/chat/data/commands/chat_escalation_command_wrapper.dart` | Adds passive chat escalation command envelope, warning, risk-tier, and wrapper classes for `chat.escalation.assign`. |
| `docs/GROUNDING_WAVE_3_W3_1_CHAT_ESCALATION_ASSIGN_SHADOW_WRAPPER.md` | Documents W3-1 scope, wiring status, behavior guarantee, manual commands, and rollback posture. |

## 4. Wiring Status

Wrapper was not wired.

The current UI/service path that calls `assignEscalationToAdmin` remains unchanged.

## 5. Confirmation

Only passive support for `assignEscalationToAdmin` was created.

No other chat escalation method was wrapped:

- `forwardEscalationToClinician` untouched.
- `resolveEscalation` untouched.
- `createEscalation` untouched.
- `createSafetyReport` untouched.
- Chat message send behavior untouched.

## 6. Behavior Guarantee

No behavior changes are intended.

Because the wrapper is not wired:

- No runtime call path changed.
- No validation is enforced.
- No audit collections are written.
- No command collections are written.
- No Firebase rules changed.
- No custom claims changed.
- No backend functions were added.
- No chat message or escalation mutation behavior changed.

The wrapper itself is passive and would, if later wired safely:

- Build a shadow-only `ChatEscalationCommandEnvelope`.
- Compute diagnostic warnings only.
- Log minimal `CHAT_ESCALATION_COMMAND_SHADOW` output.
- Delegate to the existing assignment behavior through a callback.
- Preserve exceptions from the delegate.

## 7. New Shadow Envelope

The new passive envelope uses:

```text
commandName = chat.escalation.assign
commandVersion = v1
riskTier = HIGH_RISK
requestedByUid = adminUid
requestedByRole = admin
targetCollection = chat_escalations
targetDocId = escalationId
sourceService = ChatFirestoreService
sourceRoute = /chat/escalations
dryRun = true
shadowMode = true
```

## 8. Diagnostic Warnings

Warnings are diagnostic only and never block.

Implemented warning categories:

- `missing_escalation_id`
- `missing_admin_uid`
- `assignment_from_unexpected_status`
- `already_assigned`
- `thread_id_missing`
- `client_id_missing`
- `clinician_id_missing`
- `source_route_missing`

`missing_escalation_snapshot` was not implemented because W3-1 did not safely inspect or add a Firestore diagnostic read.

## 9. Logging Policy

Diagnostic logs use:

```text
CHAT_ESCALATION_COMMAND_SHADOW
```

Allowed logged fields:

- `commandName`
- `escalationId`
- `correlationId`
- `warningCount`
- `resultStatus`
- `sourceService`
- `sourceRoute`

Forbidden content remains excluded:

- Chat message body.
- Full thread content.
- Clinical notes.
- Safety report text.
- Full user profile.
- Secrets or tokens.

## 10. Manual Commands Required

Manual operator commands:

```powershell
dart format lib\features\chat\data\commands\chat_escalation_command_wrapper.dart
```

```powershell
flutter analyze
```

If the wrapper is wired in a later step, include the modified UI/service file in the format command too.

## 11. Rollback Path

Because the wrapper is not wired, rollback is simple:

- Delete or stop importing `lib/features/chat/data/commands/chat_escalation_command_wrapper.dart`.
- No data migration is required.
- No Firestore cleanup is required.
- No Firebase rules rollback is required.
- No custom claims rollback is required.
- No backend rollback is required.

## 12. Next Step Recommendation

Before wiring, perform a narrow signature inspection step for:

```text
ChatFirestoreService.assignEscalationToAdmin
chat_escalations_page.dart assignment caller
```

Then create a W3-1B wiring-only task if the signature and caller are clear.

