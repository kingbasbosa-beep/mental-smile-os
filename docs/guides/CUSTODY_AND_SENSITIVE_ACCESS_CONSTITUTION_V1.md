# Mental Smile Custody And Sensitive Access Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | CUSTODY_AND_SENSITIVE_ACCESS_CONSTITUTION_V1 |
| Block | BLOCK_4E |
| Era | IDENTITY_AUTHORITY_CUSTODY_ERA |
| Scope | Constitutional custody and sensitive access doctrine only |
| Storage Rules Changes | NONE |
| Firebase Changes | NONE |
| Runtime Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Custody Doctrine

Custody is controlled responsibility for sensitive constitutional or runtime-governed material.

Custody is not technical access. Technical may verify custody rules but does not receive direct custody. Monitoring may observe custody events but does not receive direct custody. Runtime may consume approved outputs but does not own direct custody.

## Custody Classes

| Custody Class ID | Custody Class | Owner | Custodian | Validator | Observer | Archive Scope |
|---|---|---|---|---|---|---|
| custody.identity | Identity Custody | Owner / Identity Domain | Identity Steward | Compliance | Monitoring | IDENTITY_CUSTODY_ARCHIVE |
| custody.registry | Registry Custody | Registry Domain | Registry Steward | Compliance | Monitoring | REGISTRY_CUSTODY_ARCHIVE |
| custody.archive | Archive Custody | Archive Domain | Archive Steward | Compliance / Legal | Monitoring | ARCHIVE_CUSTODY_ARCHIVE |
| custody.evidence | Evidence Custody | Evidence owning domain | Archive Steward | Compliance | Monitoring | EVIDENCE_CUSTODY_ARCHIVE |
| custody.asset | Asset Custody | Owner / Registry | Asset Steward | Compliance / Technical Verification | Monitoring | ASSET_CUSTODY_ARCHIVE |
| custody.storage | Storage Custody | Purpose-specific domain | Custody Steward | Compliance / Legal | Monitoring | STORAGE_CUSTODY_ARCHIVE |
| custody.legal | Legal Custody | Legal Governance | Legal Steward | Compliance | Monitoring | LEGAL_CUSTODY_ARCHIVE |

## Sensitive Data Classes

| Data Class ID | Sensitive Data Class | Owner | Custodian | Validator | Observer | Archive Scope |
|---|---|---|---|---|---|---|
| sensitive.identity_documents | Identity Documents | Identity Owner / Owner Domain | Identity Steward | Compliance | Monitoring | IDENTITY_CUSTODY_ARCHIVE |
| sensitive.national_ids | National IDs | Legal Governance / Owner | Legal Custody Steward | Compliance / Legal | Monitoring | LEGAL_CUSTODY_ARCHIVE |
| sensitive.medical_documents | Medical Documents | Legal Governance / Compliance | Medical Custody Steward | Compliance / Legal | Monitoring | SENSITIVE_MEDICAL_ARCHIVE |
| sensitive.licenses | Licenses | Legal Governance / Declaration Domain | Legal / Declaration Steward | Compliance | Monitoring | LICENSE_CUSTODY_ARCHIVE |
| sensitive.certificates | Certificates | Legal Governance / Declaration Domain | Declaration Steward | Compliance / Technical Verification | Monitoring | CERTIFICATE_CUSTODY_ARCHIVE |
| sensitive.legal_records | Legal Records | Legal Governance | Legal Steward | Compliance | Monitoring | LEGAL_CUSTODY_ARCHIVE |
| sensitive.owner_records | Owner Records | Owner | Owner Steward / Archive Steward | Compliance / Legal if needed | Monitoring | OWNER_CUSTODY_ARCHIVE |

## Custody Access Boundaries

| Actor | Direct Custody? | Allowed Relationship |
|---|---|---|
| Owner | Yes for owner-governed records | Authorizes custody direction and receives evidence |
| Legal Governance | Yes for legal custody | Interprets and controls legal access meaning |
| Compliance | Validation custody only | Validates access and mismatch |
| Archive | Archive custody only | Preserves custody evidence and retrieval proof |
| Registry | Registry custody only | Maintains registry identity and custody map |
| Technical Verification | NO direct custody | Verifies technical shape and access behavior |
| Monitoring | NO direct custody | Observes events and escalates anomalies |
| Runtime | NO direct custody | Consumes approved outputs only |
| Generic Admin | NO | Not constitutional |

## Forbidden Custody Patterns

| Forbidden Pattern | Reason |
|---|---|
| Technical Direct Custody | Technical verifies; Technical does not govern sensitive custody |
| Monitoring Direct Custody | Monitoring observes; Monitoring does not hold custody |
| Runtime Direct Custody | Runtime consumes approved outputs only |
| Generic Admin Custody | Admin is decomposed and not constitutional |
| Hidden Custody | Custody must be evidenced and stewarded |
| Custody Without Archive Scope | Sensitive custody must be preservable |
| Custody Without Revocation | Custody trust must be removable |

## Block 4E Validation Result

| Pass Condition | Result |
|---|---|
| Custody defined | PASS |
| Custody classes defined | PASS |
| Sensitive access defined | PASS |
| Owner/custodian/validator/observer/archive scope defined | PASS |
| Technical direct custody forbidden | PASS |
| Monitoring direct custody forbidden | PASS |
| Runtime direct custody forbidden | PASS |
| Generic admin custody forbidden | PASS |

Final result: `BLOCK_4E_CUSTODY_SENSITIVE_ACCESS_COMPLETE`.
