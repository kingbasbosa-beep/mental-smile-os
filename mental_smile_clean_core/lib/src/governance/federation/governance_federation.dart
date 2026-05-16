import 'governance_federation_audit_link.dart';
import 'governance_federation_lock.dart';
import 'governance_federation_policy.dart';
import 'governance_federation_reference.dart';
import 'governance_federation_requirement.dart';
import 'governance_federation_review_marker.dart';
import 'governance_federation_runtime_marker.dart';
import 'governance_federation_scope.dart';
import 'governance_federation_state.dart';
import 'governance_federation_visibility_scope.dart';

class GovernanceFederation {
  const GovernanceFederation({
    required this.federationId,
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

  static const GovernanceFederation sealedDefault = GovernanceFederation(
    federationId: 'sealed_federation_default',
    state: GovernanceFederationState.sealed,
    visibilityScope: GovernanceFederationVisibilityScope.governanceInternal,
    policy: GovernanceFederationPolicy.safeDefault,
    requirement: GovernanceFederationRequirement.safeDefault,
    references: <GovernanceFederationReference>[
      GovernanceFederationReference(
        referenceId: 'governance_kernel_reference',
        scope: GovernanceFederationScope.governanceKernel,
        hashPlaceholder: 'governance_federation_hash_placeholder',
      ),
    ],
    runtimeMarker: GovernanceFederationRuntimeMarker.disabled,
    auditLink: GovernanceFederationAuditLink(
      auditId: '',
      traceHash: '',
      policyVersion: '2026-05-os6d',
    ),
    reviewMarker: GovernanceFederationReviewMarker.safeDefault,
    lock: GovernanceFederationLock.safeDefault,
    signedAuthorityPlaceholder: '',
  );

  final String federationId;
  final GovernanceFederationState state;
  final GovernanceFederationVisibilityScope visibilityScope;
  final GovernanceFederationPolicy policy;
  final GovernanceFederationRequirement requirement;
  final List<GovernanceFederationReference> references;
  final GovernanceFederationRuntimeMarker runtimeMarker;
  final GovernanceFederationAuditLink auditLink;
  final GovernanceFederationReviewMarker reviewMarker;
  final GovernanceFederationLock lock;
  final String signedAuthorityPlaceholder;

  bool get hasSignedAuthority {
    return signedAuthorityPlaceholder.trim().isNotEmpty;
  }
}
