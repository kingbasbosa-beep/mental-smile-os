# SIGNAL_OWNERSHIP_MODEL_V1

Status: REGISTERED

## Ownership Doctrine

Signals belong to source zones.

Forwarding does not transfer ownership.

## Ownership Rules

- Source zone owns the original signal.
- Local gateway does not own the signal.
- Pipe does not own the signal.
- Target gateway does not own the original signal.
- Target zone may produce a new response signal; the response belongs to the target zone.
- Archive stores a snapshot but does not own the active source signal.
- Monitoring owns observations, not source signal authority.
- Strategic owns summaries, not source signal authority.

## Required Ownership Fields

- Source Zone.
- Source Component.
- Signal Family.
- Signal Owner.
- Gateway Custodian.
- Target Consumer if applicable.
- Archive Custodian if archived.

## Ownership Violation

Any target, gateway, archive, monitoring, or strategic component claiming source ownership violates this model.
