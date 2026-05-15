enum ArchitectureManifestVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  extractionPlanning,
}

extension ArchitectureManifestVisibilityScopeKey
    on ArchitectureManifestVisibilityScope {
  String get key {
    switch (this) {
      case ArchitectureManifestVisibilityScope.backendOnly:
        return 'backend_only';
      case ArchitectureManifestVisibilityScope.auditOnly:
        return 'audit_only';
      case ArchitectureManifestVisibilityScope.restrictedReview:
        return 'restricted_review';
      case ArchitectureManifestVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case ArchitectureManifestVisibilityScope.extractionPlanning:
        return 'extraction_planning';
    }
  }
}
