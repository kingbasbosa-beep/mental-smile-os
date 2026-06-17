# Lessons Extraction Candidate Registry V1

Purpose: identify packages that should produce lessons before archive freeze.

## Lesson Candidates

| # | Package | Required Lesson |
| ---: | --- | --- |
| 1 | `forensic-audit` | Handoff drift must be investigated against actual files, not memory. |
| 2 | `firebase-purification-execution-audit` | Firebase authority must be audited from rules and code, not doctrine. |
| 3 | `firebase-warning-cleanup-wave-1` | Low-risk rule cleanup still needs explicit validation boundaries. |
| 4 | `identity-cleanup-wave-1` | Package identity can be changed safely in waves. |
| 5 | `android-namespace-wave-1` | Namespace and applicationId are separate decisions. |
| 6 | `core-extraction-wave-1` | Source dependencies can be removed without deleting source repositories. |
| 7 | `core-usage-audit` | Dependency removal requires symbol-level proof. |
| 8 | `os-only-purification-audit` | Public identity and technical source identity must be separated. |
| 9 | `tool-center-readiness-audit` | Tool Center must be judged by working user outcomes, not registries. |
| 10 | `human-journey-experience-audit` | Human experience can lag behind architectural completeness. |
| 11 | `first-release-governance-gate` | Release readiness depends on staging scope decisions. |
| 12 | `runtime-bootstrap-review` | Untracked runtime roots require go/no-go review before commit. |
| 13 | `github-public-showcase-review` | Public repositories need safety review separate from code review. |
| 14 | `archive-migration` | Preservation must come before deletion. |
| 15 | `active-workspace-migration` | A legacy host path can remain while product identity changes. |
| 16 | `release-candidate-v1` | Release candidate status is conditional, not equivalent to production launch. |

## Lesson Extraction Count

Lesson candidates: 16.

## Required Output Before Freeze

Create a future lessons package containing:

- `GENERATION_1_ARCHIVE_LESSONS_V1.md`
- `FIREBASE_AUTHORITY_LESSONS_V1.md`
- `IDENTITY_MIGRATION_LESSONS_V1.md`
- `RUNTIME_EXTRACTION_LESSONS_V1.md`
- `PUBLIC_EXPERIENCE_LESSONS_V1.md`
- `RELEASE_GOVERNANCE_LESSONS_V1.md`

No lesson extraction was performed in this audit.
