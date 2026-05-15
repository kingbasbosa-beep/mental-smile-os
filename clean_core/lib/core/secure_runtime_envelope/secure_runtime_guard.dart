import 'secure_runtime_block_reason.dart';
import 'secure_runtime_envelope.dart';

class SecureRuntimeGuard {
  const SecureRuntimeGuard();

  SecureRuntimeBlockReason? blockReason(SecureRuntimeEnvelope envelope) {
    if (envelope.lock.sealed) return SecureRuntimeBlockReason.runtimeSealed;
    if (envelope.lock.locked) return SecureRuntimeBlockReason.runtimeSealed;
    if (envelope.requirement.signedAuthorityRequired &&
        !envelope.hasSignedAuthority) {
      return SecureRuntimeBlockReason.missingAuthority;
    }
    if (envelope.requirement.policyLinkRequired &&
        envelope.policy.policyVersion != envelope.auditLink.policyVersion) {
      return SecureRuntimeBlockReason.policyMismatch;
    }
    if (!envelope.policy.runtimeAllowed &&
        envelope.runtimeMarker.runtimeMode != 'disabled') {
      return SecureRuntimeBlockReason.runtimeDisabled;
    }
    if (!envelope.policy.providerAllowed &&
        envelope.runtimeMarker.providerId.trim().isNotEmpty) {
      return SecureRuntimeBlockReason.unsafeExecution;
    }
    if (envelope.reviewMarker.reviewRequired) {
      return SecureRuntimeBlockReason.reviewRequired;
    }
    if (envelope.policy.restrictedEnvironments.contains(
      envelope.runtimeMarker.environment,
    )) {
      return SecureRuntimeBlockReason.restrictedEnvironment;
    }
    if (envelope.requirement.auditLinkRequired &&
        !envelope.auditLink.isLinked) {
      return SecureRuntimeBlockReason.missingAuditLink;
    }
    if (!envelope.policy.allowedScopes.contains(envelope.reference.scope) ||
        !envelope.policy.allowedVisibilityScopes.contains(
          envelope.visibilityScope,
        ) ||
        (envelope.policy.backendGovernanceRequired &&
            !envelope.runtimeMarker.backendGoverned)) {
      return SecureRuntimeBlockReason.unsafeExecution;
    }
    if (envelope.policy.failClosed) return SecureRuntimeBlockReason.failClosed;
    return null;
  }
}
