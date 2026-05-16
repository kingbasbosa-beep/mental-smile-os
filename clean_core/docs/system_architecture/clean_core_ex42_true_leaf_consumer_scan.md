# EX-42 True Leaf Consumer Scan

Phase: EX-42 - True Leaf Extraction Review

## Scan Scope

Consumer scan looked for references to:

- `AuditHashPlaceholder`
- `AuditHashPlaceholder.fromSeed`
- `audit_hash_placeholder`
- `AuditRedaction`
- `AuditRedaction.forbiddenFields`
- `AuditRedaction.sanitizedPreview`
- `AuditRedaction.removeForbiddenFields`
- `AuditRetentionPolicy`
- `AuditRetentionPolicy.shortTermTrace`
- `AuditRetentionPolicy.governanceSnapshot`

Search areas:

- `clean_core/lib`
- `clean_core/test`
- `mental_smile_clean_core/lib`

## `AuditHashPlaceholder` Findings

No consumer was identified outside its own declaration file.

Note: unrelated `fromSeed` usage exists in UI theme code, but it is not a reference to `AuditHashPlaceholder.fromSeed`.

## `AuditRedaction` Findings

No consumer was identified outside its own declaration file.

Note: similar redaction member names exist in other safety utilities, but they are not references to `AuditRedaction`.

## `AuditRetentionPolicy` Findings

No consumer was identified outside its own declaration file.

## Consumer Classification

| Candidate | Consumer status |
| --- | --- |
| `audit_hash_placeholder.dart` | no consumers found |
| `audit_redaction.dart` | no consumers found |
| `audit_retention_policy.dart` | no consumers found |

## Consumer Scan Finding

The three candidates currently appear to be true leaves by consumer scan. Movement would not break known remaining clean_core consumers.

