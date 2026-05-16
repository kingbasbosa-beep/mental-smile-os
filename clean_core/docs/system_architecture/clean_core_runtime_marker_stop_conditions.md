# clean_core Runtime Marker Stop Conditions

Phase: EX-32 - Runtime Marker Isolation Review

## Mandatory Stop Conditions

Future movement, export, or reconnect work must stop immediately if any runtime-marker or observability surface introduces:

- Firebase imports
- Flutter imports
- provider SDK imports
- networking imports
- generated imports
- app-owned imports
- Cloud Functions runtime coupling
- orchestration execution
- provider execution
- telemetry runtime execution
- automatic fallback execution
- automatic escalation execution
- authority transfer semantics
- distributed execution semantics
- privileged client write semantics
- broad barrel exports
- hidden guard/policy/profile exports

## Semantic Stop Conditions

Stop and require review if:

- a runtime marker is treated as runtime activation authority
- `backendGoverned` is treated as proof of backend approval
- `observabilityActive` is used to start telemetry runtime
- `telemetryRuntimeActive` becomes a runtime connector
- a boundary marker creates client-side escalation authority
- a fallback label triggers automated fallback execution
- a review marker resolves review without backend/human authority
- a state enum label becomes permission to execute

## Export Stop Conditions

Stop and require review if:

- runtime marker folders are exported broadly
- wildcard exports are added
- guard/policy/lock/profile files are exported
- AI runtime labels are exported without runtime-deferral notes
- observability contracts are exported as telemetry APIs
- provider/runtime marker exports imply SDK readiness

## Reconnect Stop Conditions

Stop and require review if:

- host app starts consuming markers as runtime toggles
- adapters are added without fail-closed behavior
- backend authority is bypassed
- provider execution becomes client-owned
- telemetry runtime becomes package-owned

## Stop Condition Verdict

Runtime markers are safe only while they remain labels. Any execution, authority, telemetry, or broad-export interpretation requires immediate stop and manual architecture review.

