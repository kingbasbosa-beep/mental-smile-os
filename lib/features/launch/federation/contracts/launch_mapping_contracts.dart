import '../models/launch_mapping_report.dart';
import '../models/launch_readiness_snapshot.dart';

abstract class LaunchReadinessAssessor {
  LaunchReadinessSnapshot assessSurface(String surfaceId);
}

abstract class LaunchMappingReportBuilder {
  LaunchMappingReport buildLaunchMappingReport();
}
