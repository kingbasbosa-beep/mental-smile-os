# EX-126 Fake Guarantee Checklist

## Scope

Docs/template only. This checklist prevents passive package surface from
looking like execution, authority, proof, emergency response, provider
causality, fallback recovery, or operational control.

## Naming Review

| Question | Answer | Evidence |
| --- | --- | --- |
| Could the name be read as a command? |  |  |
| Could the name be read as a permission? |  |  |
| Could the name be read as workflow state? |  |  |
| Could the name be read as routing/admission? |  |  |
| Could the name be read as backend enforcement? |  |  |
| Could the name be read as emergency handling? |  |  |
| Could the name be read as provider causality? |  |  |
| Could the name be read as retry/fallback recovery? |  |  |
| Could the name be read as telemetry/privacy proof? |  |  |
| Could the name be read as audit verification? |  |  |
| Could the name be read as policy compliance proof? |  |  |
| Could the name be read as moderation/safety ownership? |  |  |
| Could the name be read as operational/admin authority? |  |  |

## Required Caveats

State whether the candidate needs caveats for:

- commands:
- permissions:
- workflow states:
- routing/admission:
- backend enforcement:
- emergency handling:
- provider/runtime causality:
- retry/fallback recovery:
- telemetry/privacy proof:
- audit verification:
- policy compliance:
- moderation/safety ownership:
- write authority:
- operational/admin authority:

## Blocked Words And Patterns

Future candidates need special review if names include or imply:

- `accepts`
- `approved`
- `assigned`
- `routed`
- `enforced`
- `verified`
- `guaranteed`
- `recovered`
- `fallback`
- `runtime`
- `provider`
- `emergency`
- `admin`
- `permission`
- `owner`
- `capability`
- `available`

This list is not exhaustive. Any authoritative or operational reading is a
stop condition.

## Fake Guarantee Stop Conditions

Stop if:

- the name implies more than passive metadata
- a caveat is required but not included
- the candidate can be mistaken for backend proof
- the candidate can be mistaken for emergency capability
- the candidate can be mistaken for provider/runtime causality
- the candidate can be mistaken for retry or fallback recovery
- consumers could reasonably use it as a command, permission, or workflow
  state

## Checklist Verdict

Fake guarantee verdict:

- `Pass`
- `Blocked`
- `Needs rename`
- `Needs caveats`
- `Needs doctrine review`
