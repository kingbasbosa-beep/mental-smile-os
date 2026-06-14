# Mental Smile Storage Access Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | STORAGE_ACCESS_CONSTITUTION_V1 |
| Block | BLOCK_5D |
| Era | CONSTITUTIONAL_RUNTIME_AUTHORIZATION_ERA |
| Scope | Future Storage authorization doctrine only |
| Storage Rules Changes | NONE |
| Runtime Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Storage Access Doctrine

Storage access is governed by custody, sensitivity, ownership, claim scope, authorization scope, and evidence. Technical can verify storage access shape but cannot hold direct custody. Runtime can consume approved outputs but cannot hold direct custody.

## Storage Classes

| Storage Class ID | Storage Class | Owner | Custodian | Validator | Observer | Runtime Consumer |
|---|---|---|---|---|---|---|
| storage.identity | Identity Storage | Identity/Owner Domain | Identity Steward | Compliance | Monitoring | Scoped identity surfaces |
| storage.evidence | Evidence Storage | Evidence owning domain | Archive Steward | Compliance | Monitoring | Compliance/Archive surfaces |
| storage.archive | Archive Storage | Archive Domain | Archive Steward | Archive / Compliance | Monitoring | Archive retrieval consumers |
| storage.registry | Registry Storage | Registry Domain | Registry Steward | Compliance | Monitoring | Registry surfaces |
| storage.asset | Asset Storage | Owner / Registry | Asset Steward | Compliance / Technical Verification | Monitoring | Flutter/Firebase asset runtime |
| storage.sensitive | Sensitive Storage | Purpose-specific owner | Legal/Compliance/Archive Custodian | Compliance / Legal | Monitoring | Strictly scoped authorized consumers |

## Sensitive Storage Access Map

| Sensitive Class | Owner | Custodian | Validator | Observer | Runtime Consumer |
|---|---|---|---|---|---|
| Identity documents | Identity/Owner Domain | Identity Steward | Compliance | Monitoring | Scoped identity runtime only |
| National IDs | Legal Governance / Owner | Legal Custody Steward | Legal / Compliance | Monitoring | None by default; scoped review only |
| Medical documents | Legal Governance / Compliance | Medical Custody Steward | Legal / Compliance | Monitoring | None by default; scoped review only |
| Licenses | Legal / Declaration Domain | Legal/Declaration Steward | Compliance | Monitoring | Declaration review consumer |
| Certificates | Legal / Declaration Domain | Declaration Steward | Compliance / Technical Verification | Monitoring | Declaration review consumer |
| Legal records | Legal Governance | Legal Steward | Compliance | Monitoring | Legal/Archive consumer |
| Owner records | Owner | Owner/Archive Steward | Compliance / Legal | Monitoring | Owner/Archive consumer |

## Forbidden Storage Access

| Forbidden Pattern | Reason |
|---|---|
| Generic Admin Storage Access | Admin is not constitutional |
| Technical Direct Custody | Technical verifies only |
| Runtime Direct Custody | Runtime consumes approved outputs only |
| Hidden Storage Access | Access must be evidenced |
| Wildcard Storage Access | Scope violation |
| Storage Access Without Custody | Sensitive data needs custodian |

## Block 5D Validation Result

| Pass Condition | Result |
|---|---|
| Storage access defined | PASS |
| Storage classes defined | PASS |
| Owner/custodian/validator/observer/runtime consumer defined | PASS |
| Sensitive storage mapped | PASS |
| Generic admin storage access forbidden | PASS |
| Technical direct custody forbidden | PASS |
| Runtime direct custody forbidden | PASS |
| Hidden storage access forbidden | PASS |

Final result: `BLOCK_5D_STORAGE_ACCESS_COMPLETE`.
