# Clean Core Policy Integrity Verifier

Draft integrity verification expectations for future policy governance.

## Purpose

The future integrity verifier should detect whether a policy, rule chain, snapshot, or capability decision can be trusted before any runtime-adjacent action is considered.

## Verification Expectations

Detect:

- Policy tampering.
- Unsigned policy.
- Invalid rule chain.
- Stale snapshot.
- Missing audit link.
- Unauthorized capability.
- Environment mismatch.
- Provider mismatch.
- Missing review marker.
- Missing backend authority.

## Failure Response

If verification fails:

- Fail closed.
- Deny execution.
- Require review or escalation where appropriate.
- Preserve backend authority.
- Preserve audit requirement.
- Do not activate runtime/provider systems.

## Future Inputs

- Policy snapshot reference.
- Policy version.
- Runtime environment marker.
- Audit link.
- Review marker.
- Capability request.
- Provider governance reference.
- Backend authority marker.

## Must Not Do

The integrity verifier must not:

- Repair policy silently.
- Create authority locally.
- Fetch policy from network directly inside clean_core.
- Execute runtime behavior.
- Execute provider behavior.

## Explicit Non-Action

No verifier was implemented.
