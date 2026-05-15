import 'architecture_freeze_policy.dart';
import 'architecture_manifest_block_reason.dart';

class ArchitectureFreezeGuard {
  const ArchitectureFreezeGuard();

  ArchitectureManifestBlockReason? blockReason(
    ArchitectureFreezePolicy policy,
  ) {
    if (policy.runtimeActivationBlocked) {
      return ArchitectureManifestBlockReason.runtimeDisabled;
    }
    if (policy.providerActivationBlocked) {
      return ArchitectureManifestBlockReason.providerBlocked;
    }
    if (policy.backendOrchestrationBlocked) {
      return ArchitectureManifestBlockReason.unsafeIntegration;
    }
    if (policy.integrationReviewRequired) {
      return ArchitectureManifestBlockReason.reviewRequired;
    }
    if (policy.extractionBlocked) {
      return ArchitectureManifestBlockReason.extractionNotReady;
    }
    return null;
  }
}
