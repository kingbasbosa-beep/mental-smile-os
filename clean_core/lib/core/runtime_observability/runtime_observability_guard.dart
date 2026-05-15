import 'runtime_observability_block_reason.dart';
import 'runtime_observability_lock.dart';
import 'runtime_observability_policy.dart';
import 'runtime_observability_profile.dart';

class RuntimeObservabilityGuard {
  const RuntimeObservabilityGuard();

  RuntimeObservabilityBlockReason? blockReason({
    required RuntimeObservabilityProfile profile,
    RuntimeObservabilityPolicy policy =
        RuntimeObservabilityPolicy.safeDefault,
    RuntimeObservabilityLock lock = RuntimeObservabilityLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.observabilityBlocked) {
      return RuntimeObservabilityBlockReason.observabilityLocked;
    }
    if (!policy.observabilityAllowed) {
      return RuntimeObservabilityBlockReason.observabilityBlocked;
    }
    if (profile.requirement.signedAuthorityRequired &&
        !profile.hasSignedAuthority) {
      return RuntimeObservabilityBlockReason.missingAuthority;
    }
    if (profile.requirement.policyLinkRequired &&
        (profile.policyVersion != policy.policyVersion ||
            profile.auditLink.policyVersion != policy.policyVersion)) {
      return RuntimeObservabilityBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed &&
        profile.runtimeMarker.runtimeMode != 'disabled') {
      return RuntimeObservabilityBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        profile.runtimeMarker.providerId.trim().isNotEmpty) {
      return RuntimeObservabilityBlockReason.providerBlocked;
    }
    if (profile.reviewMarker.reviewRequired) {
      return RuntimeObservabilityBlockReason.reviewRequired;
    }
    if (profile.requirement.auditLinkRequired && !profile.auditLink.isLinked) {
      return RuntimeObservabilityBlockReason.missingAuditLink;
    }
    if (profile.requirement.observationOwnerRequired &&
        !profile.hasObservationOwner) {
      return RuntimeObservabilityBlockReason.observationOwnerMissing;
    }
    if (profile.requirement.sanitizedObservationRequired &&
        !profile.hasSanitizedObservations) {
      return RuntimeObservabilityBlockReason.unsafeObservation;
    }
    if (profile.requirement.noTelemetryRuntimeRequired &&
        !profile.hasNoTelemetryRuntime) {
      return RuntimeObservabilityBlockReason.unsafeObservation;
    }
    if (!policy.allowedStages.contains(profile.stage) ||
        !policy.allowedVisibilityScopes.contains(profile.visibilityScope) ||
        !profile.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        )) {
      return RuntimeObservabilityBlockReason.unsafeObservation;
    }
    if (policy.backendGovernanceRequired &&
        !profile.runtimeMarker.backendGoverned) {
      return RuntimeObservabilityBlockReason.unsafeObservation;
    }
    if (profile.runtimeMarker.observabilityActive) {
      return RuntimeObservabilityBlockReason.unsafeObservation;
    }
    if (policy.failClosed) {
      return RuntimeObservabilityBlockReason.failClosed;
    }
    return null;
  }
}
