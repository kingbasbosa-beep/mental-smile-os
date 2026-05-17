# EX-105 Passive Vocabulary Rollback Review

## Scope

This document defines rollback boundaries for any future passive vocabulary
introduction.

## Rollback Boundaries

Future work must remain easy to roll back by removing only newly introduced
passive vocabulary files.

Rollback must not require changes to:

- source/runtime behavior
- Firestore mappers
- imports/exports
- consumers
- routing logic
- provider/runtime code
- backend policy code
- review/resolution write code

## Safe Rollback Shape

Acceptable future shape:

- new isolated passive vocabulary files
- no consumers
- no exports
- no serialization dependency
- no package-facing contract barrel
- no mapper references

Unsafe future shape:

- modifying existing human-review contracts
- adding `accepts` or matching helpers
- changing existing enum keys
- wiring labels into requests, mappers, or Firestore
- exposing labels through package exports
- migrating existing consumers

## Rollback Triggers

Rollback should be required if a future execution phase introduces:

- routing or admission semantics
- ownership or assignment semantics
- backend enforcement claims
- emergency guarantee wording
- provider causality claims
- fallback recovery claims
- client outcome write permissions
- runtime/provider/Firebase imports

## Rollback Verdict

EX-106 is rollback-safe only if it creates isolated, unexported, inert passive
vocabulary files. Any integration, export, mapper, or consumer use should block
execution.
