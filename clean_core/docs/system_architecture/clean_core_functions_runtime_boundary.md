# Clean Core Functions Runtime Boundary

Draft Cloud Functions boundary plan.

## Boundary Principle

Cloud Functions and backend orchestration remain backend-owned. clean_core defines contracts only.

## Backend-Owned Runtime

Backend systems own:

- Cloud Functions implementation.
- Signed operation validation.
- Firestore privileged writes.
- Provider execution.
- AI runtime orchestration.
- Escalation creation and transitions.
- Notification dispatch.
- Aggregate updates.
- Audit event creation.

## clean_core Contracts

clean_core may define:

- Trusted operation contracts.
- Backend-governed action shapes.
- Protected governance field definitions.
- Escalation boundary contracts.
- AI governance boundary contracts.
- Booking lifecycle boundary contracts.
- Audit/reference contracts.

## Not Allowed In clean_core

- Cloud Functions runtime execution.
- Provider SDK calls.
- Network calls.
- AI execution.
- Firestore privileged writes.
- Notification dispatch.
- Deployment logic.
- Signed authority implementation.

## Failure Expectations

If backend is unavailable:

- Fail closed.
- Preserve review-required state.
- Do not fallback to client-side governance.
- Do not perform direct privileged writes.
- Do not activate runtime/provider systems.

## Explicit Non-Action

No Cloud Functions code or runtime bridge was implemented.
