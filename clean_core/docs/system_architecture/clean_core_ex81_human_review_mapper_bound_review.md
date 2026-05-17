# EX-81 Human Review Mapper-Bound Review

## Scope

Reviewed:

- `escalation_assignment.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`
- related state and audit-link contracts

No source, package, import, export, reconnect, analyzer, pub, runtime, provider, Firebase, or adapter work was executed.

## File Classification

### `EscalationAssignment`

- Firestore-coupled: yes
- Authority-coupled: medium
- Workflow-coupled: medium
- Approval-coupled: low
- Runtime/provider-adjacent: no direct provider/runtime import
- Mapper-bound: yes

### `EscalationResolution`

- Firestore-coupled: yes
- Authority-coupled: high
- Workflow-coupled: high
- Approval-coupled: high
- Runtime/provider-adjacent: no direct provider/runtime import
- Mapper-bound: yes

### `EscalationReview`

- Firestore-coupled: yes
- Authority-coupled: high
- Workflow-coupled: high
- Approval-coupled: medium
- Runtime/provider-adjacent: no direct provider/runtime import
- Mapper-bound: yes

## Mapper-Bound Finding

All three records import `cloud_firestore`, own `toMap`, use `FieldValue.serverTimestamp()`, and convert `DateTime?` to `Timestamp`. Direct extraction is blocked.
