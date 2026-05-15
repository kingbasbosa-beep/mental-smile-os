# Clean Core Extraction Execution Prerequisites

Final prerequisites before actual extraction may begin.

## Required Before Extraction

- Manual import scan.
- Final export review.
- Rollback checkpoint creation.
- Staged extraction approval.
- Reconnect freeze verification.
- App-owned verification.
- Adapter-only verification.
- Runtime-deferral verification.
- Firebase boundary verification.
- Routing/localization/assets/generated-file verification.
- Security/fail-closed review.

## Final Stop Conditions

Stop extraction if:

- Parent-path imports are detected in export candidates.
- Legacy package imports are detected in export candidates.
- Firebase SDK/config leakage appears.
- Generated-file leakage appears.
- Flutter UI or `BuildContext` contamination appears in export-safe areas.
- Provider SDK imports appear.
- Networking appears.
- Runtime activation appears.
- Privileged client writes appear.
- Fail-closed posture is broken.
- Deny-by-default posture is broken.
- Backend authority is weakened.

## Required Approvals

- Architecture approval.
- Governance approval.
- Export/API approval.
- Adapter boundary approval.
- Firebase boundary approval.
- Host-app responsibility approval.
- Rollback/reconnect approval.
- Security/fail-closed approval.

## Execution Rule

Extraction must be staged and rollback-ready. Runtime activation is not part of extraction.

## Explicit Non-Action

No extraction prerequisites were executed by tooling.
