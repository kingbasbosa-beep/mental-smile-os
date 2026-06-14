# Mental Smile Storage Rule Topology Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | STORAGE_RULE_TOPOLOGY_CONSTITUTION_V1 |
| Block | BLOCK_6F |
| Era | CONSTITUTIONAL_FIREBASE_RULES_ERA |
| Scope | Future storage rule topology doctrine only |
| Storage Rules Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Storage Rule Topology Doctrine

Storage classes map future Storage rules to constitutional rule classes. This document does not write or deploy rules.

## Storage Rule Class Map

| Storage Class | Read Rule Class | Write Rule Class | Custody Rule Class | Archive Rule Class | Retention Rule Class |
|---|---|---|---|---|---|
| Identity Storage | identity_storage.read.scoped | identity_storage.write.stewarded | identity_storage.custody.identity | identity_storage.archive.identity | identity_storage.retention.identity |
| Evidence Storage | evidence_storage.read.compliance_archive | evidence_storage.write.evidence_owner | evidence_storage.custody.archive | evidence_storage.archive.evidence | evidence_storage.retention.evidence |
| Archive Storage | archive_storage.read.custody | archive_storage.write.archive_steward | archive_storage.custody.archive | archive_storage.archive.self | archive_storage.retention.archive |
| Registry Storage | registry_storage.read.scoped | registry_storage.write.registry_steward | registry_storage.custody.registry | registry_storage.archive.registry | registry_storage.retention.registry |
| Asset Storage | asset_storage.read.consumer_scoped | asset_storage.write.asset_steward | asset_storage.custody.asset | asset_storage.archive.asset | asset_storage.retention.asset |
| Sensitive Storage | sensitive_storage.read.legal_compliance_scoped | sensitive_storage.write.custody_steward | sensitive_storage.custody.legal_compliance | sensitive_storage.archive.sensitive | sensitive_storage.retention.sensitive |

## Storage Rule Requirements

| Requirement | Applies To |
|---|---|
| Custody class source | All storage classes |
| Asset/ownership registry source | Asset, registry, identity, sensitive storage |
| Claim evaluation | All storage decisions |
| Authorization evaluation | All storage decisions |
| Decision evidence | All storage allow/deny/suspend/revoke/block decisions |
| No generic admin storage access | All storage classes |
| No runtime/technical direct custody | Sensitive, identity, evidence, archive storage |

## Block 6F Validation Result

| Pass Condition | Result |
|---|---|
| Storage rule topology defined | PASS |
| Required storage classes mapped | PASS |
| Read/write/custody/archive/retention rule classes defined | PASS |
| No generic admin storage doctrine | PASS |

Final result: `BLOCK_6F_STORAGE_RULE_TOPOLOGY_COMPLETE`.
