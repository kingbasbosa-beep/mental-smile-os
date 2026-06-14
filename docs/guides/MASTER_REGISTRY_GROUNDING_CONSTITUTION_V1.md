# Mental Smile Master Registry Grounding Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | MASTER_REGISTRY_GROUNDING_CONSTITUTION_V1 |
| Block | BLOCK_3A |
| Era | RUNTIME_GOVERNANCE_ERA |
| Scope | Registry grounding doctrine only |
| Runtime Implementation | NONE |
| Firebase Changes | NONE |
| Flutter Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Registry Grounding Doctrine

Registries are constitutional truth maps. Runtime consumes registries; runtime does not create registries.

Every runtime object must trace to a registry source, and every registry source must trace to a guide, snapshot, card pack, card, owner domain, and evidence record.

No Admin Era authority, manual authority, hidden authority, runtime-generated governance, or orphan runtime object is permitted.

## Registry Definitions

| Registry ID | Registry Name | Contains | Primary Owner | Steward | Runtime Consumers | Required Evidence |
|---|---|---|---|---|---|---|
| registry.ownership | Ownership Registry | Owner domains, stewards, custodians, consumers, dependencies | Owner | Registry Steward | Flutter, Firebase, Compliance, Monitoring | Ownership grounding evidence |
| registry.route | Route Registry | Route identity, status, ownership, surface, consumers | Owner / Registry | Registry Steward | Flutter routing, Monitoring | Route grounding evidence |
| registry.collection | Collection Registry | Collection identity, ownership, consumers, status | Owner / Compliance | Registry Steward | Firestore, Functions, Compliance | Collection grounding evidence |
| registry.signal | Signal Registry | Signal identity, producer, consumer, status, lifecycle | Monitoring / Compliance | Registry Steward | Signal streams, Monitoring, Archive | Signal grounding evidence |
| registry.tool | Tool Registry | Tool identity, ownership, consumers, dependencies, validation | Technical Verification / Owner | Registry Steward | Technical surfaces, Monitoring, Compliance | Tool grounding evidence |
| registry.localization | Localization Registry | Term, owner, surface, policy, replacement, status | Legal Governance / Localization | Registry Steward | Flutter localization | Localization grounding evidence |
| registry.asset | Asset Registry | Asset identity, owner, usage, status, validation | Owner / Registry | Registry Steward | Flutter assets, Firebase Storage | Asset grounding evidence |
| registry.snapshot | Snapshot Registry | Snapshot identity, source guide, version, status | Compliance | Snapshot Steward | Pack generation, Runtime Bridge | Snapshot grounding evidence |
| registry.pack | Pack Registry | Pack identity, source snapshot, consumers, version | Compliance / Owner | Pack Steward | Distribution, Activation, Runtime Bridge | Pack grounding evidence |
| registry.distribution | Distribution Registry | Distribution identity, targets, status, confirmation | Distribution Steward | Distribution Steward | Activation, Monitoring | Distribution grounding evidence |
| registry.activation | Activation Registry | Activation identity, version, status, evidence | Owner / Compliance | Activation Steward | Runtime Bridge, Monitoring, Archive | Activation grounding evidence |

## Registry Ownership Model

| Registry | Authority Owner | Custodian | Validator | Observer | Forbidden Owner Pattern |
|---|---|---|---|---|---|
| Ownership Registry | Owner | Registry Steward | Compliance | Monitoring | Generic admin owner |
| Route Registry | Owner | Registry Steward | Compliance / Technical Verification | Monitoring | Runtime route owner |
| Collection Registry | Owner / Compliance | Registry Steward | Compliance / Technical Verification | Monitoring | Firestore self-owner |
| Signal Registry | Monitoring / Compliance | Registry Steward | Compliance | Archive | Runtime-created signal owner |
| Tool Registry | Owner / Technical Verification | Registry Steward | Compliance | Monitoring | Technical self-authority |
| Localization Registry | Legal Governance | Localization Steward | Compliance | Monitoring | Runtime-created term owner |
| Asset Registry | Owner | Registry Steward | Compliance / Technical Verification | Monitoring | Orphan asset owner |
| Snapshot Registry | Compliance | Snapshot Steward | Compliance | Monitoring | Runtime snapshot owner |
| Pack Registry | Owner / Compliance | Pack Steward | Compliance | Monitoring | Runtime pack owner |
| Distribution Registry | Owner / Compliance | Distribution Steward | Compliance | Monitoring | Manual distribution owner |
| Activation Registry | Owner / Compliance | Activation Steward | Compliance / Monitoring | Archive | Manual activation owner |

## Registry Lifecycle Model

| State | Meaning | Entry Condition | Exit Condition | Forbidden Transition |
|---|---|---|---|---|
| REGISTRY_DEFINED | Registry type is constitutionally defined | Guide doctrine exists | Registry card created | Runtime creates registry |
| REGISTRY_GROUNDED | Registry has owner, steward, consumers, dependencies | Ownership evidence exists | Validation begins | Admin fallback grounds registry |
| REGISTRY_VALIDATED | Registry entries satisfy required fields | Compliance validation passes | Binding begins | Runtime self-certifies |
| REGISTRY_BOUND | Registry is bound to runtime consumption path | Binding evidence exists | Runtime validation begins | Orphan runtime binding |
| REGISTRY_ACTIVE | Registry is consumable by runtime | Activation evidence exists | Drift/block/archive event | Manual activation |
| REGISTRY_BLOCKED | Registry cannot be consumed | Mismatch, drift, missing ownership, hidden authority | Owner-approved remediation path | Silent unblock |
| REGISTRY_ARCHIVED | Registry version evidence preserved | Replacement or closure evidence exists | Retrieval only | Archive modifies active registry |

## Registry Validation Model

| Validation Check | Applies To | Pass Condition | Failure Signal |
|---|---|---|---|
| Ownership exists | All registries | Owner domain, steward, custodian, consumer present | signal.registry.ownership_missing |
| Source trace exists | All registries | Guide, snapshot, pack, card source present | signal.registry.source_missing |
| Consumer declared | All registries | Runtime/governance consumers listed | signal.registry.consumer_missing |
| Dependency declared | All registries | Required upstream/downstream registries listed | signal.registry.dependency_missing |
| Status valid | All registries | Lifecycle status belongs to approved state model | signal.registry.status_invalid |
| No admin authority | All registries | No generic admin owner, fallback, or hidden authority | signal.registry.hidden_authority_detected |
| Runtime trace valid | Runtime-facing registries | Runtime object maps to registry entry | signal.registry.runtime_trace_missing |

## Registry Dependency Model

| Registry | Depends On | Feeds |
|---|---|---|
| Ownership Registry | Authority Decomposition, Owner doctrine | All registries, runtime authority consumers |
| Route Registry | Ownership Registry, Surface Guide, Route Cards | Flutter routes, Monitoring, Runtime Validation |
| Collection Registry | Ownership Registry, Collection Cards, Firebase Bridge | Firestore, Functions, Runtime Validation |
| Signal Registry | Ownership Registry, Signal Cards, Monitoring doctrine | Signal streams, Runtime Validation, Archive |
| Tool Registry | Ownership Registry, Tool Cards, Technical Verification | Technical tools, Runtime Validation |
| Localization Registry | Language policies, Ownership Registry | Flutter localization, Legal Governance |
| Asset Registry | Ownership Registry, Asset Cards, Storage custody | Flutter assets, Firebase Storage |
| Snapshot Registry | Guide System, Snapshot doctrine | Pack Registry, Distribution Registry |
| Pack Registry | Snapshot Registry, Card Pack doctrine | Distribution Registry, Runtime Bridge |
| Distribution Registry | Pack Registry, Distribution doctrine | Activation Registry, Monitoring |
| Activation Registry | Distribution Registry, Activation doctrine | Runtime Bridge, Archive |

## Registry Evidence Model

| Evidence Class | Producer | Consumer | Required Contents |
|---|---|---|---|
| Registry Ownership Evidence | Registry Steward | Compliance, Owner | Registry ID, owner domain, steward, custodian, consumers |
| Registry Validation Evidence | Compliance | Owner, Monitoring, Archive | Validation checks, pass/fail state, mismatch list |
| Registry Dependency Evidence | Registry Steward | Compliance, Technical Verification | Upstream/downstream registry links |
| Registry Binding Evidence | Runtime Bridge Steward | Compliance, Monitoring | Registry object ID, runtime object ID, binding status |
| Registry Drift Evidence | Monitoring | Compliance, Owner, Archive | Drift type, expected registry state, observed runtime state |
| Registry Archive Evidence | Archive Steward | Owner, Compliance | Registry version, replacement link, retrieval proof |

## Block 3A Validation Result

| Pass Condition | Result |
|---|---|
| All registries defined | PASS |
| Registry ownership defined | PASS |
| Registry lifecycle defined | PASS |
| Registry validation defined | PASS |
| Registry dependencies defined | PASS |
| Registry evidence defined | PASS |
| No Admin authority exists as doctrine | PASS |
| No runtime-created registry exists | PASS |

Final result: `BLOCK_3A_REGISTRY_GROUNDING_COMPLETE`.
