# DECLARATION_REVIEW_REGISTRY_V1

Status: ACTIVE_GOVERNANCE_REGISTRY
Phase: 8A
Runtime effect: none

## Purpose

Define Declaration Review authority, inputs, outputs, and boundaries for clinician/center registration and profile change declarations.

## Authority

Declaration Reviewer may observe registered declaration streams. Owner approves any expansion from observation into approval, rejection, mutation, or visibility override.

## Owner

Owner, with Declaration Reviewer as review observer.

## Consumers

- Declaration Review Room.
- Administrative Domain.
- Registration flows.
- Profile change request flows.
- Owner Room.
- Operations Registry.

## Inputs

- `clinicians`.
- `centers`.
- `clinician_profile_change_requests`.
- `center_profile_change_requests`.
- Declaration readiness fields.
- Visibility readiness fields.

## Outputs

- Declaration visibility.
- Review context.
- Readiness summary.
- Owner decision request when mutation/approval is needed.

## Dependencies

- Owner Approval Registry.
- Governance Decision Registry.
- Collection Registry.
- Route Registry.
- Administrative audit reports.

## Escalation Path

Declaration submitted -> Declaration Review observation -> governance decision request -> Owner approval -> approved runtime mutation if required.

## Compliance Status

ACTIVE_REQUIRED

Declaration Review Room is read-only unless Owner explicitly approves a mutation workflow and registers the decision.

## Review Streams

| Stream | Collection | Authority | Status |
| --- | --- | --- | --- |
| Clinician declarations | `clinicians` | observe | ACTIVE_READ_ONLY |
| Center declarations | `centers` | observe | ACTIVE_READ_ONLY |
| Clinician profile declarations | `clinician_profile_change_requests` | observe | ACTIVE_READ_ONLY |
| Center profile declarations | `center_profile_change_requests` | observe | ACTIVE_READ_ONLY |
