# EX-104 Passive Vocabulary Specification

## Scope

This is the no-code specification for detoxed passive vocabulary candidates
before any package introduction. It does not create package contracts, mappers,
imports, exports, runtime activation, provider activation, Firebase activation,
or consumer migration.

## Required Doctrine

- No accepts predicates.
- No routing or admission guarantees.
- No team ownership guarantees.
- No emergency guarantees.
- No backend enforcement claims.
- No client outcome write permissions.
- No provider causality claims.
- No fallback recovery claims.
- Package describes facts only.

## Vocabulary Families

The candidate vocabulary is grouped into:

- queue intent labels
- queue visibility labels
- queue lifecycle labels
- governance assertion labels
- emergency posture labels
- provider issue report labels
- fallback observation labels

## Standard Caveat Text

Use this caveat for all package-safe labels:

> This label is passive metadata only. It does not route, admit, assign, enforce,
> guarantee human review, guarantee emergency handling, prove backend
> governance, diagnose provider causality, recover fallback loops, or grant
> outcome write permission.

Use this caveat for externally asserted labels:

> This label records an externally supplied assertion only. The package does not
> verify, enforce, or guarantee the assertion.

Use this caveat for emergency posture labels:

> This label does not guarantee emergency response, human availability, queue
> admission, backend intervention, provider escalation, or service-level timing.

## Final Specification Rule

Every future label must be inert. A label may describe an observed fact,
reported condition, external assertion, or negative safety posture. A label must
not decide anything.
