# clean_core Batch 1 Next Batch Readiness

## Batch 2 Target

Future Batch 2 target:

- `clean_core/lib/core/policy_runtime/`

Batch 2 was not moved during this review.

## Readiness Criteria

Batch 2 may proceed later only if:

- Batch 1 structure remains clean
- Batch 1 barrel remains narrow
- Batch 1 reconnect remains scoped
- no contamination appears
- rollback remains clear
- runtime remains disabled
- provider execution remains blocked
- no host-app runtime ownership moves into the package

## Batch 1 Readiness Findings

Confirmed:

- package structure is minimal and approved
- package source contains only Batch 1 files
- package source has no Firebase imports
- package source has no Flutter UI imports
- package source has no generated imports
- package source has no provider SDK imports
- package source has no networking imports
- package source has no Cloud Functions runtime imports
- package source has no parent-path escaping imports
- root barrel is explicit and curated
- `safety_decision_engine.dart` remains hidden

## Conditions Before Batch 2

Before moving `policy_runtime`, perform:

- file list review
- import scan
- semantic review for runtime naming
- barrel plan update
- rollback checkpoint confirmation
- test reconnect impact review

## Readiness Verdict

Batch 2 may proceed later under checkpointed execution, provided the same extraction freeze remains active and no new contamination is introduced.

Batch 2 is not approved for broad automated migration, runtime activation, provider execution, Firebase integration, networking, or app-owned dependency movement.
