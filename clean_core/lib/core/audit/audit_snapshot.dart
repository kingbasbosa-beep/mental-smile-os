import 'package:cloud_firestore/cloud_firestore.dart';

import 'audit_visibility_scope.dart';

class AuditSnapshot {
  const AuditSnapshot({
    required this.snapshotId,
    required this.policyVersion,
    required this.createdBy,
    required this.hashPlaceholder,
    required this.visibilityScope,
    required this.immutable,
    this.createdAt,
  });

  final String snapshotId;
  final String policyVersion;
  final String createdBy;
  final String hashPlaceholder;
  final AuditVisibilityScope visibilityScope;
  final bool immutable;
  final DateTime? createdAt;

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      'snapshotId': snapshotId,
      'policyVersion': policyVersion,
      'createdBy': createdBy,
      'hashPlaceholder': hashPlaceholder,
      'visibilityScope': visibilityScope.key,
      'immutable': immutable,
      'createdAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(createdAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
