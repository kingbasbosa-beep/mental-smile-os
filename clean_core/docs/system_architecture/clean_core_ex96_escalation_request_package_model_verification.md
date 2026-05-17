# EX-96 EscalationRequest Package Model Verification

## Package Model

File:

- `mental_smile_clean_core/lib/src/human_review/escalation_request.dart`

## Frozen Fields Present

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

## Excluded Fields and Logic

Verified absent from the package model:

- `boundaryMarker`
- `EscalationBoundaryMarker`
- queue/routing logic
- Firestore/Firebase imports
- `Timestamp`
- `FieldValue`
- `toMap`
- `fromMap`
- persistence logic

## Semantic Caveats Verified

- Request metadata does not initiate escalation execution.
- `level` and `priority` do not route or schedule.
- `reason` does not prove provider/runtime causality.
- `state` does not progress workflow.
- `visibilityScope` does not enforce authorization.
- `sanitizedPreview` is not privacy or security proof.
- `auditLink` and `policyReference` remain metadata only.
- `createdAt` does not prove backend ingestion or processing.
- The request record does not approve, route, execute, own, or guarantee escalation handling.

## Verification Verdict

PASS. Package model remains pure Dart, metadata-only, boundary-free, and queue-free.
