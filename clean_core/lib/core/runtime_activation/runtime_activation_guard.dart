import 'runtime_activation_block_reason.dart';
import 'runtime_activation_lock.dart';
import 'runtime_activation_policy.dart';
import 'runtime_activation_request.dart';

class RuntimeActivationGuard {
  const RuntimeActivationGuard();

  RuntimeActivationBlockReason? blockReason({
    required RuntimeActivationRequest request,
    RuntimeActivationPolicy policy = RuntimeActivationPolicy.safeDefault,
    RuntimeActivationLock lock = RuntimeActivationLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.activationBlocked) {
      return RuntimeActivationBlockReason.activationLocked;
    }
    if (!policy.activationAllowed) {
      return RuntimeActivationBlockReason.activationBlocked;
    }
    if (request.requirement.signedAuthorityRequired &&
        !request.hasSignedAuthority) {
      return RuntimeActivationBlockReason.missingAuthority;
    }
    if (request.requirement.policyLinkRequired &&
        (request.policyVersion != policy.policyVersion ||
            request.auditLink.policyVersion != policy.policyVersion)) {
      return RuntimeActivationBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed &&
        request.runtimeMarker.runtimeMode != 'disabled') {
      return RuntimeActivationBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        request.runtimeMarker.providerId.trim().isNotEmpty) {
      return RuntimeActivationBlockReason.providerBlocked;
    }
    if (request.reviewMarker.reviewRequired) {
      return RuntimeActivationBlockReason.reviewRequired;
    }
    if (policy.restrictedEnvironments
        .contains(request.runtimeMarker.environment)) {
      return RuntimeActivationBlockReason.restrictedEnvironment;
    }
    if (request.requirement.auditLinkRequired &&
        !request.auditLink.isLinked) {
      return RuntimeActivationBlockReason.missingAuditLink;
    }
    if (!policy.allowedStages.contains(request.stage) ||
        !policy.allowedVisibilityScopes.contains(request.visibilityScope) ||
        !request.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        )) {
      return RuntimeActivationBlockReason.unsafeActivation;
    }
    if (policy.backendGovernanceRequired &&
        !request.runtimeMarker.backendGoverned) {
      return RuntimeActivationBlockReason.unsafeActivation;
    }
    if (request.requirement.readinessVerificationRequired &&
        !request.readinessVerified) {
      return RuntimeActivationBlockReason.unsafeActivation;
    }
    if (request.requirement.secureEnvelopeVerificationRequired &&
        !request.secureEnvelopeVerified) {
      return RuntimeActivationBlockReason.unsafeActivation;
    }
    if (request.requirement.providerGovernanceVerificationRequired &&
        !request.providerGovernanceVerified) {
      return RuntimeActivationBlockReason.unsafeActivation;
    }
    if (policy.extractionRequired && !request.runtimeMarker.extractionReady) {
      return RuntimeActivationBlockReason.extractionNotReady;
    }
    if (policy.failClosed) {
      return RuntimeActivationBlockReason.failClosed;
    }
    return null;
  }
}
