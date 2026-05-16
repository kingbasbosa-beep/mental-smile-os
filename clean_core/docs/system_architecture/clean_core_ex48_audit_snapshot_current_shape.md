# EX-48 Audit Snapshot Current Shape

Phase: EX-48 - audit_snapshot Split Design

## Scope

This document reviews the current shape of:

- `clean_core/lib/core/audit/audit_snapshot.dart`

No source files were modified, no imports were changed, no exports were changed, no dependencies were added, and no runtime systems were activated.

## Current Imports

Current imports:

- `package:cloud_firestore/cloud_firestore.dart`
- `audit_visibility_scope.dart`

## Current Class

Current class:

- `AuditSnapshot`

## Pure Model Fields

Pure fields:

- `snapshotId`
- `policyVersion`
- `createdBy`
- `hashPlaceholder`
- `visibilityScope`
- `immutable`
- `createdAt`

## Firestore-Coupled Logic

Firestore-only logic:

- `toMap({bool useServerTimestamp = false})`
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate(...)`
- private `_timestampOrNull(DateTime? value)`

## Current Shape Finding

`AuditSnapshot` is currently a mixed model-plus-Firestore-mapper class. Its data fields are pure, but its serialization logic is not package-safe.

