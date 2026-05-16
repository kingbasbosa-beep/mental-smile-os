import 'governance_federation.dart';
import 'governance_federation_block_reason.dart';

class GovernanceFederationGuard {
  const GovernanceFederationGuard();

  GovernanceFederationBlockReason? blockReason(
    GovernanceFederation federation,
  ) {
    if (federation.lock.locked || federation.lock.sealed) {
      return GovernanceFederationBlockReason.federationLocked;
    }
    if (federation.requirement.signedAuthorityRequired &&
        !federation.hasSignedAuthority) {
      return GovernanceFederationBlockReason.missingAuthority;
    }
    if (federation.requirement.policyLinkRequired &&
        federation.policy.policyVersion != federation.auditLink.policyVersion) {
      return GovernanceFederationBlockReason.policyMismatch;
    }
    if (!federation.policy.runtimeAllowed &&
        federation.runtimeMarker.runtimeMode != 'disabled') {
      return GovernanceFederationBlockReason.runtimeDisabled;
    }
    if (!federation.policy.providerAllowed &&
        federation.runtimeMarker.providerId.trim().isNotEmpty) {
      return GovernanceFederationBlockReason.unsafeFederation;
    }
    if (federation.reviewMarker.reviewRequired) {
      return GovernanceFederationBlockReason.reviewRequired;
    }
    if (federation.policy.restrictedEnvironments.contains(
      federation.runtimeMarker.environment,
    )) {
      return GovernanceFederationBlockReason.restrictedEnvironment;
    }
    if (federation.requirement.auditLinkRequired &&
        !federation.auditLink.isLinked) {
      return GovernanceFederationBlockReason.missingAuditLink;
    }
    if (!federation.references.every((reference) => reference.isLinked) ||
        !federation.references.every(
          (reference) => federation.policy.allowedScopes.contains(
            reference.scope,
          ),
        ) ||
        !federation.policy.allowedVisibilityScopes.contains(
          federation.visibilityScope,
        ) ||
        (federation.policy.backendGovernanceRequired &&
            !federation.runtimeMarker.backendGoverned)) {
      return GovernanceFederationBlockReason.unsafeFederation;
    }
    if (federation.policy.failClosed) {
      return GovernanceFederationBlockReason.failClosed;
    }
    return null;
  }
}
