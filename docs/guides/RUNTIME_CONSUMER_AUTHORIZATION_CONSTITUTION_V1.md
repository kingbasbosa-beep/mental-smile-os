# Mental Smile Runtime Consumer Authorization Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | RUNTIME_CONSUMER_AUTHORIZATION_CONSTITUTION_V1 |
| Block | BLOCK_5B |
| Era | CONSTITUTIONAL_RUNTIME_AUTHORIZATION_ERA |
| Scope | Runtime consumer authorization doctrine only |
| Runtime Changes | NONE |
| Firebase Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Consumer Doctrine

A consumer is any constitutional identity, service, runtime object, tool, registry, or signal that consumes a governed resource. Consumers require claim, authorization, scope, and evidence.

## Runtime Consumers

| Consumer ID | Consumer Type | Allowed Resources | Forbidden Resources | Required Claims | Required Evidence | Revocation Path |
|---|---|---|---|---|---|---|
| consumer.human | Human Consumer | Authorized surfaces, collections, tools, records matching domain membership | Wildcard resources, hidden admin surfaces, unrelated custody records | Domain-scoped claim | Identity, membership, attestation, claim, authorization evidence | Domain Steward -> Compliance -> Owner |
| consumer.service | Service Consumer | Explicit service functions, signal production, approved collection writes | Human authority, owner override, hidden custody | Service execution claim | Service identity, technical attestation, authorization evidence | Technical Verification -> Compliance -> Owner |
| consumer.runtime | Runtime Consumer | Activated routes, collections, signals, assets, localization | Runtime-created governance, unregistered objects | Runtime consumption claim | Runtime identity, registry binding, runtime validation evidence | Runtime Bridge Steward -> Compliance |
| consumer.tool | Tool Consumer | Tool-scoped resources and technical verification surfaces | Business authorization, custody outside scope, hidden execution | Tool claim | Tool identity, tool registry, tool authorization evidence | Tool Steward -> Compliance -> Owner |
| consumer.registry | Registry Consumer | Registry entries and registry validation evidence | Final authorization, runtime mutation without authorization | Registry stewardship claim | Registry identity, registry grounding evidence | Registry Steward -> Compliance |
| consumer.signal | Signal Consumer | Signal stream consumption/production within signal registry | Unregistered signals, silent authority signals | Signal claim | Signal identity, signal registry, signal authorization evidence | Monitoring / Compliance -> Owner |

## Consumer Restrictions

| Restriction | Applies To | Rule |
|---|---|---|
| Scope restriction | All consumers | Consumer may consume only scoped resources |
| Evidence restriction | All consumers | Consumer must have authorization evidence |
| Registry restriction | Runtime, tool, registry, signal consumers | Resource must be registered |
| Custody restriction | Human/service/runtime/tool consumers | Sensitive custody requires custody authorization |
| Revocation restriction | All consumers | Every consumer authorization must be revocable |
| No admin restriction | All consumers | Generic admin consumer is forbidden |

## Block 5B Validation Result

| Pass Condition | Result |
|---|---|
| Consumers defined | PASS |
| Allowed resources defined | PASS |
| Forbidden resources defined | PASS |
| Required claims defined | PASS |
| Required evidence defined | PASS |
| Revocation path defined | PASS |
| Admin consumer forbidden | PASS |

Final result: `BLOCK_5B_RUNTIME_CONSUMER_AUTHORIZATION_COMPLETE`.
