# Mental Smile P0 Firebase Purification Amendment - Constitutional Purity Doctrine

## Document Control

| Field | Value |
|---|---|
| Document ID | P0_FIREBASE_PURIFICATION_AMENDMENT_CONSTITUTIONAL_PURITY_DOCTRINE |
| Scope | Pre-Phase 11 Firebase Purification |
| Source Status | Constitutional Amendment |
| Supersedes | Freeze / Archive / Remove language for dead Firebase-era artifacts in P0 purification planning |
| Runtime Changes | NONE |
| Firestore Rules Changes | NONE |
| Storage Rules Changes | NONE |
| Firebase Deployment | NONE |
| Migration Execution | NONE |
| Active Classification Set | REMOVE_NOW, REMOVE_AFTER_VERIFICATION, KEEP_CONSTITUTIONAL, FUTURE_CONSTITUTIONAL, HISTORICAL_NOTE_ONLY |

## Constitutional Purity Doctrine

The active Firebase system may contain only constitutional truth.

Dead systems, dead routes, dead rules, dead authority paths, dead booking-era artifacts, and dead admin-era authority are not preserved as active, deployable, routable, executable, compatible, fallback, transitional, deprecated, frozen, or legacy runtime surfaces.

Historical explanations may exist only as non-runtime constitutional notes or audit records. They may not be treated as deployable rules, active backups, fallback behavior, executable references, runtime compatibility layers, or authority sources.

## Disallowed Classifications

The following classifications are not permitted for active Firebase governance after this amendment:

| Disallowed Term | Constitutional Replacement |
|---|---|
| LEGACY | HISTORICAL_NOTE_ONLY or REMOVE_AFTER_VERIFICATION |
| FROZEN | HISTORICAL_NOTE_ONLY or REMOVE_AFTER_VERIFICATION |
| DEPRECATED | REMOVE_NOW or REMOVE_AFTER_VERIFICATION |
| COMPATIBILITY | REMOVE_NOW or REMOVE_AFTER_VERIFICATION |
| TRANSITIONAL_RUNTIME | FUTURE_CONSTITUTIONAL or REMOVE_AFTER_VERIFICATION |
| INACTIVE_RUNTIME | REMOVE_AFTER_VERIFICATION |
| BACKUP_RULESET | HISTORICAL_NOTE_ONLY |
| FALLBACK_AUTHORITY | REMOVE_AFTER_VERIFICATION |

## 1. Firebase Constitutional Purity Report

| Object ID | Object | Type | Current Observation | Constitutional Classification | Required Direction |
|---|---|---|---|---|---|
| FB-PURITY-ROOT-FIRESTORE-RULES | `firestore.rules` | Active rules file | Active role and collection rules exist; no booking-era references found in active scan | KEEP_CONSTITUTIONAL | Preserve as current active baseline until Phase 11 authority bridge review |
| FB-PURITY-ROOT-STORAGE-RULES | `storage.rules` | Active storage rules file | Contains generic `admin` role authority and `/admins/{uid}` fallback | REMOVE_AFTER_VERIFICATION | Replace generic admin authority with constitutional role-specific custody model in future rules work |
| FB-PURITY-FIREBASE-CONFIG | `firebase.json` | Firebase config | Active config references current rules/indexes/functions | KEEP_CONSTITUTIONAL | Preserve |
| FB-PURITY-FIRESTORE-INDEXES | `firestore.indexes.json` | Index config | No booking-era indexes found in active scan | KEEP_CONSTITUTIONAL | Preserve active indexes only |
| FB-PURITY-FUNCTIONS | `functions/index.js` | Cloud Functions runtime | Uses Firebase Admin SDK for server execution, not generic user authority | KEEP_CONSTITUTIONAL | Preserve as runtime service dependency; review service authority separately in Phase 11 |
| FB-PURITY-LEGACY-RULE-FILES | `firebase_rules/*` | Historical rules files | Multiple non-active rulesets exist outside active Firebase config | HISTORICAL_NOTE_ONLY | Mark as non-deployable constitutional notes only |
| FB-PURITY-BOOKING-ACTIVE-REFS | Booking-era active references | Runtime/rules/index/code references | Active scan found no booking refs in `lib`, root rules, storage rules, indexes, config, or functions | REMOVE_AFTER_VERIFICATION | Verify live Firebase data absence, then remove any remaining data/artifact references |
| FB-PURITY-ADMIN-AUTHORITY | Generic `admin` authority | Authority model | Present in `storage.rules`; absent from root Firestore rules as active authority | REMOVE_AFTER_VERIFICATION | Remove generic admin authority after constitutional custody replacement is ready |

### Active Scan Record

| Scan ID | Scope | Result |
|---|---|---|
| SCAN-P0-AMEND-BOOKING-001 | `lib`, `firestore.rules`, `storage.rules`, `firestore.indexes.json`, `firebase.json`, `functions` | No active booking-era references found |
| SCAN-P0-AMEND-ADMIN-001 | `firestore.rules`, `storage.rules`, `firebase_rules`, `lib`, `functions` | Generic user-facing `admin` authority found in `storage.rules`; Firebase Admin SDK found in Cloud Functions as server dependency |
| SCAN-P0-AMEND-LEGACY-RULES-001 | `firebase_rules` | Historical rules files present; not referenced by active `firebase.json` |

## 2. Removal Registry

| Removal ID | Artifact | Surface | Evidence | Classification | Removal Rule |
|---|---|---|---|---|---|
| REM-FB-001 | `booking_requests` | Firestore collection candidate | No active code/rules/index/function reference found | REMOVE_AFTER_VERIFICATION | Verify collection absence or non-use in live Firebase before removal |
| REM-FB-002 | `bookingRequests` | Firestore collection candidate | No active code/rules/index/function reference found | REMOVE_AFTER_VERIFICATION | Verify collection absence or non-use in live Firebase before removal |
| REM-FB-003 | `sessionRatings` | Firestore collection candidate | No active code/rules/index/function reference found | REMOVE_AFTER_VERIFICATION | Verify collection absence or non-use in live Firebase before removal |
| REM-FB-004 | Booking lifecycle statuses | Rules/code artifact candidate | No active references found | REMOVE_AFTER_VERIFICATION | Remove if any non-runtime docs still treat them as executable |
| REM-FB-005 | Booking approval chains | Authority artifact candidate | No active references found | REMOVE_AFTER_VERIFICATION | Verify absence from live Firebase and operational docs |
| REM-FB-006 | Admin booking queues | Authority artifact candidate | No active references found | REMOVE_AFTER_VERIFICATION | Verify absence from live Firebase and operational docs |
| REM-FB-007 | Payment proof flow | Booking-era artifact candidate | No active references found | REMOVE_AFTER_VERIFICATION | Verify no live collection or workflow dependency |
| REM-FB-008 | Payout statuses | Booking-era artifact candidate | No active references found | REMOVE_AFTER_VERIFICATION | Verify no live collection or workflow dependency |
| REM-FB-009 | Accounting flow | Booking-era artifact candidate | No active references found | REMOVE_AFTER_VERIFICATION | Verify no live collection or workflow dependency |
| REM-FB-010 | Generic `admin` claim | Authority artifact | Present in `storage.rules` | REMOVE_AFTER_VERIFICATION | Replace with constitutional authority roles before rule removal |
| REM-FB-011 | `/admins/{uid}` fallback | Authority artifact | Present in `storage.rules` | REMOVE_AFTER_VERIFICATION | Remove after role-specific custody rules are ready |
| REM-FB-012 | Generic admin storage write access | Storage authority artifact | `isAdmin()` gates public asset writes | REMOVE_AFTER_VERIFICATION | Replace with Technical Verifier / Registry Steward / Owner-specific custody |
| REM-FB-013 | `firebase_rules/firestore.rules.DEV` | Historical rules file | Not active Firebase config | HISTORICAL_NOTE_ONLY | Mark DO_NOT_DEPLOY and NON_CONSTITUTIONAL |
| REM-FB-014 | `firebase_rules/firestore.rules.DEV_BOOKING` | Historical booking rules file | Not active Firebase config | HISTORICAL_NOTE_ONLY | Mark DO_NOT_DEPLOY and NON_CONSTITUTIONAL |
| REM-FB-015 | `firebase_rules/firestore.rules.MIN_SAFE` | Historical rules file | Not active Firebase config | HISTORICAL_NOTE_ONLY | Mark DO_NOT_DEPLOY and NON_CONSTITUTIONAL |
| REM-FB-016 | `firebase_rules/firestore.rules.MIN_SAFE_STAGE2` | Historical rules file | Not active Firebase config | HISTORICAL_NOTE_ONLY | Mark DO_NOT_DEPLOY and NON_CONSTITUTIONAL |
| REM-FB-017 | `firebase_rules/firestore.rules.PROD` | Historical rules file | Not active Firebase config | HISTORICAL_NOTE_ONLY | Mark DO_NOT_DEPLOY and NON_CONSTITUTIONAL |

## 3. Authority Removal Map

| Current Authority | Current Surface | Current Status | Constitutional Classification | Replacement Direction |
|---|---|---|---|---|
| `admin` claim | Storage rules | Active generic authority | REMOVE_AFTER_VERIFICATION | Split into Owner, Legal Governance, Compliance, Technical Verifier, Monitoring, Archive Steward, Registry Steward, Declaration Reviewer, Support Observer |
| `/admins/{uid}` document fallback | Storage rules | Active hidden fallback | REMOVE_AFTER_VERIFICATION | Remove as authority source after constitutional claims/registries are grounded |
| `isAdmin()` storage function | Storage rules | Active helper for generic authority | REMOVE_AFTER_VERIFICATION | Replace with role-specific custody functions |
| Admin public asset write | `public/branding`, `public/marketing`, `public/clinician_photos`, `public/center_logos` | Active generic write authority | REMOVE_AFTER_VERIFICATION | Assign custody to Owner, Registry Steward, Technical Verifier, and surface-specific stewards |
| Admin private owner read | `owners/{uid}` storage path | Active generic read authority | REMOVE_AFTER_VERIFICATION | Assign to Owner, Compliance, Legal Governance, Archive Steward, or Technical Verifier based on record purpose |
| Firebase Admin SDK | Cloud Functions | Server SDK dependency | KEEP_CONSTITUTIONAL | Treat as service execution dependency, not human authority |

### Future Constitutional Authority Set

| Role | Authority Scope | Classification |
|---|---|---|
| Owner | Final business authorization and ownership decisions | FUTURE_CONSTITUTIONAL |
| Legal Governance | Legal interpretation and governance judgment | FUTURE_CONSTITUTIONAL |
| Compliance | Compliance review, mismatch detection, policy verification | FUTURE_CONSTITUTIONAL |
| Technical Verifier | Technical validation without business override authority | FUTURE_CONSTITUTIONAL |
| Monitoring | Observation, alerting, verification reports | FUTURE_CONSTITUTIONAL |
| Archive Steward | Archive custody and retrieval authority | FUTURE_CONSTITUTIONAL |
| Registry Steward | Registry integrity and registry lifecycle custody | FUTURE_CONSTITUTIONAL |
| Declaration Reviewer | Declaration intake and review authority | FUTURE_CONSTITUTIONAL |
| Support Observer | Support visibility without owner override | FUTURE_CONSTITUTIONAL |

## 4. Rules Removal Map

| Rules Area | File | Current Constitutional Status | Classification | Required Future Action |
|---|---|---|---|---|
| Active Firestore role checks | `firestore.rules` | Current active baseline | KEEP_CONSTITUTIONAL | Review during Phase 11, do not remove in P0 amendment |
| Active Firestore collections | `firestore.rules` | Current active baseline | KEEP_CONSTITUTIONAL | Preserve until registry/signal grounding |
| Booking-era Firestore rules | Active root rules | No active references found | REMOVE_AFTER_VERIFICATION | If discovered in deployable rules, remove rather than freeze |
| Generic admin storage authority | `storage.rules` | Non-constitutional active authority | REMOVE_AFTER_VERIFICATION | Replace with constitutional role-specific custody |
| `/admins/{uid}` fallback | `storage.rules` | Hidden admin-era fallback | REMOVE_AFTER_VERIFICATION | Remove after replacement authority is grounded |
| Historical dev rules | `firebase_rules/firestore.rules.DEV` | Not active config | HISTORICAL_NOTE_ONLY | DO_NOT_DEPLOY, NON_CONSTITUTIONAL, HISTORICAL_ONLY |
| Historical booking rules | `firebase_rules/firestore.rules.DEV_BOOKING` | Not active config | HISTORICAL_NOTE_ONLY | DO_NOT_DEPLOY, NON_CONSTITUTIONAL, HISTORICAL_ONLY |
| Historical min safe rules | `firebase_rules/firestore.rules.MIN_SAFE` | Not active config | HISTORICAL_NOTE_ONLY | DO_NOT_DEPLOY, NON_CONSTITUTIONAL, HISTORICAL_ONLY |
| Historical stage rules | `firebase_rules/firestore.rules.MIN_SAFE_STAGE2` | Not active config | HISTORICAL_NOTE_ONLY | DO_NOT_DEPLOY, NON_CONSTITUTIONAL, HISTORICAL_ONLY |
| Historical prod rules | `firebase_rules/firestore.rules.PROD` | Not active config | HISTORICAL_NOTE_ONLY | DO_NOT_DEPLOY, NON_CONSTITUTIONAL, HISTORICAL_ONLY |

## 5. Storage Authority Removal Map

| Storage Object | Sensitivity | Current Authority Concern | Constitutional Classification | Future Custody Direction |
|---|---|---|---|---|
| Identity documents | High | Generic admin fallback must not own sensitive custody | REMOVE_AFTER_VERIFICATION | Owner + Legal Governance + Compliance + Archive Steward as applicable |
| National IDs | High | Generic admin fallback must not own sensitive custody | REMOVE_AFTER_VERIFICATION | Legal Governance + Compliance + Archive Steward custody |
| Certificates | Medium/High | Generic admin write/read cannot remain broad | REMOVE_AFTER_VERIFICATION | Technical Verifier + Registry Steward + relevant surface owner |
| Licenses | High | Generic admin write/read cannot remain broad | REMOVE_AFTER_VERIFICATION | Legal Governance + Compliance + Technical Verifier |
| Verification documents | High | Generic admin fallback must be removed | REMOVE_AFTER_VERIFICATION | Declaration Reviewer + Compliance + Archive Steward |
| Medical documents | Critical | Generic admin access is non-constitutional | REMOVE_AFTER_VERIFICATION | Role-specific medical custody and compliance review only |
| Public assets | Low/Medium | Generic admin write authority is too broad | REMOVE_AFTER_VERIFICATION | Owner + Registry Steward + Technical Verifier |
| Branding assets | Medium | Generic admin write authority is too broad | REMOVE_AFTER_VERIFICATION | Owner + Registry Steward |
| Marketing assets | Medium | Generic admin write authority is too broad | REMOVE_AFTER_VERIFICATION | Owner + Registry Steward + Commercial surface owner |
| Clinician photos | Medium | Generic admin write authority is too broad | REMOVE_AFTER_VERIFICATION | Clinician owner + Technical Verifier + Registry Steward |
| Center logos | Medium | Generic admin write authority is too broad | REMOVE_AFTER_VERIFICATION | Center owner + Technical Verifier + Registry Steward |

## 6. Booking Artifact Removal Map

The booking-era decision is now:

`VERIFY ABSENCE -> REMOVE`

No booking-era artifact is classified as frozen, legacy, deprecated, transitional runtime, compatibility, or backup runtime.

| Booking Artifact | Active Reference Scan | Live Data Requirement | Classification | Decision |
|---|---|---|---|---|
| `booking_requests` | No active reference found | Verify live collection absence/non-use | REMOVE_AFTER_VERIFICATION | Remove if present and unused |
| `bookingRequests` | No active reference found | Verify live collection absence/non-use | REMOVE_AFTER_VERIFICATION | Remove if present and unused |
| `sessionRatings` | No active reference found | Verify live collection absence/non-use | REMOVE_AFTER_VERIFICATION | Remove if present and unused |
| Booking lifecycle rules | No active root rule reference found | Verify no deployable ruleset references it | REMOVE_AFTER_VERIFICATION | Remove if discovered |
| Booking approval queues | No active reference found | Verify no operational dependency | REMOVE_AFTER_VERIFICATION | Remove if discovered |
| Booking assignment rules | No active reference found | Verify no operational dependency | REMOVE_AFTER_VERIFICATION | Remove if discovered |
| Payment proof flow | No active reference found | Verify no operational dependency | REMOVE_AFTER_VERIFICATION | Remove if discovered |
| Payout flow | No active reference found | Verify no operational dependency | REMOVE_AFTER_VERIFICATION | Remove if discovered |
| Accounting flow | No active reference found | Verify no operational dependency | REMOVE_AFTER_VERIFICATION | Remove if discovered |
| Booking routes | No active reference found in active scan | Verify route registry/app route absence | REMOVE_AFTER_VERIFICATION | Remove if discovered |
| Booking docs used as execution reference | Not a runtime artifact | Verify docs are not used as runtime authority | HISTORICAL_NOTE_ONLY | Keep only as non-runtime historical note if needed |

## 7. Legacy Rule File Non-Deployable Map

| File | Active Firebase Config Reference | Constitutional Status | Required Marker | Classification |
|---|---|---|---|---|
| `firebase_rules/firestore.rules.DEV` | No | Non-executable historical note | DO_NOT_DEPLOY / NON_CONSTITUTIONAL / HISTORICAL_ONLY | HISTORICAL_NOTE_ONLY |
| `firebase_rules/firestore.rules.DEV_BOOKING` | No | Non-executable historical note | DO_NOT_DEPLOY / NON_CONSTITUTIONAL / HISTORICAL_ONLY | HISTORICAL_NOTE_ONLY |
| `firebase_rules/firestore.rules.MIN_SAFE` | No | Non-executable historical note | DO_NOT_DEPLOY / NON_CONSTITUTIONAL / HISTORICAL_ONLY | HISTORICAL_NOTE_ONLY |
| `firebase_rules/firestore.rules.MIN_SAFE_STAGE2` | No | Non-executable historical note | DO_NOT_DEPLOY / NON_CONSTITUTIONAL / HISTORICAL_ONLY | HISTORICAL_NOTE_ONLY |
| `firebase_rules/firestore.rules.PROD` | No | Non-executable historical note | DO_NOT_DEPLOY / NON_CONSTITUTIONAL / HISTORICAL_ONLY | HISTORICAL_NOTE_ONLY |

## 8. Remaining Constitutional Firebase Map

| Object | Type | Constitutional Justification | Classification |
|---|---|---|---|
| `firestore.rules` | Active rule foundation | Current deployed governance baseline; no active booking-era refs found | KEEP_CONSTITUTIONAL |
| `storage.rules` | Active storage foundation | Current deployed storage baseline with admin authority debt identified | KEEP_CONSTITUTIONAL |
| `firebase.json` | Firebase config | Active config surface | KEEP_CONSTITUTIONAL |
| `firestore.indexes.json` | Index config | Active Firestore index surface; no booking indexes found in active scan | KEEP_CONSTITUTIONAL |
| `functions/index.js` | Cloud Functions runtime | Active analytics/service writer surface | KEEP_CONSTITUTIONAL |
| `system_domains` | Firestore collection | Constitutional system/domain mapping candidate | KEEP_CONSTITUTIONAL |
| `signal_events` | Firestore collection | Active signal event foundation | KEEP_CONSTITUTIONAL |
| `signal_aggregates` | Firestore collection | Active signal aggregate foundation | KEEP_CONSTITUTIONAL |
| `analytics_summaries` | Firestore collection | Monitoring/reporting runtime foundation | KEEP_CONSTITUTIONAL |
| `support_requests` | Firestore collection | Support intake and support surface governance candidate | KEEP_CONSTITUTIONAL |
| Contact request collections | Firestore collection group | Public/contact intake surface | KEEP_CONSTITUTIONAL |
| Profile change request collections | Firestore collection group | Identity/profile lifecycle governance candidate | KEEP_CONSTITUTIONAL |
| `saved_destinations` | Firestore collection | Active user navigation/preference surface | KEEP_CONSTITUTIONAL |
| Chat threads/messages | Firestore collection group | Active communication surface | KEEP_CONSTITUTIONAL |
| Chat escalations/reports | Firestore collection group | Monitoring/compliance signal source | KEEP_CONSTITUTIONAL |
| Owner role | Future authority | Constitutional authority replacement for generic admin | FUTURE_CONSTITUTIONAL |
| Legal Governance role | Future authority | Constitutional interpretation authority | FUTURE_CONSTITUTIONAL |
| Compliance role | Future authority | Compliance review and mismatch detection authority | FUTURE_CONSTITUTIONAL |
| Technical Verifier role | Future authority | Technical validation without ownership override | FUTURE_CONSTITUTIONAL |
| Monitoring role | Future authority | Observation and alerting authority | FUTURE_CONSTITUTIONAL |
| Archive Steward role | Future authority | Archive custody authority | FUTURE_CONSTITUTIONAL |
| Registry Steward role | Future authority | Registry custody authority | FUTURE_CONSTITUTIONAL |
| Declaration Reviewer role | Future authority | Declaration review authority | FUTURE_CONSTITUTIONAL |
| Support Observer role | Future authority | Support observation authority | FUTURE_CONSTITUTIONAL |

## 9. Phase 11 Readiness Gate

| Gate ID | Gate | Status | Evidence | Required Before Phase 11 Runtime Bridge |
|---|---|---|---|---|
| P11-GATE-001 | Booking-era active references removed from deployable surface | PASS | Active scan found no booking refs in active app/rules/index/config/functions paths | Verify live Firebase data absence |
| P11-GATE-002 | Generic admin authority rejected as constitutional authority | PASS | Amendment classifies `admin` claim and `/admins/{uid}` fallback as removal targets | Replace with constitutional authority model before rules rewrite |
| P11-GATE-003 | Legacy rule files are non-deployable | CONDITIONAL_PASS | Files exist outside active config | Add explicit non-deployable markers in a future documentation-only or file-labeling pass if approved |
| P11-GATE-004 | Storage custody classified | CONDITIONAL_PASS | Sensitive surfaces mapped in this amendment | Complete role-specific custody design before rules change |
| P11-GATE-005 | Remaining Firebase surfaces have constitutional justification | PASS | Active foundations listed in Remaining Constitutional Firebase Map | Carry forward into Phase 11 bridge planning |
| P11-GATE-006 | No dead artifact preserved as active frozen/legacy/deprecated runtime | PASS | This amendment replaces old preservation language with removal classifications | Ensure future docs use only approved classification set |

## Phase 11 Readiness Verdict

| Verdict | Meaning |
|---|---|
| READY_WITH_PURITY_VERIFICATION_REQUIRED | The Firebase constitutional map is ready to proceed toward Phase 11 planning, provided live Firebase absence checks are performed for booking-era collections and generic storage admin authority is replaced through constitutional custody mapping before any rules deployment. |

## Final Constitutional Result

| Requirement | Result |
|---|---|
| All non-constitutional booking references marked for removal | PASS |
| Generic admin authority marked for removal/replacement | PASS |
| No booking-era rule remains accepted as active/deployable | PASS |
| No generic admin path remains accepted as constitutional authority | PASS |
| Remaining Firebase surfaces have constitutional justification | PASS |
| Phase 11 starts from clean constitutional Firebase map | CONDITIONAL_PASS pending live Firebase verification |

This amendment executes no runtime action. It is a constitutional documentation and governance mapping artifact only.
