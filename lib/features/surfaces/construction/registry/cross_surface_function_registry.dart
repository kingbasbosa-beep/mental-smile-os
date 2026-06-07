import '../models/cross_surface_function_models.dart';

class CrossSurfaceFunctionRegistry {
  const CrossSurfaceFunctionRegistry._();

  static const String duplicate = 'duplicate';
  static const String overlap = 'overlap';
  static const String shared = 'shared';
  static const String needsMerge = 'needs_merge';
  static const String unique = 'unique';

  static const Set<String> classifications = <String>{
    duplicate,
    overlap,
    shared,
    needsMerge,
    unique,
  };

  static const List<CrossSurfaceFunctionProfile> functions =
      <CrossSurfaceFunctionProfile>[
    CrossSurfaceFunctionProfile(
      profileId: 'guidance_client_archive_overlap',
      firstSurface: 'client',
      firstFunction: 'ClientGuidanceCardS',
      secondSurface: 'archive',
      secondFunction: 'GuidanceArchivePackageS',
      classification: shared,
    ),
    CrossSurfaceFunctionProfile(
      profileId: 'report_monitoring_archive_shared',
      firstSurface: 'monitoring',
      firstFunction: 'MonitoringReportCardS',
      secondSurface: 'archive',
      secondFunction: 'ArchiveReportCardS',
      classification: shared,
    ),
    CrossSurfaceFunctionProfile(
      profileId: 'counter_client_monitoring_unique',
      firstSurface: 'client',
      firstFunction: 'ClientSavedCounterS',
      secondSurface: 'monitoring',
      secondFunction: 'MonitoringSignalsCounterS',
      classification: unique,
    ),
  ];
}
