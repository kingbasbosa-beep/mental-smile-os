class MonitoringSurfaceAlignment {
  const MonitoringSurfaceAlignment({
    required this.monitoringReference,
    required this.observatoryReference,
    required this.surfaceReference,
  });

  final String monitoringReference;
  final String observatoryReference;
  final String surfaceReference;
}

class SurfaceArchiveAlignment {
  const SurfaceArchiveAlignment({
    required this.surfaceReference,
    required this.archiveReference,
    required this.reportReference,
  });

  final String surfaceReference;
  final String archiveReference;
  final String reportReference;
}

class SurfaceReadinessAlignment {
  const SurfaceReadinessAlignment({
    required this.surfaceReference,
    required this.readinessReference,
    required this.roadmapReference,
    required this.launchStatus,
  });

  final String surfaceReference;
  final String readinessReference;
  final String roadmapReference;
  final String launchStatus;
}
