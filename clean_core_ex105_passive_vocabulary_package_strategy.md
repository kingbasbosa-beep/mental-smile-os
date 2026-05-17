# EX-105 Passive Vocabulary Package Strategy

## Scope

This document reviews packaging shape only. It does not approve code changes.

## One File vs Grouped Files

Recommendation: grouped files for any future execution phase.

Rationale:

- Queue labels and boundary labels have different risk profiles.
- Emergency posture needs separate caveat handling.
- Provider/fallback labels need causality detox boundaries.
- Grouped files reduce the chance that a passive vocabulary type is mistaken for
  queue routing or backend governance infrastructure.

## Recommended Future Grouping

If a future no-runtime package introduction is approved, use separate passive
vocabulary files:

- queue intent/lifecycle labels
- boundary reference labels
- emergency posture labels
- provider issue labels
- fallback observation labels

Do not include:

- queues
- acceptance predicates
- admission helpers
- routing helpers
- mappers
- Firestore serialization
- backend policy contracts
- write policy contracts
- imports/exports until a separate exposure review approves them

## Package Introduction Strategy

Future introduction should be minimal and inert:

- enum-only or value-only vocabulary
- key mapping only if explicitly reviewed later
- no behavior beyond stable label identity
- no dependence on runtime/provider/Firebase code
- no consumer migration

## Package Strategy Verdict

Grouped files are preferred for clarity and rollback. EX-106 may only proceed if
it remains an inert vocabulary introduction with no exposure, no mappers, no
routing, and no consumer migration.
