# EX-109 Export Gating Checklist

## Required Gates Before EX-110

| Gate | Required result |
| --- | --- |
| Public caveat text exists | Pass |
| Export set limited to low-risk labels | Pass |
| No high-risk labels included | Pass |
| No consumers migrated | Pass |
| No mappers created | Pass |
| No imports migrated | Pass |
| No `toMap`/`fromMap` | Pass |
| No accepts predicates | Pass |
| No routing/admission helpers | Pass |
| No backend enforcement claims | Pass |
| No emergency guarantees | Pass |
| No provider causality claims | Pass |
| No fallback recovery claims | Pass |
| No runtime/provider/Firebase/adapters | Pass |
| Rollback remains small and local | Pass |

## Recommended EX-110 Shape

If EX-110 executes, it should be limited to:

- public caveat documentation
- narrow barrel export of the low-risk set only
- no consumer migration
- no mapper creation
- no runtime/provider/Firebase/adapters

## Rollback Strategy

Rollback should require only:

- removing the new public export lines
- keeping or removing public caveat docs depending on release state

Rollback must not require:

- source/runtime changes
- mapper changes
- consumer migration reversal
- provider/runtime/Firebase rollback

## Gating Verdict

EX-110 may proceed only if it preserves the narrow export boundary and keeps all
high-risk labels internal.
