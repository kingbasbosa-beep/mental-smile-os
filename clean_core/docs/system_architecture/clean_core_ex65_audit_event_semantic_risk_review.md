# EX-65 AuditEvent Semantic Risk Review

## Authority Caveats

- Actor labels do not prove identity, role, privilege, or backend authority.
- `policyVersion` is a reference label only and does not prove enforcement.
- `AuditProcessingContext` does not prove runtime execution or provider guarantees.

## Privacy Caveats

- `sanitizedPreview` must remain caller-provided metadata and must not imply safe redaction.
- `AuditReference` values are metadata only and can expose identifiers if misused.
- `visibilityScope` does not enforce access control or disclosure policy.

## Runtime Caveats

- Event type labels such as runtime-disabled or provider-rejected are vocabulary only.
- Severity labels do not trigger escalation or queueing.
- The package model must not activate observability, telemetry, moderation, review, or provider workflows.

## Remaining Risk

The split is higher risk than `audit_snapshot` because it contains nested references, actor metadata, event severity, processing context, and preview text. These risks are manageable only if mapping and interpretation stay host/backend-owned.

## Verdict

Semantic risk is acceptable for future controlled split with explicit caveats.
