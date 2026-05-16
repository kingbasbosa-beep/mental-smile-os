# EX-37 Reconnect Execution Sequence

Phase: EX-37 - Wave 2 Safe Batch Reconnect Simulation

## Recommended Future Sequence

No reconnect was executed in EX-37.

If reconnect is authorized later, use this staged sequence:

1. Confirm working tree checkpoint.
2. Confirm package barrel still exports only approved safe-batch files.
3. Reconnect pure declarative tests first if any test target is identified.
4. Reconnect declarative audit consumers only after file-by-file review.
5. Reconnect declarative human review consumers only after file-by-file review.
6. Defer observability consumers to adapter/runtime review.
7. Defer queue consumers to host/backend ownership review.
8. Stop before any runtime/provider/Firebase/adapter reconnect.

## Import Pattern Preference

Future reconnect should prefer:

- package barrel imports for approved public contracts
- no internal `src/` imports from host code
- no wildcard imports
- no broad automated migration
- no reconnect of excluded files without explicit file-level approval

## Checkpoints

Required checkpoints:

- before reconnect
- after each file-level import change
- after each semantic group
- before any test or validation command
- before any adapter/runtime consideration

## Sequence Finding

Reconnect can remain scoped only if each consumer is reviewed independently and queue/observability/runtime-sensitive files are not auto-reconnected.

