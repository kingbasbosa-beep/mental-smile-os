# RELEASE_BLOCKER_REGISTRY_V1

## Purpose

List blockers that prevent unrestricted public release.

## Blocker Matrix

| ID | Blocker | Area | Severity | Required Action |
| --- | --- | --- | --- | --- |
| REL_BLOCKER_001 | Runtime validation commands have not been executed in this release pass | Runtime | HIGH | Run validation sequence and review output |
| REL_BLOCKER_002 | Firebase deployment remains owner-gated and not authorized | Firebase | HIGH | Owner must explicitly approve any deploy |
| REL_BLOCKER_003 | GitHub push/tag/release remain owner-gated and not authorized | GitHub | HIGH | Owner must approve branch, commit scope, push, and tag |
| REL_BLOCKER_004 | Android applicationId decision remains unresolved | Android | MEDIUM | Owner must choose keep/defer/change path |
| REL_BLOCKER_005 | Identity cleanup remains planned but not executed | Identity | MEDIUM | Execute or explicitly accept technical residue for release candidate |

## Release Candidate Interpretation

These blockers prevent public production release, not release candidate documentation readiness.

