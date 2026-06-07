class CrossSurfaceFunctionProfile {
  const CrossSurfaceFunctionProfile({
    required this.profileId,
    required this.firstSurface,
    required this.firstFunction,
    required this.secondSurface,
    required this.secondFunction,
    required this.classification,
  });

  final String profileId;
  final String firstSurface;
  final String firstFunction;
  final String secondSurface;
  final String secondFunction;
  final String classification;
}

class CrossSurfaceFunctionAudit {
  const CrossSurfaceFunctionAudit({
    required this.auditId,
    required this.functions,
    required this.notes,
  });

  final String auditId;
  final List<CrossSurfaceFunctionProfile> functions;
  final String notes;
}
