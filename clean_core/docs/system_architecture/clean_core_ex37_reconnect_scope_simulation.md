# EX-37 Reconnect Scope Simulation

Phase: EX-37 - Wave 2 Safe Batch Reconnect Simulation

## Purpose

This document simulates the future reconnect phase after Wave 2 safe-batch movement.

No imports, exports, dependencies, runtime systems, provider systems, adapters, or source files were modified.

## Current Moved Surfaces

Moved audit contracts:

- `AuditActorType`
- `AuditEventType`
- `AuditHashPlaceholder`
- `AuditRedaction`
- `AuditReference`
- `AuditRetentionPolicy`
- `AuditSeverity`
- `AuditVisibilityScope`

Moved human review contracts:

- `EscalationAuditLink`
- `EscalationLevel`
- `EscalationPolicyReference`
- `EscalationReason`
- `EscalationState`
- `ReviewPriority`
- `ReviewVisibilityScope`

## Simulated Reconnect Pressure

Reconnect pressure exists where excluded files still use sibling imports for moved files.

Audit excluded files with likely reconnect needs:

- `clean_core/lib/core/audit/audit_event.dart`
- `clean_core/lib/core/audit/audit_trace.dart`
- `clean_core/lib/core/audit/audit_snapshot.dart`
- `clean_core/lib/core/audit/safety_observability_contract.dart`

Human review excluded files with likely reconnect needs:

- `clean_core/lib/core/human_review/escalation_assignment.dart`
- `clean_core/lib/core/human_review/escalation_queue.dart`
- `clean_core/lib/core/human_review/escalation_request.dart`
- `clean_core/lib/core/human_review/escalation_resolution.dart`
- `clean_core/lib/core/human_review/escalation_review.dart`

## Scope Finding

Future reconnect is not broad. It is limited to files that still consume the moved declarative contracts. However, many of those consumers are excluded/manual-review files, so reconnect must remain gated.

