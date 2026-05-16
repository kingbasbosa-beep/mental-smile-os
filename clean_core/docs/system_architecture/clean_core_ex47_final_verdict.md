# EX-47 Final Verdict

Phase: EX-47 - Mapper Split Strategy

## Final Findings

The reviewed audit and human review targets are combined model-plus-Firestore-mapper classes.

They are not safe for direct extraction as-is.

## Required Future Split

Future extraction requires:

- pure Dart contract/model
- host/backend Firestore mapper
- optional adapter boundary later

## Firestore Coupling Verdict

Firestore coupling is isolated to:

- Cloud Firestore imports
- server timestamp behavior
- timestamp conversion
- Firestore map serialization

These must remain host/backend-owned.

## Future Split Verdict

Do not move these target files as-is.

Prepare a dedicated split execution phase for one cluster at a time, beginning with the smallest low-risk cluster only after semantic approval.

