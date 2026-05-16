import 'governance_compliance_block_reason.dart';
import 'governance_compliance_profile.dart';

class GovernanceComplianceGuard {
  const GovernanceComplianceGuard();

  GovernanceComplianceBlockReason? blockReason(
    GovernanceComplianceProfile profile,
  ) {
    if (profile.policy.policyVersion != profile.auditLink.policyVersion) {
      return GovernanceComplianceBlockReason.policyMismatch;
    }
    if (!profile.policy.runtimeAllowed &&
        profile.marker.runtimeMode != 'disabled') {
      return GovernanceComplianceBlockReason.runtimeDisabled;
    }
    if (!profile.policy.providerAllowed &&
        profile.marker.providerId.trim().isNotEmpty) {
      return GovernanceComplianceBlockReason.providerBlocked;
    }
    if (profile.requirement.auditLinkRequired && !profile.auditLink.isLinked) {
      return GovernanceComplianceBlockReason.missingAuditLink;
    }
    if (profile.requirement.reviewMarkerRequired &&
        profile.reviewMarker.reviewRequired) {
      return GovernanceComplianceBlockReason.reviewRequired;
    }
    if (profile.policy.restrictedEnvironments.contains(
      profile.marker.environment,
    )) {
      return GovernanceComplianceBlockReason.restrictedEnvironment;
    }
    if (!profile.policy.allowedVisibilityScopes.contains(
      profile.visibilityScope,
    )) {
      return GovernanceComplianceBlockReason.complianceRestricted;
    }
    if (profile.requirement.legalDisclaimerRequired &&
        !profile.legalDisclaimerPresent) {
      return GovernanceComplianceBlockReason.missingLegalDisclaimer;
    }
    if (profile.policy.backendGovernanceRequired &&
        !profile.marker.backendGoverned) {
      return GovernanceComplianceBlockReason.complianceRestricted;
    }
    if (profile.policy.failClosed) {
      return GovernanceComplianceBlockReason.failClosed;
    }
    return null;
  }
}
