# CARD_BIRTH_MODEL_V1

Status: REGISTERED

## Birth Rule

Every card must be born from a traceable authority.

## Required Birth Fields

| Field | Required |
|---|---|
| Card ID | YES |
| Card Name | YES |
| Card Type | YES |
| Birth Prompt | YES |
| Birth Signal | YES |
| Birth Authority | YES |
| Parent Guide | YES if applicable |
| Source Evidence | YES |
| Owner | YES |
| Runtime Purpose | YES |
| Validation Status | YES |

## Birth States

- PROPOSED
- CANDIDATE_RECORDED
- BORN_UNVALIDATED
- VALIDATED
- REGISTERED
- READY_FOR_DISTRIBUTION

## Forbidden Birth Conditions

- Card without birth prompt.
- Card without owner.
- Card without registry entry.
- Card without validation status.
- Card created because runtime already exists.
