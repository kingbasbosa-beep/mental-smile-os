class FunctionConflictProfile {
  const FunctionConflictProfile({
    required this.conflictId,
    required this.surfaceId,
    required this.oldFunctionName,
    required this.newFunctionName,
    required this.classification,
  });

  final String conflictId;
  final String surfaceId;
  final String oldFunctionName;
  final String newFunctionName;
  final String classification;
}

class FunctionConflictReport {
  const FunctionConflictReport({
    required this.reportId,
    required this.conflicts,
    required this.recommendedActions,
  });

  final String reportId;
  final List<FunctionConflictProfile> conflicts;
  final List<String> recommendedActions;
}
