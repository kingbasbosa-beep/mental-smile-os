# Clean Core Extraction Rollback Strategy

Draft rollback strategy for future extraction. No extraction was performed.

## Rollback Principle

Every extraction phase should have a clear rollback checkpoint before files are moved, imports are rewritten, or the host app reconnects to an extracted package.

## Checkpoints

### Checkpoint 0: Before Package Creation

- Import graph verified.
- Export candidates reviewed.
- App-owned exclusions documented.
- Host app unchanged.

Rollback: abandon package creation plan; docs remain useful.

### Checkpoint 1: After Pure Contract Extraction

- Pure contract package builds independently.
- Host app can still use original source path or temporary local link.
- No app-owned runtime moved.

Rollback: point host app back to original clean_core source and remove package link.

### Checkpoint 2: After Governance Contract Extraction

- Runtime/provider governance remains inert.
- No runtime execution activated.
- Host app still owns Firebase, UI, routing, generated files.

Rollback: revert dependency link and keep governance contracts in app source until reviewed.

### Checkpoint 3: After Adapter Contract Extraction

- Adapter interfaces exist.
- Implementations remain host-app owned.
- No network/provider/Firebase runtime moved into package.

Rollback: keep adapter contracts in host app and disable extracted package dependency.

### Checkpoint 4: After Host Reconnect

- Host app reconnects through adapters.
- Tests/manual checks confirm behavior.
- Runtime systems remain disabled.

Rollback: revert adapter wiring and dependency link; keep legacy app-owned implementation path.

## Temporary Dual-Link Strategy

During extraction, maintain a short-lived compatibility path:

- Host app may reference local package dependency.
- Original app-owned implementation remains until reconnect is verified.
- Avoid deleting legacy modules during initial extraction.

## Partial Extraction Recovery

If a phase fails:

- Stop before the next phase.
- Reclassify failed files as app-owned or adapter-required.
- Keep pure contracts extracted only if stable.
- Do not activate runtime systems as a workaround.

## Explicit Non-Action

No rollback action was performed because no extraction was performed.
