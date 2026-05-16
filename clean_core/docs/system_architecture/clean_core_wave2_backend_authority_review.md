# clean_core Wave 2 Backend Authority Review

This review defines backend-owned authority boundaries for Wave 2.

## Backend-Owned Authority

The backend owns:

- trusted execution
- signed operations
- protected field decisions
- privileged writes
- moderation execution
- AI execution approval
- provider execution approval
- escalation execution
- policy publication
- runtime activation

## Candidate Backend-Boundary Contracts

Potential future contract-only candidates:

- audit references
- review markers
- escalation request/queue state
- signed-operation placeholders
- blocked/fallback result shapes
- visibility scopes

## Backend Blockers

Do not extract or expose any file that:

- grants authority locally
- approves protected writes
- performs moderation execution
- resolves escalation as final authority
- signs operations
- executes provider/runtime work

## Backend Authority Verdict

Wave 2 may extract backend-boundary language only if it remains declarative. Backend authority must not move into clean_core.
