# RELEASE_DECISION_MATRIX_V1

## Decision Matrix

| Decision | Result | Rationale |
| --- | --- | --- |
| First release gate | READY_WITH_OWNER_DECISIONS | Technical blockers cleared; staging decisions remain |
| Commit now | NOT_AUTHORIZED | Owner must approve staging scope and message |
| Push now | NOT_AUTHORIZED | Owner must explicitly approve push target |
| Tag now | NOT_AUTHORIZED | Owner must approve tag name and commit hash |
| Deploy now | NOT_AUTHORIZED | Firebase deploy remains separately gated |
| Include runtime identity changes | KEEP_FOR_RELEASE | Package/namespace/core extraction are validated release changes |
| Include Firebase rule helper cleanup | KEEP_FOR_RELEASE | Low-risk duplicate helper removal |
| Include `.firebase/` | EXCLUDE_FROM_RELEASE | Local cache; not release source |
| Include `mental-smile-os-runtime/` | REQUIRES_OWNER_DECISION | Separate runtime candidate artifact |
| Include forensic audit docs | REQUIRES_OWNER_DECISION | Valuable historical audit but optional in first release commit |

## Final Result

```text
READY_WITH_OWNER_DECISIONS
```

