import 'runtime_wiring_block_reason.dart';
import 'runtime_wiring_lock.dart';
import 'runtime_wiring_map.dart';
import 'runtime_wiring_policy.dart';

class RuntimeWiringGuard {
  const RuntimeWiringGuard();

  RuntimeWiringBlockReason? blockReason({
    required RuntimeWiringMap map,
    RuntimeWiringPolicy policy = RuntimeWiringPolicy.safeDefault,
    RuntimeWiringLock lock = RuntimeWiringLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.wiringBlocked) {
      return RuntimeWiringBlockReason.wiringLocked;
    }
    if (!policy.wiringAllowed) {
      return RuntimeWiringBlockReason.wiringBlocked;
    }
    if (map.requirement.policyLinkRequired &&
        (map.policyVersion != policy.policyVersion ||
            map.auditLink.policyVersion != policy.policyVersion)) {
      return RuntimeWiringBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed && map.runtimeMarker.runtimeMode != 'disabled') {
      return RuntimeWiringBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        map.runtimeMarker.providerId.trim().isNotEmpty) {
      return RuntimeWiringBlockReason.providerBlocked;
    }
    if (map.reviewMarker.reviewRequired) {
      return RuntimeWiringBlockReason.reviewRequired;
    }
    if (map.requirement.auditLinkRequired && !map.auditLink.isLinked) {
      return RuntimeWiringBlockReason.missingAuditLink;
    }
    if (map.requirement.ownerRequired && !map.hasTrustedOwner) {
      return RuntimeWiringBlockReason.missingOwner;
    }
    if (map.requirement.pathApprovalRequired &&
        !map.paths.every((path) => path.isApprovedPlaceholder)) {
      return RuntimeWiringBlockReason.unapprovedPath;
    }
    if (!policy.allowedVisibilityScopes.contains(map.visibilityScope) ||
        !map.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        )) {
      return RuntimeWiringBlockReason.unsafeWiring;
    }
    if (map.requirement.backendGovernanceRequired &&
        !map.runtimeMarker.backendGoverned) {
      return RuntimeWiringBlockReason.unsafeWiring;
    }
    if (map.requirement.sealingRequired &&
        !map.paths.every((path) => path.sealed)) {
      return RuntimeWiringBlockReason.unsafeWiring;
    }
    if (map.runtimeMarker.wiringActive) {
      return RuntimeWiringBlockReason.unsafeWiring;
    }
    if (policy.failClosed) {
      return RuntimeWiringBlockReason.failClosed;
    }
    return null;
  }
}
