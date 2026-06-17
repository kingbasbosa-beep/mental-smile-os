# SIGNAL_CREATION_MODEL_V1

Status: REGISTERED

## Creation Rule

Every signal must be created by a registered source and assigned to a registered signal family.

## Required Fields

| Field | Required |
|---|---|
| Signal ID | YES |
| Signal Name | YES |
| Signal Family | YES |
| Source Zone | YES |
| Source Component | YES |
| Trigger Condition | YES |
| Expected Outcome | YES |
| Owner | YES |
| Retention Class | YES |
| Compliance Status | YES |

## Creation States

- CREATED
- PACKAGED
- ROUTED_TO_GATEWAY
- FORWARDED
- CONSUMED
- ARCHIVED
- EXPIRED

## Forbidden Creation

- Anonymous signal.
- Signal without source zone.
- Signal without family.
- Signal without owner.
- Signal created to bypass route/gateway authority.
