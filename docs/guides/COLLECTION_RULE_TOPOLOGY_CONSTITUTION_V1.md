# Mental Smile Collection Rule Topology Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | COLLECTION_RULE_TOPOLOGY_CONSTITUTION_V1 |
| Block | BLOCK_6E |
| Era | CONSTITUTIONAL_FIREBASE_RULES_ERA |
| Scope | Future collection rule topology doctrine only |
| Firestore Rules Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Collection Rule Topology Doctrine

Collection classes map future Firestore rules to constitutional rule classes. This document does not write or deploy rules.

## Collection Rule Class Map

| Collection Class | Read Rule Class | Write Rule Class | Review Rule Class | Validation Rule Class | Archive Rule Class |
|---|---|---|---|---|---|
| Identity Collections | identity.read.scoped | identity.write.stewarded | identity.review.compliance_legal | identity.validate.compliance | identity.archive.custody |
| Registry Collections | registry.read.scoped | registry.write.steward | registry.review.compliance | registry.validate.registry_compliance | registry.archive.registry |
| Signal Collections | signal.read.monitoring_compliance | signal.write.registered_producer | signal.review.monitoring | signal.validate.compliance | signal.archive.signal |
| Support Collections | support.read.scoped | support.write.intake_or_steward | support.review.support_compliance | support.validate.compliance | support.archive.support |
| Declaration Collections | declaration.read.scoped | declaration.write.declarant_or_steward | declaration.review.declaration_legal | declaration.validate.compliance | declaration.archive.declaration |
| Archive Collections | archive.read.custody | archive.write.archive_steward | archive.review.compliance_legal | archive.validate.archive_compliance | archive.archive.self_custody |
| Analytics Collections | analytics.read.monitoring_owner | analytics.write.service_authorized | analytics.review.monitoring_compliance | analytics.validate.technical_compliance | analytics.archive.analytics |
| Asset Metadata Collections | asset.read.scoped | asset.write.registry_asset_steward | asset.review.owner_registry | asset.validate.compliance_technical | asset.archive.asset |

## Collection Rule Requirements

| Requirement | Applies To |
|---|---|
| Ownership registry source | All collection classes |
| Collection registry source | All collection classes |
| Claim evaluation | All read/write/review/validate/archive actions |
| Authorization evaluation | All actions |
| Decision evidence | All allow/deny/suspend/revoke/block decisions |
| No admin override | All collection classes |

## Block 6E Validation Result

| Pass Condition | Result |
|---|---|
| Collection rule topology defined | PASS |
| Required collection classes mapped | PASS |
| Read/write/review/validation/archive rule classes defined | PASS |
| No wildcard/admin collection rule doctrine | PASS |

Final result: `BLOCK_6E_COLLECTION_RULE_TOPOLOGY_COMPLETE`.
