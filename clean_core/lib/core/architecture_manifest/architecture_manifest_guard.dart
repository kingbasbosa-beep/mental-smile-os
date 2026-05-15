import 'architecture_manifest.dart';
import 'architecture_manifest_block_reason.dart';

class ArchitectureManifestGuard {
  const ArchitectureManifestGuard();

  ArchitectureManifestBlockReason? blockReason(
    ArchitectureManifest manifest,
  ) {
    if (manifest.freezeMarker.locked) {
      return ArchitectureManifestBlockReason.manifestLocked;
    }
    if (manifest.requirement.freezeRequired && !manifest.freezeMarker.frozen) {
      return ArchitectureManifestBlockReason.freezeRequired;
    }
    if (!manifest.policy.runtimeAllowed &&
        manifest.runtimeMarker.runtimeMode != 'disabled') {
      return ArchitectureManifestBlockReason.runtimeDisabled;
    }
    if (!manifest.policy.providerAllowed &&
        manifest.runtimeMarker.providerId.trim().isNotEmpty) {
      return ArchitectureManifestBlockReason.providerBlocked;
    }
    if (manifest.requirement.auditLinkRequired && !manifest.auditLink.isLinked) {
      return ArchitectureManifestBlockReason.missingAuditLink;
    }
    if (manifest.reviewMarker.reviewRequired) {
      return ArchitectureManifestBlockReason.reviewRequired;
    }
    if (!manifest.policy.extractionAllowed &&
        manifest.runtimeMarker.extractionReady) {
      return ArchitectureManifestBlockReason.extractionNotReady;
    }
    if (!manifest.policy.allowedVisibilityScopes.contains(
      manifest.visibilityScope,
    ) ||
        !manifest.entries.every((entry) => entry.isValid) ||
        !manifest.entries.every(
          (entry) => manifest.policy.allowedScopes.contains(
            entry.reference.scope,
          ),
        ) ||
        (manifest.policy.backendGovernanceRequired &&
            !manifest.runtimeMarker.backendGoverned)) {
      return ArchitectureManifestBlockReason.unsafeIntegration;
    }
    if (manifest.policy.failClosed) {
      return ArchitectureManifestBlockReason.failClosed;
    }
    return null;
  }
}
