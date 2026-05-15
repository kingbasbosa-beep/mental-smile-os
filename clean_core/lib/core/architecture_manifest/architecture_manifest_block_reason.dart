enum ArchitectureManifestBlockReason {
  manifestLocked,
  freezeRequired,
  runtimeDisabled,
  providerBlocked,
  missingAuditLink,
  reviewRequired,
  extractionNotReady,
  unsafeIntegration,
  failClosed,
}

extension ArchitectureManifestBlockReasonKey on ArchitectureManifestBlockReason {
  String get key {
    switch (this) {
      case ArchitectureManifestBlockReason.manifestLocked:
        return 'manifest_locked';
      case ArchitectureManifestBlockReason.freezeRequired:
        return 'freeze_required';
      case ArchitectureManifestBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case ArchitectureManifestBlockReason.providerBlocked:
        return 'provider_blocked';
      case ArchitectureManifestBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case ArchitectureManifestBlockReason.reviewRequired:
        return 'review_required';
      case ArchitectureManifestBlockReason.extractionNotReady:
        return 'extraction_not_ready';
      case ArchitectureManifestBlockReason.unsafeIntegration:
        return 'unsafe_integration';
      case ArchitectureManifestBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
