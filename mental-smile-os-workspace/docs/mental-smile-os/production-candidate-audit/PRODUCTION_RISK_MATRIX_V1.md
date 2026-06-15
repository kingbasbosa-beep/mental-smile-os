# PRODUCTION_RISK_MATRIX_V1

## Purpose

Score production risks before activation.

## Risk Matrix

| Risk | Severity | Impact | Mitigation Gate |
| --- | --- | --- | --- |
| Pure runtime not independently extracted | HIGH | Legacy host coupling remains. | Runtime activation validation. |
| Legacy technical Android identity | HIGH | Store identity and package continuity risk. | Android validation and Owner decision. |
| `mental_smile_clean_core` dependency | HIGH | Hidden source-mine dependency may survive. | Dependency extraction or explicit acceptance. |
| Firebase rules not execution-validated here | HIGH | Rules syntax/authority drift may remain. | Firebase activation validation. |
| Broad asset inventory | HIGH | Dead or unregistered assets may ship. | YAML asset validation. |
| Untracked generated cache | MEDIUM | Release hygiene risk. | GitHub release prep. |
| Many active routes | MEDIUM | Surface readiness may vary by route. | Route smoke validation. |
| Functions analytics summary source exists | MEDIUM | Authority and deployment surface needs validation. | Firebase Functions validation. |
| Documentation artifacts uncommitted | MEDIUM | Handoff/release traceability risk. | Git staging/review decision. |
| Web hosting target `build/web` | LOW | Correct for Flutter web, but must match CI output. | Build validation. |

## Overall Risk

Overall Production Candidate Risk: MEDIUM_HIGH.

Candidate status is acceptable only with warnings.
