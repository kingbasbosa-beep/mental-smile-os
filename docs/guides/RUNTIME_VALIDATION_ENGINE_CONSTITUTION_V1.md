# Mental Smile Runtime Validation Engine Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | RUNTIME_VALIDATION_ENGINE_CONSTITUTION_V1 |
| Block | BLOCK_3B |
| Era | RUNTIME_GOVERNANCE_ERA |
| Scope | Runtime validation doctrine only |
| Runtime Implementation | NONE |
| Firebase Changes | NONE |
| Flutter Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Runtime Validation Doctrine

Runtime validation is the constitutional process that proves runtime objects consume approved constitutional sources.

Runtime cannot validate itself, approve itself, certify itself, create authority, create cards, create signals, create registries, or override governance.

## Runtime Validation Definitions

| Term | Definition | Constitutional Meaning |
|---|---|---|
| Runtime Validation | Comparison between runtime object and constitutional source | Required before runtime object is considered consumable |
| Runtime Valid | Runtime object matches active guide/snapshot/pack/card/registry source | Consumable if activation is confirmed |
| Runtime Invalid | Runtime object conflicts with source | Must be escalated and blocked when critical |
| Runtime Unknown | Runtime object has no known constitutional source | Must be blocked from future activation path |
| Runtime Drift | Runtime object diverges from approved source after validation | Monitoring and Compliance event |
| Runtime Block | Governance decision state preventing consumption | Requires evidence and escalation |

## Runtime Drift Definitions

| Drift Type | Description | Primary Detector | Escalation |
|---|---|---|---|
| Guide Drift | Runtime consumes output from outdated guide state | Compliance | Owner |
| Registry Drift | Runtime object differs from registry entry | Registry Steward / Compliance | Owner |
| Route Drift | Flutter route is missing, orphaned, or mismatched | Monitoring / Technical Verification | Compliance |
| Signal Drift | Runtime emits unknown or wrong signal | Monitoring | Compliance |
| Asset Drift | Runtime asset lacks registry, owner, or valid status | Registry Steward | Compliance |
| Localization Drift | Runtime term lacks approved policy or registry source | Legal Governance / Compliance | Owner |

## Runtime Block Definitions

| Block Type | Meaning | Trigger | Release Condition |
|---|---|---|---|
| Validation Block | Object fails validation | Invalid or unknown runtime object | Compliance validation passes after authorized correction |
| Activation Block | Object cannot be activated | Missing activation evidence, mismatched pack, hidden authority | Owner authorization and Compliance validation |
| Consumption Block | Runtime cannot consume object | Missing registry, drift, revoked source | Current source and binding evidence restored |

## Validation Lifecycle

| State | Entry Condition | Required Action | Produced Signal | Produced Evidence |
|---|---|---|---|---|
| VALIDATION_REQUESTED | Runtime object is presented for validation | Identify object and source | signal.runtime.validation_requested | Runtime validation request evidence |
| SOURCE_TRACE_CHECKED | Guide/snapshot/pack/card/registry trace checked | Confirm trace completeness | signal.runtime.source_trace_checked | Source trace evidence |
| REGISTRY_MATCH_CHECKED | Registry entry compared to runtime object | Confirm registry match | signal.runtime.registry_match_checked | Registry match evidence |
| VALIDATION_PASSED | All required checks pass | Mark object constitutionally valid | signal.runtime.validated | Runtime validation evidence |
| VALIDATION_FAILED | Required check fails | Raise mismatch | signal.runtime.mismatch | Runtime mismatch evidence |
| VALIDATION_BLOCKED | Failure requires block | Create block record | signal.runtime.block_triggered | Runtime block evidence |
| VALIDATION_ARCHIVED | Evidence preserved | Archive validation result | signal.runtime.validation_archived | Archive evidence |

## Validation Ownership

| Responsibility | Owner Domain | Steward | Forbidden Actor |
|---|---|---|---|
| Request validation | Compliance / Runtime Bridge Steward | Runtime Bridge Steward | Runtime object itself |
| Source trace check | Compliance | Registry Steward | Generic admin |
| Technical observation | Technical Verification | Technical Verifier | Owner as self-verifier |
| Drift observation | Monitoring | Monitoring Steward | Runtime as self-observer |
| Final authorization after block | Owner | Owner | Technical / Monitoring |
| Evidence custody | Archive | Archive Steward | Runtime |

## Validation Signals

| Signal ID | Name | Producer | Consumer | Purpose |
|---|---|---|---|---|
| signal.runtime.validation_requested | Runtime Validation Requested | Runtime Bridge Steward | Compliance | Start validation lifecycle |
| signal.runtime.source_trace_checked | Runtime Source Trace Checked | Compliance | Registry Steward, Archive | Record trace check |
| signal.runtime.registry_match_checked | Runtime Registry Match Checked | Registry Steward | Compliance | Record registry comparison |
| signal.runtime.validated | Runtime Validated | Compliance | Owner, Monitoring, Archive | Confirm valid runtime consumption |
| signal.runtime.mismatch | Runtime Mismatch | Compliance | Owner, Technical, Monitoring | Report invalid runtime state |
| signal.runtime.drift_detected | Runtime Drift Detected | Monitoring | Compliance, Owner | Report runtime drift |
| signal.runtime.block_triggered | Runtime Block Triggered | Compliance | Owner, Technical, Archive | Trigger constitutional block |
| signal.runtime.validation_archived | Runtime Validation Archived | Archive | Compliance, Owner | Preserve validation result |

## Validation Escalation

| Event | First Receiver | Escalation Path | Critical Rule |
|---|---|---|---|
| Runtime Unknown | Compliance | Compliance -> Owner -> Technical Verification | Block until source exists or object is removed |
| Runtime Invalid | Compliance | Compliance -> Technical Verification -> Owner | Do not activate |
| Runtime Drift | Monitoring | Monitoring -> Compliance -> Owner | Archive drift evidence |
| Hidden Authority Detected | Compliance | Compliance -> Legal Governance -> Owner | Critical block |
| Admin Era Authority Detected | Compliance | Compliance -> Owner | Critical block |
| Missing Evidence | Archive / Compliance | Archive -> Compliance -> Owner | Cannot approve completion |

## Validation Evidence

| Evidence ID | Evidence Class | Required Fields | Archive Scope |
|---|---|---|---|
| evidence.runtime.validation_request | Validation request evidence | Object ID, object type, requester, source candidate | RUNTIME_GOVERNANCE_ARCHIVE |
| evidence.runtime.source_trace | Source trace evidence | Guide ID, snapshot ID, pack ID, card ID, registry ID | RUNTIME_GOVERNANCE_ARCHIVE |
| evidence.runtime.registry_match | Registry match evidence | Registry entry, runtime object, comparison result | RUNTIME_GOVERNANCE_ARCHIVE |
| evidence.runtime.validated | Runtime validated evidence | Pass result, validator, timestamp, consumers | RUNTIME_GOVERNANCE_ARCHIVE |
| evidence.runtime.mismatch | Runtime mismatch evidence | Mismatch type, severity, source, observed state | RUNTIME_GOVERNANCE_ARCHIVE |
| evidence.runtime.block | Runtime block evidence | Block type, trigger, owner escalation, release requirements | RUNTIME_GOVERNANCE_ARCHIVE |

## Forbidden Runtime Validation Behaviors

| Forbidden Behavior | Reason |
|---|---|
| Runtime Self Approval | Runtime cannot create constitutional truth |
| Runtime Self Certification | Runtime cannot certify its own validity |
| Runtime Authority Creation | Authority must come from constitutional source |
| Runtime Registry Creation | Registries are governance objects |
| Runtime Signal Creation | Signals require signal cards and signal registry |
| Admin Era Validation | Generic admin is not a constitutional validator |
| Hidden Authority Validation | Fallback authority cannot validate runtime |

## Block 3B Validation Result

| Pass Condition | Result |
|---|---|
| Runtime validation defined | PASS |
| Runtime drift defined | PASS |
| Runtime block defined | PASS |
| Validation lifecycle defined | PASS |
| Validation ownership defined | PASS |
| Validation signals defined | PASS |
| Validation escalation defined | PASS |
| Validation evidence defined | PASS |
| Runtime self approval forbidden | PASS |
| Runtime authority creation forbidden | PASS |

Final result: `BLOCK_3B_RUNTIME_VALIDATION_COMPLETE`.
