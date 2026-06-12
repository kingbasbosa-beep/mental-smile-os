# Master Role Authority Guide V1

Status: GUIDE_DRAFT  
Runtime effect: none

## 1. Role Doctrine

Roles define surface access and authority boundaries. Runtime enforcement exists in both Flutter route gates and Firestore custom-claim rules. App-side role documents are UI/UX gates; Firestore authorization depends on custom claims.

## 2. Current Roles

| Role ID | Runtime constant | Owner surface | Route authority | Collection authority | Status |
| --- | --- | --- | --- | --- | --- |
| role.owner | `owner` | Owner district | Owner routes, support/registry/declaration rooms | read system_domains, signal events/aggregates | ACTIVE |
| role.monitoring_operator | `monitoring_operator` | Monitoring room | signal monitoring, capital reports | read signal_events, signal_aggregates | ACTIVE |
| role.registry_steward | `registry_steward` | Registry room | registry room with owner | read system_domains | ACTIVE |
| role.declaration_reviewer | `declaration_reviewer` | Declaration review | declaration review room | read clinicians/centers/profile change requests | ACTIVE |
| role.support_observer | `support_observer` | Support room | support room, chat escalations | read support/contact/chat/signal data | ACTIVE |
| role.client | `client` | Client dashboard/personal space | client dashboard, personal space | own clients, saved destinations, chat/support | ACTIVE |
| role.center | `center` | Center room/dashboard | center dashboard/room | own center docs until ready, profile requests | ACTIVE |
| role.clinician | `clinician` | Clinician room | clinician room/inbox | own clinician docs until ready, profile requests, recommended escalation read | ACTIVE |

## 3. Authority Boundaries

| Authority | Legal & Governance | Owner | Technical | Monitoring | Runtime role |
| --- | --- | --- | --- | --- | --- |
| Interpret doctrine | YES | Review/authorize | NO | NO | None directly |
| Authorize guide changes | NO | YES | NO | NO | owner |
| Execute runtime code | NO | NO | YES in future implementation block | NO | developer, not app role |
| Verify drift | NO | Review | NO | YES | monitoring_operator |
| Approve cards | Interpret | Authorize | Confirm technical sync | Verify | not automated |
| Modify Firestore rules | NO | Authorize | Execute future block | Verify | not app role |

## 4. Route Authority Summary

| Route family | Required role |
| --- | --- |
| `/s/owner*` | owner |
| `/s/capital/signal-monitoring-room`, `/s/capital/reports` | monitoring_operator |
| `/s/support-room` | owner or support_observer |
| `/s/registry-room` | owner or registry_steward |
| `/s/declaration-review-room` | owner or declaration_reviewer |
| `/chat/escalations`, `/chat/escalation/report` | support_observer plus report-specific recommended clinician path |
| `/client/dashboard`, `/s/personal-space` | client |
| `/center/*` | center and visibility readiness |
| `/clinician/*` | clinician and visibility readiness |

## 5. Authority Risks

| Risk | Evidence | Guide action |
| --- | --- | --- |
| App-side role vs custom claims mismatch | rules state custom claims are authoritative | Compliance Agent must distinguish UI gate from Firestore authorization. |
| Visibility readiness blocks center/clinician routes | route gate checks readiness | Cards must not say approved; use readiness/visibility. |
| Administrative language can imply operational authority | language policies block assignment/case/booking authority | Legal & Governance review required. |
| Deleted admin surface history | git-deleted admin_surface | Mark frozen and do not revive silently. |

