import 'governance_capability_audit_link.dart';
import 'governance_capability_reference.dart';
import 'governance_capability_requirement.dart';
import 'governance_capability_review_marker.dart';
import 'governance_capability_runtime_marker.dart';
import 'governance_capability_scope.dart';
import 'governance_capability_state.dart';
import 'governance_capability_visibility_scope.dart';

class GovernanceCapability {
  const GovernanceCapability({
    required this.capabilityId,
    required this.state,
    required this.scope,
    required this.visibilityScope,
    required this.policyVersion,
    required this.requirement,
    required this.reference,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
  });

  static const GovernanceCapability blockedDefault = GovernanceCapability(
    capabilityId: 'blocked_capability_default',
    state: GovernanceCapabilityState.unavailable,
    scope: GovernanceCapabilityScope.auditSystem,
    visibilityScope: GovernanceCapabilityVisibilityScope.governanceInternal,
    policyVersion: '2026-05-os5e',
    requirement: GovernanceCapabilityRequirement.safeDefault,
    reference: GovernanceCapabilityReference(
      referenceId: 'blocked_capability_reference',
      scope: GovernanceCapabilityScope.auditSystem,
      hashPlaceholder: 'governance_capability_hash_placeholder',
    ),
    runtimeMarker: GovernanceCapabilityRuntimeMarker.disabled,
    auditLink: GovernanceCapabilityAuditLink(
      auditId: '',
      traceHash: '',
      policyVersion: '2026-05-os5e',
    ),
    reviewMarker: GovernanceCapabilityReviewMarker.safeDefault,
  );

  final String capabilityId;
  final GovernanceCapabilityState state;
  final GovernanceCapabilityScope scope;
  final GovernanceCapabilityVisibilityScope visibilityScope;
  final String policyVersion;
  final GovernanceCapabilityRequirement requirement;
  final GovernanceCapabilityReference reference;
  final GovernanceCapabilityRuntimeMarker runtimeMarker;
  final GovernanceCapabilityAuditLink auditLink;
  final GovernanceCapabilityReviewMarker reviewMarker;
}
