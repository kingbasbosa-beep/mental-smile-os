# Guide Snapshot V1

Snapshot ID: GUIDE_SNAPSHOT_V1  
Guide system version: V1  
Status: SYSTEM_SYNC_PENDING  
Runtime effect: none

## 1. Source Inputs

| Source | Path | Role in snapshot |
| --- | --- | --- |
| Project reality snapshot | `PROJECT_REALITY_SNAPSHOT.md` | Current runtime and governance reality. |
| Residential language policy | `docs/registry/localization/RESIDENTIAL_LANGUAGE_POLICY.md` | Residential language rules. |
| Commercial language policy | `docs/registry/localization/COMMERCIAL_LANGUAGE_POLICY.md` | Commercial language rules. |
| Administrative language policy | `docs/registry/localization/ADMINISTRATIVE_LANGUAGE_POLICY.md` | Administrative language rules. |
| Surface term matrix | `docs/registry/localization/SURFACE_TERM_PERMISSION_MATRIX.md` | ALLOWED/LIMITED/FORBIDDEN term map. |
| Surface validation rules | `docs/registry/localization/SURFACE_LANGUAGE_VALIDATION_RULES.md` | Validation method. |
| Surface policy report | `docs/registry/localization/SURFACE_LANGUAGE_POLICY_REPORT.md` | Language foundation report. |
| Registry docs | `docs/registry/**` | Existing card/signal/asset/localization docs. |
| Topology/product docs | `docs/*BLUEPRINT*`, `docs/*TOPOLOGY*`, `docs/*MODEL*`, `docs/*PRODUCT*` | Product/federation context. |

## 2. Guide Domains Included

| Guide ID | Domain | Status |
| --- | --- | --- |
| MASTER_GUIDE_SYSTEM_V1 | master system | GUIDE_DRAFT |
| MASTER_CARD_GUIDE_V1 | cards | GUIDE_DRAFT |
| MASTER_SIGNAL_GUIDE_V1 | signals | GUIDE_DRAFT |
| MASTER_SURFACE_GUIDE_V1 | surfaces/routes | GUIDE_DRAFT |
| MASTER_TOOL_GUIDE_V1 | tools | GUIDE_DRAFT |
| MASTER_ROLE_AUTHORITY_GUIDE_V1 | roles/authority | GUIDE_DRAFT |
| MASTER_COLLECTION_GUIDE_V1 | Firestore collections | GUIDE_DRAFT |
| MASTER_LANGUAGE_GUIDE_V1 | localization/language | GUIDE_DRAFT |
| MASTER_ASSET_GUIDE_V1 | assets | GUIDE_DRAFT |
| GUIDE_COMPLIANCE_LIFECYCLE_V1 | compliance | GUIDE_DRAFT |
| GUIDE_SNAPSHOT_AND_CARD_PACK_DOCTRINE_V1 | snapshot/card pack doctrine | GUIDE_DRAFT |

## 3. Runtime Truths Captured

| Truth ID | Truth |
| --- | --- |
| TRUTH-01 | Active runtime routes are governed by `Routes` and `AppRouter`. |
| TRUTH-02 | Active role gates exist in Flutter and Firestore custom-claim rules. |
| TRUTH-03 | Runtime signal package and signal type/category/routing/privacy/retention registries exist. |
| TRUTH-04 | Runtime card registry is missing. |
| TRUTH-05 | Runtime tool registry is deleted/frozen. |
| TRUTH-06 | Runtime surface registry is missing. |
| TRUTH-07 | Runtime collection registry is missing. |
| TRUTH-08 | Asset ownership is mostly pubspec/docs based; `AppAssets` is partial. |
| TRUTH-09 | Language docs exist, ARB parity exists, but hardcoded/mojibake runtime text remains. |
| TRUTH-10 | Large deleted federation/admin/tool/monitoring systems are frozen history, not active runtime. |

## 4. Snapshot Relationship Map

| Domain | Guide | Registry | Card | Signal/Tool/Surface | Consumer | Report | Action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Residential | card/signal/surface/tool/language/collection | signal registries, missing card/tool registries | client and personal space cards | client signals, saved tools, personal space | client | card pack/report | validate language and missing registries |
| Commercial | signal/surface/language/asset/collection | commercial monitoring, docs | provider/center cards | discovery, registration, contact | public/client/provider/center | card pack/report | validate attribution |
| Administrative | role/surface/collection/language | Firestore rules, domain registry | support/declaration/registry cards | S rooms | admin roles | card pack/report | verify authority |
| Owner | role/surface/card | owner routes, docs | owner cards | owner district | owner | card pack/report | authorize |
| Monitoring | signal/tool/collection/surface | signal/monitoring registries | monitoring cards | signal_events/analytics | monitoring operator | card pack/report | verify drift |
| Legal & Governance | language/compliance | language docs | compliance cards | policies | all | compliance report | interpret |
| Technical | all implementation-facing guides | runtime code registries | FUTURE implementation cards | app code/Firebase | developers | implementation report FUTURE | execute later only |

## 5. Missing Runtime Registries

| Missing registry | Snapshot status |
| --- | --- |
| Runtime card registry | MISSING_RUNTIME_REGISTRY |
| Runtime route metadata registry | MISSING_RUNTIME_REGISTRY |
| Runtime surface registry | MISSING_RUNTIME_REGISTRY |
| Runtime tool registry | FROZEN/DELETED |
| Runtime client signal option registry | MISSING_RUNTIME_REGISTRY |
| Runtime provider signal option registry | MISSING_RUNTIME_REGISTRY |
| Runtime center signal/capability registry | PARTIAL |
| Runtime asset registry | PARTIAL |
| Runtime collection registry | MISSING_RUNTIME_REGISTRY |
| Runtime localization ownership registry | MISSING_RUNTIME_REGISTRY |
| Runtime analytics event registry | PARTIAL |

## 6. Snapshot Validation Status

| Check | Result |
| --- | --- |
| Source reality snapshot present | PASS |
| Guide files present | PASS |
| Card pack generated | PASS |
| Runtime code modified | NO |
| Firebase modified | NO |
| Routes modified | NO |
| ARB modified | NO |
| Ready for governance review | YES |

