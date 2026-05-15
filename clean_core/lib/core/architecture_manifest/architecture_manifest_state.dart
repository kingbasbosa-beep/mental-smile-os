enum ArchitectureManifestState {
  draft,
  foundationReady,
  reviewRequired,
  locked,
  frozen,
  extractionCandidate,
  archived,
}

extension ArchitectureManifestStateKey on ArchitectureManifestState {
  String get key {
    switch (this) {
      case ArchitectureManifestState.draft:
        return 'draft';
      case ArchitectureManifestState.foundationReady:
        return 'foundation_ready';
      case ArchitectureManifestState.reviewRequired:
        return 'review_required';
      case ArchitectureManifestState.locked:
        return 'locked';
      case ArchitectureManifestState.frozen:
        return 'frozen';
      case ArchitectureManifestState.extractionCandidate:
        return 'extraction_candidate';
      case ArchitectureManifestState.archived:
        return 'archived';
    }
  }
}
