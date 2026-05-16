# EX-54 Audit Event Current Shape

Phase: EX-54 - audit_event Split Design

## Scope

This document reviews the current shape of:

- `clean_core/lib/core/audit/audit_event.dart`

No source files were modified, no files were moved, no imports were changed, no exports were changed, no dependencies were added, and no runtime systems were activated.

## Current Imports

Current imports:

- `package:cloud_firestore/cloud_firestore.dart`
- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_reference.dart`
- `audit_runtime_marker.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

## Current Class

Current class:

- `AuditEvent`

## Current Fields

Fields:

- `AuditEventType eventType`
- `AuditSeverity severity`
- `AuditActorType actorType`
- `String actorId`
- `AuditVisibilityScope visibilityScope`
- `String sanitizedPreview`
- `String policyVersion`
- `List<AuditReference> references`
- `AuditRuntimeMarker runtimeMarker`
- `DateTime? createdAt`

## Current Serialization

Current `toMap({bool useServerTimestamp = false})` owns:

- field key naming
- enum key serialization
- reference list serialization
- runtime marker serialization
- server timestamp selection
- timestamp conversion

## Current Shape Finding

`audit_event.dart` is a mixed model-plus-Firestore-mapper class with additional runtime-marker semantics. It is more complex than `audit_snapshot.dart`.

