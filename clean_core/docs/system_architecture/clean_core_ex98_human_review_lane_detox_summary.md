# EX-98 Human Review Lane Detox Summary

## Authority Detox

Package contracts do not prove:

- assignment authority;
- reviewer authorization;
- resolver authorization;
- approval authority;
- moderation authority;
- backend ownership.

## Workflow Detox

Package contracts do not:

- progress workflow;
- route work;
- schedule review;
- assign reviewers;
- approve or resolve escalation;
- close or finalize records.

## Queue Detox

Queue matching remains host-side. Package contracts may carry labels used by queues, but they do not guarantee queue admission, order, scheduling, or routing.

## Boundary Detox

`EscalationBoundaryMarker` is excluded from the package. Backend governance, client outcome write policy, and emergency guarantee semantics remain host-owned.

## Audit/Policy Detox

Audit and policy references remain metadata only:

- audit ids do not prove persistence;
- hashes are not integrity proof;
- policy versions do not enforce or approve policy;
- snapshot ids do not prove immutability.

## Detox Verdict

The package surface is authority-neutral, workflow-neutral, queue-neutral, and boundary-neutral.
