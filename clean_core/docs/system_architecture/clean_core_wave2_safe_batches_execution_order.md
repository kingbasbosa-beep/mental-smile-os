# clean_core Wave 2 Safe Batches Execution Order

This document defines the preferred future execution order.

## Preferred Order

1. Pre-move checkpoint.
2. Move Audit Safe Batch.
3. Add explicit Audit Safe Batch exports.
4. Audit checkpoint review.
5. Move Human Review Safe Batch.
6. Add explicit Human Review Safe Batch exports.
7. Human review checkpoint review.
8. Stop before reconnect.
9. Final post-move validation.

## Why Audit First

Audit safe contracts are lower semantic risk:

- no queue/evaluation semantics
- no assignment/resolution labels
- no escalation routing implication
- no local imports

## Why Human Review Second

Human review safe contracts include escalation and visibility labels. They are still pure and approved, but should move after audit to preserve review focus.

## Execution Order Verdict

Sequential execution is preferred. Combining the two batches into a single movement phase is not recommended unless rollback and export review remain equally clear.
