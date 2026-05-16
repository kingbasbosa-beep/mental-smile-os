# EX-43 True Leaf Simulated Stop Conditions

Phase: EX-43 - True Leaf Simulated Move Plan

## Mandatory Stop Conditions

Stop future true leaf movement if:

- a new consumer is found for any candidate
- a candidate gains an import
- a candidate gains Firebase/Flutter/provider/networking/generated dependency
- movement would require reconnect
- movement would modify package exports beyond the three explicit lines
- movement would include any additional audit file
- movement would touch audit event/trace/snapshot/runtime/observability files
- movement would touch human review files
- movement would require package-aware consumer strategy
- movement would activate runtime/provider/Firebase/adapters

## Export Stop Conditions

Stop if future barrel change includes:

- wildcard export
- directory export
- hidden audit export
- Firestore-coupled export
- runtime marker export
- observability export

## Rollback Stop Conditions

Stop if rollback scope becomes broader than:

- three moved files
- three export lines

## Stop Condition Finding

The future movement is safe only while these files remain true leaves.

