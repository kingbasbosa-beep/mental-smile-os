# EX-50 Audit Snapshot Split Risk Review

Phase: EX-50 - audit_snapshot Split Simulation

## Primary Risks

Primary risks:

- accidentally keeping Firestore imports in the pure package
- moving mapper code into `mental_smile_clean_core`
- treating `immutable` as client-enforced authority
- treating `policyVersion` as active policy authority
- exposing `createdBy` without privacy review
- expanding package exports beyond the pure model

## Stop Conditions

Stop if future split requires:

- reconnect
- queue movement
- runtime activation
- observability movement
- authority execution
- adapter execution
- Firebase inside package
- broad export growth

## Risk Mitigation

Mitigate by:

- keeping pure model data-only
- placing mapper outside package
- using explicit export only
- preserving backend authority
- preserving privacy constraints
- running post-split verification in a separate phase

## Risk Finding

The split is low-to-medium risk if scoped. It becomes high risk if Firestore or authority semantics enter the package.

