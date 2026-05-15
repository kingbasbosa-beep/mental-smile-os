import 'runtime_readiness_block_reason.dart';
import 'runtime_readiness_manifest.dart';

class RuntimeReadinessGuard {
  const RuntimeReadinessGuard();

  RuntimeReadinessBlockReason? blockReason(
    RuntimeReadinessManifest manifest,
  ) {
    if (manifest.lock.locked || manifest.lock.sealed) {
      return RuntimeReadinessBlockReason.readinessLocked;
    }
    if (manifest.requirement.signedAuthorityRequired &&
        !manifest.hasSignedAuthority) {
      return RuntimeReadinessBlockReason.missingAuthority;
    }
    if (manifest.requirement.policyLinkRequired &&
        manifest.policy.policyVersion != manifest.auditLink.policyVersion) {
      return RuntimeReadinessBlockReason.policyMismatch;
    }
    if (!manifest.policy.runtimeAllowed &&
        manifest.runtimeMarker.runtimeMode != 'disabled') {
      return RuntimeReadinessBlockReason.runtimeDisabled;
    }
    if (!manifest.policy.providerAllowed &&
        manifest.runtimeMarker.providerId.trim().isNotEmpty) {
      return RuntimeReadinessBlockReason.unsafeActivation;
    }
    if (manifest.reviewMarker.reviewRequired) {
      return RuntimeReadinessBlockReason.reviewRequired;
    }
    if (manifest.policy.restrictedEnvironments.contains(
      manifest.runtimeMarker.environment,
    )) {
      return RuntimeReadinessBlockReason.restrictedEnvironment;
    }
    if (manifest.requirement.auditLinkRequired &&
        !manifest.auditLink.isLinked) {
      return RuntimeReadinessBlockReason.missingAuditLink;
    }
    if (!manifest.references.every((reference) => reference.isLinked) ||
        !manifest.references.every(
          (reference) => manifest.policy.allowedScopes.contains(
            reference.scope,
          ),
        ) ||
        !manifest.policy.allowedVisibilityScopes.contains(
          manifest.visibilityScope,
        ) ||
        (manifest.policy.backendGovernanceRequired &&
            !manifest.runtimeMarker.backendGoverned)) {
      return RuntimeReadinessBlockReason.unsafeActivation;
    }
    if (manifest.policy.failClosed) {
      return RuntimeReadinessBlockReason.failClosed;
    }
    return null;
  }
}
