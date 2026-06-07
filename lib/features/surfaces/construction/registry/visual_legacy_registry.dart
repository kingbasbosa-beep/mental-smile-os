import '../models/visual_legacy_models.dart';

class VisualLegacyRegistry {
  const VisualLegacyRegistry._();

  static const String legacyVisual = 'legacy_visual';
  static const String legacyTextEmbedded = 'legacy_text_embedded';
  static const String legacyBackground = 'legacy_background';
  static const String legacyBanner = 'legacy_banner';
  static const String needsReplacement = 'needs_replacement';
  static const String safe = 'safe';

  static const Set<String> classifications = <String>{
    legacyVisual,
    legacyTextEmbedded,
    legacyBackground,
    legacyBanner,
    needsReplacement,
    safe,
  };

  static const List<VisualLegacyProfile> legacyProfiles =
      <VisualLegacyProfile>[
    VisualLegacyProfile(
      profileId: 'client_old_progress_visual',
      assetId: 'client_old_progress_card_image',
      surfaceId: 'client',
      classification: legacyVisual,
      recommendedAction: 'replace',
    ),
    VisualLegacyProfile(
      profileId: 'monitoring_old_ops_background',
      assetId: 'monitoring_old_operations_background',
      surfaceId: 'monitoring',
      classification: legacyBackground,
      recommendedAction: 'hide',
    ),
    VisualLegacyProfile(
      profileId: 'archive_old_export_banner',
      assetId: 'archive_old_export_banner',
      surfaceId: 'archive',
      classification: legacyBanner,
      recommendedAction: 'replace',
    ),
  ];
}
