# EX-68 AuditTrace Dependency Review

## Direct Dependencies

`audit_trace.dart` imports:

- `package:cloud_firestore/cloud_firestore.dart`
- `audit_reference.dart`
- `audit_runtime_marker.dart`

## Package-Safe Existing Counterparts

The package already contains:

- `AuditReference`
- `AuditProcessingContext`
- audit vocabulary contracts

## Missing Package-Safe Equivalent

`audit_trace.dart` currently depends on host-side `AuditRuntimeMarker`. A package-safe future model should not expose `AuditRuntimeMarker`; it should use `AuditProcessingContext`, with translation owned by a host-side mapper.

## Consumer Map

Search results found:

- `clean_core/lib/core/audit/audit_trace.dart` defines `AuditTrace`.
- No direct class consumers of `AuditTrace` were found in `clean_core` or `mental_smile_clean_core`.
- Non-class textual mentions were found in `mental_smile_clean_core/lib/src/backend_boundaries/ai_governance_boundary.dart` and `clean_core/lib/core/ai_runtime/ai_runtime_capability.dart`, but these are string/vocabulary references rather than imports or typed consumers.

## Sibling Import Risk

Current dependencies are sibling relative imports. Direct movement would break those local relationships and would risk recreating the earlier Wave 2 consumer breakage pattern.

## Package Import Risk

Importing `mental_smile_clean_core` from `clean_core/lib/core` remains unsafe as a default strategy during this lane. The safer approach is additive split plus host-side mapper, not reconnect-first imports.
