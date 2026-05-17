# EX-94 EscalationRequest Execution Readiness

## Scope

This review finalizes readiness for a future metadata-only additive split. It does not execute the split.

## Frozen Future Files

Package model:

- `mental_smile_clean_core/lib/src/human_review/escalation_request.dart`

Host mapper:

- `clean_core/lib/core/human_review/firestore/escalation_request_firestore_mapper.dart`

Compatibility path retained:

- `clean_core/lib/core/human_review/escalation_request.dart`

## Frozen Package Fields

- `uid`
- `level`
- `reason`
- `state`
- `priority`
- `visibilityScope`
- `sanitizedPreview`
- `auditLink`
- `policyReference`
- `createdAt`

## Exclusions

- `boundaryMarker`
- queue/routing logic
- backend governance flags
- client outcome write policy
- emergency guarantee semantics
- Firestore serialization

## Execution Readiness

EX-95 is approved only as a controlled additive split if it:

- preserves the host compatibility file;
- creates a pure package model;
- creates a host-side mapper;
- adds one explicit export;
- does not reconnect consumers;
- does not introduce package imports into `clean_core/lib/core`;
- preserves host-side boundary marker storage.
