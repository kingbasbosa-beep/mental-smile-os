# Clean Core Extraction Authorization Summary

Draft authorization expectations for future extraction.

## Required Reviews Before Extraction

Future extraction requires:

- Manual architecture review.
- Governance review.
- Contamination review.
- Public export surface review.
- Adapter boundary review.
- Firebase boundary review.
- App-shell boundary review.
- Reconnect review.
- Rollback review.
- Security/fail-closed review.

## Required Conditions

Extraction may proceed only if:

- Runtime/provider execution remains disabled.
- Backend authority remains preserved.
- No privileged client writes are introduced.
- No Firebase setup enters clean_core.
- No generated files become public clean_core API.
- No Flutter UI/app-shell ownership enters export-safe contracts.
- No provider SDKs or networking enter clean_core.
- Adapter implementations remain host/backend owned.

## Stop Conditions

Stop extraction if:

- Parent-path import leakage appears.
- Generated-file leakage appears.
- Firebase/provider SDK leakage appears.
- Runtime activation appears.
- `BuildContext` or router ownership contaminates pure contracts.
- Fail-closed or deny-by-default posture is weakened.
- Privileged client writes are introduced.

## Authorization Note

This document is not an execution approval. It records the future conditions required before extraction can be attempted.
