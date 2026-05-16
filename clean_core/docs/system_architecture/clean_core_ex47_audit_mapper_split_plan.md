# EX-47 Audit Mapper Split Plan

Phase: EX-47 - Mapper Split Strategy

## `audit_event.dart`

Pure model fields:

- `eventType`
- `severity`
- `actorType`
- `actorId`
- `visibilityScope`
- `sanitizedPreview`
- `policyVersion`
- `references`
- `runtimeMarker`
- `createdAt`

Firestore-only logic:

- `import 'package:cloud_firestore/cloud_firestore.dart'`
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate(...)`
- Firestore-oriented `toMap({bool useServerTimestamp = false})`

Sensitivity:

- `runtimeMarker` is runtime-sensitive vocabulary
- `actorId` and `sanitizedPreview` are privacy-sensitive
- `eventType`, `severity`, and `visibilityScope` are review/audit sensitive

Future split:

- `AuditEventContract` or equivalent pure model in package after review
- Firestore mapper remains host/backend-owned

## `audit_trace.dart`

Pure model fields:

- `traceId`
- `traceHash`
- `policyVersion`
- `runtimeMarker`
- `references`
- `sanitizedPreview`
- `createdAt`

Firestore-only logic:

- `cloud_firestore` import
- server timestamp behavior
- timestamp conversion
- Firestore map serialization

Sensitivity:

- `traceHash` and `references` are audit-link sensitive
- `runtimeMarker` is runtime-sensitive
- `sanitizedPreview` is privacy-sensitive

Future split:

- pure trace contract after runtime marker review
- Firestore mapper remains outside `mental_smile_clean_core`

## `audit_snapshot.dart`

Pure model fields:

- `snapshotId`
- `policyVersion`
- `createdBy`
- `hashPlaceholder`
- `visibilityScope`
- `immutable`
- `createdAt`

Firestore-only logic:

- `cloud_firestore` import
- server timestamp behavior
- timestamp conversion
- Firestore map serialization

Sensitivity:

- `createdBy` is authority/privacy-sensitive
- `immutable` and `policyVersion` are compliance-sensitive
- `visibilityScope` is access-control vocabulary

Future split:

- pure snapshot contract after compliance review
- Firestore mapper remains host/backend-owned

