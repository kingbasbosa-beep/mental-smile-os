import 'package:cloud_firestore/cloud_firestore.dart';

import '../audit_snapshot.dart';
import '../audit_visibility_scope.dart';

class AuditSnapshotFirestoreMapper {
  const AuditSnapshotFirestoreMapper._();

  static Map<String, Object?> toFirestoreMap(
    AuditSnapshot snapshot, {
    bool useServerTimestamp = false,
  }) {
    return {
      'snapshotId': snapshot.snapshotId,
      'policyVersion': snapshot.policyVersion,
      'createdBy': snapshot.createdBy,
      'hashPlaceholder': snapshot.hashPlaceholder,
      'visibilityScope': snapshot.visibilityScope.key,
      'immutable': snapshot.immutable,
      'createdAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(snapshot.createdAt),
    };
  }

  static AuditSnapshot fromFirestoreMap(
    Map<String, Object?> map,
  ) {
    return AuditSnapshot(
      snapshotId: map['snapshotId'] as String? ?? '',
      policyVersion: map['policyVersion'] as String? ?? '',
      createdBy: map['createdBy'] as String? ?? '',
      hashPlaceholder: map['hashPlaceholder'] as String? ?? '',
      visibilityScope: _visibilityScopeOrDefault(map['visibilityScope']),
      immutable: map['immutable'] as bool? ?? false,
      createdAt: _dateTimeOrNull(map['createdAt']),
    );
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }

  static DateTime? _dateTimeOrNull(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }

  static AuditVisibilityScope _visibilityScopeOrDefault(Object? value) {
    if (value is AuditVisibilityScope) return value;
    if (value is String) {
      for (final scope in AuditVisibilityScope.values) {
        if (scope.key == value) return scope;
      }
    }
    return AuditVisibilityScope.privateUser;
  }
}
