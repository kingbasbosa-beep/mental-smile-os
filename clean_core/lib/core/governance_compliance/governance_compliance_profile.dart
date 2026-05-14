import 'governance_compliance_audit_link.dart';
import 'governance_compliance_marker.dart';
import 'governance_compliance_policy.dart';
import 'governance_compliance_reference.dart';
import 'governance_compliance_requirement.dart';
import 'governance_compliance_review_marker.dart';
import 'governance_compliance_state.dart';
import 'governance_compliance_visibility_scope.dart';

class GovernanceComplianceProfile {
  const GovernanceComplianceProfile({
    required this.profileId,
    required this.state,
    required this.visibilityScope,
    required this.policy,
    required this.requirement,
    required this.marker,
    required this.reviewMarker,
    required this.references,
    required this.auditLink,
    required this.legalDisclaimerPresent,
  });

  static const GovernanceComplianceProfile restrictedDefault =
      GovernanceComplianceProfile(
    profileId: 'restricted_compliance_default',
    state: GovernanceComplianceState.restricted,
    visibilityScope: GovernanceComplianceVisibilityScope.restrictedReview,
    policy: GovernanceCompliancePolicy.safeDefault,
    requirement: GovernanceComplianceRequirement.safeDefault,
    marker: GovernanceComplianceMarker.safeDefault,
    reviewMarker: GovernanceComplianceReviewMarker.safeDefault,
    references: <GovernanceComplianceReference>[],
    auditLink: GovernanceComplianceAuditLink(
      auditId: '',
      traceHash: '',
      policyVersion: '2026-05-os5c',
    ),
    legalDisclaimerPresent: false,
  );

  final String profileId;
  final GovernanceComplianceState state;
  final GovernanceComplianceVisibilityScope visibilityScope;
  final GovernanceCompliancePolicy policy;
  final GovernanceComplianceRequirement requirement;
  final GovernanceComplianceMarker marker;
  final GovernanceComplianceReviewMarker reviewMarker;
  final List<GovernanceComplianceReference> references;
  final GovernanceComplianceAuditLink auditLink;
  final bool legalDisclaimerPresent;
}
