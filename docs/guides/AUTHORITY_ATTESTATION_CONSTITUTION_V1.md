# Mental Smile Authority Attestation Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | AUTHORITY_ATTESTATION_CONSTITUTION_V1 |
| Block | BLOCK_4B |
| Era | IDENTITY_AUTHORITY_CUSTODY_ERA |
| Scope | Constitutional authority attestation doctrine only |
| Firebase Claims Implementation | NONE |
| Runtime Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Authority Doctrine

Authority is not identity.

An identity may exist without authority. Authority exists only when a constitutional source attests that the identity is allowed to perform a specific class of action inside a specific domain, scope, lifecycle, and evidence chain.

## Authority Classes

| Authority ID | Authority Class | Source | Evidence | Owner | Steward | Revocation Method |
|---|---|---|---|---|---|---|
| authority.authorization | Authorization Authority | Owner doctrine and ownership registry | Owner authorization evidence | Owner | Owner Steward / Compliance | Owner revocation with compliance record |
| authority.review | Review Authority | Domain membership and guide doctrine | Review attestation evidence | Domain Owner | Domain Steward | Domain suspension or owner revocation |
| authority.validation | Validation Authority | Compliance doctrine | Validation attestation evidence | Compliance | Compliance Steward | Compliance revocation with archive evidence |
| authority.observation | Observation Authority | Monitoring doctrine | Observation attestation evidence | Monitoring | Monitoring Steward | Monitoring suspension or compliance block |
| authority.custody | Custody Authority | Custody constitution and ownership registry | Custody attestation evidence | Custody Domain Owner | Archive / Registry / Legal Steward | Custody revocation evidence |
| authority.distribution | Distribution Authority | Distribution constitution | Distribution attestation evidence | Owner / Compliance | Distribution Steward | Distribution block and archive evidence |
| authority.activation | Activation Authority | Activation constitution | Activation attestation evidence | Owner / Compliance | Activation Steward | Activation block and archive evidence |

## Authority Attestation Lifecycle

| State | Meaning | Entry Evidence | Exit Evidence | Forbidden Transition |
|---|---|---|---|---|
| AUTHORITY_REQUESTED | Identity requests authority in a domain | Identity evidence, membership evidence | Review start evidence | Self-grant |
| AUTHORITY_REVIEWED | Domain steward reviews scope | Review evidence | Validation start evidence | Hidden approval |
| AUTHORITY_VALIDATED | Compliance validates scope/source | Validation evidence | Attestation evidence | Runtime self-certification |
| AUTHORITY_ATTESTED | Authority becomes constitutionally recognized | Attestation evidence | Activation or runtime consumption | Inherited admin authority |
| AUTHORITY_SUSPENDED | Authority temporarily cannot be consumed | Suspension evidence | Recovery or revocation evidence | Silent restoration |
| AUTHORITY_REVOKED | Authority permanently removed | Revocation evidence | Archive evidence | Runtime-only revocation |
| AUTHORITY_ARCHIVED | Authority record preserved | Archive evidence | Retrieval only | Archive modifies active authority |

## Authority Source Model

| Authority Class | Required Source | Required Registry |
|---|---|---|
| Authorization Authority | Owner doctrine | Ownership Registry |
| Review Authority | Domain constitution | Domain Membership Registry |
| Validation Authority | Compliance constitution | Ownership Registry / Compliance Registry |
| Observation Authority | Monitoring constitution | Signal Registry / Ownership Registry |
| Custody Authority | Custody constitution | Ownership Registry / Asset Registry / Archive Registry |
| Distribution Authority | Distribution constitution | Distribution Registry |
| Activation Authority | Activation constitution | Activation Registry |

## Forbidden Authority Patterns

| Forbidden Pattern | Reason |
|---|---|
| Self Granted Authority | Trust must be attested by constitutional source |
| Hidden Authority | Authority must be traceable and registered |
| Inherited Admin Authority | Generic admin has been decomposed and is not constitutional |
| Wildcard Authority | Authority must be scoped |
| Runtime Created Authority | Runtime consumes authority; runtime does not create authority |
| Authority Without Revocation | Trust must be removable |
| Authority Without Evidence | Trust must be auditable |

## Block 4B Validation Result

| Pass Condition | Result |
|---|---|
| Authority defined | PASS |
| Authority distinguished from identity | PASS |
| Attestation defined | PASS |
| Authority classes defined | PASS |
| Source/evidence/owner/steward defined | PASS |
| Revocation method defined | PASS |
| Self granted authority forbidden | PASS |
| Hidden authority forbidden | PASS |
| Inherited admin authority forbidden | PASS |

Final result: `BLOCK_4B_AUTHORITY_ATTESTATION_COMPLETE`.
