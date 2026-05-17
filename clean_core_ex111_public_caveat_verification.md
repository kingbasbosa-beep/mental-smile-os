# EX-111 Public Caveat Verification

## Caveat Location

Public caveats are present near the exported labels in
`passive_review_signal.dart`.

## Caveat Coverage

The exported file states that the labels are not:

- commands
- permissions
- workflow states
- enforcement signals
- routing decisions
- admission decisions
- audit verification
- policy compliance proof
- emergency handling
- write authority

The exported file also warns consumers not to use the labels to:

- route
- admit
- assign
- enforce
- verify backend governance
- guarantee emergency handling
- infer provider/runtime causality
- recover fallback loops
- grant outcome write permission

## Label-Level Caveats

- `policyIssueObserved`: not a confirmed violation, backend adjudication,
  enforcement signal, or policy compliance finding.
- `manualSupportRequested`: not queue admission, reviewer assignment, support
  availability, or workflow execution.
- `policyReferencePresent`: not policy validity, policy enforcement, or
  compliance proof.
- `auditReferencePresent`: not audit verification, trace validity, or backend
  audit enforcement.
- `emergencyCapabilityNotGuaranteed`: negative safety posture only; no
  emergency response, human availability, backend intervention, provider
  escalation, or service-level timing.

## Caveat Verdict

Pass. Public caveats are present and directly cover the misuse risks identified
in EX-109.
