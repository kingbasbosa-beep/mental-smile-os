import 'runtime_readiness_audit_link.dart';
import 'runtime_readiness_lock.dart';
import 'runtime_readiness_policy.dart';
import 'runtime_readiness_reference.dart';
import 'runtime_readiness_requirement.dart';
import 'runtime_readiness_review_marker.dart';
import 'runtime_readiness_runtime_marker.dart';
import 'runtime_readiness_scope.dart';
import 'runtime_readiness_state.dart';
import 'runtime_readiness_visibility_scope.dart';

class RuntimeReadinessManifest {
  const RuntimeReadinessManifest({
    required this.manifestId,
    required this.state,
    required this.visibilityScope,
    required this.policy,
    required this.requirement,
    required this.references,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.lock,
    required this.signedAuthorityPlaceholder,
  });

  static const RuntimeReadinessManifest lockedDefault =
      RuntimeReadinessManifest(
    manifestId: 'locked_runtime_readiness_default',
    state: RuntimeReadinessState.locked,
    visibilityScope: RuntimeReadinessVisibilityScope.governanceInternal,
    policy: RuntimeReadinessPolicy.safeDefault,
    requirement: RuntimeReadinessRequirement.safeDefault,
    references: <RuntimeReadinessReference>[
      RuntimeReadinessReference(
        referenceId: 'governance_systems_reference',
        scope: RuntimeReadinessScope.governanceSystems,
        hashPlaceholder: 'runtime_readiness_hash_placeholder',
      ),
    ],
    runtimeMarker: RuntimeReadinessRuntimeMarker.disabled,
    auditLink: RuntimeReadinessAuditLink(
      auditId: '',
      traceHash: '',
      policyVersion: '2026-05-os6e',
    ),
    reviewMarker: RuntimeReadinessReviewMarker.safeDefault,
    lock: RuntimeReadinessLock.safeDefault,
    signedAuthorityPlaceholder: '',
  );

  final String manifestId;
  final RuntimeReadinessState state;
  final RuntimeReadinessVisibilityScope visibilityScope;
  final RuntimeReadinessPolicy policy;
  final RuntimeReadinessRequirement requirement;
  final List<RuntimeReadinessReference> references;
  final RuntimeReadinessRuntimeMarker runtimeMarker;
  final RuntimeReadinessAuditLink auditLink;
  final RuntimeReadinessReviewMarker reviewMarker;
  final RuntimeReadinessLock lock;
  final String signedAuthorityPlaceholder;

  bool get hasSignedAuthority {
    return signedAuthorityPlaceholder.trim().isNotEmpty;
  }
}
