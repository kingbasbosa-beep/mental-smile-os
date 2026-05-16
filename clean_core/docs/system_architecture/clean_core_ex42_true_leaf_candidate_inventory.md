# EX-42 True Leaf Candidate Inventory

Phase: EX-42 - True Leaf Extraction Review

## Scope

This review covers only the following possible true leaf candidates:

- `clean_core/lib/core/audit/audit_hash_placeholder.dart`
- `clean_core/lib/core/audit/audit_redaction.dart`
- `clean_core/lib/core/audit/audit_retention_policy.dart`

No files were moved, imports were modified, exports were changed, dependencies were added, or runtime systems were activated.

## Candidate: `audit_hash_placeholder.dart`

Defines:

- `AuditHashPlaceholder`
- `AuditHashPlaceholder.fromSeed(String seed)`

Import posture:

- no imports
- no exports
- no local sibling dependency
- no external package dependency

## Candidate: `audit_redaction.dart`

Defines:

- `AuditRedaction`
- `AuditRedaction.forbiddenFields`
- `AuditRedaction.sanitizedPreview(...)`
- `AuditRedaction.removeForbiddenFields(...)`

Import posture:

- no imports
- no exports
- no local sibling dependency
- no external package dependency

## Candidate: `audit_retention_policy.dart`

Defines:

- `AuditRetentionPolicy`
- `AuditRetentionPolicy.shortTermTrace`
- `AuditRetentionPolicy.governanceSnapshot`

Import posture:

- no imports
- no exports
- no local sibling dependency
- no external package dependency

## Inventory Finding

All three reviewed candidates are structurally leaf-like by import posture.

