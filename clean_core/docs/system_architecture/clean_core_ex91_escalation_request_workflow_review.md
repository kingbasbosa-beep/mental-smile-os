# EX-91 EscalationRequest Workflow Review

## Workflow Couplings

`EscalationRequest` is workflow-adjacent because it combines:

- escalation level
- escalation reason
- escalation state
- review priority
- visibility scope
- creation timestamp
- boundary marker

## Workflow Leakage Risks

The record can imply:

- escalation initiation;
- workflow start;
- state transition;
- queue eligibility;
- assignment readiness;
- emergency escalation;
- backend handling.

## Package Boundary Requirements

A package-safe request model must not:

- start workflow;
- route to a queue;
- assign reviewers;
- schedule review;
- trigger moderation;
- enforce emergency behavior;
- progress `EscalationState`;
- guarantee backend handling.

## Compatibility Strategy

The existing host file should remain intact if future split occurs. A host mapper should own Firestore and storage behavior. Any queue or boundary behavior must remain outside the package model.

## Verdict

Workflow semantics require freeze before simulation. Semantic freeze alone is not sufficient if `boundaryMarker` is included unchanged.
