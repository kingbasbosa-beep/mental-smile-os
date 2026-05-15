# Clean Core Extraction Failure Simulation

Draft failure simulation plan.

## Firebase Unavailable

Expected response:

- Stop Firebase-dependent reconnect.
- Keep protected fields backend-owned.
- Do not fallback to privileged client writes.
- Review Firebase adapter boundary.

## Adapter Missing

Expected response:

- Fail closed.
- Mark operation adapter-unavailable.
- Do not access host runtime directly from clean_core.
- Review adapter plan.

## Generated-File Leakage

Expected response:

- Stop extraction.
- Reclassify leaking file as app-owned or adapter-required.
- Remove from export candidate list.
- Review generated-file boundary.

## Runtime Activation Detected

Expected response:

- Stop immediately.
- Roll back activation-related changes.
- Review governance/fail-closed posture.
- Confirm runtime disabled defaults.

## Provider SDK Leakage

Expected response:

- Stop extraction.
- Remove SDK dependency from clean_core surface.
- Reclassify as host/backend-owned provider bridge implementation.

## BuildContext Contamination

Expected response:

- Stop export of affected contract.
- Reclassify as UI/app-owned or route-intent adapter candidate.
- Review app-shell boundary.

## Rollback Required

Expected response:

- Return host app to previous dependency path.
- Keep extracted contracts only if stable.
- Do not delete app-owned legacy path during recovery.

## Reconnect Failure

Expected response:

- Disable reconnect path.
- Use dual-link fallback.
- Review adapter ownership and host responsibilities.

## Privileged Client Writes Introduced

Expected response:

- Stop immediately.
- Roll back write path.
- Restore backend-governed authority.
- Review Firestore authority model.

## Explicit Non-Action

No failure scenarios were executed.
