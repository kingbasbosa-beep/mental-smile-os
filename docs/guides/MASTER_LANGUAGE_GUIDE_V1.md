# Master Language Guide V1

Status: GUIDE_DRAFT  
Runtime effect: none

## 1. Language Doctrine

Language is governed by surface, source owner, text owner, output type, and intended meaning. A term is not allowed or forbidden in isolation; the surface policy decides the permission. The repository currently contains mojibake Arabic in several policy and runtime files; this guide records the governance meaning without editing source language files.

## 2. Source Policies

| Policy | Path | Scope | Status |
| --- | --- | --- | --- |
| Residential Language Policy | `docs/registry/localization/RESIDENTIAL_LANGUAGE_POLICY.md` | Client room, personal space, internal rooms, tools/cards/notifications | Active governance |
| Commercial Language Policy | `docs/registry/localization/COMMERCIAL_LANGUAGE_POLICY.md` | public/commercial/provider/center/registration/discovery | Active governance |
| Administrative Language Policy | `docs/registry/localization/ADMINISTRATIVE_LANGUAGE_POLICY.md` | monitoring, owner, reports, internal analysis | Active governance |
| Surface Term Permission Matrix | `docs/registry/localization/SURFACE_TERM_PERMISSION_MATRIX.md` | term-level ALLOWED/LIMITED/FORBIDDEN matrix | Active governance |
| Surface Language Validation Rules | `docs/registry/localization/SURFACE_LANGUAGE_VALIDATION_RULES.md` | validation decision procedure | Active governance |
| Surface Language Policy Report | `docs/registry/localization/SURFACE_LANGUAGE_POLICY_REPORT.md` | foundation report | Active governance |

## 3. Validation Formula

```text
Term
+ Surface
+ Source Owner
+ Text Owner
+ Output Type
+ Intended Meaning
= Permission Decision
```

## 4. Permission Results

| Result | Meaning | Required action |
| --- | --- | --- |
| ALLOWED | Meaning/source/output are compatible with surface policy. | Card may proceed to other checks. |
| LIMITED_ALLOW | Allowed only with attribution, source, output, and boundary conditions recorded. | Card must record conditions. |
| BLOCK | Meaning or authority conflicts with surface policy. | Card is APPROVAL_BLOCKED. |
| ESCALATE_TO_REGISTRY | Surface, owner, term, or source is unclear. | Legal & Governance review required. |

## 5. Surface Language Summary

| Surface class | Allowed | Limited | Blocked |
| --- | --- | --- | --- |
| Residential | support, resource, signal, preference, tool, learning, exploration, saved destination | service/program/report only as non-directive resource context | treatment, session, diagnosis, case, booking, approval, assignment, platform-owned treatment plan |
| Commercial | declared provider/center services, programs, costs, contact, public info | therapeutic terms only as provider/center declared data with attribution | Mental Smile treatment claim, booking, payment authority, endorsement, guaranteed result |
| Administrative | report, analysis, monitoring, signal, readiness, pattern, risk, governance | therapeutic/operational terms as quoted data, report category, audit evidence | button/tab/action authority implying assignment, case ownership, treatment operation |
| Owner | doctrine, authorization, archive, strategy, governance | historical/analytical terms with context | individual clinical decisions, treatment ownership |
| Monitoring | observe, verify, report, detect, alert | quoted/provider data in reports | execute, approve, assign, modify |

## 6. Term Matrix Extract

| Term family | Residential | Commercial | Administrative | Replacement preference |
| --- | --- | --- | --- | --- |
| Session | FORBIDDEN | LIMITED | LIMITED | contact, service time information |
| Treatment | FORBIDDEN | LIMITED | LIMITED | support, recovery, resource, declared service |
| Diagnosis | FORBIDDEN | LIMITED | LIMITED | declared signal, topic of interest |
| Approved Specialist | FORBIDDEN | FORBIDDEN | LIMITED | ready for visibility, declared provider |
| Booking | FORBIDDEN | FORBIDDEN | LIMITED | contact, save destination, view information |
| Contact | ALLOWED | ALLOWED | ALLOWED | contact, contact information |
| Service | LIMITED | ALLOWED | ALLOWED | resource, capability, declared service |
| Program | LIMITED | ALLOWED | ALLOWED | declared program, educational resource |
| Report | LIMITED | LIMITED | ALLOWED | personal summary, readiness report |
| Analysis | LIMITED | LIMITED | ALLOWED | reflection, reading, aggregate analysis |
| Signal | ALLOWED | ALLOWED | ALLOWED | identity/readiness/safety signal |
| Resource | ALLOWED | ALLOWED | ALLOWED | resource, public link, support content |
| Tool | ALLOWED | ALLOWED | ALLOWED | learning/exploration/monitoring tool |
| Approval | FORBIDDEN | FORBIDDEN | LIMITED | readiness, completeness, review confirmation |
| Assignment | FORBIDDEN | FORBIDDEN | LIMITED | recommendation, options, sharing |
| Case | FORBIDDEN | FORBIDDEN | LIMITED | person, conversation, support signal, safety report |

## 7. Runtime Language Reality

| Reality | Evidence | Guide status |
| --- | --- | --- |
| ARB parity exists | 205 EN keys and 205 AR keys observed in snapshot extraction | ACTIVE |
| Hardcoded strings exist | snapshot drift and localization docs | TRANSITIONAL |
| Mojibake exists in active UI and policy docs | snapshot drift and source reads | ACTIVE debt |
| Runtime localization ownership registry missing | snapshot missing registries | SYSTEM_SYNC_PENDING |
| Surface language docs are documentation-only | no runtime consumer | TRANSITIONAL |

