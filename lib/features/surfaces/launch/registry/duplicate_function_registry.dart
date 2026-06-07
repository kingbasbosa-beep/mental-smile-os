import '../models/duplicate_function_models.dart';

class DuplicateFunctionRegistry {
  const DuplicateFunctionRegistry._();

  static const List<DuplicateFunctionProfile> knownDuplicates =
      <DuplicateFunctionProfile>[
    DuplicateFunctionProfile(
      profileId: 'client_guidance_overlap',
      surfaceId: 'client',
      oldFunctionName: 'ClientSupportShortcut',
      newFunctionName: 'ClientGuidanceCardS',
      duplicationReason:
          'Both point the client toward help, but the federation version is guidance-first.',
    ),
    DuplicateFunctionProfile(
      profileId: 'monitoring_counter_overlap',
      surfaceId: 'monitoring',
      oldFunctionName: 'OperationsCounter',
      newFunctionName: 'MonitoringCounterS',
      duplicationReason:
          'Both summarize activity, but the federation version reads aggregate signals only.',
    ),
    DuplicateFunctionProfile(
      profileId: 'archive_report_overlap',
      surfaceId: 'archive',
      oldFunctionName: 'ArchiveReportCard',
      newFunctionName: 'ArchiveReportCardS',
      duplicationReason:
          'Both expose reports, but the federation version is package-based and identity-aligned.',
    ),
  ];
}
