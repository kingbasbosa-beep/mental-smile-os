# EX-119 Provider Orchestration Mapping

## Provider Selection

Provider selection is represented by:

- provider registry lookup
- enabled provider lists
- provider capability filters
- allowed/blocked provider IDs
- provider trust levels
- provider restrictions
- provider compatibility checks

Classification: backend-only.

## Provider Ownership Findings

| Concept | Classification | Reason |
| --- | --- | --- |
| provider registry | backend-only | Selects available providers. |
| provider ID | host/backend-owned | Can identify runtime provider. |
| provider capabilities | backend-only for enforcement | Can imply execution ability. |
| provider trust level | backend-only | Trust proof cannot be public metadata. |
| provider restrictions | backend-only | Permission/denial logic. |
| provider compatibility | backend-only | Authority-bearing decision. |
| provider policy link | metadata-only possible | Reference only, no enforcement proof. |
| provider audit reference | metadata-only possible | Reference only, no trace proof. |

## Moderation/Safety Gates

Provider capabilities such as moderation assist, crisis detection, escalation
assist, and safe support imply safety ownership if public.

Classification: host/backend-only or blocked.

## Provider Verdict

Provider orchestration cannot move into package exposure. Provider diagnostics
must remain host/backend-owned until causality and trust boundaries are fully
isolated.
