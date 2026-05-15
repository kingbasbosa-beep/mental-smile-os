# Clean Core Extraction Dry-Run Plan

Draft conceptual dry-run plan. No extraction, file movement, import rewrite, package change, adapter implementation, runtime activation, Firebase setup, provider integration, or command execution was performed.

## Dry-Run Principle

The dry run should simulate extraction decisions before any package movement. It should prove that pure contracts can be isolated conceptually while host app ownership, adapter boundaries, fail-closed behavior, and deny-by-default runtime posture remain intact.

## Dry-Run Goals

- Simulate extracting pure contracts first.
- Preserve host-app ownership of Firebase, routing, UI, generated files, assets, and platform setup.
- Preserve adapter-only reconnect boundaries.
- Preserve fail-closed and deny-by-default defaults.
- Avoid generated/runtime contamination.
- Keep runtime AI disabled.
- Keep provider execution blocked.

## Dry-Run Inputs

- Export contamination audit.
- Import graph audit.
- Public API inventory and classification.
- Adapter boundary plans.
- Firebase boundary plans.
- Routing/l10n/assets boundary plans.
- Test split and emulator boundary plans.
- Pre-extraction freeze checklist.

## Dry-Run Outputs

- Export candidate list.
- App-owned exclusion list.
- Adapter-required list.
- Stop-condition checklist.
- Rollback checkpoint list.
- Reconnect sequence confirmation.

## Explicit Non-Action

This document is planning-only and does not perform a dry run with tooling.
