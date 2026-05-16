# EX-51 Audit Snapshot Compatibility Strategy

Phase: EX-51 - audit_snapshot Controlled Split Execution Review

## Key Question

How do we split without breaking existing consumers of:

- `clean_core/lib/core/audit/audit_snapshot.dart`

## Recommended Compatibility Strategy

Keep the existing file path temporarily.

Recommended future role:

- host-side compatibility wrapper or mapper-facing facade

## Why Not Remove It Immediately

Removing or moving the existing file would break any consumer still importing:

```dart
import 'audit_snapshot.dart';
```

The consumer topology lesson from Wave 2 shows that movement-first extraction causes analyzer breakage when sibling consumers remain.

## Compatibility Options

### Option 1 - Temporary Compatibility Wrapper

`clean_core/lib/core/audit/audit_snapshot.dart` remains as a host-side wrapper that preserves current import path.

Pros:

- avoids consumer breakage
- allows mapper introduction
- supports staged migration

Cons:

- temporary duplication/bridge semantics must be removed later

### Option 2 - Host-Side Alias/Re-Export

The existing file could re-export or alias the package model later.

Risk:

- package import behavior must be proven safe first

### Option 3 - Mapper Import Boundary

Existing consumers migrate to mapper-specific imports later.

Risk:

- requires consumer migration and careful authority review

## Compatibility Verdict

Use Option 1 first: temporary compatibility wrapper/facade. Do not remove the existing source file during initial split execution.

