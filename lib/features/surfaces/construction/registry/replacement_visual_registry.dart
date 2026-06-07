import '../models/replacement_visual_models.dart';

class ReplacementVisualRegistry {
  const ReplacementVisualRegistry._();

  static const List<ReplacementVisualProfile> replacements =
      <ReplacementVisualProfile>[
    ReplacementVisualProfile(
      profileId: 'replace_client_old_progress_visual',
      oldFunction: 'ClientProgressCard',
      linkedVisual: 'client_old_progress_card_image',
      cardId: 'client_signal_summary_card_s',
      replacementNeed: 'needs_federation_visual',
    ),
    ReplacementVisualProfile(
      profileId: 'replace_monitoring_old_ops_background',
      oldFunction: 'OperationsOverviewPanel',
      linkedVisual: 'monitoring_old_operations_background',
      cardId: 'monitoring_observatory_card_s',
      replacementNeed: 'needs_observatory_visual',
    ),
    ReplacementVisualProfile(
      profileId: 'replace_archive_old_export_banner',
      oldFunction: 'LegacyExportPanel',
      linkedVisual: 'archive_old_export_banner',
      cardId: 'archive_package_card_s',
      replacementNeed: 'needs_archive_identity_visual',
    ),
  ];
}
