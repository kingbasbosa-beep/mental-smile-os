# EX-62 Audit Export Governance

Phase: EX-62 - Audit Dependency Vocabulary Review

## Export-Safe With Caveats

Future explicit export candidates:

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`
- `audit_reference.dart`

## Required Caveats

If exported, docs must state:

- actor labels do not prove authority
- event labels do not execute runtime/provider behavior
- severity labels do not trigger escalation
- visibility labels do not enforce access control
- references do not prove backend integrity

## Export Restrictions

Future export must be:

- explicit file-by-file only
- no wildcard export
- no directory export
- no Firestore-coupled audit event/trace export bundled with it
- no runtime marker export bundled with it
- no observability export bundled with it

## Host-Side Only Not Required

None of the reviewed vocabulary contracts must remain host-side by implementation.

They require caveats, not host-only ownership.

## Export Governance Finding

The reviewed contracts are eligible for future controlled package exposure if caveats and rollback scope are documented.

