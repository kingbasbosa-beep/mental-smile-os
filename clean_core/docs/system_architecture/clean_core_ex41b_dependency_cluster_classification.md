# EX-41B Dependency Cluster Classification

Phase: EX-41B - Consumer Dependency Topology Audit

## Classification Summary

| Cluster | Files | Classification |
| --- | --- | --- |
| Audit simple labels | actor type, event type, severity, visibility | consumer-bound cluster |
| Audit references | audit reference | consumer-bound cluster |
| Audit independent utilities | hash placeholder, redaction, retention policy | possible extraction-safe island after review |
| Audit Firestore consumers | audit event, snapshot, trace | Firestore-coupled cluster |
| Audit observability | safety observability contract | runtime/observability-sensitive cluster |
| Human review labels | escalation level, reason, state, priority, visibility | consumer-bound cluster |
| Human review references | audit link, policy reference | consumer-bound cluster |
| Human review Firestore consumers | assignment, request, resolution, review | Firestore-coupled cluster |
| Human review queue | escalation queue | queue/escalation-sensitive cluster |
| Human review boundary | escalation boundary marker | backend-authority-sensitive boundary marker |

## Extraction-Safe Islands

Possible extraction-safe islands:

- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_retention_policy.dart`

These are candidates only if no hidden downstream compile break is introduced.

## Consumer-Bound Clusters

Consumer-bound clusters must move with consumers or wait for package-aware consumer strategy:

- audit labels/references consumed by audit event/trace/snapshot/observability
- human review labels/references consumed by assignment/queue/request/resolution/review

## Blocked Clusters

Blocked or high-risk clusters:

- Firestore-coupled audit/human review consumers
- observability-sensitive contracts
- queue/escalation-sensitive contracts
- boundary marker contracts

## Cluster Finding

The topology shows that safe files are not necessarily extractable files. A file can be pure and declarative while still being a dependency root for blocked consumers.

