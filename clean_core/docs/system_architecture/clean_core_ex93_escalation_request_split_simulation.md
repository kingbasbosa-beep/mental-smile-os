# EX-93 EscalationRequest Split Simulation

## Simulated Future Files

Package model:

- `mental_smile_clean_core/lib/src/human_review/escalation_request.dart`

Host mapper:

- `clean_core/lib/core/human_review/firestore/escalation_request_firestore_mapper.dart`

Compatibility path retained:

- `clean_core/lib/core/human_review/escalation_request.dart`

## Simulated Package Fields

The future package model would contain only:

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

## Explicit Exclusions

The package model would not contain:

- `boundaryMarker`
- queue acceptance/routing logic
- backend governance flags
- client outcome write policy
- emergency guarantee semantics
- Firestore serialization

## Simulation Finding

The metadata-only package model is viable if the existing host compatibility path remains intact and a host mapper preserves the current storage shape.
