# EX-109 Passive Vocabulary Public Caveat Plan

## Scope

Docs/plan only. This plan does not modify source/runtime files, export files,
create mappers, change imports/exports, reconnect consumers, or run pub
get/analyze.

## Low-Risk Possible Export Set

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

## Required Public Caveat Text

General caveat:

> These labels are passive metadata only. They are not commands, permissions,
> workflow states, enforcement signals, routing decisions, admission decisions,
> audit verification, policy compliance proof, emergency handling, or write
> authority.

Consumer misuse caveat:

> Consumers must not use these labels to route, admit, assign, enforce, verify
> backend governance, guarantee emergency handling, infer provider/runtime
> causality, recover fallback loops, or grant outcome write permission.

Emergency posture caveat:

> `emergencyCapabilityNotGuaranteed` is a negative safety posture only. It does
> not provide, trigger, route, or guarantee emergency response, human
> availability, backend intervention, provider escalation, or service-level
> timing.

## Export Framing

Any future export must frame these labels as descriptive vocabulary only.

Allowed framing:

- passive label
- observed/reported/requested fact
- reference-presence label
- negative emergency posture

Blocked framing:

- queue signal
- workflow command
- backend policy signal
- emergency workflow signal
- audit verification
- policy compliance proof
- write permission

## Caveat Plan Verdict

The caveat text is sufficient for planning a narrow export review. It is not
sufficient for broad export or consumer migration.
