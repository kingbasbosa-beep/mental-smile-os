# clean_core Audit Lane Semantic Review

This review assesses naming, authority, runtime implication, and execution risk for each audit lane file.

## Safe Declarative Semantics

- `audit_actor_type.dart`: role/source classification only.
- `audit_event_type.dart`: audit event labels only; runtime/provider labels are descriptive, not executable.
- `audit_hash_placeholder.dart`: placeholder hash naming; not cryptographic authority.
- `audit_redaction.dart`: privacy-preserving redaction and forbidden field list.
- `audit_reference.dart`: collection/document/hash reference shape.
- `audit_retention_policy.dart`: retention policy shape and constants.
- `audit_severity.dart`: severity labels.
- `audit_visibility_scope.dart`: visibility scope labels.

## Runtime-Sensitive Declarative Semantics

- `audit_runtime_marker.dart`: contains `runtimeMode`, `providerId`, `policyVersion`, and `fallbackReason`. It does not execute runtime, but naming is runtime-sensitive and should be documented as marker-only.
- `safety_observability_contract.dart`: combines audit reference, incident reference, runtime marker, provider id, policy version, and fallback reason. It is pure Dart but adapter-boundary oriented.

## Blocked Semantics

- `audit_event.dart`: event shape is semantically useful, but Firestore timestamp mapping makes it host/Firebase-coupled.
- `audit_trace.dart`: trace shape is semantically useful, but Firestore timestamp mapping makes it host/Firebase-coupled.
- `audit_snapshot.dart`: snapshot shape is semantically useful, but Firestore timestamp mapping makes it host/Firebase-coupled.

## Execution Semantics

No audit lane file executes provider calls, network calls, routing, orchestration, or runtime activation. The only execution-adjacent concern is Firestore serialization in blocked files.

## Semantic Verdict

Most audit lane semantics are contract-safe. Export readiness depends on separating pure audit contract shapes from Firebase serialization concerns.
