# clean_core Package Registration Readiness

This document assesses readiness for future package registration without creating package identity.

## Readiness Status

| Area | Status | Notes |
| --- | --- | --- |
| Package shell | Ready for future bootstrap | `mental_smile_clean_core/lib` exists. |
| Pubspec | Not created | Must remain absent until approved phase. |
| Dependencies | Clean by design | No package dependency file exists yet. |
| Public barrel | Exists | Explicit exports only. |
| Runtime posture | Deferred | No runtime activation allowed. |
| Provider posture | Blocked | No provider execution allowed. |
| Host reconnect | Minimal | No path dependency exists. |

## Registration Prerequisites

- Manual export surface review.
- Hidden contract review.
- Minimal pubspec approval.
- Dependency-law confirmation.
- Rollback checkpoint.
- Local path dependency approval.

## Private/Internal Package Posture

The first package registration should remain local/internal. Public publication is not appropriate until:

- API meanings are stable
- governance semantics are reviewed
- internal-only contracts are hidden
- misuse risks are documented
- runtime-deferred names are clearly marked

## Package Identity Guidance

Recommended package name:

- `mental_smile_clean_core`

Avoid names implying:

- runtime engine
- AI execution
- provider bridge
- Firebase implementation
- orchestration system

## Registration Verdict

The shell is registration-ready conceptually, but execution requires a separate approved phase and must not include runtime or provider activation.
