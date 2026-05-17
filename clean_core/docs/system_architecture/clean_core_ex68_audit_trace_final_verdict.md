# EX-68 AuditTrace Final Verdict

## Findings

`audit_trace.dart` is a mixed Firestore-coupled host-side model. It contains pure data fields but also owns Firestore serialization, timestamp conversion, server timestamp behavior, runtime marker serialization, and nested reference serialization.

## Dependency/Consumer Summary

- Depends on `AuditReference`.
- Depends on `AuditRuntimeMarker`.
- Does not depend on `AuditEvent`, `AuditSnapshot`, or `AuditProcessingContext` today.
- No direct typed consumers of `AuditTrace` were found.
- Existing sibling imports make direct movement risky.

## Risk Classification

Mapper-bound candidate with runtime-marker and observability adjacency. Not a true leaf.

## EX-68 Verdict

Do not execute extraction next. The correct next phase is simulation/design for an additive mapper split.

## Recommended EX-69 Prompt Draft

Execute EX-69 — AuditTrace Additive Split Simulation.

Target workspace:
`C:\mental_smile_workspace\app\mental-smile-app-clean2`

Strict simulation-only phase.

Do not modify files. Do not move files. Do not create package files. Do not create mappers. Do not modify imports or exports. Do not run pub get. Do not run analyze. Do not reconnect or migrate consumers. Do not activate runtime/provider/Firebase/adapters.

Inspect:

- `clean_core/lib/core/audit/audit_trace.dart`
- `clean_core/lib/core/audit/audit_reference.dart`
- `clean_core/lib/core/audit/audit_runtime_marker.dart`
- `mental_smile_clean_core/lib/src/audit/audit_reference.dart`
- `mental_smile_clean_core/lib/src/audit/audit_processing_context.dart`
- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

Simulate future split into:

1. package-safe pure model: `mental_smile_clean_core/lib/src/audit/audit_trace.dart`
2. host-side mapper: `clean_core/lib/core/audit/firestore/audit_trace_firestore_mapper.dart`
3. existing compatibility path retained: `clean_core/lib/core/audit/audit_trace.dart`

Verify simulated package model remains Dart-only, Firestore-free, runtime-free, provider-free, persistence-free, and authority-neutral.

Determine how `AuditRuntimeMarker` maps into `AuditProcessingContext`, how nested `AuditReference` mapping remains host-side, and whether rollback remains local.

Output:

- future file-map findings
- pure model findings
- mapper boundary findings
- compatibility findings
- rollback/risk findings
- EX-69 simulation verdict
