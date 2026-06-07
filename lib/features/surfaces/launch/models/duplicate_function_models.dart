class DuplicateFunctionProfile {
  const DuplicateFunctionProfile({
    required this.profileId,
    required this.surfaceId,
    required this.oldFunctionName,
    required this.newFunctionName,
    required this.duplicationReason,
  });

  final String profileId;
  final String surfaceId;
  final String oldFunctionName;
  final String newFunctionName;
  final String duplicationReason;
}

class DuplicateFunctionAudit {
  const DuplicateFunctionAudit({
    required this.auditId,
    required this.surfaceId,
    required this.detectedFunctions,
    required this.notes,
  });

  final String auditId;
  final String surfaceId;
  final List<DuplicateFunctionProfile> detectedFunctions;
  final String notes;
}
