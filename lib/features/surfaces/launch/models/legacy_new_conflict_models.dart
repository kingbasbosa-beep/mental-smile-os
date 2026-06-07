class LegacyNewConflictProfile {
  const LegacyNewConflictProfile({
    required this.conflictId,
    required this.legacyFunction,
    required this.federationFunction,
    required this.cleanupAction,
  });

  final String conflictId;
  final String legacyFunction;
  final String federationFunction;
  final String cleanupAction;
}
