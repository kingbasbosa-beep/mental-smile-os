# EX-96 EscalationRequest Mapper Verification

## Mapper

File:

- `clean_core/lib/core/human_review/firestore/escalation_request_firestore_mapper.dart`

## Host-Side Ownership Verified

The mapper remains outside `mental_smile_clean_core` and owns:

- `cloud_firestore` import
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- Firestore field names
- null/default handling
- all vocabulary `.key` serialization
- nested audit-link serialization/deserialization
- nested policy-reference serialization/deserialization
- boundary marker storage compatibility

## Import Boundary

The mapper imports local host compatibility files only. It has no `package:mental_smile_clean_core` import.

## Storage Shape

The mapper preserves the existing request storage fields:

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

## Verification Verdict

PASS. Mapper is host-side and owns Firestore/boundary serialization.
