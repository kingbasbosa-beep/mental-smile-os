# Clean Core Pre-Extraction Freeze Checklist

Draft freeze checklist for future extraction. No extraction, package movement, import rewrite, adapter implementation, runtime activation, Firebase setup, provider integration, or command execution was performed.

## Freeze Checklist

Before extraction, verify:

- Import graph is stable.
- No parent-path leakage exists.
- No `../lib` or legacy app package imports exist in export-safe files.
- Adapter boundary documentation is complete.
- Firebase boundary documentation is complete.
- Routing, localization, generated-file, and asset boundaries are complete.
- Public API inventory is complete.
- Exportable contract classification is complete.
- Extraction sequencing is complete.
- Rollback strategy is documented.
- Reconnect strategy is documented.
- App-owned responsibilities are documented.
- Fail-closed defaults are preserved.
- Deny-by-default runtime posture is preserved.
- No accidental runtime activation exists.
- No provider SDK contamination exists.
- No generated-file public exports exist.
- No Firebase setup is owned by clean_core.
- No Flutter UI or `BuildContext` dependency exists in export-safe contracts.

## Freeze Meaning

Freeze means no new extraction-risk dependencies should be introduced into export-safe areas until package extraction planning resumes.

## Explicit Non-Action

This checklist does not perform extraction or validation.
