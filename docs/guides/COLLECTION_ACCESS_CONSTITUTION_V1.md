# Mental Smile Collection Access Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | COLLECTION_ACCESS_CONSTITUTION_V1 |
| Block | BLOCK_5C |
| Era | CONSTITUTIONAL_RUNTIME_AUTHORIZATION_ERA |
| Scope | Future Firestore authorization doctrine only |
| Firestore Rules Changes | NONE |
| Runtime Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Collection Access Doctrine

Firestore collection access must trace to collection ownership, collection registry, identity, membership, attestation, claim, authorization, and evidence.

No collection may be unowned, unregistered, wildcard-accessed, or administered through generic admin authority.

## Collection Access Actions

| Action | Definition | Required Authorization |
|---|---|---|
| Collection Read | Consume collection data | Read Authorization |
| Collection Write | Create/update approved collection data | Write Authorization |
| Collection Review | Review collection data for governance/legal/support/declaration purposes | Review Authorization |
| Collection Validation | Validate collection source, ownership, lifecycle, access | Validation Authorization |
| Collection Archive | Preserve collection evidence/archive records | Custody / Archive Authorization |

## Collection Type Access Map

| Collection Type | Who Reads | Who Writes | Who Reviews | Who Validates | Who Archives |
|---|---|---|---|---|---|
| Identity collections | Identity owner, Compliance as scoped | Identity Steward / approved owner process | Compliance / Legal | Compliance | Archive |
| Ownership/registry collections | Registry Steward, Compliance, Owner | Registry Steward under authorization | Compliance | Compliance / Registry | Archive |
| Support/contact collections | Support Observer, Monitoring, Compliance, Owner as scoped | Public/runtime intake where authorized | Support / Compliance | Compliance | Archive |
| Declaration/profile change collections | Declaration Review, Compliance, Legal as scoped | Declarant/runtime intake where authorized | Declaration Review / Legal | Compliance | Archive |
| Signal collections | Monitoring, Compliance, Archive | Approved signal producer/service | Monitoring / Compliance | Compliance | Archive |
| Analytics/monitoring summaries | Monitoring, Compliance, Owner | Approved service writer | Monitoring / Compliance | Compliance / Technical Verification | Archive |
| Asset metadata collections | Registry, Owner, Technical Verification as scoped | Asset/Registry Steward | Compliance | Compliance / Technical Verification | Archive |
| Archive collections | Archive, Compliance, Legal as scoped | Archive Steward | Compliance / Legal | Archive / Compliance | Archive |

## Forbidden Collection Access

| Forbidden Pattern | Reason |
|---|---|
| Unowned Collection | No accountable owner |
| Unregistered Collection | No constitutional source |
| Wildcard Collection Access | Scope violation |
| Admin Collection Access | Generic admin is not constitutional |
| Hidden Collection Access | Access must be evidenced |
| Runtime-Created Collection Authority | Runtime cannot create authority |

## Block 5C Validation Result

| Pass Condition | Result |
|---|---|
| Collection access defined | PASS |
| Read/write/review/validation/archive defined | PASS |
| Collection type access map defined | PASS |
| Unowned collection forbidden | PASS |
| Unregistered collection forbidden | PASS |
| Wildcard collection access forbidden | PASS |
| Admin collection access forbidden | PASS |

Final result: `BLOCK_5C_COLLECTION_ACCESS_COMPLETE`.
