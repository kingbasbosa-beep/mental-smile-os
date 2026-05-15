import 'secure_runtime_audit_link.dart';
import 'secure_runtime_lock.dart';
import 'secure_runtime_policy.dart';
import 'secure_runtime_reference.dart';
import 'secure_runtime_requirement.dart';
import 'secure_runtime_review_marker.dart';
import 'secure_runtime_runtime_marker.dart';
import 'secure_runtime_scope.dart';
import 'secure_runtime_state.dart';
import 'secure_runtime_visibility_scope.dart';

class SecureRuntimeEnvelope {
  const SecureRuntimeEnvelope({
    required this.envelopeId,
    required this.state,
    required this.visibilityScope,
    required this.policy,
    required this.requirement,
    required this.reference,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.lock,
    required this.signedAuthorityPlaceholder,
  });

  static const SecureRuntimeEnvelope sealedDefault = SecureRuntimeEnvelope(
    envelopeId: 'sealed_default',
    state: SecureRuntimeState.sealed,
    visibilityScope: SecureRuntimeVisibilityScope.governanceInternal,
    policy: SecureRuntimePolicy.safeDefault,
    requirement: SecureRuntimeRequirement.safeDefault,
    reference: SecureRuntimeReference(
      referenceId: 'sealed_runtime_reference',
      scope: SecureRuntimeScope.governance,
      hashPlaceholder: 'secure_runtime_hash_placeholder',
    ),
    runtimeMarker: SecureRuntimeRuntimeMarker.disabled,
    auditLink: SecureRuntimeAuditLink(
      auditId: '',
      traceHash: '',
      policyVersion: '2026-05-os6c',
    ),
    reviewMarker: SecureRuntimeReviewMarker.safeDefault,
    lock: SecureRuntimeLock.safeDefault,
    signedAuthorityPlaceholder: '',
  );

  final String envelopeId;
  final SecureRuntimeState state;
  final SecureRuntimeVisibilityScope visibilityScope;
  final SecureRuntimePolicy policy;
  final SecureRuntimeRequirement requirement;
  final SecureRuntimeReference reference;
  final SecureRuntimeRuntimeMarker runtimeMarker;
  final SecureRuntimeAuditLink auditLink;
  final SecureRuntimeReviewMarker reviewMarker;
  final SecureRuntimeLock lock;
  final String signedAuthorityPlaceholder;

  bool get hasSignedAuthority {
    return signedAuthorityPlaceholder.trim().isNotEmpty;
  }
}
