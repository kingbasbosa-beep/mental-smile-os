# EX-41B Future Extraction Strategy

Phase: EX-41B - Consumer Dependency Topology Audit

## Strategic Shift

Future extraction must be consumer-first, not movement-first.

## Required Sequence

Recommended sequence:

1. identify all consumers of a candidate file
2. classify consumer coupling
3. decide whether the candidate is a true leaf
4. split Firestore/runtime mappers from pure contracts
5. solve package-aware consumer strategy if consumers remain in `clean_core`
6. simulate cluster movement
7. authorize movement only after dependency closure is clear
8. validate rollback boundary before execution

## Extraction-Safe Path

Only move:

- true leaf contracts
- complete reviewed dependency clusters
- pure contracts after all consumers either move with them or import strategy is approved

## Blocked Path

Do not move:

- foundational labels consumed by excluded files
- Firestore-coupled consumers without mapper split
- queue/execution semantics without authority review
- observability contracts without runtime isolation review
- boundary markers without backend authority review

## Package-Aware Strategy Requirement

If remaining `clean_core` files must import `mental_smile_clean_core`, a dedicated package-context phase must define:

- allowed import shape
- analyzer context
- dependency resolution
- rollback rules
- no-runtime/no-provider enforcement

## Future Extraction Finding

The next Wave 2 attempt should either target true leaf utilities or prepare a complete cluster/split strategy before any movement.

