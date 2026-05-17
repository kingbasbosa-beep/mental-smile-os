# EX-68 AuditTrace Candidate Review

## Reviewed File

- `clean_core/lib/core/audit/audit_trace.dart`

## Current Shape

`AuditTrace` is mixed and Firestore-coupled. It contains declarative fields, but it also imports `cloud_firestore` and owns Firestore serialization through `toMap`, `FieldValue.serverTimestamp()`, and `Timestamp.fromDate`.

## Current Fields

- `traceId`
- `traceHash`
- `policyVersion`
- `runtimeMarker`
- `references`
- `sanitizedPreview`
- `createdAt`

## Candidate Classification

`audit_trace.dart` is not a true leaf extraction candidate. It is a mapper-bound split candidate because the pure model can likely be separated from Firestore mapping while preserving the existing compatibility path.

## Initial Recommendation

Do not move `audit_trace.dart` directly. Use an additive split strategy similar to `audit_event`:

1. Introduce a package-safe pure `AuditTrace` model later.
2. Keep Firestore mapping host-side.
3. Preserve the existing compatibility path.
4. Avoid reconnect or consumer migration.
