# EX-99 Risk Avoidance Summary

## Risks Avoided

- Direct movement of consumer-bound records.
- Package Firestore contamination.
- Runtime/provider/Firebase leakage.
- Hidden consumer reconnect.
- Wildcard or directory exports.
- Backend authority leakage.
- Moderation/approval authority leakage.
- Queue/routing execution leakage.
- Boundary marker guarantee leakage.
- Emergency guarantee semantics entering the package.
- Policy/audit references being treated as proof.

## Detox Strategy

The wave applied authority, workflow, queue, boundary, audit, policy, integrity, privacy, and runtime detox caveats across package contracts.

## Key Blocking Decisions

- `EscalationBoundaryMarker` remains host-only.
- `EscalationQueue` remains host-only.
- Queue acceptance/routing remains host-owned.
- Backend governance semantics remain host/backend-owned.
- Emergency guarantee semantics remain host/backend-owned.
- Firestore persistence remains host-owned.

## Risk Verdict

The wave avoided the major failure mode from earlier movement-first extraction by moving to semantic-freeze-first and additive-split execution.
