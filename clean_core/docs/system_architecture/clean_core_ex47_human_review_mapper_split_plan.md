# EX-47 Human Review Mapper Split Plan

Phase: EX-47 - Mapper Split Strategy

## `escalation_assignment.dart`

Pure model fields:

- `escalationId`
- `assignedTo`
- `assignedBy`
- `state`
- `assignedAt`

Firestore-only logic:

- `cloud_firestore` import
- server timestamp behavior
- timestamp conversion
- Firestore map serialization

Sensitivity:

- `assignedTo` and `assignedBy` are authority/privacy-sensitive
- `state` is review lifecycle vocabulary

Future split:

- pure assignment contract after authority review
- Firestore assignment mapper remains host/backend-owned

## `escalation_request.dart`

Pure model fields:

- `uid`
- `level`
- `reason`
- `state`
- `priority`
- `visibilityScope`
- `sanitizedPreview`
- `auditLink`
- `policyReference`
- `boundaryMarker`
- `createdAt`

Firestore-only logic:

- `cloud_firestore` import
- server timestamp behavior
- timestamp conversion
- Firestore map serialization

Sensitivity:

- `uid` is privacy-sensitive
- `sanitizedPreview` is privacy/safety-sensitive
- `boundaryMarker` is backend-authority-sensitive
- `level`, `reason`, `priority`, and `state` are escalation-sensitive

Future split:

- pure request contract only after boundary marker authority review
- Firestore request mapper remains host/backend-owned

## `escalation_resolution.dart`

Pure model fields:

- `escalationId`
- `resolvedBy`
- `state`
- `outcomeKey`
- `sanitizedResolutionNote`
- `auditLink`
- `resolvedAt`

Firestore-only logic:

- `cloud_firestore` import
- server timestamp behavior
- timestamp conversion
- Firestore map serialization

Sensitivity:

- `resolvedBy` is authority/privacy-sensitive
- `outcomeKey` and `state` are resolution-sensitive
- `sanitizedResolutionNote` is privacy-sensitive

Future split:

- pure resolution contract after authority review
- Firestore mapper remains host/backend-owned

## `escalation_review.dart`

Pure model fields:

- `escalationId`
- `reviewerId`
- `state`
- `sanitizedReviewNote`
- `auditLink`
- `reviewedAt`

Firestore-only logic:

- `cloud_firestore` import
- server timestamp behavior
- timestamp conversion
- Firestore map serialization

Sensitivity:

- `reviewerId` is authority/privacy-sensitive
- `sanitizedReviewNote` is privacy-sensitive
- `state` is review lifecycle vocabulary

Future split:

- pure review contract after human-review governance review
- Firestore mapper remains host/backend-owned

