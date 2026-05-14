import 'safety_registry_block_reason.dart';
import 'safety_registry_entry.dart';
import 'safety_registry_policy.dart';

class SafetyRegistryGuard {
  const SafetyRegistryGuard();

  SafetyRegistryBlockReason? blockReason({
    required SafetyRegistryPolicy policy,
    required SafetyRegistryEntry entry,
  }) {
    if (policy.registrationLocked) return SafetyRegistryBlockReason.registryLocked;
    if (policy.policyVersion != entry.policyVersion) {
      return SafetyRegistryBlockReason.policyMismatch;
    }
    if (entry.runtimeMarker.runtimeMode == 'disabled') {
      return SafetyRegistryBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        entry.runtimeMarker.providerId.trim().isNotEmpty) {
      return SafetyRegistryBlockReason.providerBlocked;
    }
    if (policy.reviewRequired || entry.reviewMarker.reviewRequired) {
      return SafetyRegistryBlockReason.reviewRequired;
    }
    if (policy.auditRequired && !entry.auditLink.isLinked) {
      return SafetyRegistryBlockReason.missingAuditLink;
    }
    if (!policy.allowedScopes.contains(entry.scope)) {
      return SafetyRegistryBlockReason.unsafeRegistration;
    }
    if (!policy.allowedVisibilityScopes.contains(entry.visibilityScope)) {
      return SafetyRegistryBlockReason.visibilityRestricted;
    }
    if (policy.backendGovernanceRequired &&
        !entry.runtimeMarker.backendGoverned) {
      return SafetyRegistryBlockReason.unsafeRegistration;
    }
    if (policy.failClosed) return SafetyRegistryBlockReason.failClosed;
    return null;
  }
}
