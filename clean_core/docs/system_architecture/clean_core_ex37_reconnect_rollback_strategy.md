# EX-37 Reconnect Rollback Strategy

Phase: EX-37 - Wave 2 Safe Batch Reconnect Simulation

## Rollback Scope

Future reconnect rollback must be isolated to:

- import lines changed during reconnect
- no moved files
- no package barrel changes
- no dependency changes
- no runtime state changes

## Rollback Rules

For every reconnect step:

- change one file or one semantic group at a time
- record the original import shape
- preserve no-runtime posture
- preserve no-provider posture
- preserve no-Firebase posture
- preserve no-adapter posture

## Rollback Boundaries

Rollback must not touch:

- moved package files
- approved barrel exports
- excluded files not changed in that reconnect step
- pubspec files
- lock files
- runtime/provider/Firebase systems

## Checkpoint Strategy

Recommended future checkpoints:

- pre-reconnect clean checkpoint
- post-audit declarative reconnect checkpoint
- post-human-review declarative reconnect checkpoint
- stop before observability/queue reconnect

## Rollback Finding

Future reconnect rollback can remain narrow if import changes are performed manually and file-by-file. Any broad migration would weaken rollback clarity.

