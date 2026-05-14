import 'runtime_environment_audit_reference.dart';
import 'runtime_environment_lock.dart';
import 'runtime_environment_marker.dart';
import 'runtime_environment_policy.dart';
import 'runtime_environment_restriction.dart';
import 'runtime_environment_type.dart';

class RuntimeEnvironmentProfile {
  const RuntimeEnvironmentProfile({
    required this.profileId,
    required this.environmentType,
    required this.marker,
    required this.restriction,
    required this.policy,
    required this.lock,
    this.auditReference,
  });

  final String profileId;
  final RuntimeEnvironmentType environmentType;
  final RuntimeEnvironmentMarker marker;
  final RuntimeEnvironmentRestriction restriction;
  final RuntimeEnvironmentPolicy policy;
  final RuntimeEnvironmentLock lock;
  final RuntimeEnvironmentAuditReference? auditReference;
}
