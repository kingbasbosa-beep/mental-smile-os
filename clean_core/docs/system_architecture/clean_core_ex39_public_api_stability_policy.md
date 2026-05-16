# EX-39 Public API Stability Policy

Phase: EX-39 - Package Surface Freeze

## Stability Philosophy

The package public API is a governed contract surface, not an implementation convenience layer.

The public API should remain:

- explicit
- small
- declarative
- backend-governed
- fail-closed
- deny-by-default
- rollback-friendly

## Consumer Rules

Package consumers must:

- import only from `package:mental_smile_clean_core/mental_smile_clean_core.dart`
- avoid `lib/src` imports
- treat exported contracts as declarative
- avoid using labels as runtime permission
- avoid using backend boundary contracts as client authority

## Stability Levels

| Surface type | Stability posture |
| --- | --- |
| approved labels/enums | stable within current freeze |
| references/requirements/scopes | stable within current freeze |
| runtime-sensitive labels | stable vocabulary, not execution authority |
| backend-authority labels | stable boundary vocabulary, not client authority |
| hidden/internal files | unstable and non-public |
| adapters/runtime surfaces | not public API |

## Versioning Expectation

Future public API changes should be grouped into explicit versions or staged internal milestones. Any removal or semantic change requires compatibility review and rollback planning.

## Stability Finding

EX-39 freezes the current public API as the authoritative package surface until a future export governance phase reopens it.

