class CrossSurfaceReference {
  const CrossSurfaceReference({
    required this.referenceId,
    required this.sourceSurface,
    required this.targetSurface,
    required this.referenceType,
    required this.targetRoute,
  });

  final String referenceId;
  final String sourceSurface;
  final String targetSurface;
  final String referenceType;
  final String targetRoute;
}

class CrossSurfaceAuditReport {
  const CrossSurfaceAuditReport({
    required this.reportId,
    required this.references,
    required this.summary,
  });

  final String reportId;
  final List<CrossSurfaceReference> references;
  final String summary;
}
