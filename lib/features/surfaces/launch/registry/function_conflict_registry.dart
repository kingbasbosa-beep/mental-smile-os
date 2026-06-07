import '../models/function_conflict_models.dart';

class FunctionConflictRegistry {
  const FunctionConflictRegistry._();

  static const String duplicate = 'duplicate';
  static const String legacyOverlap = 'legacy_overlap';
  static const String replaceCandidate = 'replace_candidate';
  static const String safeToMerge = 'safe_to_merge';
  static const String needsReview = 'needs_review';

  static const Set<String> classifications = <String>{
    duplicate,
    legacyOverlap,
    replaceCandidate,
    safeToMerge,
    needsReview,
  };

  static const List<FunctionConflictProfile> knownConflicts =
      <FunctionConflictProfile>[
    FunctionConflictProfile(
      conflictId: 'client_history_vs_saved_destinations',
      surfaceId: 'client',
      oldFunctionName: 'ClientHistoryCard',
      newFunctionName: 'ClientSavedDestinationsCardS',
      classification: replaceCandidate,
    ),
    FunctionConflictProfile(
      conflictId: 'monitoring_admin_metrics_vs_signal_counts',
      surfaceId: 'monitoring',
      oldFunctionName: 'AdminMetricsCounter',
      newFunctionName: 'MonitoringSignalsCounterS',
      classification: legacyOverlap,
    ),
    FunctionConflictProfile(
      conflictId: 'archive_old_reports_vs_federation_reports',
      surfaceId: 'archive',
      oldFunctionName: 'ArchiveReportTab',
      newFunctionName: 'ArchiveReportTabS',
      classification: safeToMerge,
    ),
  ];
}
